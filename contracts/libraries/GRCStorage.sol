// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
library GRCStorage {
    bytes32 internal constant S_MONETARY = keccak256("grc.storage.monetary");
    bytes32 internal constant S_INDEX    = keccak256("grc.storage.index");
    bytes32 internal constant S_BOND     = keccak256("grc.storage.bond");
    bytes32 internal constant S_GOV      = keccak256("grc.storage.gov");
    bytes32 internal constant S_AUDIT    = keccak256("grc.storage.audit");
    bytes32 internal constant S_ACCESS   = keccak256("grc.storage.access");
    bytes32 internal constant S_PAUSE    = keccak256("grc.storage.pause");

    struct MonetaryState { uint256 m00; uint256 m0; uint256 m1; uint256 scalarS; }
    struct IndexEntry { uint64 version; bytes32 dashboardHash; bytes32[] keys; uint256[] weights; }
    struct IndexState { uint64 globalVersion; uint256 liCRI; mapping(bytes32 => IndexEntry) indices; }
    struct BondSeries { uint256 coverage; uint256 couponBps; uint64 termYears; bool active; }
    struct AuditPeriod { bytes32 merkleRoot; string ipfs; bool isSealed; }
    struct Roles { mapping(address => uint256) roleBits; }
    struct PauseState { bool global; mapping(bytes4 => bool) func; }
    struct GovernanceState {
        uint256 timelockSeconds; uint256 quorumBps;
        mapping(bytes32 => uint256) eta;                // proposal id => execution time
        mapping(bytes32 => bytes) encodedCut;           // proposal id => abi.encode(FacetCut[])
        mapping(bytes32 => address) initAddr;           // optional init address
        mapping(bytes32 => bytes) initData;             // optional init calldata
        mapping(bytes32 => address) proposer;           // proposer address
    }

    // Accessors
    function monetary() internal pure returns (MonetaryState storage ms) { bytes32 p = S_MONETARY; assembly { ms.slot := p } }
    function index() internal pure returns (IndexState storage isx) { bytes32 p = S_INDEX; assembly { isx.slot := p } }
    function indexEntry(bytes32 id) internal pure returns (IndexEntry storage ie) { bytes32 p = keccak256(abi.encode(id, S_INDEX)); assembly { ie.slot := p } }
    function bond(bytes32 slotKey) internal pure returns (BondSeries storage bs) { bytes32 p = keccak256(abi.encode(slotKey, S_BOND)); assembly { bs.slot := p } }
    function audit(uint64 period) internal pure returns (AuditPeriod storage ap) { bytes32 p = keccak256(abi.encode(period, S_AUDIT)); assembly { ap.slot := p } }
    function roles() internal pure returns (Roles storage rs) { bytes32 p = S_ACCESS; assembly { rs.slot := p } }
    function pause() internal pure returns (PauseState storage ps) { bytes32 p = S_PAUSE; assembly { ps.slot := p } }
    function governance() internal pure returns (GovernanceState storage gs) { bytes32 p = S_GOV; assembly { gs.slot := p } }
}
