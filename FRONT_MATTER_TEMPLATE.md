# Front Matter Template
## Standard Front Matter Schema for GRU Documents

This document defines the standard front matter fields for all GRU documentation files.

---

## Required Fields

```yaml
---
title: Document Title
version: 1.0.0
status: stable
last_updated: 2025-10-24
lang: en
---
```

### Field Descriptions

- **title** (string, required): Full document title
- **version** (string, required): Semantic version (e.g., "1.0.0", "1.1.0")
- **status** (string, required): Document status - one of: `stable`, `draft`, `deprecated`, `provisional`
- **last_updated** (date, required): Last update date in YYYY-MM-DD format
- **lang** (string, required): Language code (ISO 639-1), default: `en`

---

## Optional Fields

```yaml
---
# ... required fields ...

layer: policy
checksum: pending
document_ref: OMNL/DBIS-GRU-2025-POL01
effective_date: October 2025
toc: true
related_docs:
  - _core/01_GRU_Monetary_Policy_Framework.md
  - _core/03_GRU_Bond_System_Liquidity_Management.md
---
```

### Field Descriptions

- **layer** (string, optional): Document layer/category
  - Values: `policy`, `mechanics`, `instruments`, `governance`, `charter`, `roadmap`, `operational-policy`
- **checksum** (string, optional): SHA256 checksum for integrity verification
- **document_ref** (string, optional): Official document reference number
- **effective_date** (string, optional): When document becomes effective
- **toc** (boolean, optional): Enable/disable table of contents (default: true)
- **related_docs** (array, optional): Array of related document paths

---

## Layer Taxonomy

| Layer Value | Description | Example Documents |
|-------------|-------------|-------------------|
| `policy` | Core policy framework | Monetary Policy Framework |
| `mechanics` | Technical mechanisms | Triangulation & eMoney Creation |
| `instruments` | Financial instruments | Bond System & Liquidity Management |
| `governance` | Governance structures | Governance & Regulatory Oversight |
| `charter` | Institutional charters | DBIS Charter |
| `roadmap` | Future plans | Enhancement & Expansion Roadmap |
| `operational-policy` | Operational procedures | OMNL Operational Manual |

---

## Status Values

| Status | Description | Display |
|--------|-------------|---------|
| `stable` | Final, approved version | Green badge |
| `draft` | Work in progress | Yellow badge |
| `deprecated` | No longer current | Red badge |
| `provisional` | Temporary, subject to change | Orange badge |

---

## Examples

### Minimal (Required Only)
```yaml
---
title: GRU Executive Summary
version: 1.1.0
status: stable
last_updated: 2025-10-24
lang: en
---
```

### Complete (All Fields)
```yaml
---
title: OMNL Central Bank | Digital Bank of International Settlements - Operational Policy & Transaction Flow Manual
version: 1.0.0
status: stable
last_updated: 2025-10-29
layer: operational-policy
document_ref: OMNL/DBIS-GRU-2025-POL01
effective_date: October 2025
checksum: pending
lang: en
toc: true
related_docs:
  - _core/04_GRU_Governance_Regulatory_Oversight.md
---
```

---

## Validation Rules

1. **title**: Must be present, non-empty string
2. **version**: Must follow semantic versioning (X.Y.Z)
3. **status**: Must be one of the defined status values
4. **last_updated**: Must be valid date in YYYY-MM-DD format
5. **lang**: Must be valid ISO 639-1 language code
6. **layer**: If present, must be from defined taxonomy
7. **toc**: If present, must be boolean (true/false)

---

## Migration Notes

When updating existing documents:
1. Add `lang: en` to all English documents
2. Ensure `last_updated` uses consistent date format
3. Standardize `status` values
4. Document `layer` taxonomy for consistency
5. Add `related_docs` where appropriate

---

**Last Updated:** 2025-01-26

