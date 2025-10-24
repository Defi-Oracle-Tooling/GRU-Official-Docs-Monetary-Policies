// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title Centralized custom errors for GRC-2535 diamond + facets
/// @notice Using custom errors reduces deployment and runtime gas versus revert strings.
library Errors {
    // Ownership / Roles
    error ErrOwner();
    error ErrUpgradeRole();
    error ErrGovernanceRole();
    error ErrIndexRole();
    error ErrMonetaryRole();
    error ErrMissingRole();

    // Diamond / Facets / Selectors
    error ErrFacetZero();
    error ErrSelectorExists();
    error ErrSelectorMissing();
    error ErrNoFacet();

    // Pause
    error ErrPausedGlobal();
    error ErrPausedFunc();

    // Array / Math Validation
    error ErrLengthMismatch();
    error ErrSumInvalid();

    // Governance / Timelock
    error ErrNotReady();
    error ErrNoProposal();
    error ErrProposalExists();
    error ErrProposalUsed();

    // Bond / Series
    error ErrZeroNotional();
    error ErrSeriesExists();
    error ErrSeriesInactive();
    error ErrCoverageFail();

    // Generic / Misc
    error ErrZeroAddress();
}
