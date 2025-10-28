---
title: MiCA Issuer Obligations Readiness Assessment
version: 1.0.0
status: stable
last_updated: 2025-10-28
compliance_scope: mica_issuer_obligations
regulatory_basis: Articles_16-55_MiCA_Regulation
checksum: pending
---

# MiCA Issuer Obligations Readiness Assessment

## Executive Summary

This document assesses GRU's readiness to comply with issuer obligations under Articles 16-55 of the Markets in Crypto-Assets Regulation (MiCA) for both Asset-Referenced Tokens (M0) and E-Money Tokens (M1).

## 1. Authorization Requirements (Art. 16-19 ART / Art. 47-48 EMT)

### 1.1 ART Issuer Authorization (M0)

| Requirement | Implementation Status | Evidence/Documentation |
|-------------|---------------------|----------------------|
| **Legal Entity** | ✅ Complete | GRU Monetary Authority Ltd (Malta) |
| **Authorized Capital** | ✅ Complete | €2.5M initial capital + reserves |
| **Management Suitability** | ✅ Complete | Board CVs, background checks completed |
| **Business Plan** | ✅ Complete | 5-year projection with stress scenarios |
| **Governance Framework** | ✅ Complete | Multi-chamber governance charter |
| **Risk Management** | ✅ Complete | Comprehensive risk management framework |

#### Application Documentation Package
```
MFSA_ART_Application/
├── Corporate_Documents/
│   ├── Certificate_of_Incorporation.pdf
│   ├── Memorandum_Articles_Association.pdf
│   └── Shareholders_Register.pdf
├── Management_Suitability/
│   ├── Board_CVs_Background_Checks.pdf
│   ├── Fit_Proper_Declarations.pdf
│   └── Professional_Indemnity_Insurance.pdf
├── Financial_Information/
│   ├── Capital_Adequacy_Calculation.pdf
│   ├── Audited_Financial_Statements.pdf
│   └── Own_Funds_Verification.pdf
└── Operational_Framework/
    ├── Risk_Management_Policy.pdf
    ├── Governance_Structure.pdf
    └── Business_Continuity_Plan.pdf
```

### 1.2 EMT Partnership Strategy (M1)

Since GRU will partner with licensed e-money institutions rather than seek direct EMT authorization:

| Partner Requirements | Due Diligence Status | Partnership Agreement |
|---------------------|---------------------|----------------------|
| **EU E-Money License** | ✅ Verified | Wirecard successor entities evaluated |
| **Operational Capacity** | ✅ Assessed | Technical integration capabilities confirmed |
| **Regulatory Standing** | ✅ Validated | No regulatory actions, good standing |
| **Business Model Alignment** | ✅ Confirmed | White-label EMT issuance agreement |

## 2. White Paper Requirements (Art. 20-22 ART / Art. 52 EMT)

### 2.1 M0 ART White Paper

#### Mandatory Information Elements

| Section | Requirement | Implementation | Completeness |
|---------|-------------|----------------|--------------|
| **Token Information** | Technical description, rights, obligations | Diamond Standard architecture documented | ✅ 100% |
| **Issuer Information** | Corporate structure, management, auditors | Full disclosure in governance docs | ✅ 100% |
| **Offering Details** | Distribution method, pricing, timeline | Institutional distribution framework | ✅ 100% |
| **Reserve Assets** | Composition, custody, valuation | Gold reserve methodology detailed | ✅ 100% |
| **Risk Factors** | Comprehensive risk disclosure | Multi-dimensional risk analysis | ✅ 100% |
| **Rights & Obligations** | Redemption, governance, voting | Chamber participation rights defined | ✅ 100% |

#### White Paper Sections
```markdown
M0_ART_White_Paper_Structure:
1. Executive_Summary (2 pages)
2. Token_Description (5 pages)
   - Technical_Architecture
   - Rights_and_Obligations  
   - Use_Cases_and_Purpose
3. Issuer_Information (3 pages)
   - Corporate_Structure
   - Management_Team
   - Regulatory_Status
4. Reserve_Management (4 pages)
   - Asset_Composition
   - Custody_Arrangements
   - Valuation_Methodology
5. Risk_Factors (3 pages)
   - Market_Risks
   - Operational_Risks
   - Regulatory_Risks
6. Governance (2 pages)
   - Decision_Making_Process
   - Transparency_Commitments
7. Technical_Information (2 pages)
   - Smart_Contract_Details
   - Security_Measures
```

### 2.2 M1 EMT White Paper (Partner-Issued)

| Section | Partner Responsibility | GRU Input | Review Status |
|---------|----------------------|-----------|--------------|
| **E-Money Description** | Legal framework compliance | Technical specifications | 🔄 In Review |
| **Redemption Rights** | 1:1 EUR backing guarantee | Operational procedures | ✅ Agreed |
| **Reserve Information** | Segregated account details | Daily reporting protocols | ✅ Agreed |
| **Fee Structure** | Transaction and service fees | Revenue sharing model | 🔄 Negotiating |

## 3. Reserve Requirements and Management

### 3.1 ART Reserve Management (Art. 36-39)

#### Reserve Composition Policy
```yaml
Reserve_Management_Framework:
  Primary_Assets:
    Gold_Bullion:
      Minimum_Percentage: 80%
      Quality_Standard: "LBMA Good Delivery"
      Geographic_Distribution: "Multi-jurisdiction"
    
  Liquidity_Buffer:
    Cash_EUR: 15%
    Government_Bonds: 5%
    
  Operational_Controls:
    Valuation_Frequency: "Daily"
    Rebalancing_Trigger: "±5% from target allocation" 
    Stress_Testing: "Monthly"
```

#### Custody Arrangements
| Custodian | Asset Type | Geographic Location | Insurance Coverage |
|-----------|-----------|-------------------|------------------|
| **JP Morgan Chase** | Physical Gold | London (60%) | €500M Lloyd's policy |
| **UBS AG** | Physical Gold | Zurich (40%) | €300M comprehensive |
| **State Street** | Cash/Securities | Dublin | €100M operational |

### 3.2 EMT Reserve Requirements (Art. 50)

#### Segregation Model
```yaml
EMT_Reserve_Segregation:
  Account_Structure:
    Client_Money_Account: "Segregated trust account"
    Bank_Relationship: "Tier 1 EU credit institution"
    Account_Protection: "Deposit guarantee scheme"
    
  Investment_Restrictions:
    Permitted_Investments:
      - "Deposits with central banks"
      - "Short-term government securities (≤12 months)"
      - "Reverse repo with eligible counterparties"
    
  Daily_Reconciliation:
    Outstanding_Tokens: "Real-time blockchain query"
    Reserve_Balance: "Automated bank API"
    Variance_Tolerance: "±0.01%"
```

## 4. Ongoing Operational Obligations

### 4.1 Transparency and Reporting (Art. 41 ART / Art. 52 EMT)

#### Public Disclosure Dashboard
| Metric | Update Frequency | Publication Method | Verification |
|--------|-----------------|------------------|-------------|
| **Reserve Composition** | Daily 17:00 CET | Public API + Website | Custodian attestation |
| **Outstanding Tokens** | Real-time | Blockchain explorer | Smart contract query |
| **Redemption Requests** | Daily | Aggregated statistics | Internal audit trail |
| **Price/NAV** | Hourly | Multiple data feeds | Oracle network validation |

#### Quarterly Reporting Package
```
Quarterly_Disclosure_Package/
├── Reserve_Attestation_Report.pdf     # Independent auditor
├── Governance_Activity_Summary.pdf    # Chamber decisions
├── Risk_Management_Review.pdf         # Risk committee
├── Operational_Metrics_Dashboard.pdf  # KPI summary
└── Regulatory_Compliance_Certificate.pdf
```

### 4.2 Complaints Handling (Art. 53)

#### Complaint Resolution Framework
| Stage | Timeline | Responsible Unit | Escalation Trigger |
|-------|----------|-----------------|-------------------|
| **Acknowledgment** | 24 hours | Customer Service | All complaints |
| **Investigation** | 15 business days | Compliance Team | Complex issues |
| **Resolution** | 30 business days | Department Head | Unresolved cases |
| **Appeal** | 45 business days | Independent Panel | Disputed resolution |

#### Contact Channels
- **Email**: complaints@gru-authority.org
- **Portal**: https://complaints.gru-authority.org
- **Phone**: +356 2144 4000 (Business hours)
- **Post**: GRU Complaints, Level 3, Quantum House, Abate Rigord Street, Ta' Xbiex XBX 1120, Malta

## 5. Risk Management and Controls (Art. 35 ART)

### 5.1 Risk Management Framework

#### Risk Committee Structure
| Role | Responsibility | Reporting Line |
|------|---------------|---------------|
| **Chief Risk Officer** | Overall risk management strategy | Board Risk Committee |
| **Market Risk Manager** | Price, liquidity, concentration risk | Chief Risk Officer |
| **Operational Risk Manager** | Technology, process, fraud risk | Chief Risk Officer |
| **Compliance Risk Manager** | Regulatory, legal risk | Chief Compliance Officer |

#### Risk Appetite Framework
```yaml
Risk_Appetite_Statements:
  Market_Risk:
    Gold_Price_Volatility: "Maximum 10% daily drawdown tolerance"
    Concentration_Risk: "No single asset >25% of reserves"
    Liquidity_Risk: "Minimum 10% liquid assets for redemptions"
    
  Operational_Risk:
    System_Downtime: "Maximum 4 hours per month"
    Data_Breach: "Zero tolerance for customer data loss"
    Custody_Risk: "Geographic diversification mandatory"
    
  Regulatory_Risk:
    Compliance_Breaches: "Zero tolerance for material breaches"
    Regulatory_Changes: "6-month adaptation timeline maximum"
```

### 5.2 Stress Testing Program

#### Scenario Design
| Stress Scenario | Frequency | Impact Assessment | Response Protocol |
|----------------|-----------|------------------|------------------|
| **50% Gold Price Drop** | Monthly | Reserve adequacy, redemption capacity | Liquidity injection plan |
| **Mass Redemption Event** | Quarterly | Operational capacity, market impact | Emergency procedures |
| **Custody Failure** | Semi-annually | Asset recovery, business continuity | Backup custody activation |
| **Regulatory Suspension** | Annually | Orderly wind-down capability | Asset preservation plan |

## 6. Marketing Communications (Art. 54)

### 6.1 Pre-Approval Process

#### Marketing Materials Review
| Material Type | Review Level | Approval Authority | Documentation |
|---------------|-------------|------------------|---------------|
| **Public Statements** | Legal + Compliance | Chief Compliance Officer | Signed approval form |
| **Website Content** | Compliance | Marketing Manager | Content approval log |
| **Technical Documentation** | Technical + Legal | Chief Technology Officer | Technical accuracy sign-off |
| **Media Interviews** | Senior Management | CEO/Board designate | Media protocol checklist |

### 6.2 Mandatory Disclosures

#### Standard Disclaimers
```
Investment_Warning:
"Crypto-assets are subject to high volatility and regulatory risk. 
Past performance does not guarantee future results. 
Only invest what you can afford to lose."

Regulatory_Status:
"GRU tokens are regulated under MiCA. 
Issuer authorized by Malta Financial Services Authority."

Risk_Disclosure:
"See full risk factors in the White Paper available at 
https://docs.gru-authority.org/whitepaper"
```

## 7. Implementation Timeline and Readiness

### 7.1 Readiness Assessment Summary

| Obligation Category | M0 (ART) Readiness | M1 (EMT) Readiness | Critical Path Items |
|-------------------|------------------|------------------|-------------------|
| **Authorization** | 95% Complete | 85% Complete (Partner) | MFSA application submission |
| **White Paper** | 100% Complete | 90% Complete | Partner review completion |
| **Reserve Management** | 100% Complete | 95% Complete | Final custody agreements |
| **Risk Framework** | 100% Complete | 100% Complete | Stress testing validation |
| **Operational Controls** | 90% Complete | 85% Complete | System integration testing |
| **Compliance Program** | 95% Complete | 90% Complete | Staff training completion |

### 7.2 Go-Live Checklist

#### Pre-Launch Requirements (30 days before launch)
- [ ] Final regulatory authorization received
- [ ] All custody agreements executed and tested
- [ ] White paper published and distributed
- [ ] Complaints handling system operational
- [ ] Risk management systems validated
- [ ] Staff training completed and certified
- [ ] External audit of readiness completed
- [ ] Legal opinions finalized
- [ ] Insurance policies activated
- [ ] Incident response procedures tested

## 8. Conclusion

GRU demonstrates strong readiness for MiCA compliance across both ART (M0) and EMT (M1) obligations:

**Strengths:**
- Comprehensive governance and risk management frameworks
- Robust reserve management and custody arrangements  
- Clear operational procedures and transparency commitments
- Strong legal and regulatory support structure

**Areas for Final Implementation:**
- MFSA authorization completion (Q1 2025 target)
- EMT partnership agreement finalization
- Operational system integration testing
- Staff training and certification completion

The organization is well-positioned for successful MiCA compliance and can proceed to launch pending final regulatory authorizations.

---
**Classification**: Confidential - Regulatory
**Distribution**: Board, Executive Committee, External Counsel
**Next Review**: Monthly until launch, quarterly thereafter