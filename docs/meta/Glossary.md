---
title: GRU Glossary
version: 1.1.0
status: stable
last_updated: 2025-10-24
checksum: pending
---
# GRU Glossary

| Term | Definition |
|------|------------|
| GRU | Global Reserve Unit; asset-backed multi-layer digital reserve denomination |
| M00 | Sovereign issuance layer — directly tied to audited reserves |
| M0 | Institutional circulation layer — bank & authority operations |
| M1 | Commercial / eMoney circulation layer — public settlement |
| XAU GRU | Gold-pegged denomination unit (1 XAU GRU = 1.2 XAU) |
| LiXAU | Lithium-gold hybrid composite reserve index for diversification |
| SHTE | Sovereign Hybrid Trust Entity — governance wrapper for GRU operations |
| MPC | Monetary Policy Chamber — sets issuance, parity, expansion controls |
| RAC | Reserve Audit Chamber — validates Proof-of-Reserves & custody |
| BSC | Bond Servicing Chamber — manages Li99 bond cycles & coupons |
| TLC | Technology & Ledger Chamber — DSL integrity & smart contract lifecycle |
| ECC | Ethics & Compliance Chamber — legal neutrality, AML/KYC oversight |
| DSL | Distributed Sovereign Ledger — immutable transaction + reserve registry |
| PoR | Proof-of-Reserves — auditor-verified reserve attestations |
| MPAP | Monetary Parity Adjustment Protocol — corrects XAU parity drift |
| ACP | Automatic Compression Protocol — burns excess GRU to maintain supply discipline |
| Atomic Cycle | 7→10 issuance loop with fee-adjusted reinvestment (three-pass standard) |
| 40/40/20 Rule | Capital allocation split: 40% reserve, 40% expansion, 20% stabilization buffer |
| Li99PpOsB10 | 99-year Perpetual Off-set Bond (10-year buy-back) |
| Li99PpAvB10 | 99-year Perpetual Avail Bond (10-year buy-back) |
| DRB | Digital Reserve Basket (multi-asset index denominated in GRU) |
| VGRU | Velocity-of-GRU Index — transactional velocity metric for policy tuning |
| ERM-G | GRU Exchange Rate Mechanism — dynamic parity corridor management |
| PIMI | Private International Monetary Instrument classification |
| Escrow (Bond) | Dedicated coupon reserve for scheduled buy-back completion |
| Parity Drift | Deviation from target XAU anchor beyond tolerance band |
| Coverage Ratio | (Audited Reserve Value / Circulating GRU) × 100% |
| Coupon Rollover | Reinvestment of bond coupon proceeds into reserve expansion cycle |
| Stabilization Tranche | 20% capital buffer mitigating volatility & parity stress |
| Governance Capture | Centralization risk mitigated by chamber segregation & rotation |
| DMSR | Digital Monetary Stability Report (annual macro review) |
| v_raw | Transaction count velocity per interval (Tx_count / Δt) |
| v_adj | Value-adjusted velocity (Tx_value / Monetary_Float) |
| v_cov | Coverage-weighted velocity (v_adj × Coverage_Ratio / 1.20) |
| Stab | Stability factor (0–1) after outlier dampening (Z-score filter) |
| V_GRU | Composite velocity index (w1·v_adj + w2·v_cov + w3·Stab) |
| Velocity Band | Target ±10% controlled volatility range for V_GRU |
| Discount Purchase | Acquisition of Li99 bonds below par (e.g. 15% basis) amplifying coverage |
| Coupon Efficiency | Percent of gross coupons retained after escrow obligations (≥65% target) |
| Buy-back Cycle | Scheduled principal retirement window (10-year Li99 cycle) |
| Green Reserve Allocation | Minimum sustainability-linked reserve floor (e.g. 10%) |
| Carbon Credit Pool | Tokenized channel for emissions offset (GRU-Carbon) |
| ESG Audit | Third-party certification of reserve sustainability and governance metrics |
| Oracle (Price) | Feeds real-time XAU/XAG/XPT and composite reserve pricing |
| Oracle (Parity Drift) | Signals deviation from corridor triggering MPAP |
| Oracle (Velocity) | Publishes transactional cadence inputs for V_GRU computation |
| Oracle (Coverage) | Aggregates reserve + circulation data for Coverage_Ratio |
| Oracle (Sustainability) | Validates ESG reserve composition & carbon pool integrity |
| Settlement Event | Atomic ledger record class (issuance, compression, parity adjust, coupon reinvest, buy-back) |
| Atomic Issuance Event | Single 7→10 cycle execution with fee application |
| Compression Event | ACP-triggered supply contraction to restore ratio discipline |
| Parity Adjustment Event | MPAP operation modifying corridor or anchor calibration |
| Coupon Reinvestment Event | Ledger action reinserting coupon yield into reserve or expansion tranche |
| Buy-back Settlement Event | Bond principal closure and redemption confirmation |
| Velocity Throttle | Adaptive pacing modifier adjusting issuance rate based on V_GRU thresholds |
| Multi-Anchor Matrix | Reserve composition including XAU/XAG/XPT + LiXAU composite weighting |
| Governance Rotation | Scheduled chamber membership turnover to mitigate capture |
| Coverage Reinforcement | Additional stabilization tranche injection after velocity softening |
| Escrow Top-up | Surplus coupon allocation ensuring buy-back funding certainty |
| LiXAU Decay Exponent | Efficiency adjustment factor (0.9475^4) in hybrid index formula (derivation pending) |

## Notes
- Velocity terms align with formulas documented in `GRU_Formulas.md` section 7.
- Oracle classes may expand with external interoperability (CBDC bridge, commodity token feeds).
- LiXAU exponent derivation scheduled for Technical Annex release.
- ESG terminology stabilized post sustainability framework ratification; current entries considered draft-stable.

# GRU Commodity Indices Definition

## Base Formula for Valuation
All Li-based commodity indices within the GRU framework are defined and traded according to the following parity rule:

```
1 Li(Index) = 1.2 / (0.9475 ^ 4) XAU
```

This establishes a universal benchmark linking all commodity groups to the intrinsic gold value (XAU), ensuring consistent valuation, cross-market interoperability, and inflation-adjusted stability.

---

## 1. LiXAU — Core Gold-Linked Index
**Definition:** The principal reserve benchmark for the GRU system, directly pegged to gold (XAU).
**Valuation Basis:** 1 LiXAU = 1.2 / (0.9475 ^ 4) XAU
**Function:** Serves as the root parity layer for all other Li commodity indices.

---

## 2. LiPMG — Precious Metals Group
**Constituents:** Gold (Au), Silver (Ag), Platinum (Pt), Palladium (Pd), Rhodium (Rh).
**Valuation Formula:**
```
1 LiPMG = 1.2 / (0.9475 ^ 4) XAU × (Weighted basket of [Au, Ag, Pt, Pd, Rh])
```
**Purpose:** Reflects the cumulative strength of the global precious metals market. Used for hedging and sovereign asset management.

---

## 3. LiBMG1 — Base Metals Group
**Constituents:** Copper (Cu), Nickel (Ni), Aluminum (Al), Zinc (Zn), Lead (Pb).
**Valuation Formula:**
```
1 LiBMG1 = 1.2 / (0.9475 ^ 4) XAU × (Industrial metals weighted index)
```
**Purpose:** Represents industrial demand and serves as a performance barometer for infrastructure, energy, and manufacturing cycles.

---

## 4. LiBMG2 — Battery Materials Group
**Constituents:** Lithium (Li), Cobalt (Co), Graphite (C), Manganese (Mn), Nickel (Ni).
**Valuation Formula:**
```
1 LiBMG2 = 1.2 / (0.9475 ^ 4) XAU × (Energy metals weighted index)
```
**Purpose:** Tracks global electrification trends and energy storage markets. Used for ESG-compliant asset tokenization.

---

## 5. LiBMG3 — Building Materials Group
**Constituents:** Iron Ore (Fe), Cement (Cmt), Glass (Si), Lumber (Lbr), Aggregates (Agg).
**Valuation Formula:**
```
1 LiBMG3 = 1.2 / (0.9475 ^ 4) XAU × (Construction commodity weighted index)
```
**Purpose:** Measures growth and resilience of the construction and real estate sectors, integrating into macroeconomic stability indicators.

---

## Index Integration Summary
| Index      | Focus              | Function                                          | Linkage                         |
| :--------- | :----------------- | :------------------------------------------------ | :------------------------------ |
| **LiXAU**  | Gold Benchmark     | Core parity for all commodities                   | Direct to XAU                   |
| **LiPMG**  | Precious Metals    | Inflation hedge & reserve measure                 | 1.2/(0.9475^4) × XAU basket     |
| **LiBMG1** | Base Metals        | Industrial & infrastructure performance           | Derived from XAU-linked weights |
| **LiBMG2** | Battery Materials  | Energy transition and ESG performance             | Li-centric weighting            |
| **LiBMG3** | Building Materials | Construction, housing, and structural commodities | Weighted XAU linkage            |

---

## Use within the GRU Ecosystem
Each Li-index supports the Digital Bank for International Settlements (DBIS) commodity-tracking framework, forming the Li Composite Reserve Index (LiCRI) — a unified, gold-triangulated reference for cross-asset pricing and reserve diversification.

**Composite Equation:**
```
LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
```

---

# GRU Commodity Indices — Mermaid Diagrams & Tables

> All Li-based indices share the same gold-linked parity:
> **1 Li(Index) = 1.2 / (0.9475^4) XAU**

---

## 1) Triangulation & Index Hierarchy (Mermaid Flowchart)

```mermaid
flowchart TD
  A[Source Assets / Currencies / Securities] -->|Triangulate| B[XAU (Gold) Anchor]
  B -->|Mint/Settle via Parity| C[GRU (Global Reserve Unit)]
  C --> D{{Li-Based Commodity Indices}}
  D --> D1[LiXAU\n(Core Gold-Linked Index)]
  D --> D2[LiPMG\n(Precious Metals Group)]
  D --> D3[LiBMG1\n(Base Metals Group)]
  D --> D4[LiBMG2\n(Battery Materials Group)]
  D --> D5[LiBMG3\n(Building Materials Group)]

  classDef anchor fill:#f6e7a1,stroke:#c9a227,color:#3a2f00;
  classDef unit fill:#d6ecff,stroke:#3c75b8,color:#0f2a4d;
  classDef index fill:#eaf8ef,stroke:#3a9d6b,color:#0e3b25;

  class B anchor;
  class C unit;
  class D,D1,D2,D3,D4,D5 index;
```

---

## 2) Concept Map (Mermaid Mindmap)

```mermaid
mindmap
  root((GRU Commodity Indices))
    XAU:::anchor
      note: "Global anchor & valuation basis"
    GRU:::unit
      note: "Triangulated unit of account"
    Indices:::index
      LiXAU
        note: "Direct gold-linked index"
      LiPMG
        note: "Au, Ag, Pt, Pd, Rh basket"
      LiBMG1
        note: "Cu, Ni, Al, Zn, Pb"
      LiBMG2
        note: "Li, Co, Graphite, Mn, Ni"
      LiBMG3
        note: "Fe ore, Cement, Glass(Si), Lumber, Aggregates"

  classDef anchor fill:#f6e7a1,stroke:#c9a227,color:#3a2f00;
  classDef unit fill:#d6ecff,stroke:#3c75b8,color:#0f2a4d;
  classDef index fill:#eaf8ef,stroke:#3a9d6b,color:#0e3b25;
```

---

## 3) Index Definition Table (Markdown)

| Index      | Focus / Constituents                            | Valuation (relative to XAU)                                       | Primary Use                              |
| :--------- | :---------------------------------------------- | :---------------------------------------------------------------- | :--------------------------------------- |
| **LiXAU**  | Gold benchmark (XAU)                            | **1 LiXAU = 1.2 / (0.9475^4) XAU**                                | Core parity reference for all Li-indices |
| **LiPMG**  | Au, Ag, Pt, Pd, Rh                              | **1 LiPMG = [1.2 / (0.9475^4)] × (weighted precious basket)**     | Reserve & inflation hedge index          |
| **LiBMG1** | Cu, Ni, Al, Zn, Pb                              | **1 LiBMG1 = [1.2 / (0.9475^4)] × (weighted base metals)**        | Industrial activity barometer            |
| **LiBMG2** | Li, Co, Graphite, Mn, Ni                        | **1 LiBMG2 = [1.2 / (0.9475^4)] × (weighted battery materials)**  | Energy transition & storage proxy        |
| **LiBMG3** | Iron ore, Cement, Glass(Si), Lumber, Aggregates | **1 LiBMG3 = [1.2 / (0.9475^4)] × (weighted building materials)** | Construction & infrastructure proxy      |

---

## 4) Parity Notes

* The scalar **S = 1.2 / (0.9475^4)** applies to **every** Li-based index.
* Basket **weights** are configurable (e.g., liquidity/production-weighted) but must be disclosed alongside index publication.
* All conversions are **triangulated through XAU** → GRU → target asset for issuance and redemption.

---

# GRU Li Composite (LiCRI) vs. M00 Composite — Definitive Specification

> This note formalizes the relationship between the **Li Composite Reserve Index (LiCRI)** and the **M00 Composite** under the GRU framework, based on your latest definitions.

---

## 1) Composite Equation (Face‑Value Index)
**Definition:** The **Li Composite Reserve Index (LiCRI)** is a *face‑value* composite that averages the five Li indices:

```
LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
```

**Interpretation:** LiCRI is a *face‑value composite of M00* (not the asset‑collateral sum). It is primarily used for reporting, benchmarking, and policy dashboards.

> **Note:** Each Li(Index) adheres to the scalar parity S = 1.2/(0.9475^4) × XAU basis.

---

## 2) Actual Composite Assets of M00 (Collateral Definition)
**Definition:** The *asset‑backed* composite for the **M00** layer is the scalar‑weighted **sum** of the Li indices (not the average):

```
1 M00  =  1.2 × ( LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3 )
```

**Interpretation:** This represents the **collateral side** (asset base) for M00, aggregating all five Li indices and multiplying by 1.2 to reflect the M00 face‑to‑asset mapping.

---

## 3) Relationship Summary
* **LiCRI** = *Average* of the five Li indices → **Face‑value composite** for presentation/benchmarking.
* **M00 Composite** = *Sum* of the five Li indices × **1.2** → **Asset‑backed collateral** definition for issuance.
* Therefore, LiCRI provides a normalized indicator; the M00 composite defines actual reserve magnitude.

---

## 4) Consistency & Parity Notes
* All Li indices are defined over the same parity scalar **S = 1.2/(0.9475^4)** ensuring XAU triangulation.
* If any Li basket’s internal **weights** change, **re‑publish** both:
  * the **LiCRI** (face value), and
  * the **M00 composite** (asset value),
    with effective timestamps and hash/version in the PoR/Registry.

---

## 5) Audit/Registry Fields (Recommended)
| Field                 | Example                                            |
| --------------------- | -------------------------------------------------- |
| scalar_S              | `1.2/(0.9475^4)`                                   |
| LiCRI_formula         | `(LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)/5`     |
| M00_composite_formula | `1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)` |
| weights_version       | `v1.0.0`                                           |
| effective_date        | `2025‑10‑24`                                       |
| registry_record       | `DSL#GRU-LiCRI-M00-20251024`                       |

---

## 6) Sanity‑Check Example (Symbolic)
Let each Li index be reported in the same units (already S‑scaled to XAU parity). Then:

```
Given: LiXAU=a, LiPMG=b, LiBMG1=c, LiBMG2=d, LiBMG3=e

LiCRI               = (a + b + c + d + e) / 5
M00_CompositeAssets = 1.2 × (a + b + c + d + e)
```

This keeps **reporting** (LiCRI) and **collateral** (M00 composite) consistent yet distinct.

---

### ✅ Status
*Spec captured per your inputs. Ready to propagate to the Commodity Index docs, DBIS charter annex, and Reserve Dashboard formulas.*

---

**© 2025 GRU Monetary Authority — Commodity Index Division**
*Prepared by Teresa Lopez — Institutional Policy Division*