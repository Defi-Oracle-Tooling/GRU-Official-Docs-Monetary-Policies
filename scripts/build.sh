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
  echo "[INFO] pandoc detected. Generating formats..."
  for f in "$CORE_DIR"/*.md; do
    base="$(basename "$f" .md)"
    pandoc "$f" -o "$DIST_DIR/pdf/${base}.pdf"
    pandoc "$f" -o "$DIST_DIR/docx/${base}.docx"
  done
  # Master collection (concatenate in numeric order)
  pandoc $(ls -1 "$CORE_DIR"/*_GRU_*.md | sort) -o "$DIST_DIR/markdown/00_GRU_Master_Whitepaper_Collection.md"
  pandoc $(ls -1 "$CORE_DIR"/*_GRU_*.md | sort) -o "$DIST_DIR/pdf/00_GRU_Master_Whitepaper_Collection.pdf"
  pandoc $(ls -1 "$CORE_DIR"/*_GRU_*.md | sort) -o "$DIST_DIR/docx/00_GRU_Master_Whitepaper_Collection.docx"
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
