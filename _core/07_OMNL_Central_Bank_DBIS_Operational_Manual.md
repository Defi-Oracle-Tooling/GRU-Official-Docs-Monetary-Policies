---
title: OMNL Central Bank | Digital Bank of International Settlements - Operational Policy & Transaction Flow Manual
version: 1.0.1
status: stable
last_updated: 2026-03-31
layer: operational-policy
document_ref: OMNL/DBIS-GRU-2025-POL01
effective_date: October 2025
checksum: pending
lang: en
---

# OMNL Central Bank | Digital Bank of International Settlements  
### ARIN-Registered Monetary Policy & Compliance Division  
**Document Ref:** OMNL/DBIS-GRU-2025-POL01  
**Effective Date:** October 2025  

---

## 0 — Document scope, authority, and alignment with the core corpus

This manual is an **OMNL / DBIS implementation profile**: it describes **European-facing** operational flows (SEPA, EUR settlement, MiCA/DORA reporting labels, ISO 20022 samples) for a **specific deployment**. It does **not** supersede normative monetary definitions in **01_GRU_Monetary_Policy_Framework**, **GRU_Formulas**, or the **[canonical parity and unit definition specification](/meta/canonical-parity-and-unit-definition-specification/)**.

| Topic | Core / canonical specs | This manual (profile) |
|-------|-------------------------|------------------------|
| One-page anti-confusion | [Canonical parity quick reference](/meta/canonical-parity-quick-reference/) | Same face vs supporting rules apply to this profile |
| Face vs supporting XAU per tier | [Canonical parity](/meta/canonical-parity-and-unit-definition-specification/), [Collateral stack](/meta/collateral-stack-decomposition/) | Table in Section 2 = **supporting** ratios (`6`, `1.20`, `0.24` XAU per GRU) alongside **face** `1 GRU = 1 XAU` |
| PoR / attestation **cadence** | Framework: **quarterly** composite emphasis; **PoR methodology**: MiCA-aligned **daily** composition reporting where applicable | **Monthly** operational attestation (Section 7) + **quarterly** ICT/AML reviews |
| Governance labels | Five-chamber **SHTE** model | **MPC / RCC / Audit Board** naming for banking audiences — see [Governance decision matrix](/meta/governance-decision-matrix/) |

Readers resolving an apparent conflict should treat **canonical parity / collateral stack** as controlling **meanings**, and this manual as controlling **this profile’s** operational cadence and rail-specific flows.

---

## 1 — Executive Overview
The **Global Reserve Unit (GRU)** is a gold-referenced, unit-invariant instrument designed to unify reserve, institutional, and settlement liquidity under a transparent regulatory architecture. At the implementation layer, GRU uses ERC-2535 Diamond so reserve policy, compliance, index mechanics, and asset-specific behavior can evolve without fragmenting governance.

The GRU implementation uses the ERC-2535 Diamond standard because the system is intentionally modular: reserve layers, issuance rules, compliance controls, multi-token baskets, and asset-specific behaviors need to coexist without forcing a single monolithic contract shape. Diamond facets let the GRU evolve without breaking the shared governance surface.

- **Assigned / face parity:** 1 GRU = 1 XAU (troy ounce of gold)  
- **Governance:** OMNL Central Bank (ARIN code OMNL-DBIS)  
- **Oversight Partner:** Digital Bank of International Settlements (DBIS)  
- **Regulatory Alignment:** ECB / ICC / MiCA / DORA / SEPA / AML-CFT / GDPR  

The manual defines monetary structure, account architecture, transaction flow, and compliance responsibilities. Operationally, all FX is triangulated through XAU using `cXAUC/cXAUT`, and the M00 basket references the five equal-value Li indices: LiXAU, LiPMG, LiBMG1, LiBMG2, and LiBMG3.

For audit clarity, this manual distinguishes assigned value from supporting asset value. Assigned value is the accounting and settlement parity of the GRU unit (`1 GRU = 1 XAU`). Supporting asset value is the reserve quantity carried by the layer that supports that unit.

---

## 2 — Monetary Structure

| Tier | Function | Supporting Asset Coverage | Money Multiplier | Purpose |
|------|-----------|---------------------------|------------------|----------|
| **M00** | Sovereign Reserve | 6 XAU : 1 M00 GRU (6.00 XAU/GRU) | Base Reserve | Long-term collateral |
| **M0** | Institutional Reserve | 6 XAU : 5 M0 GRU (1.20 XAU/GRU) | 1 M00 = 5 M0 | Monetary Base |
| **M1** | Circulation / Settlement | 6 XAU : 25 M1 GRU (0.24 XAU/GRU) | 1 M0 = 5 M1 | SEPA Fiat Interface |

The M00 reserve basket is composed of five equal-value Li indices:

- LiXAU = gold reserve index
- LiPMG = Precious Metals Group index
- LiBMG1 = Base Metals Group index
- LiBMG2 = Battery Materials Group index
- LiBMG3 = Building Metals Group index

Operationally:

```text
1 M00 GRU = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
```

**Cross-Formula:** 1 M00 = 5 M0 = 25 M1 GRU.  
Assigned / face value is always `1 XAU` per GRU. Supporting asset value is `1.2 XAU` per `M0 GRU`; because M00 is composed of five equal-value Li classes, `1 M00 GRU` carries `6.0 XAU` of supporting asset value.

Current implementation mapping: canonical Chain 138 `c*` instruments and public-network `cW*` mirrors are the current GRU M1 settlement surface. `cW*` denotes a mirrored transport representation of canonical GRU M1, not a separate monetary tier.

---

## 3 — Account and Custody Framework

| Account Type | Currency | Institution | Purpose |
|---------------|-----------|--------------|----------|
| **M00 Reserve** | GRU | OMNL Reserve Ledger | Core gold-backed reserves |
| **M0 Treasury** | GRU | OMNL Treasury Division | Intermediate liquidity |
| **M1 Settlement** | EUR | DBIS / SEPA Partner Bank | External payments |
| **Collateral Vault** | XAU | LBMA-accredited Vault | Physical gold custody |
| **Compliance Escrow** | EUR | DBIS Compliance Node | AML / Sanctions clearing |
| **Fee Reconciliation** | EUR | DBIS Settlement Ops | Charges and FX balancing |

All accounts are subject to PoR (Proof of Reserves) audits and daily reconciliation.

---

## 4 — Regulatory Compliance Framework

| Regulation | Domain | Implementation |
|-------------|---------|----------------|
| **MiCA (EU 2023/1114)** | Digital asset classification | GRU = asset-referenced token backed by XAU |
| **DORA (EU 2022/2554)** | ICT resilience | Incident response, BCP, testing logs |
| **SEPA / IPR (EU 2024/886)** | Payment execution | SCT/SCT Inst compliance, instant screening |
| **PSD2 / E-Money** | Payment services | DBIS licensed PSP under PSD2 |
| **AML / CFT** | Compliance | KYC, CDD, TM, PEP screening |
| **GDPR (EU 2016/679)** | Data protection | DPIA filed, no PII on-ledger |
| **IFRS / IAS 32** | Accounting | GRU treated as financial liability |
| **ICC (UCP 600 / URDG 758)** | Documentary discipline | Standardized undertaking formats |

---

## 5 — Transaction Flow Process

### 5.1 Pre-Transaction
1. Counterparty onboarding (KYC / Sanctions pass).  
2. Oracle feeds LBMA gold fix → EUR/XAU rate = Pₑ.  
3. Contract & coverage verified by OMNL Compliance.

### 5.2 Execution
1. Internal entry: `<InstdAmt Ccy="GRU">N M1 GRU</InstdAmt>`  
2. SEPA instruction: `Debit EUR IBAN for N × Pₑ (EUR/XAU)`  
3. Settlement method: SCT or SCT Inst via DBIS PSP.  
4. Parallel ledger posting M1 GRU @ face parity.  

### 5.3 Post-Settlement
1. Ledger and bank reconciliation.  
2. Compliance confirmation + PoR update.  
3. Reporting to OMNL Oversight and ECB RegTech gateway.  
4. ISO 20022 logs stored (`pain.001`, `pacs.008`, `camt.053`).  

---

## 6 — Reporting and Audit Trail

- **Daily:** Transaction summary + coverage report.  
- **Monthly:** PoR attestation (DBIS audit team).  
- **Quarterly:** ICT resilience and AML review (DORA scope).  
- **Annual:** Independent reserve audit + ECB filing.

All audit files retained for 10 years per EU Recordkeeping Reg. (EU 2022/2554).

---

## 7 — Governance and Oversight

**Bodies:**
- Monetary Policy Committee (MPC)  
- Risk & Compliance Council (RCC)  
- Independent Audit Board (DBIS Oversight)

**Change-Control:** Policy amendments require MPC approval and dual sign-off by OMNL and DBIS.  

**Proof-of-Reserves:** Monthly verification of 6 XAU coverage per M00 GRU equivalent.

---

## 8 — Annexes (Reference Summaries)

**Annex A — ISO 20022 Samples**  
`pain.001`, `pacs.008`, `camt.053` message templates with Ccy fields (GRU and EUR).

**Annex B — SEPA Compliance Matrix**  
Mapping to EPC SCT Rulebook v1.1 and IPR 2024/886.

**Annex C — MiCA / DORA Crosswalk**  
Checklist of issuer obligations and ICT controls.

**Annex D — Risk Summary**  
Key risks: FX rate volatility, oracle deviation, counterparty compliance.

**Annex E — Sample Transaction Snapshot**

| Parameter | Example |
|------------|----------|
| Txn ID | GRU-SEPA-2025-0003 |
| Tier | M1 |
| Amount | 100 M1 GRU |
| Parity Rate | €2,200 / XAU |
| EUR Debit | €220,000 |
| Coverage | 0.24 XAU/GRU → 24 XAU total |
| Logs | ISO 20022 pain.001 / camt.053 |
| Compliance | Instant sanctions cleared |

**Annex F — Proof-of-Reserves Template**

```
Reserve Tier: M00
Physical Gold Held: XXX oz
Total GRU Issued: YYY
Coverage Ratio: 6 XAU per M00 GRU
Audit Date: [YYYY-MM-DD]
Auditor: DBIS Oversight Division
```

---

## 8.1 — Related specifications (canonical)

- **Implementation truth:** [Implementation status and control disclosure](/meta/implementation-status-and-control-disclosure/).
- **Parity quick reference:** [Canonical parity quick reference](/meta/canonical-parity-quick-reference/).
- **Acceptance checklist (branch):** [docs-review-fixes acceptance checklist](/meta/docs-review-fixes-acceptance-checklist/).

---

## 9 — Approval and Record Control

**Authorized by:** T. Lopez, Director Monetary Policy & Compliance, OMNL Central Bank  
**Reviewed by:** Digital Bank of International Settlements — Reserve Systems Oversight  
**Revision Cycle:** Annual or upon ECB regulatory update  

---

**End of Manual**  
*(For internal use within OMNL Central Bank and DBIS only. Reproduction requires written approval.)*
