// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IIndex {
    event IndexWeightsUpdated(bytes32 indexed id, uint64 version);
    event DashboardSnapshot(bytes32 indexed dashboardHash, uint64 globalVersion, uint256 liCRI, uint256 timestamp);
    function setWeights(bytes32 indexId, bytes32[] calldata keys, uint256[] calldata weights, uint64 version, bytes32 dashboardHash) external;
    function getIndex(bytes32 indexId) external view returns (uint64 version, bytes32[] memory keys, uint256[] memory weights, bytes32 dashboardHash);
    function recalcLiCRI(bytes32[] calldata componentIds, uint256[] calldata componentValues) external returns (uint256 faceValueComposite);
    function recalcLiCRIWeighted(bytes32[] calldata componentIds, uint256[] calldata componentValues, uint256[] calldata weights) external returns (uint256 liCRI);
    function setDashboardComposite(bytes32 dashboardHash, uint256 liCRI, uint64 globalVersion) external;
    function getLiCRI() external view returns (uint256);
}