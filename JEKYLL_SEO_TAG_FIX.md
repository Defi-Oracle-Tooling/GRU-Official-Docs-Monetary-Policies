# Jekyll SEO Tag Fix

## Issue
The `jekyll-seo-tag` plugin was failing with:
```
undefined method `tr' for []:Array
@page_locale ||= (page["locale"] || site["locale"] || page_lang).tr("-", "_")
```

## Root Cause
The `jekyll-seo-tag` plugin was trying to extract the language from pages but `page_lang` was returning an empty array `[]` instead of a string, causing the `.tr()` method call to fail.

## Solution Applied

1. **Set site-wide language in `_config.yml`**:
   - Added `lang: "en"` and `locale: "en_US"` to site settings
   - Ensures jekyll-seo-tag has a fallback value

2. **Simplified HTML lang attribute**:
   - Changed from `{{ page.lang | default: 'en' }}` to hardcoded `"en"`
   - Prevents Liquid expression issues that might confuse jekyll-seo-tag

3. **Added lang defaults**:
   - Added `lang: "en"` to all default scopes in `_config.yml`
   - Ensures all pages have a lang value

4. **Updated front matter**:
   - Added `lang: en` to `index.md` and `_core/00_GRU_Executive_Summary.md`
   - Other documents will inherit from defaults

## Files Modified

- `_config.yml` - Added lang and locale settings, updated defaults
- `_layouts/default.html` - Simplified HTML lang attribute
- `index.md` - Added lang front matter
- `_core/00_GRU_Executive_Summary.md` - Added lang front matter

## Result

The jekyll-seo-tag plugin should now receive a proper string value for language instead of an array, allowing the build to complete successfully.

