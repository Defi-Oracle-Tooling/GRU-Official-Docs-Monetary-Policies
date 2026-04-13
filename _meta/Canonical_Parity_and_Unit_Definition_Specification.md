---
title: Canonical Parity and Unit Definition Specification
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/core/01_GRU_Monetary_Policy_Framework.md
  - docs/meta/GRU_Formulas.md
  - docs/core/07_OMNL_Central_Bank_DBIS_Operational_Manual.md
---

# Canonical parity and unit definition specification

**Anti-confusion one-pager:** [Canonical parity quick reference](Canonical_Parity_Quick_Reference.md) (site: `/meta/canonical-parity-quick-reference/`).

## 1. Purpose

End external ambiguity about what a **GRU** is in ledgers, policy formulas, and settlement instructions. This document is the **authoritative separation** of:

- **Unit of account** and **face parity**
- **Reserve / supporting-asset value** (economic backing)
- **Ledger denomination** (how amounts are posted at each tier)

It explicitly retires ambiguous shorthand that mixed these categories.

## 2. Unit of account

- **Primary unit of account:** one **GRU** (same symbol at M00, M0, and M1 layers unless a deployment namespaces layer-specific ledger tokens).
- **Gold reference:** one **troy ounce XAU** is the numeraire for parity policy and FX triangulation (`cXAUC` / `cXAUT` on-chain references in companion deployments).

## 3. Face parity (assigned value)

**Normative rule:** For booking, public denomination, and counterparty-facing settlement instructions, **one GRU of any monetary layer carries the same assigned (face) value:**

```text
1 GRU (face) = 1 XAU   at M00, M0, and M1
```

This is the meaning of statements such as “face parity: 1 GRU = 1 XAU” in the OMNL operational manual and the monetary policy framework.

Face parity is **not** the same as “grams of gold in the vault per retail coin” nor “mark-to-market USD value.” It is the **nominal** GRU↔XAU assignment used for parity bands, MPAP triggers, and ISO 20022 amount fields when the currency is GRU.

## 4. Supporting asset value (reserve-side, overcollateralization)

Supporting value answers: **how much reserve asset mass must exist, at minimum policy, per issued GRU at a given layer?** It uses the **120% minimum coverage** policy and the **fixed layer fan-out** `1 M00 : 5 M0 : 25 M1`.

| Layer | Face (assigned) | Supporting asset value (policy baseline) | Derivation |
|-------|-----------------|-------------------------------------------|------------|
| **M0** | 1 M0 GRU = 1 XAU (face) | **1.2 XAU** of supporting assets per 1 M0 GRU | Direct 120% rule at the institutional reserve layer. |
| **M00** | 1 M00 GRU = 1 XAU (face) | **6.0 XAU** of supporting assets per 1 M00 GRU | Five equal-weight Li index classes in the M00 basket, each mapped to **1.2 XAU** supporting contribution at the M00 collateral definition (see Collateral stack decomposition). |
| **M1** | 1 M1 GRU = 1 XAU (face) | **0.24 XAU** of supporting assets per 1 M1 GRU | `6 XAU` supporting per M00 / `25` M1 per M00 = `6/25 = 0.24` XAU supporting per M1 GRU. |

These three rows are **one consistent system**: the operational manual table (“6 XAU : 25 M1 GRU”) is **supporting value per M1**, not a second face value.

## 5. Retired shorthand: “1 XAU GRU = 1.2 XAU” and the incorrect `1.44` stack

Some drafts used **“XAU GRU”** to mean “gold-referenced GRU” and wrote `1 XAU GRU = 1.2 XAU`. That line mixes **face** and **backing** unless carefully qualified.

**Normative clarification:**

- `1 XAU GRU = 1.2 XAU` is only acceptable as shorthand for **supporting asset value at the M0 layer** (120% rule), **not** as a claim that the **face** of a GRU is 1.2 XAU.
- **Do not** multiply `1.2 × 1.2` to imply **1 M0 GRU = 1.44 XAU face** or **1 M1 GRU = 1.44 XAU supporting**. That double application is **not** part of the canonical ledger. The correct M0 supporting row is **1.2 XAU per M0 GRU**, full stop.

If a document needs the “two 1.2 factors” intuition, it must label them as **distinct domains** (for example Li scalar inside index methodology vs M00 aggregate multiplier), not as sequential face redefinition — see [Collateral stack decomposition](/meta/collateral-stack-decomposition/).

## 6. Economic backing rule vs valuation rule vs ledger conversion rule

| Kind of rule | What it governs | Example in GRU |
|--------------|------------------|----------------|
| **Economic backing rule** | Minimum real-asset mass vs liabilities | ≥ 120% coverage; M00 composite `1.2 × (LiXAU + … + LiBMG3)`. |
| **Valuation rule** | How indices and constituents map to XAU | Li scalar `1.2 / 0.9475^4` per index methodology. |
| **Ledger conversion rule** | How posted amounts move between assets and GRU tiers | Triangulation `source → XAU → GRU → target`; layer multipliers `1:5:25`. |

A reviewer should never infer that a **valuation** identity for Li indices rewrites **face parity** for GRU.

## 7. Ledger denomination rules (normative target)

1. **Client-facing balances** in GRU use **face** amounts (Section 3).
2. **Coverage tests** compare **total supporting asset value** (Section 4, mark-to-policy) to **face-equivalent exposure** (GRU face × 1 XAU per GRU in the test currency, with FX triangulated through XAU).
3. **Layer inventory:** postings that move GRU between M00, M0, and M1 must preserve `1 M00 = 5 M0 = 25 M1` **face** relationships unless an explicit governance-approved recapitalization event is recorded.

Implementations MAY use internal “supporting units” or “collateral units” in APIs; if so, they MUST publish a deterministic conversion to Section 3–4.

## 8. Relationship to other documents

- **01_GRU_Monetary_Policy_Framework** — narrative + tables; must stay aligned with Sections 3–4 here.
- **GRU_Formulas** — formula sheet; treats face vs supporting explicitly.
- **07_OMNL_… Operational Manual** — **implementation profile** (SEPA, EUR); authoritative for **this profile’s** ops cadence, deferring to this spec for parity semantics.

## 9. Change control

Amendments require Monetary Policy Chamber (MPC) review and publication in `CHANGELOG` with version bump of this document.
