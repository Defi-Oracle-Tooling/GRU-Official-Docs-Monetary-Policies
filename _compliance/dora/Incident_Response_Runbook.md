---
title: ICT Incident Response Runbook
version: 1.0.0
status: operational
last_updated: 2025-10-28
compliance_scope: dora_article_17-20
regulatory_basis: Regulation_EU_2022_2554_DORA
classification: restricted
checksum: pending
---

# ICT Incident Response Runbook

## 1. Executive Summary and Scope

### 1.1 Purpose
This runbook provides detailed procedures for responding to ICT-related incidents in compliance with DORA Articles 17-20, ensuring rapid containment, assessment, and recovery while meeting regulatory reporting obligations.

### 1.2 Incident Definition (DORA Art. 18)
An **ICT-related incident** is a single event or series of linked events that have caused or may cause:
- Service disruption
- Data corruption or unauthorized access  
- System compromise or security breach
- Regulatory compliance impact

## 2. Incident Classification and Severity Levels

### 2.1 Severity Matrix

| Severity | Impact Criteria | Examples | Response Time |
|----------|----------------|----------|---------------|
| **P1 - Critical** | System-wide outage >4 hrs OR data breach affecting >1000 customers | Complete payment system failure | 15 minutes |
| **P2 - High** | Major service degradation >2 hrs OR security compromise | Regional service disruption | 30 minutes |  
| **P3 - Medium** | Limited service impact <2 hrs OR minor security events | Single component failure | 2 hours |
| **P4 - Low** | Minor operational issues OR potential vulnerabilities | Performance degradation | 24 hours |

### 2.2 Major Incident Criteria (DORA Art. 18(1))

An incident is classified as **Major** if it meets any of these thresholds:
- Service unavailable for ≥2 hours with significant client impact
- Data breach affecting ≥500 clients or €500K+ financial exposure
- Critical business function severely impacted for ≥4 hours
- Regulatory reporting capability compromised for ≥1 business day

## 3. Incident Response Team Structure

### 3.1 Core Response Roles

| Role | Primary Responsibility | Contact Method | Escalation Authority |
|------|----------------------|---------------|-------------------|
| **Incident Commander** | Overall incident coordination | Dedicated hotline +356 2144 4911 | Executive escalation |
| **Technical Lead** | Technical resolution and coordination | Technical emergency line | Architecture decisions |
| **Security Lead** | Security assessment and containment | Security hotline | Law enforcement liaison |
| **Communications Lead** | Internal/external communications | Crisis communication line | Public statements |
| **Business Lead** | Business impact assessment | Business continuity line | Service decisions |

### 3.2 Extended Response Team

```yaml
Extended_Response_Team:
  Technical_Specialists:
    - Database_Administrator: "Data recovery and integrity"
    - Network_Engineer: "Network connectivity and performance"  
    - Security_Analyst: "Forensics and threat analysis"
    - Cloud_Engineer: "Cloud infrastructure and services"
    
  Business_Specialists:
    - Risk_Manager: "Risk assessment and mitigation"
    - Compliance_Officer: "Regulatory requirements and reporting"
    - Legal_Counsel: "Legal implications and liability"
    - Customer_Service_Manager: "Customer communication and support"
```

## 4. Incident Response Process Flow

### 4.1 Detection and Initial Response (0-15 minutes)

#### Automated Detection Systems
```mermaid
graph LR
    MONITOR[Monitoring Systems] --> ALERT[Alert Generation]
    ALERT --> TRIAGE[Automated Triage]
    TRIAGE --> NOTIFY[Team Notification]
    NOTIFY --> ASSESS[Initial Assessment]
    ASSESS --> CLASSIFY[Incident Classification]
```

#### Detection Sources
- **Automated Monitoring**: System alerts, performance thresholds
- **Customer Reports**: Service desk tickets, customer complaints  
- **Internal Discovery**: Staff observation, routine checks
- **External Notification**: Vendor alerts, regulatory communications

#### Initial Response Checklist
- [ ] **Acknowledge Alert** (2 minutes): Confirm receipt and initial assessment
- [ ] **Safety Assessment** (5 minutes): Identify immediate risks to people/systems
- [ ] **Initial Classification** (10 minutes): Assign preliminary severity level
- [ ] **Team Activation** (15 minutes): Notify appropriate response team members

### 4.2 Assessment and Classification (15-60 minutes)

#### Impact Assessment Framework
| Assessment Area | Evaluation Criteria | Data Sources |
|-----------------|-------------------|--------------|
| **Service Impact** | Number of affected users, duration of disruption | Service monitoring tools |
| **Financial Impact** | Revenue loss, recovery costs, penalties | Business impact calculator |
| **Regulatory Impact** | Compliance breaches, reporting requirements | Legal and compliance team |
| **Reputational Impact** | Media attention, customer satisfaction impact | Communications team assessment |

#### Classification Decision Matrix
```yaml
Classification_Criteria:
  Major_Incident_Triggers:
    Service_Disruption:
      Duration: ">2 hours for critical services"
      User_Impact: ">50% of active users affected"
      Financial_Threshold: ">€100K hourly revenue impact"
      
    Security_Incident:
      Data_Exposure: ">500 customer records"
      System_Compromise: "Critical system administrative access"
      Compliance_Impact: "Regulatory reporting capability affected"
```

### 4.3 Containment and Stabilization (1-4 hours)

#### Immediate Containment Actions
1. **Isolate Affected Systems**: Prevent spread of impact
2. **Preserve Evidence**: Maintain forensic integrity for analysis  
3. **Implement Workarounds**: Restore service where possible
4. **Communications**: Notify stakeholders per communication plan

#### Technical Response Procedures
```yaml
Containment_Procedures:
  Security_Incidents:
    - "Isolate compromised systems from network"
    - "Disable compromised user accounts"  
    - "Activate backup authentication systems"
    - "Implement additional monitoring"
    
  System_Failures:
    - "Switch to backup/redundant systems"
    - "Implement degraded service mode"
    - "Isolate failed components"
    - "Begin diagnostic procedures"
    
  Performance_Issues:
    - "Implement traffic throttling"
    - "Activate additional resources"
    - "Optimize critical processes"
    - "Monitor system stability"
```

## 5. Communication Protocols

### 5.1 Internal Communication Flow

#### Notification Timeline
| Timeline | Audience | Communication Method | Content |
|----------|----------|---------------------|---------|
| **0-15 min** | Response Team | SMS + Voice Call | Incident activation notice |
| **15-30 min** | Department Heads | Email + Slack | Initial impact assessment |
| **30-60 min** | Executive Team | Conference Call | Detailed briefing |
| **1-2 hours** | Board (if Major) | Direct Call + Email | Formal incident notification |

#### Communication Templates
```yaml
Communication_Templates:
  Initial_Alert:
    Subject: "[P{X}] ICT Incident - {Brief Description}"
    Content:
      - Incident_ID: "INC-YYYY-MMDD-XXXX"
      - Severity_Level: "P1/P2/P3/P4"
      - Affected_Systems: "List of impacted components"
      - Current_Status: "Brief status description"
      - Next_Update: "Scheduled update time"
      
  Status_Update:
    Subject: "[UPDATE] {Incident_ID} - {Current Status}"
    Content:
      - Actions_Taken: "Summary of response actions"
      - Current_Impact: "Updated impact assessment"
      - Next_Steps: "Planned resolution activities"
      - ETA_Resolution: "Estimated resolution time"
```

### 5.2 External Communication

#### Regulatory Reporting (DORA Art. 19)

##### Initial Notification (Major Incidents)
- **Timeframe**: Without undue delay (typically 2-4 hours)
- **Recipients**: National competent authorities (Malta MFSA, ECB)
- **Content**: Preliminary incident description, impact assessment, immediate actions

##### Intermediate Report  
- **Timeframe**: Within 72 hours of classification as major
- **Content**: Detailed impact analysis, root cause investigation progress, recovery actions

##### Final Report
- **Timeframe**: Within 1 month of incident resolution  
- **Content**: Comprehensive incident analysis, lessons learned, preventive measures

#### Customer Communication
```yaml
Customer_Communication_Strategy:
  Service_Disruption:
    Channel: "Website banner, email alerts, mobile notifications"
    Frequency: "Every 2 hours until resolved"
    Content: "Service status, expected resolution, alternative options"
    
  Security_Incident:
    Channel: "Direct email, registered mail for high-impact"
    Timeline: "Within 24 hours of confirmation"
    Content: "Nature of incident, data involved, protection measures"
```

## 6. Investigation and Analysis

### 6.1 Root Cause Analysis Process

#### Investigation Timeline
| Phase | Duration | Activities | Deliverables |
|-------|----------|------------|-------------|
| **Immediate (0-24 hrs)** | Containment focus | Initial evidence gathering | Preliminary findings |
| **Short-term (1-7 days)** | Detailed analysis | Forensic examination | Technical analysis report |
| **Long-term (1-4 weeks)** | Comprehensive review | Process improvement analysis | Final investigation report |

#### Analysis Framework
```yaml
RCA_Methodology:
  Technical_Analysis:
    - System_Logs_Review: "Comprehensive log analysis"
    - Performance_Data_Analysis: "Metrics and trends examination"  
    - Configuration_Review: "System and security configuration audit"
    - Timeline_Reconstruction: "Detailed incident timeline creation"
    
  Process_Analysis:
    - Human_Factors_Assessment: "Training and procedure effectiveness"
    - Control_Effectiveness_Review: "Security and operational control validation"
    - Communication_Analysis: "Response team coordination evaluation"
    - Decision_Making_Review: "Management decision effectiveness"
```

### 6.2 Evidence Preservation

#### Digital Forensics Protocol
- **Chain of Custody**: Formal evidence handling procedures
- **Data Preservation**: Immutable copies of relevant system data
- **Access Control**: Restricted access to investigation materials
- **Documentation**: Comprehensive evidence documentation

## 7. Recovery and Restoration

### 7.1 Recovery Planning

#### Recovery Objectives
| Service Tier | RTO (Recovery Time Objective) | RPO (Recovery Point Objective) | Minimum Service Level |
|--------------|------------------------------|-------------------------------|---------------------|
| **Critical** | 4 hours | 15 minutes | 80% capacity |
| **Important** | 8 hours | 1 hour | 70% capacity |
| **Standard** | 24 hours | 4 hours | 60% capacity |
| **Non-critical** | 72 hours | 24 hours | On-demand |

#### Recovery Procedures
```yaml
Recovery_Process:
  System_Restoration:
    - Verify_System_Integrity: "Security and data integrity validation"
    - Performance_Testing: "Load and stress testing before full restoration"
    - Gradual_Service_Restoration: "Phased approach to minimize risk"
    - Monitoring_Enhancement: "Increased monitoring during recovery period"
    
  Data_Recovery:
    - Backup_Validation: "Verify backup integrity and completeness"
    - Point_in_Time_Recovery: "Restore to last known good state"
    - Data_Consistency_Checks: "Validate data consistency across systems"
    - Transaction_Reconciliation: "Ensure no data loss or duplication"
```

### 7.2 Service Restoration Validation

#### Testing Checklist
- [ ] **Functionality Testing**: All critical functions operational
- [ ] **Performance Testing**: System performance within acceptable parameters
- [ ] **Security Testing**: No residual security vulnerabilities
- [ ] **Integration Testing**: All system interfaces functioning correctly
- [ ] **User Acceptance Testing**: Business users confirm system usability

## 8. Post-Incident Activities

### 8.1 Post-Incident Review Process

#### Review Meeting Structure
| Meeting Type | Participants | Timeline | Focus |
|-------------|-------------|----------|-------|
| **Hot Wash** | Response team | Within 24 hours | Immediate lessons learned |
| **Tactical Review** | Department heads | Within 1 week | Process improvements |
| **Strategic Review** | Executive team | Within 2 weeks | Policy and investment decisions |

#### Lessons Learned Documentation
```yaml
Lessons_Learned_Framework:
  What_Worked_Well:
    - Effective_Response_Actions
    - Successful_Communications  
    - Proper_Tool_Usage
    - Team_Coordination_Success
    
  Areas_for_Improvement:
    - Response_Time_Delays
    - Communication_Gaps
    - Process_Inefficiencies
    - Resource_Constraints
    
  Action_Items:
    - Process_Updates: "Specific procedure modifications"
    - Training_Needs: "Additional training requirements"
    - Tool_Enhancements: "Technology improvement needs"
    - Resource_Requirements: "Additional resources needed"
```

### 8.2 Continuous Improvement Program

#### Improvement Implementation
- **Policy Updates**: Incorporate lessons learned into incident response procedures
- **Training Enhancement**: Update training programs based on identified gaps
- **Technology Improvements**: Implement tools and systems to prevent recurrence
- **Process Optimization**: Streamline response procedures for efficiency

## 9. Regulatory Compliance and Documentation

### 9.1 DORA Compliance Checklist

#### Documentation Requirements
- [ ] **Incident Register**: Comprehensive log of all incidents (Art. 17(9))
- [ ] **Major Incident Reports**: Detailed reports for regulatory submission (Art. 19)
- [ ] **Response Procedures**: Documented and tested incident response procedures (Art. 17(6))
- [ ] **Communication Records**: Complete communication logs and notifications (Art. 19(3))

### 9.2 Record Keeping Requirements

| Record Type | Retention Period | Access Requirements | Storage Location |
|-------------|-----------------|-------------------|------------------|
| **Incident Reports** | 7 years | Audit and regulatory access | Secure document management system |
| **Communication Logs** | 5 years | Management and compliance access | Encrypted communication archive |
| **Investigation Files** | 10 years | Restricted access with approval | Secure evidence repository |
| **Lessons Learned** | Permanent | Business and training access | Knowledge management system |

---

**Document Control:**
- **Version**: 1.0.0  
- **Classification**: Restricted - Response Team Only
- **Review Frequency**: Semi-annually
- **Next Review**: April 2025