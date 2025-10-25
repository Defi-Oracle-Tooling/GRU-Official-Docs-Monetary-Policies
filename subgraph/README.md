# GRU Subgraph

This directory provides an indexing scaffold for GRU Diamond events.

## Structure
- `schema.graphql` – Entity definitions for all facet events plus analytic aggregates (daily, rolling windows, EMAs, confidence intervals).
- `subgraph.yaml` – Data source configuration pointing to the Diamond address and its ABI.
- `src/mapping.ts` – Handlers converting logs into entities, computing rolling statistics, EMAs, and 95% confidence intervals.

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
- Analytics layer includes:
	- `DailyLiCRISnapshot`: moving averages (7/30/90/180), variance numerators, std dev, EMAs, 95% confidence intervals (mean ±1.96·σ), and alpha factors (scaled 1e6) for EMA smoothing.
	- `LiCRIRollingWindow`: generic per-window (7/30/90/180) statistics (average, variance numerator, std dev) for flexible charting.
	- `BondSeriesCouponSnapshot`: cumulative daily coupon accrual per bond series.
- EMAs use integer smoothing approximation: EMA_t = (val*2 + prev*(n-1)) / (n+1); alpha = 2/(n+1) scaled by 1e6 persisted in snapshot.
- Std dev uses integer square root; confidence interval multiplier approximated with 1.96 (scaled 196/100).

## Future Improvements
- Optional BigDecimal scaling for higher precision variance & EMA.
- Percentile bands (e.g. 95th) using reservoir or order-stat approximations.
- Volatility clustering metrics (e.g. rolling squared returns once price feed integrated).
- Merge window entities into a single multi-window snapshot for query efficiency.
- Automatic pruning / archival of old gas benchmark artifacts.
