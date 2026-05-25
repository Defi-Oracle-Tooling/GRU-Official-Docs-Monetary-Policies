---
title: Accounting Policy — IFRS / IAS 32 Classification of GRU
version: 1.0.0
status: pending_qualified_signoff
effective_date: null
policy_id: OMNL-AP-IAS32-GRU-2026-001
last_updated: 2026-05-20
---

# Accounting policy — IFRS / IAS 32 classification of GRU

**Status:** Template ready for qualified accountant sign-off. This document is **not** statutory audit advice.

**Related:** [07_OMNL_Central_Bank_DBIS_Operational_Manual](../../core/07_OMNL_Central_Bank_DBIS_Operational_Manual.md) · [GRU_Classification_Matrix](../../meta/GRU_Classification_Matrix.md) · [omnl-ipsas-gl-registry.json](../../../../smom-dbis-138/config/omnl-ipsas-gl-registry.json)

---

## 1. Purpose and scope

This policy defines how **OMNL / DBIS** classifies and measures **Global Reserve Unit (GRU)** and related ledger balances under **IFRS** and **IAS 32 Financial Instruments: Presentation**, for the OMNL Fineract tenant and aligned IPSAS public-sector reporting.

**Reporting entity (confirm):** ___________________________

**Consolidation perimeter (confirm):** ___________________________

---

## 2. Unit definition (monetary vs accounting)

| Concept | Definition |
|---------|------------|
| **Face parity** | 1 GRU = 1 troy ounce XAU (assigned value) |
| **Supporting collateral** | Tier-dependent XAU coverage (M00 6 oz, M0 1.2 oz, M1 0.24 oz per GRU) — see operational manual §2 |
| **Token** | Ledger carrier on Chain 138 / ALL Mainnet (`c*` instruments) — not a separate monetary tier |

GRU **M1** in circulation is presented as a **financial liability** of the issuer when the issuer has a contractual obligation to honour redemption/settlement at face parity.

---

## 3. IAS 32 classification

| Instrument / balance | Classification | Measurement (IFRS 9) | Fineract GL (primary) |
|---------------------|----------------|----------------------|------------------------|
| M1 GRU in issue | **Financial liability** | Amortized cost (unless FVTPL elected — document election) | 2000, 2100 |
| M0 treasury reserve asset | **Financial asset** | Amortized cost / FVTPL per election | 1050 |
| M00 base reserve (control) | **Financial liability** (program layer) | Per component analysis | 21010 |
| EUR SEPA settlement | **Cash / payable** | N/A | 1000, 13010 |
| Escrow / restricted M1 | **Financial liability** (restricted) | Amortized cost | 2100 |
| Physical XAU at custodian | **Off-balance** custodial asset or inventory per legal form | N/A — reconciled to on-chain `R` | 12090 (FX/XAU reserve tagging) |

**Accountant conclusion (sign below):** GRU M1 is classified as □ financial liability □ other (specify) _______________

**IFRS reference paragraphs cited:** ___________________________

---

## 4. Recognition and derecognition

- **Issuance:** Credit liability (2000/2100), debit reserve/settlement (1000/1050) per journal matrix.
- **Redemption / settlement:** Reverse issuance pattern; EUR leg via SEPA per operational flow §5.
- **Derecognition:** When contractual obligation extinguished and no continuing involvement — document criteria here: ___________________________

---

## 5. On-chain vs books boundary

| Source | Role |
|--------|------|
| **Fineract OMNL** | System of record for institutional GL and journals |
| **ReserveCommitmentStore `R`** | Attested reserve commitment — **supporting** evidence, not substitute for GL |
| **ComplianceCore** | Policy math gate (`reportingCompliant`) — operational control |

---

## 6. Disclosures (IFRS 7 cross-reference)

Issuer prepares liquidity and market risk disclosures using:

- `GET /api/v1/omnl/disclosures/ifrs7` (automated extract)
- This policy + signed `config/compliance/ias32-gru-signoff.v1.json`

---

## 7. Sign-off block

| Role | Name | Firm | Date | Signature |
|------|------|------|------|-----------|
| Preparer | | | | |
| Reviewer (qualified accountant) | | | | |
| External auditor (optional) | | | | |

After sign-off: update `config/compliance/ias32-gru-signoff.v1.json` (`status: signed`, `policyHash`, `signedAt`).
