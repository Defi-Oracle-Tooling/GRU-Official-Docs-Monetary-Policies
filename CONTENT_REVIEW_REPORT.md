# Content Review Report
## Duplications, Inconsistencies, and Issues

**Date:** 2025-01-26  
**Reviewer:** Automated Content Analysis
**Status:** Historical report. Several findings below have since been corrected in the working tree.

---

## 🔴 Critical Issues Found

### 1. **Duplicate Loading Attribute**
**File:** `_core/01_GRU_Monetary_Policy_Framework.md`  
**Line:** 15  
**Issue:** `{: loading="lazy" }{: loading="lazy" }` - duplicate attribute  
**Fix:** Remove one instance

### 2. **Inconsistent Image Paths in Language Files**
**Location:** `docs/lang/*/core/*.md`  
**Issue:** Using old paths `../../media/` instead of `/assets/media/`  
**Impact:** Images won't load correctly in multilingual versions  
**Files Affected:**
- `docs/lang/pt/core/*.md` (4 files)
- `docs/lang/id/core/*.md` (4 files)
- `docs/lang/fr/core/*.md` (4 files)
- `docs/lang/ar/core/*.md` (4 files)

### 3. **Inconsistent Image Formats**
**Location:** `docs/lang/*/core/*.md`  
**Issue:** Using `.pdf` format instead of `.png` for web display  
**Current:** `../../media/issuance_cycle.pdf`  
**Should be:** `/assets/media/issuance_cycle.png`

### 4. **Missing Lang Field in Front Matter**
**Issue:** Only `00_GRU_Executive_Summary.md` has `lang: en`  
**Files Missing Lang:**
- `01_GRU_Monetary_Policy_Framework.md`
- `02_GRU_Triangulation_eMoney_Creation.md`
- `03_GRU_Bond_System_Liquidity_Management.md`
- `04_GRU_Governance_Regulatory_Oversight.md`
- `05_Digital_Bank_for_International_Settlements_Charter.md`
- `06_GRU_Enhancement_Expansion_Roadmap.md`
- `07_OMNL_Central_Bank_DBIS_Operational_Manual.md`

**Note:** While defaults in `_config.yml` provide `lang: "en"`, explicit front matter is better for consistency.

---

## 🟡 Medium Priority Issues

### 5. **Inconsistent URL Patterns**
**Issue:** Mix of underscore and hyphen patterns in URLs  
**Examples:**
- Config uses: `/core/00_gru_executive_summary/`
- 404 page uses: `/core/00-gru-executive-summary/`
- Actual permalink: `/core/00-gru-executive-summary/` (Jekyll converts underscores to hyphens)

**Impact:** Potential broken links if hardcoded URLs don't match Jekyll's permalink generation

### 6. **Duplicate Content in docs/core**
**Issue:** Files exist in both `_core/` (Jekyll collections) and `docs/core/` (excluded)  
**Files:**
- `docs/core/01_GRU_Monetary_Policy_Framework.md`
- `docs/core/02_GRU_Triangulation_eMoney_Creation.md`
- `docs/core/03_GRU_Bond_System_Liquidity_Management.md`
- `docs/core/04_GRU_Governance_Regulatory_Oversight.md`
- `docs/core/06_GRU_Enhancement_Expansion_Roadmap.md`

**Status:** These are excluded in `_config.yml`, so not processed by Jekyll, but could cause confusion.

### 7. **Inconsistent Date Format**
**Issue:** One document has different date  
**File:** `07_OMNL_Central_Bank_DBIS_Operational_Manual.md`  
**Date:** `2025-10-29` (others use `2025-10-24`)

**Note:** This may be intentional if document was updated later.

### 8. **Inconsistent Front Matter Fields**
**Issue:** Some documents have extra fields  
**File:** `07_OMNL_Central_Bank_DBIS_Operational_Manual.md`  
**Extra Fields:**
- `document_ref: OMNL/DBIS-GRU-2025-POL01`
- `effective_date: October 2025`

**Recommendation:** Standardize front matter or document which fields are optional.

---

## 🟢 Low Priority / Recommendations

### 9. **Version Number Inconsistency**
**Issue:** Executive Summary is version `1.1.0`, others are `1.0.0`  
**File:** `00_GRU_Executive_Summary.md`  
**Status:** May be intentional - document was updated more recently

### 10. **Missing Checksums**
**Issue:** All documents show `checksum: pending`  
**Recommendation:** Generate and populate checksums if integrity verification is important

### 11. **Layer Field Inconsistency**
**Issue:** Different layer values across documents  
**Values Found:**
- `policy`
- `mechanics`
- `instruments`
- `governance`
- `charter`
- `roadmap`
- `operational-policy`

**Recommendation:** Document layer taxonomy or standardize values

---

## 📋 Summary of Issues

| Priority | Issue | Count | Status |
|----------|-------|-------|--------|
| 🔴 Critical | Duplicate loading attribute | 1 | Needs Fix |
| 🔴 Critical | Wrong image paths (lang files) | 16 | Needs Fix |
| 🔴 Critical | Wrong image format (lang files) | 16 | Needs Fix |
| 🔴 Critical | Missing lang field | 7 | Should Fix |
| 🟡 Medium | URL pattern inconsistency | Multiple | Should Review |
| 🟡 Medium | Duplicate content locations | 5 | Documented |
| 🟡 Medium | Date inconsistency | 1 | May be Intentional |
| 🟡 Medium | Front matter inconsistency | 1 | Should Document |
| 🟢 Low | Version inconsistency | 1 | May be Intentional |
| 🟢 Low | Missing checksums | 8 | Optional |
| 🟢 Low | Layer field inconsistency | 7 | Should Document |

---

## 🔧 Recommended Fixes

### Immediate Fixes (Critical)

1. **Fix duplicate loading attribute:**
   ```markdown
   ![GRU Issuance Cycle](/assets/media/issuance_cycle.png){: loading="lazy" }
   ```

2. **Add lang field to all core documents:**
   ```yaml
   lang: en
   ```

3. **Update language file image paths:**
   - Change `../../media/` to `/assets/media/`
   - Change `.pdf` to `.png`
   - Add `{: loading="lazy" }` attribute

### Documentation Needed

1. **Document front matter schema:**
   - Required fields: `title`, `version`, `status`, `last_updated`
   - Optional fields: `lang`, `layer`, `checksum`, `document_ref`, `effective_date`

2. **Document layer taxonomy:**
   - Define what each layer value means
   - Create reference guide

3. **Document URL pattern:**
   - Clarify that Jekyll converts underscores to hyphens
   - Use consistent references in config and links

---

## ✅ Verification Checklist

- [ ] Fix duplicate loading attribute
- [ ] Add lang field to all core documents
- [ ] Update language file image paths and formats
- [ ] Standardize front matter fields
- [ ] Document layer taxonomy
- [ ] Verify all URLs match Jekyll permalink pattern
- [ ] Generate checksums (if needed)
- [ ] Review and document date inconsistencies

---

**Next Steps:**
1. Fix critical issues
2. Document standards
3. Create front matter template
4. Update language files
