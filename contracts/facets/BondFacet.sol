// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IBond} from "../interfaces/IBond.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract BondFacet is IBond {
    function issueLi99(bytes32 series, address to, uint256 notional) external {
        to; GRCStorage.BondSeries storage bs = GRCStorage.bond(series);
        bs.active = true; emit BondIssued(series, to, notional); revert("NOT_IMPL");
    }
    function accrueCoupons(bytes32 series) external returns (uint256 accrued) { series; revert("NOT_IMPL"); }
    function buyback(bytes32 series) external returns (uint256 principalClosed) { series; revert("NOT_IMPL"); }
    function coverageCheck(bytes32 series) external view returns (bool ok, uint256 coverageRatio) { series; return (false,0); }
}
