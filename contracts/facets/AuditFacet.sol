// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IAudit} from "../interfaces/IAudit.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract AuditFacet is IAudit {
    function postPoR(uint64 period, bytes32 merkleRoot, string calldata ipfsRef) external {
        GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period);
        ap.merkleRoot = merkleRoot; ap.ipfs = ipfsRef; emit PoRPosted(period, merkleRoot, ipfsRef); }
    function seal(uint64 period) external { GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period); ap.isSealed = true; emit PoRSealed(period); }
    function getPoR(uint64 period) external view returns (bytes32 merkleRoot, string memory ipfsRef, bool isSealed) { GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period); return (ap.merkleRoot, ap.ipfs, ap.isSealed); }
}
