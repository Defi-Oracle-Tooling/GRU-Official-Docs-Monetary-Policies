// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IAudit} from "../interfaces/IAudit.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract AuditFacet is IAudit {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier onlyGov() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    function postPoR(uint64 period, bytes32 merkleRoot, string calldata ipfsRef) external onlyGov {
        GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period);
        if(ap.isSealed) revert Errors.ErrPeriodSealed();
        ap.merkleRoot = merkleRoot; ap.ipfs = ipfsRef; emit PoRPosted(period, merkleRoot, ipfsRef);
    }
    function seal(uint64 period) external onlyGov {
        GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period);
        if(ap.isSealed) revert Errors.ErrPeriodSealed();
        ap.isSealed = true; emit PoRSealed(period);
    }
    function getPoR(uint64 period) external view returns (bytes32 merkleRoot, string memory ipfsRef, bool isSealed) {
        GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period); return (ap.merkleRoot, ap.ipfs, ap.isSealed);
    }
}
