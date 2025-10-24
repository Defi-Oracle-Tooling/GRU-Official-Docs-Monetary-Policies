// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface ITriangulation {
    event RateSet(bytes32 indexed fromAsset, bytes32 indexed toAsset, uint256 rate); // 1e18 scaled
    event Triangulated(bytes32 indexed fromAsset, bytes32 indexed toAsset, uint256 inputAmount, uint256 outputAmount);
    event Redeemed(bytes32 indexed fromAsset, bytes32 indexed toAsset, uint256 inputAmount, uint256 outputAmount);
    event FeeUpdated(uint256 oldFeeBps, uint256 newFeeBps);
    function setRate(bytes32 fromAsset, bytes32 toAsset, uint256 rate) external;
    function getRate(bytes32 fromAsset, bytes32 toAsset) external view returns (uint256 rate);
    function triangulate(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external returns (uint256 outAmount);
    function redeem(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external returns (uint256 outAmount);
    function setFees(uint256 feeBps) external;
    function feeBps() external view returns (uint256);
}