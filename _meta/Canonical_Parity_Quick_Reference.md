---
title: Canonical Parity Quick Reference (Anti-Confusion Sheet)
version: 1.0.0
status: stable
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/meta/Canonical_Parity_and_Unit_Definition_Specification.md
---

# Canonical parity quick reference (anti-confusion sheet)

**Read this first** if you landed on an older formula, diagram, or translation. Full logic: [Canonical parity and unit definition](Canonical_Parity_and_Unit_Definition_Specification.md) (site: `/meta/canonical-parity-and-unit-definition-specification/`).

## 1. What “1 GRU” means

| Question | Answer |
|----------|--------|
| What is **1 GRU**? | The **unit of account** for the GRU system. |
| What is it **worth in XAU (face)**? | **`1 GRU = 1 XAU`** (troy ounce basis for **assigned / face** parity). |
| Does “GRU” change meaning by layer? | **No** for **face** — M00, M0, and M1 GRU use the **same** face assignment. Stock counts differ (`1 M00 = 5 M0 = 25 M1` **face** units). |

## 2. What **1 M00 / 1 M0 / 1 M1** mean (face)

| Layer | One GRU at this layer (face) | Supporting asset value (policy baseline) |
|-------|------------------------------|------------------------------------------|
| **1 M00 GRU** | `1 XAU` face | **`6.0 XAU`** supporting |
| **1 M0 GRU** | `1 XAU` face | **`1.2 XAU`** supporting |
| **1 M1 GRU** | `1 XAU` face | **`0.24 XAU`** supporting (= 6 / 25) |

The numbers **`6`**, **`1.2`**, and **`0.24`** are **supporting-coverage mechanics**, not a higher face price.

## 3. Wrong inferences (do not use)

| Wrong statement | Why it is wrong |
|-----------------|-----------------|
| `1 M0 GRU = 1.2 XAU` **face** | **1.2** is **supporting**, not face. **Face** stays **`1 XAU`**. |
| `1 GRU = 1.2 XAU` **public parity** | That would rewrite face parity. **Not canonical.** |
| `1.44 XAU` is M0 or M1 **face** or **supporting** | **`1.2 × 1.2`** stacked as **successive face** is **invalid**. See canonical spec §5. |
| “Parity” = “supporting coverage” without a label | Use **face parity** vs **supporting value** explicitly ([valuation taxonomy](Valuation_Taxonomy_Face_Settlement_Reserve_Collateral_Accounting.md)). |

## 4. “XAU GRU” and deprecated shorthand

| Term | Meaning now |
|------|-------------|
| **XAU GRU** (legacy) | Often meant “gold-referenced GRU.” **Do not** read old lines as **`1 XAU GRU = 1.2 XAU` face**. |
| **`1 XAU GRU = 1.2 XAU`** | **Deprecated.** If it appears, interpret strictly as **M0 supporting** language, **not** face. |

## 5. One-line summary

**Face everywhere:** `1 GRU = 1 XAU`. **Supporting** intensities: **6 / 1.2 / 0.24** XAU per M00 / M0 / M1 GRU respectively — **never** mixed into face without saying so.
