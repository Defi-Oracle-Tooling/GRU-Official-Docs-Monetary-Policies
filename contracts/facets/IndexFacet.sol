// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IIndex} from "../interfaces/IIndex.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
contract IndexFacet is IIndex {
    uint256 internal constant ROLE_INDEX = 1 << 2;
    modifier onlyIndexRole() {
        if((GRCStorage.roles().roleBits[msg.sender] & ROLE_INDEX) == 0) revert Errors.ErrIndexRole();
        _;
    }
    function setWeights(bytes32 indexId, bytes32[] calldata keys, uint256[] calldata weights, uint64 version, bytes32 dashboardHash) external onlyIndexRole {
    if(keys.length != weights.length) revert Errors.ErrLengthMismatch();
        uint256 sum;
        for(uint i; i<weights.length; i++){ sum += weights[i]; }
    if(sum != 1e18) revert Errors.ErrSumInvalid();
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
    function recalcLiCRI(bytes32[] calldata componentIds, uint256[] calldata componentValues) external onlyIndexRole returns (uint256 faceValueComposite) {
    if(componentIds.length != componentValues.length) revert Errors.ErrLengthMismatch();
        uint256 sum;
        for(uint i; i<componentValues.length; i++){ sum += componentValues[i]; }
        faceValueComposite = sum / componentValues.length; // simple average placeholder
        GRCStorage.IndexState storage isx = GRCStorage.index();
        isx.liCRI = faceValueComposite;
    emit DashboardSnapshot(bytes32(0), isx.globalVersion, faceValueComposite, block.timestamp);
    }
    function recalcLiCRIWeighted(bytes32[] calldata componentIds, uint256[] calldata componentValues, uint256[] calldata weights) external onlyIndexRole returns (uint256 liCRI) {
        if(componentIds.length != componentValues.length || componentIds.length != weights.length) revert Errors.ErrLengthMismatch();
        uint256 wsum;
        uint256 acc;
        for(uint i; i<weights.length; i++) { wsum += weights[i]; acc += componentValues[i] * weights[i] / 1e18; }
        if(wsum != 1e18) revert Errors.ErrSumInvalid();
        liCRI = acc; // weighted sum already scaled
        GRCStorage.IndexState storage isx = GRCStorage.index();
        isx.liCRI = liCRI;
        emit DashboardSnapshot(bytes32(0), isx.globalVersion, liCRI, block.timestamp);
    }
    function setDashboardComposite(bytes32 dashboardHash, uint256 liCRI, uint64 globalVersion) external onlyIndexRole {
        GRCStorage.IndexState storage isx = GRCStorage.index();
        isx.liCRI = liCRI; isx.globalVersion = globalVersion;
    emit DashboardSnapshot(dashboardHash, globalVersion, liCRI, block.timestamp);
    }
    function getLiCRI() external view returns (uint256) { return GRCStorage.index().liCRI; }
    function setIndexValue(bytes32 indexId, uint256 value) external onlyIndexRole {
        GRCStorage.IndexEntry storage ie = GRCStorage.indexEntry(indexId);
        if(ie.keys.length == 0){ ie.keys.push(bytes32("VALUE")); ie.weights.push(value); }
        else { ie.weights[0] = value; }
    }
    function getIndexValue(bytes32 indexId) external view returns (uint256) {
        GRCStorage.IndexEntry storage ie = GRCStorage.indexEntry(indexId);
        return ie.weights.length == 0 ? 0 : ie.weights[0];
    }
}
