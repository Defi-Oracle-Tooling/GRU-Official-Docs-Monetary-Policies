#!/usr/bin/env bash
set -euo pipefail

# Recreate subgraph/subgraph.yaml with clean indentation using a heredoc.
# Backs up existing manifest to subgraph/subgraph.yaml.bak if present.

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

MANIFEST="subgraph/subgraph.yaml"
BACKUP="subgraph/subgraph.yaml.bak"

if [ -f "$MANIFEST" ]; then
  echo "Backing up existing $MANIFEST to $BACKUP" >&2
  mv "$MANIFEST" "$BACKUP"
fi

cat > "$MANIFEST" <<'EOF'
specVersion: 0.0.5
schema:
  file: ./schema.graphql
dataSources:
  - kind: ethereum
    name: GrcDiamond
    network: mainnet
    source:
      address: "0x0000000000000000000000000000000000000000"
      abi: GrcDiamond
      startBlock: 0
    mapping:
      kind: ethereum/events
      apiVersion: 0.0.7
      language: wasm/assemblyscript
      entities:
        - IndexWeightsUpdated
        - DashboardSnapshot
        - BondIssued
        - CouponsAccrued
        - BondBuyback
        - CutProposed
        - CutQueued
        - CutExecuted
        - EmergencyBrake
        - FunctionPaused
        - PoRPosted
        - PoRSealed
        - RateSet
        - Triangulated
        - Redeemed
        - FeeUpdated
        - DailyLiCRISnapshot
        - GovernanceProposal
        - BondSeriesCouponSnapshot
        - LiCRIRollingWindow
      abis:
        - name: GrcDiamond
          file: ../artifacts/contracts/GrcDiamond.sol/GrcDiamond.json
      eventHandlers:
        - event: IndexWeightsUpdated(indexed bytes32,uint64)
          handler: handleIndexWeightsUpdated
        - event: DashboardSnapshot(indexed bytes32,uint64,uint256,uint256)
          handler: handleDashboardSnapshot
        - event: BondIssued(indexed bytes32,indexed address,uint256)
          handler: handleBondIssued
        - event: CouponsAccrued(indexed bytes32,uint256)
          handler: handleCouponsAccrued
        - event: BondBuyback(indexed bytes32,uint256)
          handler: handleBondBuyback
        - event: CutProposed(indexed bytes32,address,address,bytes)
          handler: handleCutProposed
        - event: CutQueued(indexed bytes32,uint256)
          handler: handleCutQueued
        - event: CutExecuted(indexed bytes32)
          handler: handleCutExecuted
        - event: EmergencyBrake(indexed bytes4,bool)
          handler: handleEmergencyBrake
        - event: FunctionPaused(indexed bytes4,bool)
          handler: handleFunctionPaused
        - event: PoRPosted(indexed uint64,bytes32,string)
          handler: handlePoRPosted
        - event: PoRSealed(indexed uint64)
          handler: handlePoRSealed
        - event: RateSet(indexed bytes32,indexed bytes32,uint256)
          handler: handleRateSet
        - event: Triangulated(indexed bytes32,indexed bytes32,uint256,uint256)
          handler: handleTriangulated
        - event: Redeemed(indexed bytes32,indexed bytes32,uint256,uint256)
          handler: handleRedeemed
        - event: FeeUpdated(uint256,uint256)
          handler: handleFeeUpdated
      file: ./src/mapping.ts
EOF

echo "Recreated $MANIFEST successfully." >&2