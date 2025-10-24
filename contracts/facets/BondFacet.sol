// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IBond} from "../interfaces/IBond.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract BondFacet is IBond {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier onlyGovOrOwner() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert("NO_GOV");
        _;
    }
    function issueLi99(bytes32 series, address to, uint256 notional) external onlyGovOrOwner {
        require(to != address(0), "ZERO_TO"); require(notional > 0, "ZERO_NOTIONAL");
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        require(!bs.active, "EXISTS_SERIES");
        bs.active = true; bs.principal = notional; bs.couponBps = 500; // 5% placeholder
        bs.termYears = 5; bs.lastCouponTs = uint64(block.timestamp);
        emit BondIssued(series, to, notional);
    }
    function accrueCoupons(bytes32 series) external returns (uint256 accrued) {
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        require(bs.active, "NO_SERIES");
        uint256 elapsed = block.timestamp - bs.lastCouponTs;
        // simple linear accrual: principal * couponBps * elapsed / (YEAR * 10000)
        uint256 yearly = 365 days;
        accrued = bs.principal * bs.couponBps * elapsed / (yearly * 10000);
        bs.lastCouponTs = uint64(block.timestamp);
        emit CouponsAccrued(series, accrued);
    }
    function buyback(bytes32 series) external returns (uint256 principalClosed) {
        GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        require(bs.active, "NO_SERIES");
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
