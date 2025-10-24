// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IBond {
    event BondIssued(bytes32 indexed series, address indexed to, uint256 notional);
    event CouponsAccrued(bytes32 indexed series, uint256 amount);
    event BondBuyback(bytes32 indexed series, uint256 principalClosed);
    function issueLi99(bytes32 series, address to, uint256 notional) external;
    function accrueCoupons(bytes32 series) external returns (uint256 accrued);
    function buyback(bytes32 series) external returns (uint256 principalClosed);
    function coverageCheck(bytes32 series) external view returns (bool ok, uint256 coverageRatio);
}