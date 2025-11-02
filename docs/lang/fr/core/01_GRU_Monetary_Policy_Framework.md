---
title: Cadre de Politique Monétaire GRU
version: 1.0.0
status: stable
last_updated: 2025-10-24
layer: politique
checksum: en attente
language: Français
---
# Cadre de Politique Monétaire GRU

## Aperçu
La Global Reserve Unit (GRU) établit un système monétaire multi-niveaux adossé à des actifs, ancrant toute la liquidité via XAU (or) pour garantir une valeur intrinsèque, une parité auditable et une convertibilité inter-domaines.

### Diagramme du Cycle d'Émission
![Cycle d'Émission GRU](../../media/issuance_cycle.pdf)
*Figure : Réserve → Émission → Circulation avec boucle de recyclage de liquidité et maintien de la couverture.*

## Ratios Fondamentaux
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Les coefficients dynamiques (x, y) sont des poids de distribution ajustés par la politique entre les couches M0 (institutionnelle) et M1 (commerciale).

## Valeurs Nominales et d'Actifs
```
1 XAU GRU = 1.2 XAU
1 M0 GRU = 1.2 XAU GRU
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
LiXAU est un indice de réserve hybride composite utilisé pour la diversification et l'alignement ESG.

## Structure des Couches
| Couche | Fonction | Description |
|-------|----------|-------------|
| M00 | Émission Souveraine | Création de base liée 1:1 aux réserves auditées |
| M0  | Réserve Institutionnelle | Instrument de liquidité au niveau interbancaire et des autorités |
| M1  | Circulation Commerciale | Couche de monnaie électronique de marché et de règlement |

## Politique de Réserves
- Couverture minimale : ≥ 120% de la valeur GRU en circulation.
- Niveaux d'actifs : Primaire (XAU), secondaire (Li, Pt, REE, ETF souverains), dynamique (actifs vérifiés tokenisés).
- Seuil de déviation de parité : ±2.5% déclenche MPAP (Protocole d'Ajustement de Parité Monétaire).

## Gouvernance
Fonctionne sous la Sovereign Hybrid Trust Entity (SHTE) avec des chambres :
- Chambre de Politique Monétaire (MPC)
- Chambre d'Audit des Réserves (RAC)
- Chambre de Service des Obligations (BSC)
- Chambre de Technologie et de Registre (TLC)
- Chambre d'Éthique et de Conformité (ECC)

## Instruments de Contrôle
| Instrument | Objectif | Déclencheur |
|------------|---------|---------|
| MPAP | Ajuster la parité à XAU | Dérive de parité > 2.5% |
| ACP | Compression / brûlage de liquidité | Excès d'offre > bande cible |
| Modulation du Rendement des Obligations | Élasticité de l'offre | Signaux de vélocité / inflation |

## Transparence
- Proof-of-Reserves (PoR) Trimestriel
- Tableau de Bord des Réserves Public (planifié)
- Attestations de transactions en registre intelligent

## Plafond d'Inflation
Expansion nette annuelle plafonnée à 2.75% sauf si override de crise est exécuté par vote unanime MPC + RAC.

## Résumé
Le cadre combine émission mathématiquement disciplinée, parité or et routage de liquidité multi-couches pour former un standard de réserve neutre-souverain auditable.

---

## Indices Composites Li et Collatéral M00 — Référence

- **LiCRI (Composite de Valeur Nominale) :**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  Utilisé pour les rapports, le benchmarking et les tableaux de bord.

- **Composite M00 (Collatéral Adossé aux Actifs) :**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  Utilisé pour l'ampleur des réserves et le collatéral d'émission.

*Voir Glossary et GRU_Formulas pour la spécification complète et les champs d'audit.*
