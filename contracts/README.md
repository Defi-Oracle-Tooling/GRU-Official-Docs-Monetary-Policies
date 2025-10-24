# GRC-2535 Diamond Architecture

This directory contains the GRU adaptation of the ERC-2535 Diamond Standard ("GRC-2535"). It modularizes protocol functionality into upgradeable facets governed by institutional policy constraints.

## Core Concepts
- Diamond (`GrcDiamond.sol`): Upgrade dispatcher holding selector -> facet address mapping and enumerability state for loupe introspection.
- Facets: Grouped logic domains (Monetary, Triangulation, Index, Bond, Audit, Governance, Access, Pause).
- Storage Library (`GRCStorage.sol`): Namespaced structs pinned to deterministic slots (keccak namespace pattern) to avoid collision across facets.
- Loupe: Standard introspection functions (`facets`, `facetFunctionSelectors`, `facetAddresses`, `facetAddress`) plus GRU-specific read-only views in `IGrcLoupe`.

## diamondCut Usage
The `diamondCut(FacetCut[] _cut, address _init, bytes _calldata)` function accepts an array of facet cut structs:
```
struct FacetCut { address facetAddress; FacetCutAction action; bytes4[] functionSelectors; }
enum FacetCutAction { Add, Replace, Remove }
```
Actions:
- Add: Introduces new selectors; facetAddress must be non-zero and selectors must not exist.
- Replace: Moves existing selectors to a new facet (old facet entry pruned if emptied). Skips work if facetAddress is identical.
- Remove: Deletes selectors; facetAddress in struct is ignored (may be zero); selectors must exist.

Optional initialization delegatecall occurs when `_init != address(0)` with `_calldata`. Use this to run state wiring after upgrade.

## Enumeration Expectations
The diamond maintains:
- `_facetAddresses[]`: Dynamic array of active facet addresses.
- `_facetIndex[address]`: Index+1 for O(1) removal and existence checks.
- `_facetSelectors[address]`: Array of selectors belonging to facet.

Loupe functions return current live state:
- `facets()` returns aligned arrays of facet addresses and their selector arrays.
- `facetFunctionSelectors(facet)` returns all selectors owned by a facet.
- `facetAddresses()` returns the ordered list of facet addresses.
- `facetAddress(selector)` returns the facet currently implementing a selector (or zero address if removed).

## IGrcLoupe Extensions
The protocol adds read-only data accessors:
- `grcVersion()` – Semantic version or policy release tag.
- `getScalarS()` – Monetary scalar parameter from `MonetaryState`.
- `getIndexWeights(bytes32 indexId)` – Placeholder for index composition registry (empty until implemented).
- `getPoR(uint64 period)` – Proof-of-Reserves reference (Merkle root + IPFS pointer).
- `governanceParams()` – Timelock + quorum basis points.

## Selector Generation Helper
A script (`scripts/generate_selectors.js`) produces function selectors from compiled ABI artifacts to facilitate upgrade planning.
```
node scripts/generate_selectors.js MonetaryFacet
```
Outputs JSON mapping of function signatures to selectors.

## Upgrade Safety Considerations
- Replacing a selector with identical facet address is ignored (gas save).
- Removing the last selector of a facet triggers facet address removal (array swap/pop) maintaining compact storage.
- Mapping index eliminates O(n) facet existence checks.

## Implemented Capabilities
- Role bitmask gating (upgrade, governance, index, monetary) with `AccessFacet`.
- Governance timelock proposal -> queue -> execute flow (`GovernanceFacet`).
- Index weight registry + dashboard hash snapshot + placeholder LiCRI calculation (`IndexFacet`).
- Bond issuance, coupon accrual (linear), buyback, coverage placeholder (`BondFacet`).
- Global + per-function pause controls enforced in diamond fallback (`PauseFacet`).
- Centralized custom error codes (`Errors.sol`) replacing string reverts for gas efficiency.

## Remaining / Future Enhancements
- Weighted LiCRI composite (use stored per-index values and weights).
- Reentrancy guards and additional upgrade integrity assertions.
- Audit / Triangulation facet full logic (proof-of-reserves, asset conversion).
- Extended economic invariant tests (coverage thresholds, scalar bounds).
- Event off-chain indexing examples / subgraph schema.

## Custom Errors Catalog
All revert conditions are normalized via `Errors.sol`:

| Error | Meaning |
|-------|---------|
| `ErrOwner()` | Caller is not current diamond owner. |
| `ErrUpgradeRole()` | Missing upgrade role for diamondCut / execution path. |
| `ErrGovernanceRole()` | Missing governance role. |
| `ErrIndexRole()` | Missing index management role. |
| `ErrMonetaryRole()` | Missing monetary management role. |
| `ErrMissingRole()` | Generic required role absent. |
| `ErrFacetZero()` | Facet address is zero on Add/Replace. |
| `ErrSelectorExists()` | Adding a selector that already exists. |
| `ErrSelectorMissing()` | Replacing/removing a selector that does not exist. |
| `ErrNoFacet()` | Fallback dispatch found no facet for selector. |
| `ErrPausedGlobal()` | Global pause active. |
| `ErrPausedFunc()` | Selector-specific pause active. |
| `ErrLengthMismatch()` | Array length mismatch (e.g., keys vs weights). |
| `ErrSumInvalid()` | Weight sum not equal to required fixed point (1e18). |
| `ErrNotReady()` | Timelock ETA not reached or initialization placeholder. |
| `ErrNoProposal()` | Referenced proposal absent (not encoded). |
| `ErrProposalExists()` | Proposal already queued/exists. |
| `ErrProposalUsed()` | Proposal already has ETA or consumed. |
| `ErrZeroNotional()` | Bond issuance notional must be > 0. |
| `ErrSeriesExists()` | Bond series already active. |
| `ErrSeriesInactive()` | Bond series inactive when expected active. |
| `ErrCoverageFail()` | Coverage ratio check failed (< threshold). |
| `ErrZeroAddress()` | Provided address is zero. |

## Event Indexing Normalization
Events now index primary identifiers for efficient off-chain filtering:
- `IndexWeightsUpdated(bytes32 indexed id, ...)`
- `DashboardSnapshot(bytes32 indexed dashboardHash, ...)`
- `BondIssued(bytes32 indexed series, address indexed to, ...)`
- `CouponsAccrued(bytes32 indexed series, ...)`
- `BondBuyback(bytes32 indexed series, ...)`
- `CutProposed(bytes32 indexed id, ...)`
- `CutQueued(bytes32 indexed id, ...)`
- `CutExecuted(bytes32 indexed id)`
- `EmergencyBrake(bytes4 indexed selector, ...)`
- `FunctionPaused(bytes4 indexed selector, ...)`

Where practical, only unique identifiers are indexed (to conserve topic space and gas).

## Testing
`test/diamond.spec.js` covers deployment, interface support, diamondCut actions, governance timelock, role gating, pause enforcement, index weight persistence, bond lifecycle and custom error expectations.

Run:
```
npx hardhat test
```

## Notes
Several domain implementations remain placeholders (e.g., monetary mint/burn, full LiCRI weighting). These emit `ErrNotReady()` on invocation until logic is finalized.

## Testing
`test/diamond.spec.js` covers:
- Deployment and interface support via ERC-165.
- IGrcLoupe interface ID computation and assertion.
- Add / Replace / Remove diamondCut actions enumerated through loupe.

Run:
```
npx hardhat test
```

## Notes
This is an early scaffolding; many functions intentionally revert with `NOT_IMPL` until domain logic is integrated. Storage shapes may extend but namespace slots should remain stable to ensure upgrade safety.
