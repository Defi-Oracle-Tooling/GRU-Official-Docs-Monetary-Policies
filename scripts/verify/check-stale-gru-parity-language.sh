#!/usr/bin/env bash
# Heuristic scan for ambiguous GRU parity / "face vs supporting" phrasing.
# Default: exit 0 (report-only). Use --strict to fail CI on high-risk hits in English core.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

STRICT=0
if [[ "${1:-}" == "--strict" ]]; then
  STRICT=1
fi

echo "== GRU parity language scan (repo root: $ROOT) =="

scan() {
  local label="$1"
  shift
  echo ""
  echo "-- $label --"
  rg -n "$@" 2>/dev/null || true
}

# High-risk if presented as policy (not as "wrong" example in quick ref / checklist)
scan "Literal '1 GRU = 1.2' (review context)" \
  '1 GRU = 1\.2' docs/core _core docs/lang --glob '*.md' \
  --glob '!**/Canonical_Parity_Quick_Reference.md' \
  --glob '!**/DOCS_REVIEW_FIXES_ACCEPTANCE_CHECKLIST.md' \
  --glob '!**/Deterministic_Specifications_Index.md' || true

scan "'1.44' mentions (should be rejection/education only)" \
  '1\.44' docs/core _core docs/lang docs/meta _meta --glob '*.md' \
  --glob '!**/DOCS_REVIEW_FIXES_ACCEPTANCE_CHECKLIST.md' || true

scan "'1 XAU GRU = 1.2' without immediate 'supporting' hint (spot-check)" \
  '1 XAU GRU = 1\.2' docs/core _core docs/lang --glob '*.md' || true

echo ""
echo "Done. Interpretation:"
echo "  - M0 line '1.2 XAU' is OK when labeled SUPPORTING / reserve-side."
echo "  - Face parity is always 1 GRU = 1 XAU (see docs/meta/Canonical_Parity_Quick_Reference.md)."
echo ""
if [[ "$STRICT" -eq 1 ]]; then
  if rg -q '1 GRU = 1\.2' docs/core _core docs/lang --glob '*.md' \
    --glob '!**/Canonical_Parity_Quick_Reference.md' \
    --glob '!**/DOCS_REVIEW_FIXES_ACCEPTANCE_CHECKLIST.md' \
    --glob '!**/Deterministic_Specifications_Index.md' 2>/dev/null
  then
    echo "STRICT: failing due to '1 GRU = 1.2' outside whitelisted education files." >&2
    exit 1
  fi
  echo "STRICT: no forbidden '1 GRU = 1.2' pattern in core/lang (outside whitelist)."
fi
exit 0
