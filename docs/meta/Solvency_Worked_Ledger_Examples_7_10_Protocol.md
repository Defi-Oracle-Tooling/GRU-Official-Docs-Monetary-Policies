---
title: Solvency Worked Ledger Examples — 7:10 Protocol and 40/40/20
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: mechanics
checksum: pending
related_docs:
  - docs/core/02_GRU_Triangulation_eMoney_Creation.md
  - docs/meta/Collateral_Stack_Decomposition.md
  - docs/meta/GRU_Formulas.md
---

# Solvency worked ledger examples — 7:10 protocol and 40/40/20

## 1. Purpose

Show **balance-sheet style** postings that connect:

- `GRU_M1 = Input × 10 / 7` (standard atomic expansion),
- **40% reserve / 40% expansion / 20% stabilization** allocation of the **newly issued M1**,
- **M00 : M0 : M1** stock ratios,

without inventing shadow seniorities unless explicitly labeled.

## 2. Symbols

- `R` = reserve account (eligible assets, XAU-equivalent at policy marks).
- `E` = expansion / liquidity facility account.
- `S` = stabilization tranche.
- `M1_out` = circulating M1 GRU **face** liability to the public.

## 2.1 Admission theorem (pre-trade coverage)

> **Admission (normative policy intent).** A **7:10** issuance batch, including its **40/40/20** internal allocation and any **sequenced loops**, is **valid for posting** only if a **pre-trade coverage simulation** on the **full issuer balance sheet** shows **coverage ≥ the policy floor** (default **120%**) **after** the batch **and** each loop sub-step that moves reserves or M1 supply, using the **same mark** set as production.

**Which floor governs:** the **issuer-wide** M1-vs-reserves coverage test is **dispositive** for admission. **Per-layer** supporting identities (**6 / 1.2 / 0.24** XAU) must remain **internally consistent** with `1 M00 = 5 M0 = 25 M1` stock; a breach at any **checked** consolidation blocks the batch.

**Loops:** **Re-simulate** after **each** loop iteration before authorizing the next. No loop may assume **slack** created only by **uncommitted** stabilization entries.

**Stabilization vs expansion lock:** for a standard batch, **`R` / `E` / `S`** splits are **fixed at admission** for that batch id; **double-spend** of stabilization or expansion capacity is **forbidden** (idempotent batch key).

**Fees:** Treat fees as explicit **`fee_component`** lines. **Default:** fees accrue to **issuer P&L** unless a published policy maps a **stated fraction** to **reserve reinforcement** (then they increase the coverage numerator accordingly in the simulation).

## 3. Micro example — single triangulation input

Assume **Input = 7** (in policy-normalized input units that map to the 7 side of 7:10).

1. **Gross mint:** `GRU_M1 = 7 × 10 / 7 = 10` new M1 GRU **face**.

2. **40/40/20 split** applies to the **10** units of new M1 stock (illustrative posting to internal accounts; issuer chart of accounts may vary):

| Account | Debit | Credit | Comment |
|---------|-------|--------|---------|
| `R` (asset) | +4 | | 40% of 10 → reserve reinforcement |
| `E` (asset / facility) | +4 | | 40% expansion capacity |
| `S` (buffer) | +2 | | 20% stabilization |
| `M1_out` (liability) | | +10 | Public M1 face |

3. **Coverage check (illustrative numbers):** Suppose pre-event reserve value already covered outstanding M1 at **>120%**. After posting, numerator rises by **4** in the reserve tranche while liabilities rise by **10** face — the **net** effect on coverage depends on pre-existing stock; **solvency** requires the **issuer-specific** full balance sheet, not this slice alone.

**Takeaway:** the 7:10 rule sets **how many M1 face units appear per input**; the 40/40/20 rule governs **how that issuance is booked across internal buckets**. Neither replaces the **global** coverage test.

## 4. Bank-scale example — reserve expansion path

Opening (XAU-equivalent, millions, face basis):

- `M1_out = 100`
- `R = 130` → coverage `130 / 100 = 1.30`

New input batch equivalent to **7m** normalized input units → **+10m** M1 face.

After 40/40/20 on the **+10m**:

- `R_new = 130 + 4 = 134`
- `M1_new = 110`
- Coverage `134 / 110 ≈ 1.218` → still **above 1.20** floor in this toy.

If the opening coverage had been **exactly 1.20**, adding **10** liabilities with only **+4** reserve would **breach** the floor — operational policy must **pre-fund** reserve, throttle issuance, or run ACP/compression **before** approving such a batch. **Deterministic control:** issuance engines MUST run a **pre-trade coverage simulation** with the full balance sheet.

## 5. Sovereign-scale cross-border settlement (sketch)

1. **Opening:** national custodian holds M00-equivalent pool; domestic bank holds M0 inventory; retail holds M1.
2. **Cross-border GRU leg:** ISO 20022 GRU amount + EUR settlement per operational manual; **same `tx_id`** binds FX and GRU posting.
3. **Closing:** reserve pool marks move with LBMA + FX; **coverage** recomputed issuer-wide including **off-balance** guarantees if any.

Full templates belong in the operational manual’s annex once jurisdictional reporting lines are fixed.

## 6. Loops and seniority

- **Default position:** three triangulation loops in policy examples multiply **economic** expansion paths; they do **not** silently create **junior** M1 tranches unless a **labeled** instrument (for example a bond series) is issued.
- **Seniority questions** are **instrument-specific** and MUST be documented in bond terms and reserve lineage — see [Reserve lineage](/meta/reserve-lineage-and-segregation-specification/).

## 7. Worked examples status

Figures here are **didactic**. Production disclosures MUST use **audited** marks and actual charts of accounts. Future revision: add **three** fully closed examples with **opening / transaction / closing** tables signed off by RAC template.
