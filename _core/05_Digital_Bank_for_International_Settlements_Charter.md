---
title: Digital Bank for International Settlements (DBIS) Concept Charter
version: 1.0.1
status: stable
last_updated: 2026-03-31
layer: charter
checksum: pending
lang: en
---
# Digital Bank for International Settlements (DBIS) — Concept Charter

## I. Preamble
The DBIS is founded to provide a sovereign-neutral, transparent, asset-backed coordination layer for global monetary stability using the GRU.

At the implementation layer, GRU uses the ERC-2535 Diamond standard because its reserve architecture is intentionally modular: multiple issuance layers, compliance controls, token standards, and asset-specific behaviors must coexist without forcing a single monolithic contract. Diamond facets let the GRU evolve policy-by-policy while preserving one coherent governance surface.

## II. Principles
1. Sovereign neutrality
2. Algorithmic transparency
3. Asset-backed integrity (XAU anchoring via `cXAUC/cXAUT`)
4. Inclusive interoperability (CBDCs, commodities, securities)
5. Audit-first governance

## III. Governance Architecture
| Body | Role | Decision Threshold |
|------|-----|-------------------|
| Council of Governors (COG) | Strategic & admission decisions | 2/3 majority |
| Monetary Policy Chamber (MPC) | Parity & issuance control | Quorum + supermajority |
| Reserve Audit Chamber (RAC) | Reserve verification | Formal attestation |
| Secretariat | Administrative operations | Procedural |

## IV. Legal Foundation
- Recognition under UNCITRAL international arbitration norms
- Arbitration seat: New York; satellite hubs in Geneva, Singapore, Dubai
- Treaty-level immunity for registered reserve operations

## V. GRU Integration Clause
```text
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
Assigned / face parity: 1 GRU = 1 XAU
Supporting asset value: 1 M0 GRU = 1.2 XAU
Supporting asset value: 1 M00 GRU = 6.0 XAU
```
Minimum reserve coverage: ≥ 120% verified.
Assigned / face parity remains `1 XAU` per GRU. The larger XAU figures in this charter describe supporting asset coverage, not a separate settlement unit.

The M00 reserve basket is built from five equal-value Li indices:

- LiXAU = gold reserve index
- LiPMG = Precious Metals Group index
- LiBMG1 = Base Metals Group index
- LiBMG2 = Battery Materials Group index
- LiBMG3 = Building Metals Group index

Accordingly:

```text
1 M00 GRU = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
```

Current M1 implementation surface: canonical Chain 138 `c*` assets and mirrored public-network `cW*` transport assets.

## VI. Triangulation & Issuance
- All issuance atomic: Source → XAU → GRU → Destination
- Expansion function: E = I × (10/7) × (1 - f)^n
- 40/40/20 application binding for standardized liquidity alignment

## VII. Bond Instruments Recognition
- Li99PpOsB10 & Li99PpAvB10 accepted as internal stabilization + expansion tools
- 10-year buy-back mandate enforceable via coupon escrow

## VIII. Proof-of-Reserves (PoR)
- Quarterly multi-auditor attestation
- DSL registered ledger entries with hashed timestamp proofs

## IX. Monetary Control
| Instrument | Purpose |
|-----------|---------|
| MPAP | Parity drift correction |
| ACP | Excess supply compression |
| Bond Yield Modulation | Liquidity elasticity |
| Velocity Index (VGRU) | Dynamic policy input |

## X. Interoperability Mandates
- ISO 20022 event mapping
- CBDC bridging adapters
- Digital Reserve Basket (DRB) pilot index:
```
DRB = 0.40 XAU + 0.25 EUR + 0.15 USD + 0.10 BTC + 0.10 LiXAU
```

## XI. Legal Protections
- Non-seizure clause for reserves
- Arbitration-first dispute resolution
- Data immutability security classification

## XII. Implementation Roadmap
| Phase | Timeline | Milestones |
|-------|----------|-----------|
| Establishment | 0–12m | Charter ratification, initial reserve registry |
| Integration | 12–24m | CBDC test settlements, bond cycle launch |
| Global Operation | 24–48m | DRB publication, expanded membership |

## XIII. Amendment Process
- Charter amendments require 2/3 COG vote and MPC concurrence

## XIV. Ratification Block (Template)
| Entity | Representative | Title | Signature | Date |
|--------|---------------|-------|----------|------|
| Sovereign Member | TBD | TBD | ___ | ___ |
| Digital Authority | TBD | TBD | ___ | ___ |
| Reserve Custodian | TBD | TBD | ___ | ___ |
| GRU Monetary Authority | TBD | TBD | ___ | ___ |

## XV. Annex Placeholders
- Annex I: Atomic Transaction Diagram
- Annex II: Multi-Anchor Triangulation Matrix
- Annex III: Bond Cycle Escrow Model
- Annex IV: PoR Attestation Template
- Annex V: Legal Reference Index

---

## Commodity Index Registry & Dashboard Integration

- **LiCRI (Face-Value Composite):**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  Used for DBIS reporting and benchmarking.

- **M00 Composite (Asset-Backed Collateral):**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  Used for reserve magnitude and issuance collateral.

*See Glossary and GRU_Formulas for full specification and audit fields.*

## Summary
The DBIS Charter codifies a modern institutional reserve framework, delivering transparent, asset-backed global settlement capability through GRU integration.
