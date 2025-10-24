---
title: GRU Core Formulas Reference
version: 1.0.0
status: provisional
last_updated: 2025-10-24
checksum: pending
---

# Global Reserve Unit (GRU) — Core Formulas

This document records the currently defined structural and conversion formulas for the Global Reserve Unit (GRU) monetary framework.

## 1. Monetary Layer Relationships
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Where:
- M00 = Sovereign issuance layer
- M0 = Institutional reserve circulation layer
- M1 = Commercial / eMoney circulation layer
- x, y are dynamic allocation coefficients determined by monetary policy (MPC) based on target liquidity profile.

## 2. Face Values vs Asset Values
```
1 XAU GRU = 1.2 XAU
1 M0 GRU = 1.2 XAU GRU
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
Interpretation:
- XAU GRU denotes the gold-pegged denomination unit.
- LiXAU represents the composite lithium-gold hybrid reserve index; the decay exponent (0.9475^4) reflects multi-stage efficiency or adjustment factors applied in reserve weighting.

## 3. Atomic Issuance (Triangulation / eMoney Creation)
Standard atomic expansion ratio:
```
GRU_M1 = (Input × 10) / 7
```
Expanded liquidity after n atomic cycles with fee f:
```
E = I × (10/7) × (1 - f)^n
```
Where:
- I = Initial input capital (fiat or asset value expressed in EUR-equivalent)
- f = Exchange fee per cycle (≤ 0.045)
- n = Number of iterative triangular passes (default 3)

Example (micro):
| Cycle | Input (€) | Minted GRU (€) | After Fee (€) |
|-------|----------:|---------------:|--------------:|
| 1     | 7.0000    | 10.0000        | 9.5500        |
| 2     | 9.5500    | 13.6429        | 13.0289       |
| 3     | 13.0289   | 18.6128        | 17.7752       |

Example (macro, €100M base):
| Cycle | Input (€M) | Minted GRU (€M) | After Fee (€M) |
|-------|-----------:|----------------:|---------------:|
| 1     | 100.0000   | 142.8571        | 136.4286       |
| 2     | 136.4286   | 194.8980        | 186.1276       |
| 3     | 186.1276   | 265.8965        | 253.9312       |

## 4. 40/40/20 Liquidity Allocation Rule
For deposited capital D:
```
Base Reserve  = 0.40 D
Expansion     = 0.40 D (cycled through atomic issuance)
Stabilization = 0.20 D (parity + volatility buffer)
Target Coverage = 2.5 × Base Reserve
```

## 5. Closed-Loop Bond Coverage
Discounted bond purchase (example):
```
Notional = Input / 0.15
Per Bond Allocation (two-bond system) = Notional / 2
Coverage per Bond ≈ 250M (example context)
```
Applied to €100M:
```
Notional = 100M / 0.15 = 666.667M
Per Bond ≈ 333.333M
```

## 6. Parity and Reserve Policy Triggers
- Minimum reserve coverage: ≥ 120% of circulating GRU value.
- Parity deviation trigger: ±2.5% from XAU anchor → invoke MPAP (Monetary Parity Adjustment Protocol).
- Inflation ceiling: Annual net GRU expansion ≤ 2.75% (excluding sanctioned crisis windows).

## 7. Velocity & Coverage Metrics
To quantify transactional health and guide adaptive issuance pacing:

Raw transactional velocity (count-based):
```
v_raw = Tx_count / Δt
```

Value-adjusted velocity (float-weighted):
```
v_adj = Tx_value / Monetary_Float
```

Coverage-weighted velocity (penalizes weak reserves):
```
v_cov = v_adj × (Coverage_Ratio / 1.20)
```
Where Coverage_Ratio = (Reserve_Value / Circulating_GRU_Value). Normalized to 1.20 (120%).

Stability filter (Z-score dampening; output bounded [0,1]):
```
Stab = max(0, 1 - σ_outlier_factor)
```
Illustrative: σ_outlier_factor derived from rolling deviation beyond k standard deviations (k ≈ 2.25 seasonal).

Composite velocity index:
```
V_GRU = w1·v_adj + w2·v_cov + w3·Stab
```
Weights (w1, w2, w3) tuned quarterly to maintain target velocity volatility band (±10%). Example regime: w1=0.45, w2=0.35, w3=0.20.

Adaptive issuance modulation (preview):
```
Issuance_Rate = Base_Issuance × f(V_GRU)
```
Where f(V_GRU) is a piecewise stabilizer reducing expansion when V_GRU < lower_threshold or > upper_threshold to dampen extremes.

## 8. Terminology Quick Reference
| Term | Definition |
|------|------------|
| M00 | Sovereign issuance base layer |
| M0 | Institutional reserve circulation layer |
| M1 | Commercial / eMoney public layer |
| XAU GRU | Gold-pegged GRU denomination unit |
| LiXAU | Composite lithium-gold hybrid reserve index |
| Atomic Cycle | One 7→10 issuance + fee-adjusted re-entry loop |
| 40/40/20 | Capital allocation rule: reserve / expansion / stabilization |
| MPAP | Monetary Parity Adjustment Protocol |
| ACP | Automatic Compression Protocol (excess burn) |

## 9. Notes & Pending Items
- Precise derivation of LiXAU decay exponent (0.9475^4) to be documented in Technical Annex.
- Dynamic allocation coefficients (x, y) require publication of policy weighting formula.
- Formal smart contract specifications for atomic issuance loop (E function) pending engineering review.

---

# GRU Commodity Indices — Formula Reference

## Universal Parity Rule
All Li-based commodity indices are defined by:
```
1 Li(Index) = 1.2 / (0.9475 ^ 4) XAU
```

## 1. LiXAU — Core Gold-Linked Index
```
1 LiXAU = 1.2 / (0.9475 ^ 4) XAU
```

## 2. LiPMG — Precious Metals Group
```
1 LiPMG = 1.2 / (0.9475 ^ 4) XAU × (Weighted basket of [Au, Ag, Pt, Pd, Rh])
```

## 3. LiBMG1 — Base Metals Group
```
1 LiBMG1 = 1.2 / (0.9475 ^ 4) XAU × (Industrial metals weighted index)
```

## 4. LiBMG2 — Battery Materials Group
```
1 LiBMG2 = 1.2 / (0.9475 ^ 4) XAU × (Energy metals weighted index)
```

## 5. LiBMG3 — Building Materials Group
```
1 LiBMG3 = 1.2 / (0.9475 ^ 4) XAU × (Construction commodity weighted index)
```

## Composite Reserve Index
```
LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
```

---

*See Glossary for definitions and integration notes.*

---
© 2025 GRU Monetary Authority — Commodity Index Division