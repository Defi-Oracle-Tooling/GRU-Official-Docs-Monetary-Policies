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

## 7. Terminology Quick Reference
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

## 8. Notes & Pending Items
- Precise derivation of LiXAU decay exponent (0.9475^4) to be documented in Technical Annex.
- Dynamic allocation coefficients (x, y) require publication of policy weighting formula.
- Formal smart contract specifications for atomic issuance loop (E function) pending engineering review.

---
© 2025 GRU Monetary Authority — Formula Reference v1.0.0 (Provisional)