# GRU Subgraph

This directory provides an indexing scaffold for GRU Diamond events.

## Structure
- `schema.graphql` – Entity definitions mirroring emitted facet events.
- `subgraph.yaml` – Data source configuration pointing to the Diamond address and its ABI.
- `src/mapping.ts` – Handlers converting on-chain logs into entities.

## Generation & Build
Requires `@graphprotocol/graph-ts` dependency (added to root `package.json`). Typical steps:

```bash
# Install graph cli locally if desired
npm install --save-dev @graphprotocol/graph-cli

# Codegen (generates types into generated/)
npx graph codegen subgraph/subgraph.yaml

# Build
npx graph build subgraph/subgraph.yaml
```

Deploy (example – replace endpoint/auth):
```bash
npx graph deploy --node https://api.thegraph.com/deploy/ --ipfs https://api.thegraph.com/ipfs/ my-org/gru-diamond subgraph/subgraph.yaml
```

## Notes
- Event declarations were aggregated into `GrcDiamond.sol` so the single Diamond ABI contains all signatures.
- Each entity ID uses `txHash-logIndex` to guarantee uniqueness.
- Consider adding pagination / composite aggregates (e.g. daily snapshots) downstream.

## Future Improvements
- Add derived fields (e.g., running coupon totals) using `BondSeries` aggregation.
- Add rate reciprocal auto-indexing for triangulation events.
- Introduce governance proposal status entity (Proposed/Queued/Executed).
