---
title: GRU Monetary Policy Framework
version: 1.0.1
status: stable
last_updated: 2026-03-31
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
Assigned value and supporting asset value are different measures. Assigned value is the unit used for parity, booking, settlement, and policy control. Supporting asset value is the quantity of reserve assets required to support that unit at a given layer.
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

*See Glossary and GRU_Formulas for full specification and audit fields.*
