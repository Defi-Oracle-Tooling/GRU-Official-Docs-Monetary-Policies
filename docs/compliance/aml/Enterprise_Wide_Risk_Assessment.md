---
title: Enterprise-Wide AML/CFT Risk Assessment
version: 1.0.0
status: approved
last_updated: 2025-10-28
compliance_scope: aml_cft_enterprise_risk
regulatory_basis: 4AMLD_5AMLD_6AMLD_Travel_Rule
approval_authority: board_aml_committee
next_review: 2026-10-28
classification: confidential
checksum: pending
---

# Enterprise-Wide AML/CFT Risk Assessment

## Executive Summary

This Enterprise-Wide Risk Assessment (EWRA) identifies, assesses, and documents money laundering and terrorist financing risks across GRU operations, in compliance with EU Anti-Money Laundering Directives and supporting GRU's risk-based approach to compliance.

### Key Risk Findings
- **Overall Risk Rating**: Medium-High
- **Primary Risk Drivers**: Cross-border payments, digital asset exposure, institutional customer base
- **Critical Controls**: Enhanced due diligence, transaction monitoring, sanctions screening

## 1. Regulatory Framework and Scope

### 1.1 Applicable Regulations

| Regulation | Scope | Key Requirements |
|------------|-------|-----------------|
| **4th AML Directive (2015/849/EU)** | Customer due diligence, beneficial ownership | Enhanced DD for high-risk customers |
| **5th AML Directive (2018/843/EU)** | Virtual currencies, high-risk third countries | Crypto-asset service providers |
| **6th AML Directive (2018/1673/EU)** | Criminal offenses, predicate crimes | Expanded ML offense definitions |
| **Transfer of Funds Regulation (2023/1113/EU)** | Payment traceability | Travel rule compliance |

### 1.2 Business Lines in Scope

```yaml
Business_Line_Assessment:
  M0_Institutional_Layer:
    Risk_Level: "High"
    Key_Risks: 
      - "Large value transactions (€1M+)"
      - "Cross-border institutional payments"
      - "Complex ownership structures"
      - "Politically exposed persons (PEPs)"
    
  M1_Commercial_Layer:
    Risk_Level: "Medium-High" 
    Key_Risks:
      - "High transaction volumes"
      - "Multiple payment corridors"
      - "SME customer base complexity"
      - "Instant payment speed risks"
      
  Digital_Payment_Rails:
    Risk_Level: "Medium"
    Key_Risks:
      - "Cross-border payments"
      - "Currency conversion services"
      - "Third-party integrations"
      - "Payment aggregation services"
```

## 2. Customer Risk Assessment

### 2.1 Customer Segmentation and Risk Profiling

#### High-Risk Customer Categories

| Customer Type | Risk Factors | Enhanced Measures |
|---------------|-------------|------------------|
| **Politically Exposed Persons (PEPs)** | Political influence, corruption risk | Enhanced DD, senior management approval |
| **Non-Resident Customers** | Limited oversight, complex structures | Additional documentation, source of funds verification |
| **High-Risk Jurisdictions** | FATF grey/blacklist countries | Enhanced monitoring, compliance officer review |
| **Complex Corporate Structures** | Beneficial ownership opacity | Ultimate beneficial owner verification |

#### Customer Risk Matrix
```yaml
Customer_Risk_Scoring:
  Geographic_Risk:
    High_Risk_Jurisdictions: "+3 points"
    Medium_Risk_Jurisdictions: "+2 points" 
    Low_Risk_Jurisdictions: "+1 point"
    
  Customer_Type_Risk:
    PEP_Customer: "+3 points"
    Corporate_Complex_Structure: "+2 points"
    SME_Standard: "+1 point"
    Individual_Retail: "+0 points"
    
  Transaction_Pattern_Risk:
    High_Volume_Irregular: "+3 points"
    Cross_Border_Frequent: "+2 points"
    Standard_Domestic: "+1 point"
    
  Risk_Score_Thresholds:
    High_Risk: "7-9 points"
    Medium_Risk: "4-6 points"
    Low_Risk: "0-3 points"
```

### 2.2 Enhanced Due Diligence Requirements

#### High-Risk Customer Procedures
1. **Enhanced Identity Verification**
   - Multiple identity documents
   - Independent source verification
   - Biometric verification where available

2. **Source of Wealth/Funds Verification**
   - Financial statements and tax returns
   - Employment verification
   - Business registration documents
   - Asset ownership documentation

3. **Beneficial Ownership Analysis**
   - Ownership structure charts
   - Control mechanism analysis
   - Ultimate beneficial owner identification (25%+ threshold)

## 3. Geographic Risk Assessment

### 3.1 Jurisdiction Risk Classification

#### High-Risk Jurisdictions (Enhanced DD Required)
| Country/Region | Risk Factors | Specific Controls |
|----------------|-------------|------------------|
| **FATF Blacklist Countries** | Non-cooperative, strategic deficiencies | Transaction prohibition |
| **EU High-Risk Third Countries** | AML/CFT deficiencies per Commission Regulation | Enhanced customer DD, transaction monitoring |
| **Sanctions Jurisdictions** | OFAC, EU, UN sanctions regimes | Pre-transaction screening, blocking |

#### Geographic Risk Scoring Matrix
```yaml
Geographic_Risk_Factors:
  Regulatory_Environment:
    Strong_AML_Framework: "Low risk (Score: 1)"
    Adequate_Framework: "Medium risk (Score: 2)"
    Weak_Framework: "High risk (Score: 3)"
    
  Corruption_Perception:
    Low_Corruption: "Low risk (Score: 1)"
    Medium_Corruption: "Medium risk (Score: 2)" 
    High_Corruption: "High risk (Score: 3)"
    
  Financial_System_Integrity:
    Transparent_System: "Low risk (Score: 1)"
    Limited_Transparency: "Medium risk (Score: 2)"
    Opaque_System: "High risk (Score: 3)"
    
  Composite_Score:
    High_Risk: "7-9 total score"
    Medium_Risk: "4-6 total score"
    Low_Risk: "3-4 total score"
```

### 3.2 Payment Corridor Analysis

#### Cross-Border Payment Risk Assessment
| Corridor | Volume (€M/month) | Risk Level | Key Risk Factors |
|----------|------------------|------------|-----------------|
| **EU ↔ UK** | €150M | Medium | Brexit regulatory divergence |
| **EU ↔ Switzerland** | €75M | Low-Medium | Strong AML framework, banking secrecy |
| **EU ↔ UAE** | €25M | High | High-risk jurisdiction, PEP exposure |
| **EU ↔ Singapore** | €20M | Medium | Strong framework, regional hub risks |

## 4. Product and Service Risk Assessment

### 4.1 Payment Product Risk Analysis

#### Product Risk Matrix
| Product/Service | Inherent Risk | Risk Factors | Mitigation Measures |
|-----------------|---------------|-------------|-------------------|
| **Instant Payments (M1)** | Medium-High | Speed limits DD verification | Real-time sanctions screening |
| **Large Value Transfers (M0)** | High | High amounts, complex structures | Enhanced DD, manual review |
| **Cross-Border Remittances** | Medium-High | Correspondent banking risks | Enhanced transaction monitoring |
| **Foreign Exchange Services** | Medium | Layering potential | Rate monitoring, source verification |

### 4.2 Digital Payment Rail Risks

#### Technology-Specific Risk Factors
```yaml
Digital_Payment_Risks:
  Blockchain_Transparency:
    Risk: "Transaction traceability challenges"
    Control: "Blockchain analytics tools"
    
  Smart_Contract_Automation:
    Risk: "Reduced human oversight"
    Control: "Automated compliance rules"
    
  Cross_Chain_Interactions:
    Risk: "Multi-protocol complexity"
    Control: "Enhanced monitoring systems"
    
  Instant_Settlement:
    Risk: "Limited intervention window"
    Control: "Pre-transaction screening"
```

## 5. Transaction Monitoring and Suspicious Activity Detection

### 5.1 Transaction Monitoring Scenarios

#### Automated Monitoring Rules
| Scenario Category | Alert Threshold | Investigation Trigger |
|------------------|----------------|---------------------|
| **Structuring** | Transactions just below reporting thresholds | Pattern analysis over 30 days |
| **Rapid Movement** | Multiple transactions within 24 hours | €50K+ aggregate value |
| **Geographic Anomalies** | Transactions from unusual locations | Customer profile deviation |
| **Round Dollar Amounts** | Frequent round number transactions | Pattern frequency analysis |

#### High-Risk Transaction Indicators
```yaml
Suspicious_Activity_Indicators:
  Transaction_Patterns:
    - "Just below reporting thresholds (€9,999)"
    - "Round dollar amounts in foreign currency"
    - "Rapid succession of transfers"
    - "Unusual transaction timing (off-hours)"
    
  Geographic_Patterns:
    - "Transactions from high-risk jurisdictions"
    - "Sudden geographic pattern changes"
    - "Multiple countries in short timeframe"
    - "Sanctions-related geographic connections"
    
  Customer_Behavior:
    - "Sudden increase in transaction activity"
    - "Deviation from expected customer profile"
    - "Reluctance to provide information"
    - "Use of multiple payment methods"
```

### 5.2 Investigation and Escalation Procedures

#### Investigation Timeline
| Investigation Stage | Timeframe | Responsible Team | Deliverable |
|-------------------|-----------|-----------------|------------|
| **Level 1 Review** | 24 hours | Transaction Monitoring Analyst | Initial assessment report |
| **Level 2 Investigation** | 72 hours | Senior Compliance Analyst | Detailed investigation report |
| **SAR Decision** | 120 hours | MLRO/Deputy MLRO | SAR filing decision |

## 6. Sanctions and PEP Screening

### 6.1 Sanctions Screening Framework

#### Screening Lists and Sources
| Sanctions List | Update Frequency | Coverage | Screening Point |
|----------------|-----------------|----------|-----------------|
| **OFAC SDN** | Real-time API | US sanctions program | Transaction initiation |
| **EU Consolidated List** | Daily batch | EU sanctions regimes | Customer onboarding |
| **UN Security Council** | Weekly batch | UN sanctions measures | Periodic screening |
| **National Lists** | Daily batch | Country-specific sanctions | Enhanced DD triggers |

#### Screening Technology Stack
```yaml
Sanctions_Screening_System:
  Primary_Engine: "Dow Jones Risk Center"
  Secondary_Validation: "Refinitiv World-Check"
  Real_Time_API: "OFAC API integration"
  
  Screening_Parameters:
    Match_Threshold: "85% fuzzy matching"
    Name_Variations: "Phonetic and transliteration algorithms"
    False_Positive_Management: "Machine learning optimization"
    
  Performance_Metrics:
    Processing_Speed: "<200ms per screening"
    False_Positive_Rate: "<5%"
    Coverage_Rate: ">99.9%"
```

### 6.2 PEP Management Program

#### PEP Category Classifications
| PEP Category | Definition | Risk Rating | Review Frequency |
|-------------|------------|-------------|-----------------|
| **Head of State/Government** | Current/former heads of state | High | Monthly |
| **Senior Government Officials** | Ministers, senior civil servants | High | Quarterly |
| **Senior Political Party Officials** | Party leaders, senior members | Medium-High | Semi-annually |
| **Family Members/Associates** | Immediate family, close associates | Medium | Annually |

## 7. Training and Awareness Program

### 7.1 AML Training Framework

#### Role-Based Training Requirements
| Role Category | Training Frequency | Specialized Modules | Certification Required |
|---------------|------------------|-------------------|---------------------|
| **All Employees** | Annual | AML fundamentals, sanctions awareness | Basic certification |
| **Customer-Facing Staff** | Semi-annual | Customer DD, suspicious activity recognition | Intermediate certification |
| **Compliance Team** | Quarterly | Advanced investigation, regulatory updates | Professional certification |
| **Senior Management** | Annual | Strategic risk, regulatory landscape | Executive briefing |

### 7.2 Training Content and Delivery

#### Core Training Modules
```yaml
Training_Curriculum:
  Module_1_Fundamentals:
    - "AML/CFT legal framework"
    - "Money laundering typologies"
    - "Terrorist financing indicators"
    - "GRU-specific risk factors"
    
  Module_2_Customer_DD:
    - "Identity verification procedures"
    - "Enhanced DD requirements"
    - "Beneficial ownership identification"
    - "PEP identification and management"
    
  Module_3_Transaction_Monitoring:
    - "Suspicious activity indicators"
    - "Investigation procedures"
    - "SAR preparation and filing"
    - "Record keeping requirements"
    
  Module_4_Sanctions_Compliance:
    - "Sanctions screening procedures"
    - "Sanctions evasion techniques"
    - "Blocking and rejection procedures"
    - "Regulatory reporting requirements"
```

## 8. Risk Mitigation and Control Framework

### 8.1 Three Lines of Defense

#### First Line of Defense (Business Operations)
- **Customer Onboarding**: Frontline DD procedures
- **Transaction Processing**: Real-time screening and monitoring
- **Customer Service**: Ongoing customer interaction and observation

#### Second Line of Defense (Risk and Compliance)
- **Risk Assessment**: Ongoing risk assessment and methodology updates
- **Policy Development**: AML/CFT policy and procedure development
- **Independent Testing**: Quality assurance and effectiveness testing

#### Third Line of Defense (Internal Audit)
- **Independent Assurance**: Annual AML program audit
- **Regulatory Compliance**: Regulatory examination preparation
- **Governance Oversight**: Board and committee reporting

### 8.2 Key Risk Indicators (KRIs)

#### Operational KRIs
| KRI | Target Threshold | Escalation Trigger | Reporting Frequency |
|-----|-----------------|-------------------|-------------------|
| **SAR Filing Rate** | 0.1-0.5% of customers | >1.0% or <0.05% | Monthly |
| **False Positive Rate** | <10% | >15% | Weekly |
| **Investigation Backlog** | <48 hours average | >72 hours | Daily |
| **Training Completion** | >95% | <90% | Monthly |

## 9. Regulatory Reporting and Record Keeping

### 9.1 Suspicious Activity Reporting (SAR)

#### SAR Filing Requirements
- **Filing Timeframe**: Within 5 business days of suspicion identification
- **Reporting Authority**: Financial Intelligence Unit Malta (FIUMALTA)
- **Content Requirements**: Comprehensive transaction and customer information
- **Confidentiality**: Strict tipping-off prevention measures

### 9.2 Record Keeping Requirements

#### Document Retention Schedule
| Record Type | Retention Period | Storage Requirements | Access Controls |
|-------------|-----------------|-------------------|-----------------|
| **Customer DD Files** | 5 years after relationship end | Encrypted digital storage | Compliance team access |
| **Transaction Records** | 5 years after transaction | Secure database with audit trail | Audit and regulatory access |
| **SAR Files** | 10 years after filing | Restricted access secure storage | MLRO and designees only |
| **Training Records** | 5 years after training completion | HR system with compliance access | Management and audit access |

## 10. Conclusion and Next Steps

### 10.1 Risk Assessment Summary

**Overall Assessment**: The GRU enterprise demonstrates a Medium-High risk profile primarily driven by:
- Cross-border payment facilitation
- Institutional customer complexity
- High-value transaction processing
- Digital payment innovation risks

### 10.2 Priority Risk Mitigation Actions

1. **Enhanced Transaction Monitoring** (Q1 2025)
   - Implement advanced analytics for pattern detection
   - Reduce false positive rates through ML optimization

2. **PEP Screening Enhancement** (Q2 2025)
   - Upgrade screening technology stack
   - Implement continuous monitoring capabilities

3. **Geographic Risk Management** (Q2 2025)
   - Enhance high-risk jurisdiction controls
   - Implement country-specific compliance procedures

4. **Training Program Expansion** (Ongoing)
   - Develop role-specific training modules
   - Implement continuous education program

### 10.3 Review and Update Schedule

- **Annual Comprehensive Review**: Full EWRA update including methodology review
- **Semi-Annual Updates**: Risk factor assessment and KRI threshold review
- **Quarterly Reviews**: Emerging risk identification and control effectiveness assessment
- **Ad-Hoc Reviews**: Triggered by significant regulatory changes or risk events

---

**Document Classification**: Internal Use - Risk Management Framework
**Next Review**: October 2026
**Regulatory Basis**: 4AMLD, 5AMLD, 6AMLD, Transfer of Funds Regulation
**Approval Required**: Board AML Committee
**Public Version**: Risk management framework overview (detailed risk analysis available separately)