# Global Reserve Unit (GRU) – Official Monetary Policy Documentation

## Repository Purpose
This repository contains the structured institutional documentation set for the **Global Reserve Unit (GRU)** monetary architecture and the **Digital Bank for International Settlements (DBIS)** concept charter. It standardizes core policy, mechanical issuance logic, governance, bond infrastructure, and forward expansion roadmap materials.

## Directory Structure
```
docs/
	core/                      # Primary white paper section documents
		01_GRU_Monetary_Policy_Framework.md
		02_GRU_Triangulation_eMoney_Creation.md
		03_GRU_Bond_System_Liquidity_Management.md
		04_GRU_Governance_Regulatory_Oversight.md
		05_Digital_Bank_for_International_Settlements_Charter.md
		06_GRU_Enhancement_Expansion_Roadmap.md
	meta/                      # Supporting references & annexes
		GRU_Formulas.md
		Glossary.md
		Risk_Annex.md
scripts/                     # Build & packaging automation
dist/                        # Generated artifacts (ignored on commit)
LICENSE                      # License (CC BY 4.0)
README.md                    # This file
```

## Core Documents Overview
| File | Scope | Status |
|------|-------|--------|
| 01_GRU_Monetary_Policy_Framework.md | Structural ratios, reserve policy, governance layers | Stable |
| 02_GRU_Triangulation_eMoney_Creation.md | Atomic issuance, 7:10 protocol, 40/40/20 rule | Stable |
| 03_GRU_Bond_System_Liquidity_Management.md | Li99-series bonds, coupon & buy-back cycles | Stable |
| 04_GRU_Governance_Regulatory_Oversight.md | Multi-chamber SHTE governance & compliance | Stable |
| 05_Digital_Bank_for_International_Settlements_Charter.md | DBIS treaty-style charter & integration | Stable |
| 06_GRU_Enhancement_Expansion_Roadmap.md | Phase rollout, aggregates M2/M3, future enhancements | Stable |

## Build & Packaging
Run the build script to generate PDF, DOCX, combined master collection, checksum log, and ZIP archive.

### Prerequisites
- `pandoc` (for PDF/DOCX conversion)
- `sha256sum` (standard on most Unix systems)
- `zip`

### Build
```
chmod +x scripts/build.sh
./scripts/build.sh
```
Artifacts produced under `dist/`:
```
dist/
	markdown/                      # Source markdown copies + master collection
	pdf/                           # PDF conversions (if pandoc present)
	docx/                          # DOCX conversions (if pandoc present)
	metadata/                      # Checksum log & auxiliary notices
	GRU_Master_Whitepaper_PRO.zip  # Packaged archive
```

If pandoc is missing, a warning is written to `dist/metadata/pandoc_missing.txt` and only markdown + checksum output are generated.

## Checksum Verification
Use the generated `GRU_Checksum_Verification_Log.txt`:
```
sha256sum -c dist/metadata/GRU_Checksum_Verification_Log.txt
```
All entries should report `OK`. Any mismatch indicates tampering or file corruption.

## Versioning & Release
1. Ensure build completes successfully.
2. Review changes & commit.
3. Tag initial stable release:
```
git tag -a v1.0.0 -m "GRU Documentation Initial Stable Release"
git push --tags
```

## Licensing
Content is released under **Creative Commons Attribution 4.0 (CC BY 4.0)**. Attribution required for reuse or derivative works.

## Roadmap (High-Level)
- Add Executive Summary & Metadata Sheet to `meta/`
- Integrate master collection auto-generation into build (currently included when pandoc exists)
- Add diagram assets (atomic cycle, triangulation flow, bond cycle) as SVG/PNG + optional mermaid
- Add glossary expansions (ESG, velocity metrics, oracle classes)

## Contribution Guidelines (Lightweight)
1. Maintain front matter consistency (title, version, status, last_updated, checksum placeholder).
2. Avoid reformatting unrelated sections in edits.
3. Update `last_updated` date on substantive content change.
4. Re-run build script before tagging releases.

## Integrity & Transparency Notes
- Reserve and issuance modeling assumes external validation modules (planned DSL PoR interface).
- Risk Annex is provisional—thresholds subject to operational telemetry after initial deployment.

## Contact / Stewardship
Primary stewardship: **GRU Monetary Authority** — Policy & Systems Division.

---
© 2025 GRU Monetary Authority