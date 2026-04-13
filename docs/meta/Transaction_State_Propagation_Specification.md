---
title: Transaction State Propagation Specification
version: 1.0.1
status: provisional
last_updated: 2026-04-12
layer: mechanics
checksum: pending
related_docs:
  - docs/core/02_GRU_Triangulation_eMoney_Creation.md
  - docs/meta/Reserve_Lineage_and_Segregation_Specification.md
---

# Transaction state propagation specification

## 1. Purpose

Answer, in **implementation-neutral** but **auditor-grade** terms:

- Whether XAU in “source → XAU → GRU → target” is **valuation-only** or also a **settlement-state** obligation.
- What **ledger objects** must exist so a third party can reconstruct **reserve impact** and **collateral lineage** for a transfer.

## 2. Triangulation roles (normative model)

| Stage | Role |
|-------|------|
| `source → XAU` | **Valuation and compliance:** express the economic exposure of the source asset in XAU at policy-approved marks. |
| `XAU → GRU` | **Denomination change:** map XAU-equivalent into GRU **face** at `1 GRU = 1 XAU` (assigned). |
| `GRU → target` | **Exit valuation:** map GRU face into target asset using approved marks and fees. |

**Deterministic statement:** XAU is always the **valuation hub** for FX and coverage tests. A **settlement-state** XAU leg (physical move or wholesale spot) is **required only when** the business contract or rail demands physical settlement; otherwise the XAU leg may be **synthetic accounting** backed by the reserve stack.

## 3. XAU “accompaniment” of M1 transfers

**Normative intent:** Every **M1 GRU** liability must be **traceable** to an **M00-equivalent** collateral path such that aggregate supporting value meets policy minima (see collateral stack).

**Auditable minimum (target schema):** each M1 movement carries or references:

| Field | Description |
|-------|-------------|
| `tx_id` | Globally unique transaction identifier. |
| `layer` | `M1` / `M0` / `M00` posting class. |
| `face_gru_delta` | Change in GRU face at stated layer. |
| `xau_equiv_at_policy_mark` | XAU equivalent used for the triangulation snapshot (not necessarily a separate wire). |
| `reserve_pool_id` | Pointer into segregated reserve accounting (see reserve lineage spec). |
| `coverage_ratio_snapshot` | Numerator/denominator or policy tuple at posting time. |
| `triangulation_path_hash` | Canonical encoding of the path `source→XAU→GRU→target` and oracle versions. |

## 4. On-chain vs off-chain proof

| Mechanism | Today (reference implementation) | Target |
|-----------|-----------------------------------|--------|
| **On-chain FX / triangulation** | `TriangulationFacet` emits `Triangulated` / `Redeemed` with `fromAsset`, `toAsset`, amounts; **does not yet** emit M00 pool IDs or coverage fields. | Extend events or companion **SettlementMirror** contract with hashed lineage bundle. |
| **Off-chain** | ISO 20022 store, PoR Merkle roots (`PoRPosted` / `PoRSealed` pattern). | Mandatory linkage field `tx_id` ↔ on-chain event id. |

## 5. Event types (normative vocabulary)

Implementations SHOULD classify settlement records into:

1. **`GRU_ISSUANCE`** — mint / triangulation-driven increase in M1 (and reserve accounts).
2. **`GRU_REDEMPTION`** — contractual or policy redemption reducing M1 and adjusting reserves.
3. **`GRU_TRANSFER`** — M1 payer → payee without aggregate M1 supply change.
4. **`GRU_COMPRESSION`** — ACP-class burn / supply reduction.
5. **`PARITY_ADJUSTMENT`** — MPAP-class revaluation, fee correction, or parity-band technical adjustment.
6. **`LAYER_MIGRATION`** — explicit M00↔M0↔M1 stock adjustments (governance-gated).
7. **`RESERVE_SUBSTITUTION`** — like-for-like or approved cross-class swap touching `reserve_pool_id`.
8. **`COUPON_REINVEST`** — Li99 or other programmed cashflow reinvestment (if applicable).
9. **`BUYBACK_SETTLE`** — bond buy-back principal/coupon settlement.

## 6. Normative event envelope (minimum fields)

Every persisted event record (on-chain log row, off-chain ISO adjunct, or normalized subgraph entity) **SHALL** include the following **minimum** fields. Optional fields are noted.

| Field | Type / role | Required |
|-------|----------------|----------|
| `event_id` | UUID or deterministic hash over payload | **Yes** |
| `event_type` | One of §5 enum values | **Yes** |
| `timestamp_utc` | RFC 3339 | **Yes** |
| `layer_impacted` | `M00` \| `M0` \| `M1` \| multi | **Yes** |
| `face_gru_delta` | Signed decimal string (face units) | **Yes** (zero allowed) |
| `source_asset_id` | Asset or ISO code from which triangulation starts | If triangulation applies |
| `target_asset_id` | Asset or ISO code to which triangulation exits | If triangulation applies |
| `xau_reference_value` | XAU amount or XAU-equivalent at policy marks for this event | **Yes** for valuation-bound events |
| `xau_reference_oracle_id` | Oracle / fix version identifier | **Yes** when marks are oracle-driven |
| `reserve_pool_id` | Pool per [reserve lineage](Reserve_Lineage_and_Segregation_Specification.md) | **Yes** when reserve state moves |
| `lineage_pointer` | Hash or id linking to parent `event_id` chain | **Yes** for issuance / compression trees |
| `jurisdiction_ref` | ISO country / regulatory filing id / sanctions case ref | **Yes** for cross-border or controlled flows |
| `compliance_ref` | Screening batch id, KYC record handle (off-chain pointer) | **Yes** when compliance gate ran |
| `attestation_ref` | MPC/RAC signature set, HSM attestation id, or Merkle path id | **Yes** for high-value or policy-critical events |
| `reconciliation_status` | `pending` \| `matched` \| `exception` | **Yes** |
| `fee_component` | Explicit fee lines (issuer P&L vs reserve reinforcement) | Recommended |

**Binding rule:** no production **issuance** or **compression** event may be marked `reconciliation_status=matched` until **pre-trade coverage** checks (see [solvency examples](Solvency_Worked_Ledger_Examples_7_10_Protocol.md) admission theorem) pass for the **full issuer balance sheet** snapshot referenced in `lineage_pointer`.

## 7. Reconciliation rules

- **End-of-day:** sum of `face_gru_delta` at M1 equals net change in public M1 supply per issuer ledger.
- **Coverage:** reserve value / (GRU face × 1 XAU equivalent) ≥ policy floor unless a published **breach / recovery** playbook is active.
- **Cross-border:** settlement value in domestic currency must tie to the same `triangulation_path_hash` as the GRU leg, or carry an exception code approved under governance matrix.

## 8. On-chain mapping (reference)

Today `TriangulationFacet` emits `Triangulated` / `Redeemed` with only rate legs. **Target:** extend or wrap with an event that carries a **hash of** the §6 envelope (cheap on-chain) and stores the full envelope **off-chain** with tamper-evident linkage.

## 9. Open engineering items

Reserve pool identifiers in smart storage, mandatory subgraph entities for lineage edges, and standardized **reserve claim ID** format — tracked under [Implementation status](/meta/implementation-status-and-control-disclosure/).
