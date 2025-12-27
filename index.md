---
layout: default
title: GRU Monetary Policy Documentation
permalink: /
lang: en
---

<div align="center">

# 🌍 Global Reserve Unit (GRU)
## Official Monetary Policy Documentation

[![Build Status](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/workflows/GRU%20Documentation%20Build/badge.svg)](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/actions)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

</div>

## 🎯 Repository Purpose

This repository contains the **comprehensive institutional documentation** for the **Global Reserve Unit (GRU)** monetary architecture and **Digital Bank for International Settlements (DBIS)** charter.

## 📋 Core Documents

{% assign core_docs = site.core | sort: 'path' %}
{% for doc in core_docs %}
- **[{{ doc.title }}]({{ doc.url }})**  
  {% if doc.description %}{{ doc.description }}{% endif %}
{% endfor %}

## 🏛️ Compliance & Regulatory

### SEPA Compliance
- [SEPA Compliance Matrix](/compliance/sepa/sepa_compliance_matrix/)
- [IPR Compliance Memo](/compliance/sepa/ipr_compliance_memo/)

### MiCA (Markets in Crypto-Assets)
- [Legal Position: GRU vs MiCA](/compliance/mica/legal_position_gru_vs_mica/)
- [Issuer Obligations Readiness](/compliance/mica/issuer_obligations_readiness/)

### DORA (Digital Operational Resilience Act)
- [ICT Risk Policy](/compliance/dora/ict_risk_policy/)
- [Incident Response Runbook](/compliance/dora/incident_response_runbook/)

### AML/CFT
- [Enterprise Wide Risk Assessment](/compliance/aml/enterprise_wide_risk_assessment/)

## 📚 Reference Materials

- [**GRU Formulas**](/meta/gru_formulas/) - Core mathematical formulas and equations
- [**Glossary**](/meta/glossary/) - Complete terminology reference
- [**Risk Annex**](/meta/risk_annex/) - Risk catalog and mitigation matrix

## 🌍 Multilingual Documentation

The GRU documentation is available in multiple languages:

- 🇬🇧 **English** - [Primary documentation](/)
- 🇮🇩 **Bahasa Indonesia** - [Indonesian Translation](/lang/id/)
- 🇧🇷 **Português** - [Portuguese Translation](/lang/pt/)
- 🇸🇦 **العربية** - [Arabic Translation](/lang/ar/)
- 🇫🇷 **Français** - [French Translation](/lang/fr/)

## 🔗 Quick Links

| 📖 **Core Documentation** | 🏛️ **Regulatory Compliance** | 💎 **Smart Contracts** | 🛠️ **Development** |
|---------------------------|----------------------------|------------------------|-------------------|
| [Executive Summary](/core/00_gru_executive_summary/) | [SEPA Compliance Matrix](/compliance/sepa/sepa_compliance_matrix/) | [Diamond Architecture](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/blob/main/contracts/GrcDiamond.sol) | [Build System](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/blob/main/scripts/build.sh) |
| [Policy Framework](/core/01_gru_monetary_policy_framework/) | [MiCA Legal Position](/compliance/mica/legal_position_gru_vs_mica/) | [Monetary Facet](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/blob/main/contracts/facets/MonetaryFacet.sol) | [CI/CD Pipeline](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/blob/main/.github/workflows/build.yml) |
| [Governance & Oversight](/core/04_gru_governance_regulatory_oversight/) | [DORA ICT Risk Policy](/compliance/dora/ict_risk_policy/) | [Graph Protocol](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies/blob/main/subgraph/schema.graphql) | [Contribution Guide](https://github.com/Defi-Oracle-Tooling/GRU-Official-Docs-Monetary-Policies#-contribution-guidelines) |

## 🏛️ EU/ECB Compliance Dashboard

| **Regulation** | **Status** | **Key Documents** | **Next Review** |
|----------------|------------|-------------------|-----------------|
| **SEPA/IPR** | ✅ Compliant | [Compliance Matrix](/compliance/sepa/sepa_compliance_matrix/) • [IPR Memo](/compliance/sepa/ipr_compliance_memo/) | Q2 2025 |
| **MiCA** | ✅ Ready | [Legal Position](/compliance/mica/legal_position_gru_vs_mica/) • [Issuer Readiness](/compliance/mica/issuer_obligations_readiness/) | Q1 2025 |
| **DORA** | ✅ Implemented | [ICT Risk Policy](/compliance/dora/ict_risk_policy/) • [Incident Response](/compliance/dora/incident_response_runbook/) | Q2 2025 |
| **AML/CFT** | ✅ Compliant | [Enterprise Risk Assessment](/compliance/aml/enterprise_wide_risk_assessment/) | Annual |
| **ISO 20022** | ✅ Implemented | [Message Mapping](/integration/iso20022/mapping_table/) | Q3 2025 |

---

**Built with ❤️ by the Global Reserve Unit Community**

© 2025 GRU Monetary Authority | Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

*Advancing transparent, programmable, and sustainable monetary policy for the digital age*

