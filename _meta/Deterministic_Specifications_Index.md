---
title: Deterministic Specifications Index
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: meta
checksum: pending
related_docs:
  - docs/core/01_GRU_Monetary_Policy_Framework.md
  - docs/meta/GRU_Formulas.md
---

# Deterministic specifications index

This index lists **normative-style** documents that translate GRU policy from narrative architecture into **auditor-facing rules**: definitions, ledgers, events, governance mechanics, and explicit gaps where parameters are still provisional.

These specifications **sit above** any single deployment (for example OMNL / SEPA rails) and **below** the high-level core whitepapers. Where a profile-specific rule differs (attestation cadence, committee naming), the profile document states its scope and defers to the canonical spec for monetary definitions.

**Implementation truth:** cross-check claims against [Implementation status and control disclosure](/meta/implementation-status-and-control-disclosure/) (`live` / `partial` / `conceptual` / `placeholder` / `deprecated`).

**Merge / tag review:** [Acceptance checklist for `docs-review-fixes`](DOCS_REVIEW_FIXES_ACCEPTANCE_CHECKLIST.md) (site: `/meta/docs-review-fixes-acceptance-checklist/`).

| Document | Purpose |
|----------|---------|
| [Canonical parity quick reference](/meta/canonical-parity-quick-reference/) | **One-page** face vs supporting; where **6 / 1.2 / 0.24** apply; deprecated “XAU GRU” shorthand. |
| [Canonical parity and unit definition](/meta/canonical-parity-and-unit-definition-specification/) | Single source for unit of account, face parity, reserve backing, and why `1.2 × 1.2` must not be read as M1 face value. |
| [Collateral stack decomposition](/meta/collateral-stack-decomposition/) | Layer-by-layer supporting-asset math from Li indices through M00, M0, and M1. |
| [Valuation taxonomy](/meta/valuation-taxonomy-face-settlement-reserve-collateral-accounting/) | Definitions of face, settlement, reserve, collateral, and accounting value. |
| [Transaction state propagation](/meta/transaction-state-propagation-specification/) | Target event schema, reserve lineage fields, and on-chain vs off-chain proof boundaries. |
| [Solvency worked ledger examples (7:10)](/meta/solvency-worked-ledger-examples-7-10-protocol/) | Balance-sheet style examples tying 7:10 and 40/40/20 to layer ratios. |
| [Velocity policy rulebook](/meta/velocity-policy-rulebook/) | Measurement → action mapping; explicit **TBD** thresholds pending MPC adoption. |
| [Index methodology annex](/meta/index-methodology-annex/) | Reproducibility requirements per Li class; weights and venues **TBD** where not fixed. |
| [LiXAU scalar and decay exponent annex](/meta/lixau-scalar-and-decay-exponent-annex/) | Status of `0.9475^4`, sensitivity, and change control. |
| [Legal enforceability annex](/meta/legal-enforceability-annex/) | Questions an external counsel panel must close; not legal advice. |
| [Governance decision matrix](/meta/governance-decision-matrix/) | Action types, quorum, emergency paths, OMNL label mapping to SHTE chambers. |
| [Reserve lineage and segregation](/meta/reserve-lineage-and-segregation-specification/) | Pool IDs, claim seniority, substitution, impairment — normative targets. |
| [Claim structure and rights by layer](/meta/claim-structure-and-rights-by-layer/) | What M1/M0/M00 holders hold; direct vs mediated; insolvency / freeze — economic meaning + open legal items. |
| [GRU classification matrix](/meta/gru-classification-matrix/) | Currency vs liability vs instrument vs modality across regulatory frames. |
| [Implementation status and control disclosure](/meta/implementation-status-and-control-disclosure/) | Conceptual vs implemented vs placeholder (contracts and oracles). |

Start with **Canonical parity quick reference**, then **Canonical parity** and **Collateral stack**, then **Valuation taxonomy**, then domain-specific annexes as needed.

## Maintenance: stale-language scrub

When editing any diagram, caption, translation, or legacy PDF, search for ambiguous phrases (`1 XAU GRU = 1.2 XAU` without context, `1.44`, `1 GRU = 1.2 XAU` face, “parity” for “supporting coverage”) and align to the quick reference + canonical parity spec.
