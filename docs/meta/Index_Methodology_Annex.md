---
title: Index Methodology Annex — LiXAU, LiPMG, LiBMG1–3
version: 1.0.0
status: draft
last_updated: 2026-04-12
layer: instruments
checksum: pending
related_docs:
  - docs/meta/Glossary.md
  - docs/meta/li_indices_enhancement_playbook.md
  - docs/meta/LiXAU_Scalar_and_Decay_Exponent_Annex.md
---

# Index methodology annex — LiXAU, LiPMG, LiBMG1–3

## 1. Purpose

Institutional users need **reproducible** index rules: weights, pricing venues, rebalance cadence, stale-price handling, and ESG screens. This annex states **what must be published** for each class. **Constituent-level weights and venue tables** remain **draft** until the Index working group publishes versioned CSV/YAML (see `li_indices_enhancement_playbook.md` roadmap).

## 2. Common requirements (all Li classes)

| Requirement | Description |
|-------------|-------------|
| **Publication** | Versioned methodology PDF + machine-readable weights file (`index_id`, `version`, `effective_from`). |
| **Pricing window** | Primary fix window (e.g. London AM/PM for PMG) stated per class. |
| **Fallback** | If primary venue fails: ordered backup venues; if all fail: **last good index** + **stale flag** + governance escalation. |
| **Illiquidity** | Wide-spread / missing prints: use documented **median-of-sources** or **hold-last** with max age `T_max`. |
| **Market closure** | Holiday calendar + roll rule. |
| **Rebalance** | Calendar (e.g. monthly / quarterly) + **drift bands** if applicable. |
| **ESG** | Exclusion list methodology (coal, conflict minerals, etc.) — **TBD** issuer charter. |

## 3. LiXAU

- **Economic role:** Gold benchmark inside Li stack.
- **Scalar:** see [LiXAU scalar annex](/meta/lixau-scalar-and-decay-exponent-annex/).
- **Venues:** LBMA-approved fixes + approved electronic venues — **enumerate in v1 weights file**.

## 4. LiPMG (precious metals basket)

- **Constituents:** Au, Ag, Pt, Pd, Rh (baseline narrative).
- **Weights:** **TBD** in published `li_indices_weights.*` until board adoption.
- **Roll:** coordinated with LiXAU scalar publication.

## 5. LiBMG1 / LiBMG2 / LiBMG3

- **Industrial / battery / construction** proxies per glossary.
- **Weights and rolls:** **TBD** pending commodity committee sign-off.
- **Liquidity:** documented minimum ADV thresholds before inclusion.

## 6. Change control

Any change to weights or scalar requires:

1. Proposed version bump.
2. MPC notice period `N` days (set in governance matrix).
3. Parallel run (optional) with old and new index side-by-side for `M` days.

## 7. Relation to on-chain code

`IndexFacet` registry fields must eventually **hash-bind** to published weights files. Until then, on-chain values are **not** sole source of truth for external auditors — see [Implementation status](/meta/implementation-status-and-control-disclosure/).

## 8. Publication governance (official index versions)

| Rule | Normative intent |
|------|------------------|
| **Publisher of record** | **Index working group** posts to issuer-controlled domain; **RAC** attests hash; **MPC** acknowledges **effective** timestamp. |
| **Valid version** | A version is **valid** only if tuple `(weights_file_hash, methodology_pdf_hash, effective_from_utc)` is published **together** and **signed** per governance matrix. |
| **Notice period** | **Prospective-only** reweights: default **`N ≥ 30` calendar days** between publication and `effective_from` unless emergency path (documented). |
| **Disputes** | **ECC** intake → **MPC** technical panel → optional **external index committee**; no silent retroactive edits. |
| **Restatement** | **Historical index levels are frozen** at the version that was official on each date. **Restatement** requires (a) **erratum** publication, (b) **RAC** fraud/correction finding, or (c) **court/regulator** direction — never routine reoptimization. |
| **Parallel run** | Optional `M`-day parallel publish of old/new indices before switch (see §6). |
| **Engineering mirror** | On-chain `getIndexWeights` must reference **`version_id`** matching published file; mismatch = **incident**. |
