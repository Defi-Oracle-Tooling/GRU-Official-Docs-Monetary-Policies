---
title: Implementation Status and Control Disclosure — Concept vs Live vs Placeholder
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: meta
checksum: pending
related_docs:
  - ../../contracts/README.md
  - Deterministic_Specifications_Index.md
---

# Implementation status and control disclosure

## Master use

This document is the **repository master** for **implementation truth**. Other chapters may describe **target** behavior; **this file** states what is **`live`**, **`partial`**, **`conceptual`**, **`placeholder`**, or **`deprecated`**. When reading any core, compliance, or contract document, **cross-check** claims here first.

**Repo-wide convention:** substantive features SHOULD carry an explicit badge inline, e.g. `Status: partial — see Implementation status (meta)`, or link to `/meta/implementation-status-and-control-disclosure/`.

## 1. Purpose

Let **central banks, auditors, and regulators** separate **policy intent** from **what is live in code** today. This reduces credibility risk when marketing language outruns engineering.

## 2. Status vocabulary

| Status | Meaning |
|--------|---------|
| **Conceptual** | Documented in policy / charter; no production automation. |
| **Partial** | Some flows live; critical guarantees incomplete. |
| **Live** | Production path with monitoring and RAC sign-off. |
| **Placeholder** | Interface exists; reverts or returns sentinel values. |
| **Deprecated** | Prior behavior or term **retired**; retained only for audit trail — do not build new integrations against it without migration plan. |

## 3. Smart contract snapshot (reference repo)

| Area | Status | Notes |
|------|--------|-------|
| Access / roles / pause | **Live** (baseline) | `AccessFacet`, `PauseFacet` |
| Governance timelock | **Live** (pattern) | `GovernanceFacet` per repo README |
| Index weights / LiCRI | **Partial** | Registry + calculations evolving |
| Triangulation rates | **Partial** | `TriangulationFacet` emits core events; **no** lineage fields yet |
| **OracleAggregatorFacet** | **Placeholder** | Median aggregation **not** production-complete per README |
| **ComplianceFacet** | **Placeholder** | KYC/AML hooks revert `ErrNotReady` per README |
| PoR Merkle post/seal | **Partial** | Events exist; operational cadence per disclosures |

**Source of truth for code claims:** root `README.md` smart-contract section and `contracts/README.md`.

## 4. Oracle and compliance suite

- **Oracle redundancy:** **Conceptual / partial** — multi-feed strategy documented; full redundancy **pending** per README checklist.
- **Automated regulatory reporting:** **Conceptual / partial** — interfaces and stubs; storage + enforcement **pending**.

## 5. Documentation vs code

Deterministic policy specs in `/meta/` describe **target** behavior. Where code **lags**, the **spec** still governs **issuer obligations** for manual or off-chain processes until code is certified.

## 6. Review cadence

This file MUST be updated on each **release tag** of the contracts package and each **quarter** for ops items.
