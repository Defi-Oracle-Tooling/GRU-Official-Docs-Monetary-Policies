---
title: Valuation Taxonomy — Face, Settlement, Reserve, Collateral, Accounting
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/meta/Canonical_Parity_and_Unit_Definition_Specification.md
  - docs/meta/Collateral_Stack_Decomposition.md
---

# Valuation taxonomy — face, settlement, reserve, collateral, accounting

## 1. Purpose

Reserve documentation reuses terms (**face**, **parity**, **asset value**, **collateral**, **coverage**). This taxonomy assigns **one meaning per term** for external reviewers.

## 2. Definitions

| Term | Definition | Typical use |
|------|------------|-------------|
| **Face value** | Nominal GRU amount times **assigned parity** `1 GRU = 1 XAU` (troy ounce basis for policy). | Client balances, ISO 20022 `InstdAmt` when currency is GRU, public statements. |
| **Settlement value** | Value used to **clear** a payment leg in a **specific rail currency** (e.g. EUR) at **observed FX** `P_e` (EUR per XAU) or triangulated equivalent. | SEPA debit amount, nostro/vostro posting in EUR. |
| **Reserve value** | **Audited** quantity of eligible reserve assets × **policy marks** (LBMA fix, approved oracle marks, haircuts). | Proof-of-reserves, regulator dashboards, coverage ratio numerator. |
| **Collateral value** | Marked value of **index-linked and vault** positions supporting a tier, including Li basket components before aggregation to M00. | Stress tests, MPAP / ACP triggers, index methodology. |
| **Accounting value** | Carrying amount under **IFRS / IAS** (or local GAAP), which may differ from face or reserve marks due to amortized cost, OCI, or liability classification. | Issuer financial statements; see compliance memos. |

## 3. Non-goals

- This taxonomy does **not** replace national GAAP or regulator-specific reporting templates.
- It does **not** fix hedge accounting rules for gold derivatives; it only separates **policy face** from **settlement FX**.

## 4. Consistency rules

1. **Face** never drifts with the EUR/XAU spot; **settlement value** does.
2. **Coverage** tests use **reserve value** vs **face-equivalent exposure** unless a published stress methodology explicitly switches denominators.
3. **LiCRI** movements affect **collateral value** and **risk** metrics; they do not redefine **face parity** without a governance event explicitly labeled “parity reassignment” (not currently part of the baseline model).

## 5. Cross-reference

Canonical numeric identities: [Canonical parity and unit definition](/meta/canonical-parity-and-unit-definition-specification/) and [Collateral stack decomposition](/meta/collateral-stack-decomposition/).
