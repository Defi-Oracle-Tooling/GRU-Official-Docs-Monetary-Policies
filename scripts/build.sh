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

  # Detect PDF engine; prefer pdflatex, fallback to wkhtmltopdf; skip if none.
  PDF_ENGINE="pdflatex"
  if ! command -v "$PDF_ENGINE" >/dev/null 2>&1; then
    if command -v wkhtmltopdf >/dev/null 2>&1; then
      PDF_ENGINE="wkhtmltopdf"
    else
      echo "[WARN] No PDF engine (pdflatex/wkhtmltopdf) detected. PDF generation will be skipped." >&2
      SKIP_PDF=1
    fi
  fi

  for f in "$CORE_DIR"/*.md; do
    base="$(basename "$f" .md)"
    # DOCX always attempted
    if ! pandoc "$f" -o "$DIST_DIR/docx/${base}.docx"; then
      echo "[ERROR] DOCX conversion failed for $f" >&2
    fi
    # PDF conditional
    if [ -z "${SKIP_PDF:-}" ]; then
      if ! pandoc "$f" --pdf-engine="$PDF_ENGINE" -o "$DIST_DIR/pdf/${base}.pdf" 2>"$DIST_DIR/metadata/${base}_pdf_error.log"; then
        echo "[WARN] PDF conversion failed for $f (see metadata/${base}_pdf_error.log)." >&2
      fi
    fi
  done

  # Master collection (concatenate in numeric order)
  MASTER_INPUTS=$(ls -1 "$CORE_DIR"/*_GRU_*.md | sort)
  if pandoc $MASTER_INPUTS -o "$DIST_DIR/markdown/00_GRU_Master_Whitepaper_Collection.md"; then
    if [ -z "${SKIP_PDF:-}" ]; then
      pandoc $MASTER_INPUTS --pdf-engine="$PDF_ENGINE" -o "$DIST_DIR/pdf/00_GRU_Master_Whitepaper_Collection.pdf" 2>"$DIST_DIR/metadata/master_pdf_error.log" || echo "[WARN] Master PDF conversion failed (see metadata/master_pdf_error.log)." >&2
    fi
    pandoc $MASTER_INPUTS -o "$DIST_DIR/docx/00_GRU_Master_Whitepaper_Collection.docx" || echo "[WARN] Master DOCX conversion failed." >&2
  else
    echo "[ERROR] Master collection markdown build failed." >&2
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
