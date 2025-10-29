---
title: SEPA Compliance Matrix
version: 1.0.0
status: stable
last_updated: 2025-10-28
compliance_scope: sepa_sct_inst
regulatory_basis: EPC_2025_SCT_Rulebook_v1.1
checksum: pending
---

# SEPA Compliance Matrix for GRU System

## Executive Summary
This document maps GRU system implementation to the **European Payments Council (EPC) 2025 SEPA Credit Transfer Rulebook v1.1** and corresponding Implementation Guidelines, ensuring full compliance for EUR-denominated transactions.

## 1. SEPA Credit Transfer (SCT) Implementation

### 1.1 Message Standards Compliance

| EPC Requirement | ISO 20022 Element | GRU Implementation | Test Status |
|-----------------|-------------------|-------------------|-------------|
| **Customer-to-Bank Payment** | pain.001.001.03 | `EUR_Payment_Initiation` facet | ✅ Validated |
| **Bank-to-Bank Transfer** | pacs.008.001.02 | `SEPA_Interbank_Settlement` | ✅ Validated |
| **Payment Status Report** | pacs.002.001.03 | `Payment_Status_Handler` | ✅ Validated |
| **Account Statement** | camt.053.001.02 | `Account_Statement_Generator` | 🔄 Testing |

### 1.2 SCT Implementation Guidelines Mapping

#### Core Data Elements (C2PSP IG 2025 v1.0)

| Data Element | Mandatory | GRU Field Mapping | Validation Rules |
|--------------|-----------|-------------------|------------------|
| **End-to-End Identification** | M | `payment.endToEndId` | Max 35 chars, unique per originator |
| **Instructed Amount** | M | `payment.instructedAmount.value` | EUR currency code, decimal precision |
| **Creditor Account** | M | `payment.creditorAccount.iban` | IBAN format validation |
| **Creditor Name** | M | `payment.creditorName` | Max 70 chars, UTF-8 encoding |
| **Debtor Account** | M | `payment.debtorAccount.iban` | IBAN format validation |
| **Debtor Name** | M | `payment.debtorName` | Max 70 chars, UTF-8 encoding |
| **Remittance Information** | O | `payment.remittanceInfo.unstructured` | Max 140 chars |

## 2. SEPA Instant Credit Transfer (SCT Inst) Readiness

### 2.1 Technical Requirements

| SCT Inst Requirement | Implementation | Status |
|---------------------|----------------|--------|
| **10-second processing** | `FastSettlement` engine with pre-validation | ✅ Ready |
| **24/7/365 availability** | Multi-region deployment with failover | ✅ Ready |
| **€100,000 transaction limit** | Built-in validation rules | ✅ Ready |
| **Immediate finality** | Atomic settlement with DvP guarantee | ✅ Ready |

### 2.2 Partner PSP Certification

| Partner PSP | Certification Status | SCT Support | SCT Inst Support | Test Completion |
|-------------|---------------------|-------------|------------------|-----------------|
| **Deutsche Bank AG** | EPC Direct Participant | ✅ Certified | ✅ Certified | ✅ Q4 2024 |
| **BNP Paribas SA** | EPC Direct Participant | ✅ Certified | ✅ Certified | ✅ Q4 2024 |
| **ING Bank N.V.** | EPC Direct Participant | ✅ Certified | 🔄 Testing | 🔄 Q1 2025 |

## 3. Compliance Monitoring and Reporting

### 3.1 Automated Compliance Checks

```yaml
Compliance_Monitoring:
  Daily_Checks:
    - IBAN_Validation_Rate: ">99.9%"
    - Message_Format_Compliance: "100%"
    - Processing_Time_SLA: "<10s (SCT Inst), <1 business day (SCT)"
    
  Weekly_Reports:
    - Transaction_Volume_Analysis
    - Reject_Rate_Analysis  
    - Partner_PSP_Performance_Review
```

---

**Document Control:**
- **Version**: 1.0.0
- **Approved by**: GRU Compliance Committee
- **Next Review**: Q2 2025
- **Classification**: Internal Use Only