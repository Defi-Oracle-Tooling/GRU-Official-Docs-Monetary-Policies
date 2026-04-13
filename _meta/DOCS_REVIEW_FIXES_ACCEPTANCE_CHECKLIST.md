---
title: Acceptance Checklist — docs-review-fixes (deterministic docs bundle)
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: meta
checksum: pending
related_docs:
  - Deterministic_Specifications_Index.md
---

# Acceptance checklist — `docs-review-fixes`

**Branch:** `docs-review-fixes`  
**Intent:** Sign off that deterministic policy specs, cross-links, legal posture callouts, and navigation are **internally consistent** and **safe to merge** (or tag) for institutional readers.

## How to use

1. Assign a **lead reviewer** (RAC / MPC secretariat / documentation owner).
2. For each path below, mark **Pass**, **Fail**, or **N/A**, add initials + date.
3. **Fail** any item that would allow a reader to infer non-canonical parity (`1 GRU = 1.2 XAU` face, `1.44` stack, or “XAU GRU” as face) without correction.
4. Before merge, run **§7 merge gate** and **`docs/core` vs `_core`** consistency for mirrored English.

### Sign-off block

| Role | Name | Date | Branch @ commit |
|------|------|------|------------------|
| Documentation owner | | | |
| Policy (MPC liaison) | | | |
| Reserve audit (RAC) | | | |
| Legal counsel (optional) | | | |

---

## 1. New deterministic specifications (`docs/meta/` = source; `_meta/` = Jekyll mirror)

For each file: confirm **front matter** (`title`, `version`, `status`, `last_updated`, `layer`) present; links resolve on GitHub **and** on the static site (paths below use site slugs).

| File | Primary acceptance criteria |
|------|------------------------------|
| [Deterministic_Specifications_Index](Deterministic_Specifications_Index.md) | Hub lists all specs; **Implementation status** called out as master truth; **maintenance / stale-language** note present; every linked slug loads. |
| [Canonical_Parity_Quick_Reference](Canonical_Parity_Quick_Reference.md) | **Face** `1 GRU = 1 XAU` for M00/M0/M1; **6 / 1.2 / 0.24** explicitly **supporting**; **wrong** table blocks `1.44` and `1 M0 = 1.2 XAU` face misread; deprecated “XAU GRU” explained. |
| [Canonical_Parity_and_Unit_Definition_Specification](Canonical_Parity_and_Unit_Definition_Specification.md) | Canonical definitions match quick reference; §5 rejects double `1.2`; change control §9 present. |
| [Collateral_Stack_Decomposition](Collateral_Stack_Decomposition.md) | M00/M0/M1 math consistent with OMNL §2; **600% vs 120% vs 1.44** table clear. |
| [Valuation_Taxonomy_Face_Settlement_Reserve_Collateral_Accounting](Valuation_Taxonomy_Face_Settlement_Reserve_Collateral_Accounting.md) | Five valuation terms defined; consistency rules do not contradict face parity. |
| [Transaction_State_Propagation_Specification](Transaction_State_Propagation_Specification.md) | §5 event enum + **§6 minimum envelope** complete; binding rule references solvency admission; on-chain gap honestly stated. |
| [Solvency_Worked_Ledger_Examples_7_10_Protocol](Solvency_Worked_Ledger_Examples_7_10_Protocol.md) | **§2.1 admission theorem** states issuer-wide floor, loop re-sim, stabilization lock, fee default. |
| [Velocity_Policy_Rulebook](Velocity_Policy_Rulebook.md) | **§1.1–1.2**: advisory vs policy vs self-executing; parity boundary; oracle degradation; no fake numeric thresholds without MPC label. |
| [Index_Methodology_Annex](Index_Methodology_Annex.md) | **§8 publication governance** (publisher, version tuple, notice, disputes, restatement) present. |
| [LiXAU_Scalar_and_Decay_Exponent_Annex](LiXAU_Scalar_and_Decay_Exponent_Annex.md) | **§7 immutability** + `S@version`; engineering/chamber rules clear; derivation still honestly **pending**. |
| [Legal_Enforceability_Annex](Legal_Enforceability_Annex.md) | Top banner: **not legal advice**; question table intact; no new unqualified legal guarantees added. |
| [Governance_Decision_Matrix](Governance_Decision_Matrix.md) | OMNL labels mapped to SHTE; emergency / deadlock paths stated. |
| [Reserve_Lineage_and_Segregation_Specification](Reserve_Lineage_and_Segregation_Specification.md) | M1 mediated vs direct; seniority table; substitution / contamination / waterfall **TBD** where appropriate. |
| [Claim_Structure_and_Rights_by_Layer](Claim_Structure_and_Rights_by_Layer.md) | M1/M0/M00 economic framing; insolvency/freeze caveats; cross-refs to legal + reserve specs. |
| [GRU_Classification_Matrix](GRU_Classification_Matrix.md) | Hierarchy clear; token vs unit distinction present. |
| [Implementation_Status_and_Control_Disclosure](Implementation_Status_and_Control_Disclosure.md) | **Master use** + vocabulary includes **deprecated**; contract snapshot matches root `README` / `contracts/README` at this commit. |

**Mirror rule:** After editing any `docs/meta/*.md` in the table above, run `cp -a docs/meta/<file> _meta/<file>` (or bulk `cp docs/meta/*.md _meta/`) so GitHub Pages stays in sync.

---

## 2. Modified English core + contracts + navigation

| Path | Primary acceptance criteria |
|------|------------------------------|
| `docs/core/01_GRU_Monetary_Policy_Framework.md` | “For avoidance of doubt” paragraph + pointers to deterministic index **and** implementation disclosure; face vs supporting block unchanged in meaning. |
| `docs/core/02_GRU_Triangulation_eMoney_Creation.md` | **Related specifications** footer links implementation + quick ref + transaction propagation + deterministic index. |
| `docs/core/03_GRU_Bond_System_Liquidity_Management.md` | **Related specifications** footer links implementation + deterministic index. |
| `docs/core/04_GRU_Governance_Regulatory_Oversight.md` | **Legal posture** callout before §4; links to legal annex (relative `../meta/...`). |
| `docs/core/05_Digital_Bank_for_International_Settlements_Charter.md` | **Legal posture** callout before treaty-style claims; link to legal annex; **Related specifications** footer → implementation + legal enforceability annex. |
| `docs/core/06_GRU_Enhancement_Expansion_Roadmap.md` | M00 composite footnote = **supporting**; **Related specifications** → implementation disclosure. |
| `docs/core/07_OMNL_Central_Bank_DBIS_Operational_Manual.md` | §0 scope table includes **quick reference**; §1–2 match **supporting** column semantics + M00 composite + `c*`/`cW*` note; **§8.1** related specs; version/date bumped. |
| `docs/core/00_GRU_Executive_Summary.md` | Document map lists deterministic index, quick ref, **implementation master**; formula clarification does not assert wrong parity. |
| `_core/01_GRU_Monetary_Policy_Framework.md` | Same substance as `docs/core/01` (wording may use site links). |
| `_core/02_…`, `_core/03_…`, `_core/06_…` | Same **Related specifications** intent as `docs/core` peers; `/meta/` URLs. |
| `_core/04_…`, `_core/05_…` | Legal posture callouts use `/meta/...` site paths. |
| `_core/07_…` | Matches `docs/core/07` semantics (§0–2, §8.1); site links valid. |
| `_core/00_GRU_Executive_Summary.md` | Face vs supporting note adjacent to M00 composite; document map rows present. |
| `docs/meta/GRU_Formulas.md` | Intro links quick reference + implementation disclosure; “related deterministic specifications” footer intact. |
| `docs/meta/Glossary.md` | XAU GRU row + Li scalar note do not imply face `1.2`; version/date bumped if changed. |
| `docs/meta/Risk_Annex.md` | PIMI mitigation references legal annex + filed instruments. |
| `_meta/` copies of the three above | Identical to `docs/meta` after copy. |
| `contracts/README.md` | Points to **implementation status** as repo master for live vs placeholder. |
| `README.md` | Deterministic specs subsection includes quick reference + claim structure rows; links valid on GitHub. |
| `meta.md` | References entry for deterministic index + quick reference. |
| `index.html` | Same as `meta.md` for discoverability. |
| `_config.yml` | Navigation includes **Deterministic specifications** child URL `/meta/deterministic-specifications-index/`. |

---

## 3. Optional: other files on branch vs `main`

This branch may contain additional commits (e.g. triangulation wording, translations, Jekyll docker). Regenerate the full list:

```bash
git fetch origin
git diff --name-only origin/main...HEAD
```

For each **extra** path not listed above: apply **§4** spot checks.

---

## 4. Global spot checks (all contributors)

| # | Check | Pass? |
|---|--------|--------|
| G1 | Repo-wide search: no standalone `1 GRU = 1.2 XAU` **as face** without “supporting” or “deprecated” context in **English** `docs/core`, `_core`, `docs/meta`, `_meta`. | |
| G2 | Search `1.44`: only appears in **rejection** / education context, not as policy. | |
| G3 | “Parity” in tables: if numeric ≠ 1:1 XAU face, label **supporting** or **Li valuation**. | |
| G4 | `docs/core/*.md` and `_core/*.md` **pairs** for same number (00–07): no contradictory **face** statements. | |
| G5 | External links in `README` / `index.html` / `meta.md` return 200 (manual or CI link checker). | |

---

## 5. Automated parity-language scan

| # | Check | Pass? |
|---|--------|--------|
| A1 | `bash scripts/verify/check-stale-gru-parity-language.sh` (report-only) reviewed; no unexpected hits. | |
| A2 | `bash scripts/verify/check-stale-gru-parity-language.sh --strict` passes in CI (same as `build.yml`). | |

## 6. Build / site (if CI available)

| # | Check | Pass? |
|---|--------|--------|
| B1 | `bundle exec jekyll build` (or repo Docker Jekyll script) succeeds with `_config.yml` collections. | |
| B2 | New meta pages render: `/meta/deterministic-specifications-index/`, `/meta/canonical-parity-quick-reference/`, `/meta/implementation-status-and-control-disclosure/`. | |
| B3 | `bash scripts/build.sh` still runs (pandoc optional); no broken image paths in touched core files. | |

---

## 7. Merge gate (minimum)

- [ ] All **§1** rows Pass or N/A with documented exception.
- [ ] All **§2** rows Pass.
- [ ] **G1–G4** Pass.
- [ ] **A2** Pass (CI strict scan).
- [ ] `_meta/` mirrors `docs/meta/` for every deterministic spec file edited in §1.

---

## Reference

- [Deterministic specifications index](Deterministic_Specifications_Index.md)
