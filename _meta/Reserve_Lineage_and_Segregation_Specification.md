---
title: Reserve Lineage and Segregation Specification
version: 1.0.0
status: draft
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/meta/Transaction_State_Propagation_Specification.md
  - docs/disclosures/PoR_Methodology.md
---

# Reserve lineage and segregation specification

## 1. Purpose

Define **normative targets** for how reserves are **pooled**, **labeled**, and **traced** so that:

- M1 claims map to **M0 / M00** supporting mass without ambiguous commingling,
- **Substitution** of assets is logged,
- **Impairment** and **liquidation** follow a published waterfall.

## 2. Reserve pool identifiers (target schema)

| Pool ID | Layer | Eligible assets | Claimants |
|---------|-------|-----------------|-----------|
| `M00-P-*` | M00 | Li-aggregated + physical gold earmarked | Issuer / sovereign member |
| `M0-R-*` | M0 | Short-dated liquidity + credit lines against M00 | Licensed banks / PSPs |
| `M1-L-*` | M1 backing | Pro-rata share of upstream pools | End-users via intermediary |

**Rule:** retail **M1** does **not** assert a direct security interest in a named bar unless a **separate** warehouse receipt program exists.

**Mediated vs direct (M1):** by default M1 is a **contractual claim on the issuer / licensed EMI**, not a **pro rata** co-tenancy in a specific `M00-P-*` bar list. **Pro rata** or **pooled** beneficial structures require **explicit** prospectus language and **jurisdiction filing**.

## 3. Legal claim seniority (normative vocabulary — subject to counsel)

| Rank | Claim class | Typical holders | Notes |
|------|-------------|-----------------|-------|
| SS | **Super-senior / statutory** | Regulator segregations, court freezes | Overrides programmatic “non-seizure” narratives where **mandatory law** applies. |
| S1 | **Senior secured (program)** | Registered noteholders with **first-ranking** security on named pools | Requires **filed** security interest. |
| S2 | **Senior unsecured program** | M00 / sovereign facility lenders | Defined by facility agreement. |
| P0 | **Par — institutional M0** | Banks / PSPs under **M0** agreements | **Mediated** access to upstream pools. |
| P1 | **Par — retail M1** | End-users | **Issuer/EMI** claim; see [Claim structure](Claim_Structure_and_Rights_by_Layer.md). |
| J | **Junior** | Stabilization `S`, equity, sponsor support | First-loss in **documented** waterfalls. |

**Bond series (Li99):** may create **separate** tranches with **intercreditor** agreements; those agreements **override** this generic stack **only where** explicitly executed.

## 4. Substitution rules

- **Like-for-like** within approved asset class (e.g. bar serial swap) — logged with **before/after** custody attestation and **dual-control** release.
- **Cross-class substitution** (e.g. gold → short sovereign paper) — **governance-gated** + **30+ day** notice (unless emergency path) + **disclosure** + **pre- and post-coverage** simulation.
- **Authorization:** `RESERVE_SUBSTITUTION` events must carry `attestation_ref` and **two-of-three** (example) signers per governance matrix.

## 5. Impairment and recognition

- **Level 1:** MTM haircut inside tolerance — **OCI / P&L** per accounting policy; **no** supply action.
- **Level 2:** coverage **< floor** — **issuance stop** + **ACP study** + **public exception** flag on new events.
- **Level 3:** insolvency / resolution — **host-state** procedure; repo does **not** prescribe outcomes.

## 6. Impairment liquidation waterfall (numeric TBD)

Order of **application of loss** (not the same as creditor seniority table — counsel must align):

1. **Junior equity / sponsor** first-loss tranche  
2. **Stabilization `S`**  
3. **Expansion facility `E`** (if contractually subordinated)  
4. **Core reserve `R`** until regulatory minimum  
5. **Negotiated** restructuring with **senior** creditors

**Percent caps per layer** are **TBD** in RAC `v1` recovery playbook.

## 7. Cross-pool contamination rules

- **Hard rule:** no `M1-L-*` batch may net-settle against a **different** `M00-P-*` without a **published** bridge event (`LAYER_MIGRATION` + `lineage_pointer`).
- **Rehypothecation:** **off** unless a **named** jurisdiction package explicitly permits it with **haircut** tables.
- **Commingling tests:** monthly **pool purity** report: sum of child pool balances = parent pool balance within **ε**.

## 8. Commingling prevention (operational)

- **Accounting:** separate GL codes per `Pool ID`.
- **Custody:** ISAE 3402 / SOC reports naming **sub-accounts**.
- **On-chain:** hashed Merkle leaves per pool in `PoRPosted` (target).

## 9. Status

Segregation IDs, waterfall percentages, and **intercreditor** templates are **design targets** until RAC publishes **v1** operational tables and counsel files **security** language.
