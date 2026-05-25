---
title: IFRS 9 — Expected Credit Loss (ECL) Methodology for GRU / OMNL
version: 1.0.0
status: pending_qualified_signoff
methodology_id: OMNL-IFRS9-ECL-2026-001
last_updated: 2026-05-20
---

# IFRS 9 ECL methodology — GRU / OMNL

**Status:** Template ready for finance model owner and qualified accountant sign-off.

**Parameters file:** `config/compliance/ifrs9-ecl-parameters.v1.json` (copy from `.example.json`)

**Calculator:** `scripts/compliance/ecl-calculate.py`

**Monthly run:** `bash scripts/compliance/run-ifrs9-ecl-monthly.sh`

---

## 1. Scope

In-scope balances (default — confirm with IAS 32 policy):

| Fineract GL | Description | ECL applicable? |
|-------------|-------------|-----------------|
| 2000 | M1 demand deposits / liabilities | **No** (liability — ECL on asset side) |
| 13010 | Nostro / settlement receivables | **Yes** if asset |
| 1050 | M0 reserve assets | **Yes** if financial asset at AC |
| Counterparty receivables | Per office | **Yes** |

**Clarification:** ECL under IFRS 9 applies to **financial assets** measured at amortized cost or FVOCI. GRU **liabilities** use IAS 32 presentation; impairment of **assets** held against those liabilities is modeled here.

---

## 2. Approach

| Item | Election |
|------|----------|
| Model | □ General □ Simplified □ Purchased credit-impaired |
| Staging | Stage 1 (12-month ECL) / Stage 2 (lifetime if SICR) / Stage 3 (credit-impaired) |
| Forward-looking | □ Yes — scenarios in parameters file |

---

## 3. Formula

For each exposure segment `i`:

```
ECL_i = EAD_i × PD_i × LGD_i
```

- **EAD** — exposure at default (outstanding balance)
- **PD** — probability of default (12-month or lifetime by stage)
- **LGD** — loss given default

Stage allocation rules: see `ifrs9-ecl-parameters.v1.json` → `segments[]`.

---

## 4. Journal entries

| Event | Debit | Credit |
|-------|-------|--------|
| Increase in ECL allowance | 52100 (unrealized FX / ECL expense) | Contra-asset or allowance account (document) |
| Release of ECL | Reverse | |

IPSAS pair reference: `IAS37-PROVISION` / ECL-specific pairs in registry.

All postings require **maker-checker** above `MATERIAL_THRESHOLD_MAKER_CHECKER`.

---

## 5. Governance

1. Finance runs `ecl-calculate.py` monthly.
2. Accountant reviews output JSON.
3. OMNL ops posts via `omnl-je-maker.sh` / checker.
4. Sign-off recorded in `config/compliance/ifrs9-ecl-signoff.v1.json`.

---

## 6. Sign-off

| Role | Name | Date |
|------|------|------|
| Finance model owner | | |
| Qualified accountant | | |
