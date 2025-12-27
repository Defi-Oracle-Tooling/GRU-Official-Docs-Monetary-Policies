# Jekyll Build Fix

## Issue
Jekyll build was failing with an error during the GitHub Actions workflow.

## Root Cause
Jekyll collections require directories prefixed with underscores (`_core`, `_compliance`, etc.), but the original structure used `docs/core`, `docs/compliance`.

## Solution Applied

1. **Created Collection Directories**: 
   - Created `_core/`, `_compliance/`, `_meta/`, `_lang/` directories
   - Copied files from `docs/` to collection directories

2. **Updated Configuration**:
   - Updated `_config.yml` to point to underscore-prefixed collection directories
   - Updated defaults to use `_core`, `_compliance`, `_meta` paths
   - Excluded original `docs/core`, `docs/compliance`, `docs/meta` from processing

3. **Fixed Front Matter**:
   - Standardized front matter to use lowercase keys (`title` instead of `Title`)
   - Updated `00_GRU_Executive_Summary.md` front matter format

4. **Updated Gemfile**:
   - Added `kramdown-parser-gfm` gem for GFM markdown support
   - Removed version constraints that might cause conflicts

5. **Improved Error Reporting**:
   - Added `--verbose --trace` flags to Jekyll build command for better error messages

## Files Modified

- `_config.yml` - Updated collection paths and defaults
- `Gemfile` - Added kramdown-parser-gfm
- `.github/workflows/pages.yml` - Added verbose flags
- `_core/00_GRU_Executive_Summary.md` - Fixed front matter

## Collection Structure

```
_core/          # Core documents collection
_compliance/    # Compliance documents collection  
_meta/          # Meta references collection
_lang/          # Language translations collection
```

## Next Steps

1. Commit and push these changes
2. The workflow should now build successfully
3. Verify the site deploys correctly

