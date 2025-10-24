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
MEDIA_DIR="$ROOT_DIR/docs/media"

# Pre-convert SVG diagrams to PDF (and PNG fallback) for reliable embedding
if command -v rsvg-convert >/dev/null 2>&1; then
  for svg in "$MEDIA_DIR"/*.svg; do
    [ -f "$svg" ] || continue
    pdf_out="${svg%.svg}.pdf"
    png_out="${svg%.svg}.png"
    if ! rsvg-convert -f pdf -o "$pdf_out" "$svg" 2>/dev/null; then
      echo "[WARN] SVG→PDF conversion failed for $svg" >&2
    fi
    if ! rsvg-convert -f png -o "$png_out" "$svg" 2>/dev/null; then
      echo "[WARN] SVG→PNG conversion failed for $svg" >&2
    fi
  done
else
  echo "[WARN] rsvg-convert not found; SVG diagrams may not embed in PDFs." >&2
fi

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
    printf "\n\n# Source: %s\n\n" "$(basename "$mf")" >> "$MASTER_MD"
    # Strip YAML front matter blocks and decorative end markers
    awk 'BEGIN{inmeta=0} /^---[[:space:]]*$/ { if(inmeta==0){inmeta=1; next} else if(inmeta==1){inmeta=2; next} } { if(inmeta!=1) print }' "$mf" \
      | sed '/\*End of Executive Summary\*/d' >> "$MASTER_MD"
    printf "\n\n" >> "$MASTER_MD"
  done
  # Normalize image paths for master aggregation: copy media assets locally and rewrite ../media/ to media/
  mkdir -p "$DIST_DIR/markdown/media"
  cp "$ROOT_DIR/docs/media"/*.pdf "$DIST_DIR/markdown/media/" 2>/dev/null || true
  cp "$ROOT_DIR/docs/media"/*.png "$DIST_DIR/markdown/media/" 2>/dev/null || true
  sed -i 's#](../media/#](media/#g' "$MASTER_MD"
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
   # Add Li-Indices diagram and weights files to checksum log
   for f in "$ROOT_DIR/docs/meta/li_indices_enhancement_playbook.md" "$ROOT_DIR/docs/meta/li_indices_weights.yaml" "$ROOT_DIR/docs/meta/li_indices_weights.csv" "$ROOT_DIR/docs/meta/CHANGELOG.md"; do
     if [ -f "$f" ]; then
       sum=$(sha256sum "$f" | awk '{print $1}')
       rel=${f#"$ROOT_DIR/"}
       echo "$sum  $rel"
     fi
   done
} > "$CHECKSUM_FILE"

# Create ZIP archive
ZIP_NAME="GRU_Master_Whitepaper_PRO.zip"
( cd "$DIST_DIR" && zip -qr "$ZIP_NAME" . )

echo "[DONE] Build complete. Artifacts in $DIST_DIR"
