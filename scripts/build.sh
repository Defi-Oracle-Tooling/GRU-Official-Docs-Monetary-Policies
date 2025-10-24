#!/usr/bin/env bash
set -euo pipefail

# GRU Documentation Build Script
# Converts core markdown documents to PDF and DOCX (if pandoc installed),
# generates master collection, and produces checksum log + ZIP archive.

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CORE_DIR="$ROOT_DIR/docs/core"
META_DIR="$ROOT_DIR/docs/meta"
DIST_DIR="$ROOT_DIR/dist"
DATE_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

mkdir -p "$DIST_DIR/markdown" "$DIST_DIR/pdf" "$DIST_DIR/docx" "$DIST_DIR/metadata"

# Copy markdown sources
cp "$CORE_DIR"/*.md "$DIST_DIR/markdown/"
cp "$META_DIR"/*.md "$DIST_DIR/metadata/"

# Check pandoc availability
if ! command -v pandoc >/dev/null 2>&1; then
  echo "[WARN] pandoc not found. Install pandoc to enable PDF/DOCX generation." >&2
  echo "PDF/DOCX conversion skipped" > "$DIST_DIR/metadata/pandoc_missing.txt"
else
  echo "[INFO] pandoc detected. Preparing format conversion..."

  # Detect PDF engine; prefer Unicode-aware engines (xelatex, lualatex) then pdflatex, fallback to wkhtmltopdf; skip if none.
  PDF_ENGINE=""
  if command -v xelatex >/dev/null 2>&1; then
    PDF_ENGINE="xelatex"  # Full Unicode + font support
  elif command -v lualatex >/dev/null 2>&1; then
    PDF_ENGINE="lualatex" # Unicode capable
  elif command -v pdflatex >/dev/null 2>&1; then
    PDF_ENGINE="pdflatex"
  elif command -v wkhtmltopdf >/dev/null 2>&1; then
    PDF_ENGINE="wkhtmltopdf" # HTML-based fallback (limited metadata control)
  else
    echo "[WARN] No suitable PDF engine (xelatex/lualatex/pdflatex/wkhtmltopdf) detected. PDF generation will be skipped." >&2
    SKIP_PDF=1
  fi

  if [ -n "$PDF_ENGINE" ]; then
    echo "[INFO] Using PDF engine: $PDF_ENGINE" >&2
  fi
  # Common PDF options (Unicode-capable fonts to avoid missing glyph warnings for ≥ ≤ ≈ ↔)
  if [ -z "${SKIP_PDF:-}" ]; then
    RESOURCE_PATH="$CORE_DIR:$ROOT_DIR/docs/media:$META_DIR"
    PDF_OPTS=(--pdf-engine="$PDF_ENGINE" --include-in-header "$ROOT_DIR/docs/meta/preamble.tex" --resource-path="$RESOURCE_PATH" -V mainfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" -V mathfont="TeX Gyre Termes Math")
    if [ ! -f "$ROOT_DIR/docs/meta/preamble.tex" ]; then
      echo "[WARN] Preamble header missing; proceeding without custom styling." >&2
      PDF_OPTS=(--pdf-engine="$PDF_ENGINE" --resource-path="$RESOURCE_PATH" -V mainfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" -V mathfont="TeX Gyre Termes Math")
    fi
  fi

  for f in "$CORE_DIR"/*.md; do
    base="$(basename "$f" .md)"
    # DOCX always attempted
    if ( cd "$(dirname "$f")" && pandoc "$(basename "$f")" -o "$DIST_DIR/docx/${base}.docx" ); then :; else
      echo "[ERROR] DOCX conversion failed for $f" >&2
    fi
    # PDF conditional
    if [ -z "${SKIP_PDF:-}" ]; then
      if ( cd "$(dirname "$f")" && pandoc "$(basename "$f")" "${PDF_OPTS[@]}" -o "$DIST_DIR/pdf/${base}.pdf" 2>"$DIST_DIR/metadata/${base}_pdf_error.log" ); then :; else
        echo "[WARN] PDF conversion failed for $f (see metadata/${base}_pdf_error.log)." >&2
      fi
    fi
  done

  # Master collection (concatenate in numeric order)
  MASTER_INPUTS=$(ls -1 "$CORE_DIR"/*_GRU_*.md | sort)
  MASTER_MD="$DIST_DIR/markdown/00_GRU_Master_Whitepaper_Collection.md"
  : > "$MASTER_MD"
  for mf in $MASTER_INPUTS; do
    echo "\n\n# Source: $(basename "$mf")\n" >> "$MASTER_MD"
    cat "$mf" >> "$MASTER_MD"
    echo "\n\n---" >> "$MASTER_MD"
  done
  # Attempt richer PDF/DOCX via pandoc on concatenated master markdown
  if [ -z "${SKIP_PDF:-}" ]; then
    if ! pandoc "$MASTER_MD" "${PDF_OPTS[@]}" -o "$DIST_DIR/pdf/00_GRU_Master_Whitepaper_Collection.pdf" 2>"$DIST_DIR/metadata/master_pdf_error.log"; then
      echo "[WARN] Master PDF conversion failed (see metadata/master_pdf_error.log)." >&2
    fi
  fi
  if ! pandoc "$MASTER_MD" -o "$DIST_DIR/docx/00_GRU_Master_Whitepaper_Collection.docx"; then
    echo "[WARN] Master DOCX conversion failed." >&2
  fi
fi

# Generate checksum log (markdown + any produced artifacts)
CHECKSUM_FILE="$DIST_DIR/metadata/GRU_Checksum_Verification_Log.txt"
{
  echo "# GRU Documentation Checksums (SHA256)"
  echo "Generated: $DATE_UTC"
  echo
  find "$DIST_DIR" -type f \( -name '*.md' -o -name '*.pdf' -o -name '*.docx' \) -print0 | while IFS= read -r -d '' file; do
    sum=$(sha256sum "$file" | awk '{print $1}')
    rel=${file#"$DIST_DIR/"}
    echo "$sum  $rel"
  done
} > "$CHECKSUM_FILE"

# Create ZIP archive
ZIP_NAME="GRU_Master_Whitepaper_PRO.zip"
( cd "$DIST_DIR" && zip -qr "$ZIP_NAME" . )

echo "[DONE] Build complete. Artifacts in $DIST_DIR"
