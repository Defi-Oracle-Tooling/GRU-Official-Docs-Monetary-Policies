---
title: Velocity Policy Rulebook
version: 1.0.0
status: draft
last_updated: 2026-04-12
layer: policy
checksum: pending
related_docs:
  - docs/meta/GRU_Formulas.md
  - docs/core/01_GRU_Monetary_Policy_Framework.md
---

# Velocity policy rulebook

## 1. Purpose

Turn velocity metrics (`v_raw`, `v_adj`, `v_cov`, `V_GRU` — see [GRU Formulas](/meta/gru-formulas/)) into **enforceable** policy: thresholds, actions, timing, and authority.

**Status:** **Draft.** Numeric thresholds in Section 3 are **placeholders** pending MPC calibration and RAC sign-off.

### 1.1 Advisory vs policy-guiding vs self-executing

| Character | Meaning in GRU policy |
|-----------|------------------------|
| **Advisory** | Velocity metrics are published; **no** automatic economic action follows. |
| **Policy-guiding (default)** | MPC **must** act within published SLAs (fee tilt, throttle proposal) using **chamber votes / signatures** — not silent automation. |
| **Self-executing** | **Only** if a specific control is **whitelisted** in **certified** code **and** RAC has published a **positive certification**. Default = **off**. |

**Parity boundary:** velocity instruments **must not** change **assigned face parity** (`1 GRU = 1 XAU`). They may affect **fees**, **issuance pacing**, **compression triggers**, and **reporting overlays** only.

**Oracle degradation:** any **stale** or **disputed** oracle state forces velocity automation into **advisory** mode; **MPC** human procedure is mandatory before resuming **policy-guiding** or **self-executing** paths.

### 1.2 What may and may not be automated

| May be automated (if certified) | Always requires chamber approval |
|-----------------------------------|-----------------------------------|
| Data collection, aggregation, dashboards | Threshold numeric changes (`L0`, `U0`, …) |
| Hard caps already encoded in **immutable** or **timelocked** parameters | Parity reassignment (not part of baseline) |
| Issuance **block** on **cryptographic** coverage breach flag | Redemption pause, pool substitution |

## 2. Measurement inputs (deterministic definitions)

| Symbol | Definition | Source |
|--------|------------|--------|
| `v_raw` | Raw turnover velocity | On-chain + partner ledger aggregates / ISO 20022 traffic |
| `v_adj` | Risk- and seasonality-adjusted velocity | Model in formulas doc |
| `v_cov` | Coverage-weighted velocity | `v_adj × (Coverage_Ratio / 1.20)` |
| `V_GRU` | Composite velocity index | Policy-weighted function of above |

All published values MUST include **oracle version id**, **window length**, and **revision id**.

## 3. Threshold → action matrix (TBD numerics)

| Zone | Condition (placeholder) | Primary action | Secondary actions | Authority |
|------|-------------------------|----------------|-------------------|-----------|
| **Green** | `V_GRU` inside `[L0, U0]` | None | Continue monitoring | MPC secretariat |
| **Amber low** | `V_GRU < L0` for `T1` consecutive windows | **Fee tilt** toward issuance / routing incentives | Report to MPC | MPC |
| **Amber high** | `V_GRU > U0` for `T1` consecutive windows | **Fee tilt** toward stabilization / compression preview | Stress coverage | MPC + RAC |
| **Red** | `V_GRU` outside `[L_red, U_red]` for `T2` OR `v_cov` breach combo | **Issuance throttle** (hard cap on 7:10 batches) | Activate ACP study | MPC chair + RAC |
| **Black** | Coverage `< 1.20` **and** `V_GRU` in red | **Emergency brake** on mint; optional redemption queue | Public notice + DBIS | Emergency matrix |

**Constants to be set by MPC:** `L0`, `U0`, `L_red`, `U_red`, `T1`, `T2` (windows in days).

## 4. Timing

- **Publication:** velocity zone and actions within **24h** of measurement finalization.
- **Lookback:** default rolling **30d**; configurable to **7d** stress mode by MPC supermajority.

## 5. Oracle dependency and fallback

1. **Primary:** approved oracle set with median rule and deviation cap.
2. **Fallback:** last good tick + manual MPC mark with dual-signature (see oracle governance standard).
3. **If oracle stale > `T_stale`:** freeze **automatic** issuance modulation; human MPC review required.

## 6. Interaction with parity controls

- **MPAP** may be triggered by **parity drift** independent of velocity.
- If **both** MPAP and velocity red trigger, **coverage actions take precedence** over expansion.

## 7. Chamber authority

- **MPC:** sets thresholds and fee curves.
- **RAC:** vetoes issuance if models disagree; audits parameter changes.
- **ECC:** reviews market-manipulation scenarios affecting velocity.

Emergency overrides: see [Governance decision matrix](/meta/governance-decision-matrix/).
