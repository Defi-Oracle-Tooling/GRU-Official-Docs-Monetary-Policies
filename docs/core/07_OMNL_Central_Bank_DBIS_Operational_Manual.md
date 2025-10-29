---
title: OMNL Central Bank | Digital Bank of International Settlements - Operational Policy & Transaction Flow Manual
version: 1.0.0
status: stable
last_updated: 2025-10-29
layer: operational-policy
document_ref: OMNL/DBIS-GRU-2025-POL01
effective_date: October 2025
checksum: pending
---

# OMNL Central Bank | Digital Bank of International Settlements  
### ARIN-Registered Monetary Policy & Compliance Division  
**Document Ref:** OMNL/DBIS-GRU-2025-POL01  
**Effective Date:** October 2025  

---

## 1 — Executive Overview
The **Global Reserve Unit (GRU)** is a gold-referenced, unit-invariant instrument designed to unify reserve, institutional, and settlement liquidity under a transparent regulatory architecture.

- **Parity:** 1 GRU = 1 XAU (troy ounce of gold)  
- **Governance:** OMNL Central Bank (ARIN code OMNL-DBIS)  
- **Oversight Partner:** Digital Bank of International Settlements (DBIS)  
- **Regulatory Alignment:** ECB / ICC / MiCA / DORA / SEPA / AML-CFT / GDPR  

The manual defines monetary structure, account architecture, transaction flow, and compliance responsibilities.

---

## 2 — Monetary Structure

| Tier | Function | Asset Coverage | Money Multiplier | Purpose |
|------|-----------|----------------|------------------|----------|
| **M00** | Sovereign Reserve | 6 XAU : 1 M00 GRU (6.00 XAU/GRU) | Base Reserve | Long-term collateral |
| **M0** | Institutional Reserve | 6 XAU : 5 M0 GRU (1.20 XAU/GRU) | 1 M00 = 5 M0 | Monetary Base |
| **M1** | Circulation / Settlement | 6 XAU : 25 M1 GRU (0.24 XAU/GRU) | 1 M0 = 5 M1 | SEPA Fiat Interface |

**Cross-Formula:** 1 M00 = 5 M0 = 25 M1 GRU.  
Face value is always 1 XAU per GRU.

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

## 9 — Approval and Record Control

**Authorized by:** T. Lopez, Director Monetary Policy & Compliance, OMNL Central Bank  
**Reviewed by:** Digital Bank of International Settlements — Reserve Systems Oversight  
**Revision Cycle:** Annual or upon ECB regulatory update  

---

**End of Manual**  
*(For internal use within OMNL Central Bank and DBIS only. Reproduction requires written approval.)*