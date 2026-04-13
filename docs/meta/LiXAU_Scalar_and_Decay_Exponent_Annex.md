---
title: LiXAU Scalar and Decay Exponent Annex (0.9475^4)
version: 1.0.0
status: draft
last_updated: 2026-04-12
layer: instruments
checksum: pending
related_docs:
  - docs/meta/Glossary.md
  - docs/meta/GRU_Formulas.md
---

# LiXAU scalar and decay exponent annex (`0.9475^4`)

## 1. Purpose

The factor `0.9475^4` appears throughout Li index parity identities. This annex records **what is known**, **what is still derived**, and **how changes are governed**.

## 2. Current published identity

Across glossary and formulas:

```text
1 Li(Index) = (1.2 / 0.9475^4) XAU   [valuation basis]
```

The numerator **1.2** aligns with the **120%** policy motif on the collateral side. The denominator **`0.9475^4`** is documented as a **multi-stage efficiency / adjustment** composite applied to Li valuations.

## 3. Materiality

Because the scalar enters **every** Li-linked valuation, incomplete derivation of `0.9475^4` is a **first-order** documentation gap for:

- external index auditors,
- regulators comparing GRU marks to independent gold models,
- custodian SLAs tying insurance haircuts to published methodology.

## 4. Required deliverables (normative)

| Deliverable | Owner | Status |
|-------------|-------|--------|
| **Algebraic derivation** linking each `0.9475` stage to a named economic or operational loss / efficiency assumption | Index + MPC working group | **Pending** |
| **Sensitivity table** — ±1% on scalar vs coverage and M00 composite | RAC analytics | **Pending** |
| **Regime question** — constant vs state-dependent | MPC | **Open** |
| **Change process** — who approves, notice period, parallel publication | Governance | **Cross-ref** [Governance matrix](/meta/governance-decision-matrix/) |

## 5. Interim policy

Until the derivation is published:

1. Treat `S = 1.2 / 0.9475^4` as a **versioned constant** `S@2026-04` in indices code and docs.
2. Any code change to the numeric **must** bump `getScalarS()` policy tag and re-run full coverage regression suite.

## 6. Public communication

Issuer-facing materials MUST say: **“Li scalar exponent under formal publication; constant frozen per version tag.”**

## 7. Immutability and change-control (scalar `S`)

| Question | Deterministic rule (until derivation is published) |
|----------|-----------------------------------------------------|
| Is `S` frozen? | **Yes** at the published **`S@version`** tag. Engineering MUST ship `S` as a **named constant** or **governance-only** storage slot with **no** silent runtime drift. |
| Can engineering change digits ad hoc? | **No.** Any numeric change requires **version bump**, **MPC + RAC** publication, and **parallel** disclosure per [Index publication governance](Index_Methodology_Annex.md#8-publication-governance-official-index-versions). |
| Can a chamber revise `S` before derivation exists? | **Emergency downward** revision (tightening) only with **unanimous** MPC + RAC + published **erratum**; **upward** relaxation requires the same **and** external counsel memo. |
| Are past records valid if a future derivation **changes** the economic story? | **Ledger history** remains valid at the **S@t** that was official on date **t**. Restatement of **economic interpretation** does **not** rewrite settled balances; **prospective** `S` changes only. |
| Relationship to formal ratification | Once algebraic derivation is published, **`S`** may be **re-expressed** equivalently but **not** altered in **economic effect** without a **new** version series. |
