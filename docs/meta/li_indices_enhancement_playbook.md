# GRU Li‑Indices — Enhancement & Export Playbook

A comprehensive checklist of optional additions to: (1) tweak colors and theming, (2) add basket‑weight placeholders + data schemas, and (3) export the Mermaid diagrams to PNG/SVG at publication quality.

---

## 1) Theming & Color Tweaks (Mermaid + Markdown)

### A. Accessible, Brand‑ready Palettes (WCAG‑aware)
* **Core palette ideas (color‑blind safe):**
  * Navy `#1F2A44`, Teal `#1EA896`, Gold `#C9A227`, Slate `#596273`, Sky `#D6ECFF`, Leaf `#3A9D6B`, Cream `#F6E7A1`
* **Light/Dark dual themes:** ensure 4.5:1 contrast for text on fills.
* **Status accents:**
  * Anchor/Gold nodes (XAU): Gold `#C9A227`
  * GRU unit: Sky `#D6ECFF`
  * Indices: Leaf `#EAF8EF`
  * Warnings/Notes: Amber `#FFB020`

### B. Mermaid `themeVariables` (global)
```mermaid
%%{init: {
  "theme": "base",
  "themeVariables": {
    "primaryColor": "#D6ECFF",
    "primaryBorderColor": "#3C75B8",
    "primaryTextColor": "#0F2A4D",
    "lineColor": "#596273",
    "secondaryColor": "#EAF8EF",
    "tertiaryColor": "#F6E7A1",
    "fontFamily": "Inter, Segoe UI, Roboto, sans-serif"
  }
}}%%
```

### C. Mermaid class definitions (local)
```mermaid
classDef anchor fill:#F6E7A1,stroke:#C9A227,color:#3A2F00;
classDef unit   fill:#D6ECFF,stroke:#3C75B8,color:#0F2A4D;
classDef index  fill:#EAF8EF,stroke:#3A9D6B,color:#0E3B25;
classDef warn   fill:#FFF4E5,stroke:#FFB020,color:#5C3B00;
```

### D. Shape & icon tweaks
* Use **rounded rectangles** for assets, **stadium** for GRU, **subroutine** for indices.
* Optional emoji labels: `🏛️` governance, `🪙` XAU, `📊` indices (keep minimal for print).

### E. Print & Dark‑mode notes
* Prefer **solid fills** (no gradients) for clarity when printed.
* Provide a **dark theme** variant by swapping fills/background to near‑black and text to light gray.

---

## 2) Basket Weights — Placeholders, Tables & Schemas

### A. Per‑Index weight table templates
```markdown
#### LiPMG — Precious Metals Group (weights must sum to 1.000)
| Metal | Symbol | Placeholder Weight |
|---|---|---:|
| Gold | Au | 0.40 |
| Silver | Ag | 0.20 |
| Platinum | Pt | 0.18 |
| Palladium | Pd | 0.15 |
| Rhodium | Rh | 0.07 |
| **Total** |  | **1.00** |

#### LiBMG1 — Base Metals Group
| Metal | Symbol | Placeholder Weight |
|---|---|---:|
| Copper | Cu | 0.35 |
| Nickel | Ni | 0.20 |
| Aluminum | Al | 0.25 |
| Zinc | Zn | 0.12 |
| Lead | Pb | 0.08 |
| **Total** |  | **1.00** |

#### LiBMG2 — Battery Materials Group
| Material | Symbol | Placeholder Weight |
|---|---|---:|
| Lithium | Li | 0.40 |
| Cobalt | Co | 0.18 |
| Graphite | C | 0.22 |
| Manganese | Mn | 0.10 |
| Nickel | Ni | 0.10 |
| **Total** |  | **1.00** |

#### LiBMG3 — Building Materials Group
| Material | Short | Placeholder Weight |
|---|---|---:|
| Iron Ore | Fe | 0.40 |
| Cement | Cmt | 0.20 |
| Glass (Silica) | Si | 0.12 |
| Lumber | Lbr | 0.18 |
| Aggregates | Agg | 0.10 |
| **Total** |  | **1.00** |
```

### B. Weight schema (YAML/JSON)
```yaml
schema_version: 1
scalar_S: "1.2/(0.9475^4)"  # applied to all Li(Index)
indices:
  LiPMG:
    constituents:
      - {name: Au, weight: 0.40}
      - {name: Ag, weight: 0.20}
      - {name: Pt, weight: 0.18}
      - {name: Pd, weight: 0.15}
      - {name: Rh, weight: 0.07}
  LiBMG1:
    constituents:
      - {name: Cu, weight: 0.35}
      - {name: Ni, weight: 0.20}
      - {name: Al, weight: 0.25}
      - {name: Zn, weight: 0.12}
      - {name: Pb, weight: 0.08}
  LiBMG2:
    constituents:
      - {name: Li, weight: 0.40}
      - {name: Co, weight: 0.18}
      - {name: C,  weight: 0.22}
      - {name: Mn, weight: 0.10}
      - {name: Ni, weight: 0.10}
  LiBMG3:
    constituents:
      - {name: Fe,  weight: 0.40}
      - {name: Cmt, weight: 0.20}
      - {name: Si,  weight: 0.12}
      - {name: Lbr, weight: 0.18}
      - {name: Agg, weight: 0.10}
constraints:
  weights_sum_to: 1.0
  min_weight: 0.05
  max_weight: 0.50
update_policy:
  cadence: quarterly
  methodology: production+liquidity weighted with cap/floor bands
```

### C. Index formula w/ weights
```
Index_Value = S × Σ(w_i × P_i)
  where S = 1.2/(0.9475^4), w_i = weight, P_i = normalized price of constituent i
```

---

## 3) Exporting Mermaid to PNG/SVG (Publication‑grade)

### A. Using mermaid‑cli (`mmdc`)
* Install: `npm i -g @mermaid-js/mermaid-cli`
* **PNG export:**
  ```bash
  mmdc -i diagram.mmd -o diagram.png \
       -b transparent -s 2 -H 1200 -W 1600 --puppeteerConfig puppeteer.json
  ```
* **SVG export:**
  ```bash
  mmdc -i diagram.mmd -o diagram.svg \
       -b transparent -H 1200 -W 1600 --scale 1
  ```
* Optional theme injection: add the `%%{init: {...}}%%` block at top of your `.mmd`.

### B. Batch export (Bash)
```bash
for f in *.mmd; do
  base="${f%.mmd}"
  mmdc -i "$f" -o "out/png/${base}.png" -b transparent -s 2 -H 1200 -W 1600
  mmdc -i "$f" -o "out/svg/${base}.svg" -b transparent -H 1200 -W 1600
  done
```

### C. Batch export (PowerShell)
```powershell
Get-ChildItem *.mmd | ForEach-Object {
  $base = $_.BaseName
  mmdc -i $_.FullName -o "out/png/$base.png" -b transparent -s 2 -H 1200 -W 1600
  mmdc -i $_.FullName -o "out/svg/$base.svg" -b transparent -H 1200 -W 1600
}
```

### D. SVG optimization & accessibility
* Optimize with **svgo**: `npx svgo out/svg/*.svg`
* Add `<title>` and `<desc>` inside SVG root for screen readers.
* Provide text alt‑captions under each embedded figure in Markdown/PDF.

### E. File naming & versions
* `YYYYMMDD_li-indices_flow_v1.svg`
* Keep a `CHANGELOG.md` noting palette/weight changes.

---

## 4) Ready‑to‑use Mermaid with Placeholders (copy/paste)

### A. Flowchart (with classDefs)
```mermaid
%%{init: {"theme": "base"}}%%
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
```

### B. Mindmap (labels editable)
```mermaid
%%{init: {"theme": "base"}}%%
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
```

---

## 5) QA & Governance Checklist
* [ ] Palette passes **WCAG AA** contrast on text.
* [ ] All weights **sum to 1.000**; min/max caps respected.
* [ ] **Scalar S** applied consistently: `1.2/(0.9475^4)`.
* [ ] Exported **PNG @2x–3x** scale; **SVG optimized**.
* [ ] Captions + alt text provided for accessibility.
* [ ] **CHANGELOG.md** updated; version bump recorded.
* [ ] Markdown/PDF embeds verified in print preview.

---

## 6) Deliverables You Can Request Next
* Color‑variant diagram set (Light/Dark/Print).
* Pre‑filled weight sheets (CSV + YAML) for each index.
* Auto‑export toolchain (Node script or Makefile) for one‑click PNG/SVG builds.
* Branded Word/PDF templates with embedded SVGs.

---

*Prepared for GRU Commodity Index Division — Visualization, Data & Publishing*
