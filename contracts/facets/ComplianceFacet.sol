// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";

/// @title ComplianceFacet (stub)
/// @notice Placeholder for KYC / AML / jurisdictional enforcement. Logic deferred.
/// @dev All stateful methods revert ErrNotReady() until storage & validation integrated.
contract ComplianceFacet {
    // Proposed role bit for compliance operators (not yet granted via AccessFacet)
    uint256 internal constant ROLE_COMPLIANCE = 1 << 4;

    modifier onlyCompliance() {
        if (IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_COMPLIANCE) == 0) {
            revert Errors.ErrMissingRole();
        }
        _;
    }

    // --- Planned Structures (future) ---
    // struct ComplianceProfile { /* mirrored off-chain; not stored yet */ }

    // --- Stub Functions ---

    /// @notice Check if a transfer between two addresses is compliant.
    /// @dev Will integrate jurisdiction, allowlist/blocklist, velocity limits.
    function checkTransfer(address from, address to, uint256 amount) external view returns (bool allowed, string memory reason) {
        from; to; amount; // silence warnings
        return (true, "STUB: compliance not enforced");
    }

    /// @notice Placeholder to set KYC profile for an address (deferred implementation).
    function setKYC(address account, uint8 level, uint64 expiry) external onlyCompliance {
        account; level; expiry;
        revert Errors.ErrNotReady();
    }

    /// @notice Placeholder to set AML risk classification.
    function setAMLRisk(address account, uint8 riskTier, bytes32 reason) external onlyCompliance {
        account; riskTier; reason;
        revert Errors.ErrNotReady();
    }

    /// @notice Placeholder to emergency pause a jurisdiction.
    function emergencyJurisdictionPause(bytes16 jurisdiction, uint256 durationSecs) external onlyCompliance {
        jurisdiction; durationSecs;
        revert Errors.ErrNotReady();
    }
}
