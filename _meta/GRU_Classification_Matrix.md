---
title: GRU Classification Matrix — Monetary, Accounting, Regulatory, Custody, Payments
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/compliance/mica/Legal_Position_GRU_vs_MiCA.md
  - docs/meta/Valuation_Taxonomy_Face_Settlement_Reserve_Collateral_Accounting.md
---

# GRU classification matrix

## 1. Purpose

GRU is described variously as a **unit**, **token**, **asset-referenced e-money**, **liability**, **settlement asset**, and **reserve standard**. This matrix assigns **hierarchy** so counterparties know which label applies in which context.

## 2. Primary hierarchy (normative)

1. **Monetary classification:** GRU is a **private international reserve unit** with **multi-tier stock** (M00/M0/M1) and **XAU-referenced face parity**.
2. **Payments classification:** M1 GRU functions as **e-money / EMR-style** digital settlement unit where licensed; EUR legs are **separate** fiat settlement.
3. **Accounting classification:** Issuer treats GRU as **financial liability** under IFRS / IAS 32 (see compliance memos) at **face** unless hedged.
4. **Regulatory classification:** **MiCA ART**-style asset-referenced token in EU framing; other jurisdictions **TBD**.
5. **Custody classification:** Underlying gold and Li proxies are **issuer-controlled** or **sub-custodian** assets, **not** owned by retail simply by holding M1 in most programs.
6. **Treaty / charter classification:** DBIS and member instruments may create **international organization** features — see [Legal enforceability annex](/meta/legal-enforceability-annex/).

## 3. Layer-specific emphasis

| Layer | Dominant character |
|-------|--------------------|
| **M00** | Reserve **anchor** / sovereign program |
| **M0** | **Intermediated** wholesale money |
| **M1** | **Retail / commercial** e-money interface |

## 4. “Token” vs “unit”

- **Unit** = economic and accounting **definition**.
- **Token** = **ledger carrier** (ERC-20 style, account-based bank ledger, etc.).

The same **unit** may be represented by **multiple** tokenized or non-tokenized records across chains and banks.

## 5. Counterparty communication

Public materials SHOULD lead with **“GRU is a reserve-referenced settlement unit (M1) backed by a layered reserve program”** and place **token** wording second unless the audience is purely on-chain.
