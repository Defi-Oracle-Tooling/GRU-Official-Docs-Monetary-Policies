// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface ITriangulation {
    function triangulateToGRU(uint256 xauAmount) external returns (uint256 gruOut);
    function redeemFromGRU(uint256 gruAmount) external returns (uint256 xauOut);
    function atomicLoop7to10(uint256 input, uint8 n, uint256 feeBps) external returns (uint256 expanded);
    function setFees(uint256 feeBps) external;
}