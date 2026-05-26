---
title: GRU Monetary Policy Framework
version: 1.0.2
status: stable
last_updated: 2026-05-25
layer: policy
checksum: pending
---
# GRU Monetary Policy Framework

## Overview
The Global Reserve Unit (GRU) establishes a multi-tier, asset-backed monetary system, anchoring all liquidity via XAU (gold) to ensure intrinsic value, auditable parity, and cross-domain convertibility. In operational terms, all FX is triangulated through XAU with `cXAUC/cXAUT` as the on-chain asset reference.

### Issuance Cycle Diagram
![GRU Issuance Cycle](/assets/media/issuance_cycle.png)
*Figure: Reserve → Issuance → Circulation with liquidity recycling loop and coverage maintenance.*

## Core Ratios
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Dynamic coefficients (x, y) are policy-adjusted distribution weights between M0 (institutional) and M1 (commercial) layers.

## Assigned / Face Value vs Supporting Asset Value
```text
Assigned / face value (parity, accounting, settlement):
1 GRU = 1 XAU
1 M0 GRU = 1 XAU
1 M1 GRU = 1 XAU

Supporting asset value (reserve-side coverage):
1 M0 GRU = 1.2 XAU of supporting assets
1 M00 GRU = 6.0 XAU of supporting assets
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
For avoidance of doubt, assigned value and supporting asset value are different measures. Assigned value is the unit used for parity, booking, settlement, and policy control. Supporting asset value is the quantity of reserve assets required to support that unit at a given layer. Earlier shorthand such as `1 XAU GRU = 1.2 XAU` refers to supporting asset value and must not be read as changing the assigned parity of `1 GRU = 1 XAU`.

LiXAU is the gold reserve index. Within the Li framework, five equal-value components form the operational composite:
- `LiXAU` = gold reserve index
- `LiPMG` = Precious Metals Group index
- `LiBMG1` = Base Metals Group index
- `LiBMG2` = Battery Materials Group index
- `LiBMG3` = Building Metals Group index

## Layer Structure
| Layer | Function | Description |
|-------|----------|-------------|
| M00 | Sovereign Issuance | Base creation tied 1:1 to audited reserves |
| M0  | Institutional Reserve | Interbank & authority level liquidity instrument |
| M1  | Commercial Circulation | Market & settlement eMoney layer |

Current implementation mapping: canonical Chain 138 `c*` assets are GRU M1 instruments. Public-network `cW*` assets are mirrored transport representations of that same GRU M1 layer and are not a separate monetary class.

## Chain 138 (Defi Oracle Meta) — RWA indices vs M1 transport

Chain 138 (`dfio_meta_main`, chainId **138**) hosts **two parallel tracks**. They must not be described as a single flow (“RWA → lock → CCIP → mint on public chains”) for all assets.

| Track | GRU layer | Symbols | Role on 138 | Public networks |
|-------|-----------|---------|-------------|-----------------|
| **Commodity / index RWA** | **M00** | **Li\*** (LiXAU, LiPMG, LiBMG1–3) | Institutional index instruments when deployed | DefiLlama **RWA** path when evidenced — **not** created via **cW\*** bridge escrow |
| **Compliant eMoney** | **M1** | **c\*** (cUSDT, cUSDC, cEURC, …) | Native hub issuance and settlement | **cW\*** wrapped transport (e.g. Ethereum, Optimism, BSC, Polygon, Wemix) |

**cXAUC / cXAUT** are **M1** eMoney with gold exposure for FX triangulation — **not** substitutes for **LiXAU** (M00 gold reserve index).

### M1 transport (c\* → cW\*)

Economic backing for **c\*** is primarily **off-chain GRU reserve policy** (M0/M00 layers), with Chain 138 as verification and settlement. For cross-chain **cW\***:

```text
Off-chain GRU reserves
  → c* native on Chain 138 (hub)
  → hub c* locked in bridge escrow on 138 (CWMultiTokenBridgeL1)
  → GRU multichain bridge / orchestration
  → cW* minted on destination public network
```

Escrow for wrapped supply sits on **138**, not as Circle USDC or Tether USDT locked on the destination chain. **CCIP** applies to defined lanes (e.g. WETH9/WETH10, LINK fee paths) and must not be used as the label for all **c\*** → **cW\*** movement unless that specific lane is intended.

Monorepo reference (operator docs): `docs/04-configuration/CHAIN138_RWA_AND_TRANSPORT_ARCHITECTURE.md` in the Proxmox deployment repository.

## Reserve Policy
- Minimum coverage: ≥ 120% of circulating GRU value.
- Asset tiers: Primary (XAU via `cXAUC/cXAUT`), secondary (Li, Pt, REE, sovereign ETFs), dynamic (tokenized verified assets).
- Parity deviation threshold: ±2.5% triggers MPAP (Monetary Parity Adjustment Protocol).

## Governance
Operates under Sovereign Hybrid Trust Entity (SHTE) with chambers:
- Monetary Policy Chamber (MPC)
- Reserve Audit Chamber (RAC)
- Bond Servicing Chamber (BSC)
- Technology & Ledger Chamber (TLC)
- Ethics & Compliance Chamber (ECC)

## Control Instruments
| Instrument | Purpose | Trigger |
|------------|---------|---------|
| MPAP | Adjust parity to XAU | Parity drift > 2.5% |
| ACP | Liquidity compression / burn | Excess supply > target band |
| Bond Yield Modulation | Supply elasticity | Velocity / inflation signals |

## Transparency
- Quarterly Proof-of-Reserves (PoR)
- Public Reserve Dashboard (planned)
- Smart ledger transaction attestations

## Inflation Ceiling
Annual net expansion capped at 2.75% unless crisis override executed by unanimous MPC + RAC vote.

## Summary
The framework combines mathematically disciplined issuance, gold parity, and multi-layer liquidity routing to form a sovereign-neutral, auditable reserve standard.

---

## Li Composite Indices & M00 Collateral — Reference

- **LiCRI (Face-Value Composite):**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  Used for reporting, benchmarking, and dashboards.

- **M00 Composite (Asset-Backed Collateral):**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  Used for reserve magnitude and issuance collateral.

The GRU monetary architecture uses ERC-2535 Diamond because reserve policy, compliance hooks, index logic, and asset-specific modules must evolve independently while sharing one governance surface.

*See Glossary and GRU_Formulas for full specification and audit fields. For auditor-grade definitions of face vs supporting value, layer fan-out, and triangulation proof targets, see [Deterministic specifications index](../meta/Deterministic_Specifications_Index.md) (published site: `/meta/deterministic-specifications-index/`). For **live vs placeholder** smart-contract and control disclosure, see [Implementation status and control disclosure](../meta/Implementation_Status_and_Control_Disclosure.md).*
