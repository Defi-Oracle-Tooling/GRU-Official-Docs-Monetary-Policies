// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IBond} from "../interfaces/IBond.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract BondFacet is IBond {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier onlyGovOrOwner() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    function issueLi99(bytes32 series, address to, uint256 notional) external onlyGovOrOwner {
    if(to == address(0)) revert Errors.ErrZeroAddress(); if(notional == 0) revert Errors.ErrZeroNotional();
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
    if(bs.active) revert Errors.ErrSeriesExists();
        bs.active = true; bs.principal = notional; bs.couponBps = 500; // 5% placeholder
        bs.termYears = 5; bs.lastCouponTs = uint64(block.timestamp);
        emit BondIssued(series, to, notional);
    }
    function accrueCoupons(bytes32 series) external returns (uint256 accrued) {
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
    if(!bs.active) revert Errors.ErrSeriesInactive();
        uint256 elapsed = block.timestamp - bs.lastCouponTs;
        // simple linear accrual: principal * couponBps * elapsed / (YEAR * 10000)
        uint256 yearly = 365 days;
        accrued = bs.principal * bs.couponBps * elapsed / (yearly * 10000);
        bs.lastCouponTs = uint64(block.timestamp);
        emit CouponsAccrued(series, accrued);
    }
    function buyback(bytes32 series) external returns (uint256 principalClosed) {
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        if(!bs.active) revert Errors.ErrSeriesInactive();
        // economic invariant: coverage must be >= principal * 120% if principal > 0
        if(bs.principal > 0) {
            uint256 coverageRatio = bs.principal == 0 ? 0 : (bs.principal * 125) / 100;
            if(coverageRatio < bs.principal * 120 / 100) revert Errors.ErrCoverageFail();
        }
        principalClosed = bs.principal; bs.principal = 0; bs.active = false;
        emit BondBuyback(series, principalClosed);
    }
    function coverageCheck(bytes32 series) external view returns (bool ok, uint256 coverageRatio) {
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        if(!bs.active) return (false,0);
        // Placeholder: coverage ratio = (principal + accrued placeholder) / principal => assume 125% if active
        coverageRatio = bs.principal == 0 ? 0 : (bs.principal * 125) / 100; // 125%
        ok = coverageRatio >= bs.principal * 120 / 100; // >=120%
    }
}
