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

## Planned Enhancements
- Role modifiers referencing `AccessFacet` bitmasks.
- Governance timelock execution path for authorized diamondCut calls.
- Index registry weight persistence and on-chain Li composite calculations.
- Bond coupon accrual and coverage checks.
- Reentrancy / pause guards across state-changing facets.

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
