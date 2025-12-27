---
title: GRU Checksums & Integrity Guide
version: 1.0.0
status: provisional
last_updated: 2025-10-24
checksum: pending
---
# GRU Documentation Checksums & Integrity Guide

## 1. Purpose
This document explains how integrity is established, verified, and maintained for GRU documentation artifacts (Markdown, PDF, DOCX, packaged ZIP). It complements the automatically generated `GRU_Checksum_Verification_Log.txt` under `dist/metadata/`.

## 2. Generation Process
Checksums are produced by the build script:
```
./scripts/build.sh
```
If `pandoc` is available, PDF and DOCX versions are generated prior to checksum collection. The script computes SHA256 digests for all `.md`, `.pdf`, and `.docx` files inside `dist/`.

## 3. Output File Structure
After a successful build:
```
dist/
  markdown/            # Source markdown copies + master collection
  pdf/                 # PDF outputs (if pandoc installed)
  docx/                # DOCX outputs (if pandoc installed)
  metadata/
    GRU_Checksum_Verification_Log.txt
    (optional) pandoc_missing.txt
  GRU_Master_Whitepaper_PRO.zip
```

## 4. Verification Procedure
From the `dist/` directory:
```
cd dist
sha256sum -c metadata/GRU_Checksum_Verification_Log.txt
```
Expected result: each file line reports `OK`. Any mismatch indicates alteration or corruption.

## 5. Sample Log (Excerpt)
```
# GRU Documentation Checksums (SHA256)
Generated: 2025-10-24T00:00:00Z
b3f1...  markdown/01_GRU_Monetary_Policy_Framework.md
9c4e...  pdf/01_GRU_Monetary_Policy_Framework.pdf
...
```
(The above hashes are placeholders.)

## 6. Integrity Policy
| Aspect | Policy |
|--------|--------|
| Hash Algorithm | SHA256 (migration path to SHA3-256 possible) |
| Reproducibility | Deterministic build—same input yields identical hashes |
| Tamper Detection | Any hash mismatch fails verification step |
| Frequency | On each tagged release / significant content change |

## 7. Release Workflow Integration
1. Update content.
2. Run build script.
3. Verify checksums.
4. Commit changes (excluding `/dist/` per `.gitignore`).
5. Tag release (`v1.x.y`).
6. Distribute ZIP + checksum log externally if required.

## 8. Security Considerations
| Risk | Mitigation |
|------|------------|
| Hash Collision | Use SHA256 (low practical risk); monitor NIST guidance |
| Unsigned Distribution | Future: GPG signing of checksum log + tag |
| Malicious Rebuild | CI policy + reproducible environment (container) |

## 9. Planned Enhancements
- GPG signature for `GRU_Checksum_Verification_Log.txt`.
- Inclusion of merkle root summary for all artifacts.
- Automated CI validation on pull requests.

## 10. FAQ
| Question | Answer |
|----------|--------|
| Why exclude `dist/` from VCS? | Prevent large binary churn; artifacts are reproducible |
| Can I add new formats? | Extend build script; ensure added types included in checksum loop |
| What if pandoc is missing? | Only markdown hashes generated; install pandoc and rebuild for full set |

---
© 2025 GRU Monetary Authority — Integrity Reference v1.0.0
