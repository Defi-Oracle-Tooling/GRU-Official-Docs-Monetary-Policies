# Link Check Report
## Comprehensive Link Verification

**Date:** 2025-01-26  
**Site URL:** https://monetary-policies.d-bis.org
**Status:** Historical report. The current source tree now includes additional landing pages and language hubs.

---

## ✅ Working Links (14)

### Core Documents (8/8) ✅
- ✓ `/core/00-gru-executive-summary/` - 200 OK
- ✓ `/core/01-gru-monetary-policy-framework/` - 200 OK
- ✓ `/core/02-gru-triangulation-emoney-creation/` - 200 OK
- ✓ `/core/03-gru-bond-system-liquidity-management/` - 200 OK
- ✓ `/core/04-gru-governance-regulatory-oversight/` - 200 OK
- ✓ `/core/05-digital-bank-for-international-settlements-charter/` - 200 OK
- ✓ `/core/06-gru-enhancement-expansion-roadmap/` - 200 OK
- ✓ `/core/07-omnl-central-bank-dbis-operational-manual/` - 200 OK

### Meta Documents (3/3) ✅
- ✓ `/meta/gru-formulas/` - 200 OK
- ✓ `/meta/glossary/` - 200 OK
- ✓ `/meta/risk-annex/` - 200 OK

### Key Pages (3/3) ✅
- ✓ `/` (Homepage) - 200 OK
- ✓ `/search/` - 200 OK
- ✓ `/404.html` - 200 OK

---

## ⚠️ Issue Found: Compliance Document URLs

### Problem
Compliance documents are being generated at the wrong URL level due to permalink pattern.

**Current Pattern:** `/compliance/:name/`  
**Result:** Documents appear at `/compliance/sepa-compliance-matrix/` (no subdirectory)

**Expected Pattern:** `/compliance/:path/:name/`  
**Should be:** `/compliance/sepa/sepa-compliance-matrix/`

### Files Affected
All compliance documents in subdirectories:
- `/compliance/sepa/sepa-compliance-matrix/` → Currently at `/compliance/sepa-compliance-matrix/`
- `/compliance/sepa/ipr-compliance-memo/` → Currently at `/compliance/ipr-compliance-memo/`
- `/compliance/mica/legal-position-gru-vs-mica/` → Currently at `/compliance/legal-position-gru-vs-mica/`
- `/compliance/mica/issuer-obligations-readiness/` → Currently at `/compliance/issuer-obligations-readiness/`
- `/compliance/dora/ict-risk-policy/` → Currently at `/compliance/ict-risk-policy/`
- `/compliance/dora/incident-response-runbook/` → Currently at `/compliance/incident-response-runbook/`
- `/compliance/aml/enterprise-wide-risk-assessment/` → Currently at `/compliance/enterprise-wide-risk-assessment/`

### Fix Applied
Updated `_config.yml`:
```yaml
compliance:
  output: true
  permalink: /compliance/:path/:name/  # Changed from /compliance/:name/
```

### Status
✅ **Fix Applied** - Configuration updated  
⏳ **Pending Deployment** - Needs to be pushed and rebuilt

---

## 📊 Link Status Summary

| Category | Total | Working | Broken | Status |
|----------|-------|---------|--------|--------|
| Core Documents | 8 | 8 | 0 | ✅ 100% |
| Meta Documents | 3 | 3 | 0 | ✅ 100% |
| Compliance Documents | 7 | 0* | 7* | ⚠️ URL Pattern Issue |
| Key Pages | 3 | 3 | 0 | ✅ 100% |
| **Total** | **21** | **14** | **7*** | **67%** |

*Will be fixed after next deployment with updated permalink pattern

---

## 🔍 Additional Findings

### Sitemap Analysis
The sitemap shows compliance documents are currently at:
- `/compliance/sepa-compliance-matrix/` (should be `/compliance/sepa/sepa-compliance-matrix/`)
- `/compliance/ipr-compliance-memo/` (should be `/compliance/sepa/ipr-compliance-memo/`)
- etc.

### Base URL Issue
The sitemap uses `https://defi-oracle-tooling.github.io/GRU-Official-Docs-Monetary-Policies/` but the actual site is at `https://monetary-policies.d-bis.org/`. This is expected if using a custom domain.

---

## ✅ Verification After Fix

Once the permalink fix is deployed, these URLs should work:
- `/compliance/sepa/sepa-compliance-matrix/`
- `/compliance/sepa/ipr-compliance-memo/`
- `/compliance/mica/legal-position-gru-vs-mica/`
- `/compliance/mica/issuer-obligations-readiness/`
- `/compliance/dora/ict-risk-policy/`
- `/compliance/dora/incident-response-runbook/`
- `/compliance/aml/enterprise-wide-risk-assessment/`

---

## 🛠️ Tools Created

### `check_links.sh`
Automated link checking script that:
- Tests all major links
- Reports HTTP status codes
- Provides color-coded output
- Generates summary report

**Usage:**
```bash
./check_links.sh
```

---

**Next Steps:**
1. ✅ Permalink pattern fixed in `_config.yml`
2. ⏳ Commit and push changes
3. ⏳ Wait for GitHub Pages rebuild
4. ⏳ Re-run link checker to verify

---

**Report Generated:** 2025-01-26
