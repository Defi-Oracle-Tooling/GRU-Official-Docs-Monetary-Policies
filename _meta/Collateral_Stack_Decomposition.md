---
title: Collateral Stack Decomposition
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: mechanics
checksum: pending
related_docs:
  - docs/meta/Canonical_Parity_and_Unit_Definition_Specification.md
  - docs/meta/Glossary.md
  - docs/meta/GRU_Formulas.md
---

# Collateral stack decomposition

## 1. Purpose

Give a **single mathematical picture** of how collateral is stacked from **index constituents** through **M00**, **M0**, and **M1**, without conflating **face parity** with **supporting asset value**.

## 2. Primary anchor

- **Policy anchor:** physical and allocated **XAU** (gold) and gold-index components inside the Li system.
- **Operational FX anchor (companion chains):** `cXAUC` / `cXAUT` tokenized references for triangulation and pricing feeds.

## 3. Index-class layer (LiXAU, LiPMG, LiBMG1–3)

Each Li index has a **valuation identity** linking the index unit to an XAU-equivalent basis using the shared scalar (see Glossary and [LiXAU scalar annex](/meta/lixau-scalar-and-decay-exponent-annex/)):

```text
1 Li(Index) = (1.2 / 0.9475^4) XAU   [valuation basis; subject to methodology annex]
```

The five index classes are **not** five different face values for GRU; they are **collateral-side** building blocks aggregated into M00.

## 4. M00 aggregate (collateral definition for sovereign issuance)

**M00 composite (asset-backed collateral magnitude):**

```text
M00_collateral_units = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
```

**LiCRI (face-value composite for dashboards):**

```text
LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
```

LiCRI is a **reporting composite**; M00 issuance tests use **M00 composite**, not LiCRI, unless a specific policy instrument explicitly says otherwise.

**Supporting value per 1 M00 GRU (face):** When the five Li components are in **policy-normalized “equal value”** configuration, the framework targets **6.0 XAU** supporting per **1 M00 GRU** (five contributions × **1.2 XAU** each). This matches the **6 XAU : 1 M00 GRU** row in the OMNL operational manual, interpreted as **supporting**, not face.

## 5. M0 layer (institutional reserve)

- **Face:** `1 M0 GRU = 1 XAU` (assigned).
- **Supporting:** `1 M0 GRU` backed by **1.2 XAU** of supporting assets (120% rule at this layer).
- **Stock fan-out:** `1 M00 = 5 M0` **face** GRU units.

## 6. M1 layer (commercial / eMoney circulation)

- **Face:** `1 M1 GRU = 1 XAU` (assigned).
- **Supporting:** `1 M1 GRU` backed by **6 / 25 = 0.24 XAU** supporting assets under the baseline `1 M00 : 25 M1` fan-out and **6 XAU** supporting per M00.
- **Stock fan-out:** `1 M0 = 5 M1` **face** GRU units; equivalently `1 M00 = 25 M1`.

## 7. “120% vs 600% vs 1.44” in one place

| Question | Canonical answer |
|----------|------------------|
| Is the system **120%** collateralized? | **Yes**, as the **minimum coverage ratio** policy on circulating GRU **value** vs reserve **value** (see monetary framework and formulas). |
| Where does **“600%”** language appear? | As **6.0 XAU supporting per 1 M00 GRU face** — a **layer-specific** collateral intensity, not a second definition of face parity. |
| Is **1.44 XAU** the M0 or M1 face? | **No.** **1.44** arises only from an **invalid** double stack that treats deprecated shorthand as sequential face redefinition. See [Canonical parity](/meta/canonical-parity-and-unit-definition-specification/). |

## 8. Interfaces to triangulation and issuance

- **Triangulation** (policy narrative): `source asset → XAU → GRU → target asset`. That route defines **valuation and conversion paths**, not an extra hidden face value.
- **7:10 issuance** and **40/40/20** splits operate on **issued M1 stock** and reserve / expansion / stabilization accounts — see [Solvency worked examples](/meta/solvency-worked-ledger-examples-7-10-protocol/).
