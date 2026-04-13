---
title: Claim Structure and Rights by Layer — Economic vs Legal Status
version: 1.0.0
status: draft
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/meta/Reserve_Lineage_and_Segregation_Specification.md
  - docs/meta/GRU_Classification_Matrix.md
  - docs/meta/Legal_Enforceability_Annex.md
---

# Claim structure and rights by layer

## 1. Purpose

State **as explicitly as the repo currently can** what holders **economically** hold at M1, M0, and M00, how claims are **mediated**, and what remains **for counsel and member instruments** to finalize. This is **not** legal advice.

## 2. M1 (commercial / eMoney layer)

| Dimension | Normative description |
|-----------|------------------------|
| **Economic** | Claim on the **issuer (or licensed e-money institution)** to redeem or transfer **GRU face** at **`1 GRU = 1 XAU`** policy assignment, subject to **program terms**, **AML**, and **liquidity** rules. |
| **Direct vault / bar right?** | **Default: no.** Retail M1 is ordinarily a **contractual / book-entry** claim on the **issuer or PSP**, not a **direct** undivided interest in a named gold bar unless a **separate** warehouse-receipt or bailment program exists ([reserve lineage](Reserve_Lineage_and_Segregation_Specification.md)). |
| **Insolvency** | Treatment follows **host-state** insolvency law for **e-money / deposit-like** instruments and **contractual** priority — **not** fully specified here. |
| **Freeze / seizure** | Subject to **court order**, **sanctions**, and **mandatory law**; any **non-seizure** narrative must be read alongside [Legal enforceability annex](Legal_Enforceability_Annex.md). |

## 3. M0 (institutional reserve layer)

| Dimension | Normative description |
|-----------|------------------------|
| **Economic** | Institutions hold **M0 GRU** as **wholesale** liquidity with **1 XAU** face and **1.2 XAU** supporting policy; interbank terms are **contractual**. |
| **Mediation** | M0 participants typically face the **issuer / program operator** or **DBIS-layer** settlement agent under **bilateral or clearing** agreements. |
| **Substitution / impairment** | Governed by **facility docs** + [reserve lineage](Reserve_Lineage_and_Segregation_Specification.md) substitution rules. |

## 4. M00 (sovereign / program anchor layer)

| Dimension | Normative description |
|-----------|------------------------|
| **Economic** | Program-level **anchor** for collateral and issuance; **6 XAU** supporting per **1 M00 GRU** face under baseline basket policy. |
| **Legal form** | May be implemented as **trust**, **special purpose entity**, **sovereign reserve account**, or **international organization** account — **member-specific**. |
| **Beneficial vs legal owner** | Split must be disclosed per **jurisdiction schedule** (legal annex deliverable). |

## 5. Cross-border and dispute

- **Conflict of laws:** not deterministic in this repo; requires **schedule** per corridor.
- **Arbitration / UNCITRAL** references in governance docs are **design intent** until instruments are filed — see [Legal enforceability annex](Legal_Enforceability_Annex.md).

## 6. Open items (central-bank-grade closure)

1. **Prospectus / terms & conditions** text for each **M1** program (retail vs wholesale).
2. **Insolvency waterfall** numeric priorities filed with **host regulator**.
3. **Direct vs indirect** holding mechanics for **tokenized** vs **account-based** M1.
4. **Standing** — who may sue for **reserve shortfall** and in which seat.

Until those are published, external reviewers should treat this document as the **repo’s declared economic meaning**, not a substitute for **national law** or **offering documents**.
