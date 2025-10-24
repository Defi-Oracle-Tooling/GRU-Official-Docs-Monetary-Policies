#!/usr/bin/env bash
# GRU Li-Indices Diagram Export & QA Script
# Requires: npm install -g @mermaid-js/mermaid-cli npx svgo
set -euo pipefail

DIAGRAM_DIR="docs/meta/diagrams"
OUT_PNG="docs/media/li_indices_png"
OUT_SVG="docs/media/li_indices_svg"
mkdir -p "$DIAGRAM_DIR" "$OUT_PNG" "$OUT_SVG"

# Theme block for all diagrams
THEME_BLOCK='%%{init: {"theme": "base", "themeVariables": {"primaryColor": "#D6ECFF","primaryBorderColor": "#3C75B8","primaryTextColor": "#0F2A4D","lineColor": "#596273","secondaryColor": "#EAF8EF","tertiaryColor": "#F6E7A1","fontFamily": "Inter, Segoe UI, Roboto, sans-serif"}}}%%'

# List of diagram source files (add more as needed)
DIAGRAMS=(
  "li_indices_flow.mmd"
  "li_indices_mindmap.mmd"
)

# Write diagram sources from playbook if missing
if [ ! -f "$DIAGRAM_DIR/li_indices_flow.mmd" ]; then
  cat > "$DIAGRAM_DIR/li_indices_flow.mmd" <<EOF
$THEME_BLOCK
flowchart TD
  A[Source Assets] -->|Triangulate| B[XAU (Gold) Anchor]
  B -->|Parity Mint/Settle| C[GRU Unit]
  C --> D{{Li Commodity Indices}}
  D --> D1[LiXAU]
  D --> D2[LiPMG]
  D --> D3[LiBMG1]
  D --> D4[LiBMG2]
  D --> D5[LiBMG3]
classDef anchor fill:#F6E7A1,stroke:#C9A227,color:#3A2F00;
classDef unit   fill:#D6ECFF,stroke:#3C75B8,color:#0F2A4D;
classDef index  fill:#EAF8EF,stroke:#3A9D6B,color:#0E3B25;
class B anchor; class C unit; class D,D1,D2,D3,D4,D5 index;
EOF
fi

if [ ! -f "$DIAGRAM_DIR/li_indices_mindmap.mmd" ]; then
  cat > "$DIAGRAM_DIR/li_indices_mindmap.mmd" <<EOF
$THEME_BLOCK
mindmap
  root((GRU Indices))
    XAU:::anchor
    GRU:::unit
    Indices:::index
      LiXAU
      LiPMG
      LiBMG1
      LiBMG2
      LiBMG3
classDef anchor fill:#F6E7A1,stroke:#C9A227,color:#3A2F00;
classDef unit   fill:#D6ECFF,stroke:#3C75B8,color:#0F2A4D;
classDef index  fill:#EAF8EF,stroke:#3A9D6B,color:#0E3B25;
EOF
fi

# Export diagrams to PNG and SVG
for f in "${DIAGRAMS[@]}"; do
  base="${f%.mmd}"
  mmdc -i "$DIAGRAM_DIR/$f" -o "$OUT_PNG/${base}_v1.png" -b transparent -s 2 -H 1200 -W 1600
  mmdc -i "$DIAGRAM_DIR/$f" -o "$OUT_SVG/${base}_v1.svg" -b transparent -H 1200 -W 1600
  npx svgo "$OUT_SVG/${base}_v1.svg" --output "$OUT_SVG/${base}_v1.svg"
  # Add accessibility tags
  sed -i '1a <title>GRU Li-Indices Diagram</title>\n<desc>Automated export from playbook. See docs/meta/li_indices_enhancement_playbook.md for details.</desc>' "$OUT_SVG/${base}_v1.svg"
done

# QA checklist
PASS=true
for f in "$OUT_SVG"/*.svg; do
  if ! grep -q '<title>' "$f"; then echo "[WARN] Missing <title> in $f"; PASS=false; fi
  if ! grep -q '<desc>' "$f"; then echo "[WARN] Missing <desc> in $f"; PASS=false; fi
  # Palette check (basic)
  if ! grep -q '#C9A227' "$f"; then echo "[WARN] Gold anchor color missing in $f"; PASS=false; fi
  if ! grep -q '#D6ECFF' "$f"; then echo "[WARN] Sky GRU color missing in $f"; PASS=false; fi
  if ! grep -q '#EAF8EF' "$f"; then echo "[WARN] Index color missing in $f"; PASS=false; fi

done
if $PASS; then echo "[QA] All SVGs pass accessibility and palette checks."; else echo "[QA] Some SVGs failed checks."; fi

echo "[DONE] Diagrams exported to $OUT_PNG and $OUT_SVG. See playbook for further steps."
