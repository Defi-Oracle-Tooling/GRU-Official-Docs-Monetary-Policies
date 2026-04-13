---
title: Cadre de Politique Monétaire GRU
version: 1.0.1
status: stable
last_updated: 2026-03-31
layer: politique
checksum: en attente
lang: fr
---
# Cadre de Politique Monétaire GRU

## Aperçu
La Global Reserve Unit (GRU) établit un système monétaire multi-niveaux adossé à des actifs, ancrant toute la liquidité via XAU (or) pour garantir une valeur intrinsèque, une parité auditable et une convertibilité inter-domaines. En pratique opérationnelle, tout le FX est triangulé via XAU avec une référence on-chain à `cXAUC/cXAUT`.

### Diagramme du Cycle d'Émission
![Cycle d'Émission GRU](/assets/media/issuance_cycle.png)
*Figure : Réserve → Émission → Circulation avec boucle de recyclage de liquidité et maintien de la couverture.*

## Ratios Fondamentaux
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Les coefficients dynamiques (x, y) sont des poids de distribution ajustés par la politique entre les couches M0 (institutionnelle) et M1 (commerciale).

## Valeur nominale assignée vs valeur d'actifs de soutien
```text
Valeur nominale / parité (face, comptabilité, règlement) :
1 GRU = 1 XAU
1 M0 GRU = 1 XAU
1 M1 GRU = 1 XAU

Valeur d'actifs de soutien (couverture côté réserves) :
1 M0 GRU = 1.2 XAU d'actifs de soutien
1 M00 GRU = 6.0 XAU d'actifs de soutien
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
Pour lever toute ambiguïté, la valeur nominale assignée et la valeur d'actifs de soutien sont des mesures distinctes. La valeur nominale est l'unité utilisée pour la parité, la comptabilité, le règlement et le pilotage de la politique. La valeur d'actifs de soutien est la quantité d'actifs de réserve requise pour soutenir cette unité à une couche donnée. Des formulations historiques telles que `1 XAU GRU = 1.2 XAU` désignent uniquement la valeur de soutien et ne modifient pas la parité de face `1 GRU = 1 XAU`.

LiXAU est un indice de réserve or. Dans le cadre Li, cinq composantes de valeur équivalente forment le composite opérationnel :
- `LiXAU` = indice de réserve or
- `LiPMG` = indice Precious Metals Group
- `LiBMG1` = indice Base Metals Group
- `LiBMG2` = indice Battery Materials Group
- `LiBMG3` = indice Building Metals Group

## Structure des Couches
| Couche | Fonction | Description |
|-------|----------|-------------|
| M00 | Émission Souveraine | Création de base liée 1:1 aux réserves auditées |
| M0  | Réserve Institutionnelle | Instrument de liquidité au niveau interbancaire et des autorités |
| M1  | Circulation Commerciale | Couche de monnaie électronique de marché et de règlement |

Cartographie d'implémentation actuelle : les actifs canoniques `c*` sur la chaîne 138 sont des instruments GRU M1. Les actifs `cW*` sur les réseaux publics sont des représentations de transport en miroir de cette même couche GRU M1 et ne constituent pas une classe monétaire distincte.

## Politique de Réserves
- Couverture minimale : ≥ 120% de la valeur GRU en circulation.
- Niveaux d'actifs : Primaire (XAU via `cXAUC/cXAUT`), secondaire (Li, Pt, REE, ETF souverains), dynamique (actifs vérifiés tokenisés).
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

Ce cadre utilise volontairement Diamond afin que les couches monétaires, de conformité, d'indice et d'actifs puissent évoluer séparément sans casser une surface de gouvernance unique.

*Voir également [l'index des spécifications déterministes](../../../meta/Deterministic_Specifications_Index.md), [la référence rapide de parité canonique](../../../meta/Canonical_Parity_Quick_Reference.md) et [l'état d'implémentation](../../../meta/Implementation_Status_and_Control_Disclosure.md) ; complété par Glossary et GRU_Formulas pour la spécification complète et les champs d'audit.*
