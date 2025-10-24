// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IIndex} from "../interfaces/IIndex.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract IndexFacet is IIndex {
    function setWeights(bytes32 indexId, bytes32[] calldata keys, uint256[] calldata weights, uint64 version, bytes32 dashboardHash) external {
        require(keys.length == weights.length, "LEN");
        uint256 sum;
        for(uint i; i<weights.length; i++){ sum += weights[i]; }
        require(sum == 1e18, "SUM");
        GRCStorage.IndexEntry storage ie = GRCStorage.indexEntry(indexId);
        ie.version = version;
        ie.dashboardHash = dashboardHash;
        // overwrite arrays
        delete ie.keys; delete ie.weights;
        for(uint i; i<keys.length; i++){ ie.keys.push(keys[i]); ie.weights.push(weights[i]); }
        emit IndexWeightsUpdated(indexId, version);
    }
    function getIndex(bytes32 indexId) external view returns (uint64 version, bytes32[] memory keys, uint256[] memory weights, bytes32 dashboardHash) {
        GRCStorage.IndexEntry storage ie = GRCStorage.indexEntry(indexId);
        version = ie.version; dashboardHash = ie.dashboardHash; keys = ie.keys; weights = ie.weights;
    }
    function recalcLiCRI(bytes32[] calldata componentIds, uint256[] calldata componentValues) external returns (uint256 faceValueComposite) {
        require(componentIds.length == componentValues.length, "LEN");
        uint256 sum;
        for(uint i; i<componentValues.length; i++){ sum += componentValues[i]; }
        faceValueComposite = sum / componentValues.length; // simple average placeholder
        GRCStorage.IndexState storage isx = GRCStorage.index();
        isx.liCRI = faceValueComposite;
    emit DashboardSnapshot(bytes32(0), isx.globalVersion, faceValueComposite, block.timestamp);
    }
    function setDashboardComposite(bytes32 dashboardHash, uint256 liCRI, uint64 globalVersion) external {
        GRCStorage.IndexState storage isx = GRCStorage.index();
        isx.liCRI = liCRI; isx.globalVersion = globalVersion;
    emit DashboardSnapshot(dashboardHash, globalVersion, liCRI, block.timestamp);
    }
    function getLiCRI() external view returns (uint256) { return GRCStorage.index().liCRI; }
}
