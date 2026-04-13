---
title: Governance Decision Matrix — Actions, Quorum, Emergency, OMNL Labels
version: 1.0.0
status: provisional
last_updated: 2026-04-12
layer: governance
checksum: pending
related_docs:
  - docs/core/04_GRU_Governance_Regulatory_Oversight.md
  - docs/core/07_OMNL_Central_Bank_DBIS_Operational_Manual.md
---

# Governance decision matrix

## 1. Purpose

Reduce deadlock risk by stating **who may initiate**, **who approves**, and **what happens in emergency** for each control instrument. Align **OMNL operational labels** with **SHTE five-chamber** architecture.

## 2. Label mapping (non-exclusive)

| OMNL manual term | SHTE chamber / body | Notes |
|------------------|---------------------|-------|
| Monetary Policy Committee (MPC) | **Monetary Policy Chamber (MPC)** | Same function; manual uses committee label for banking audiences. |
| Risk & Compliance Council (RCC) | **Ethics & Compliance Chamber (ECC)** + **Reserve Audit Chamber (RAC)** split | Manual aggregates risk + compliance; split detailed RAC vs ECC in charter. |
| Independent Audit Board (DBIS Oversight) | **RAC** + external auditors under DBIS | Operational reporting line. |

Disagreement between manual labels and charter is **cosmetic** unless powers conflict — this matrix is **authoritative for authority**.

## 3. Action matrix (summary)

| Action type | Initiator | Approver | Quorum / vote | Emergency | Publication |
|-------------|-----------|----------|----------------|-------------|-------------|
| Parity band change (MPAP params) | MPC chair | MPC supermajority | **TBD** bps | MPC chair + RAC co-chair freeze first | 48h |
| Issuance throttle / velocity | MPC analytics | MPC | Majority | MPC chair + 1 RAC | 24h |
| ACP compression | MPC | MPC + RAC | Supermajority | MPC + ECC if market abuse suspected | Immediate summary |
| `diamondCut` upgrade | TLC security lead | TLC + MPC + timelock | Per contract `governanceParams` | **Pause** then queue | On-chain event |
| Oracle set change | TLC | MPC + RAC | Dual approval | Fallback to manual marks | Hash of config |
| Redemption pause | RAC | MPC + RAC + ECC | Unanimous | Court order path documented | Public notice |

**TBD:** replace vote fractions with explicit **bps** of voting power once tokenized governance or member votes are fixed.

## 4. Deadlock

1. **Operational deadlock** (MPC split): chief mediator from **DBIS** board steps in; if still deadlocked, **expansion frozen** until next scheduled session.
2. **Technical deadlock** (TLC vs MPC): **safety wins** — pause non-critical modules; critical payments continue read-only if architecturally possible.

## 5. Freeze issuance / pause redemptions

- **Freeze issuance:** MPC chair + RAC co-chair **or** automated **coverage black** (velocity rulebook).
- **Pause redemptions:** **unanimous** MPC + RAC + published **liquidity stress** rationale unless regulator mandates faster path.

## 6. DBIS vs OMNL override

- **DBIS** does not **unilaterally** override national OMNL monetary decisions; it **suspends cross-border program participation** per charter dispute article.
- **OMNL** cannot unilaterally alter **global Li scalar**; that is **MPC + index committee** scope.

## 7. Appeal

Internal appeal: **ECC** ethics panel → **external arbitration** per charter. Timeline **TBD**.
