// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IGrcLoupe {
    function grcVersion() external view returns (string memory);
    function getScalarS() external view returns (uint256);
    function getIndexWeights(bytes32 indexId) external view returns (uint64 ver, bytes32[] memory keys, uint256[] memory weights, bytes32 dashboardHash);
    function getPoR(uint64 period) external view returns (bytes32 merkleRoot, string memory ipfs);
    function governanceParams() external view returns (uint256 timelockSeconds, uint256 quorumBps);
}