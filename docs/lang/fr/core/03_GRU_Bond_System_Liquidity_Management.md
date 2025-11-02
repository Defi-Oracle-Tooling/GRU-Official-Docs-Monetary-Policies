---
title: Système d'Obligations GRU et Gestion de la Liquidité
version: 1.0.0
status: stable
last_updated: 2025-10-24
layer: instruments
checksum: en attente
language: Français
---
# Système d'Obligations GRU et Gestion de la Liquidité

## 1. Aperçu
Les obligations hybrides perpétuelles en boucle fermée (série Li99) fournissent une liquidité élastique tout en préservant la solvabilité adossée aux réserves.

## 2. Instruments
| Code | Nom | Objectif | Durée | Rachat |
|------|------|---------|------|----------|
| Li99PpOsB10 | Obligation Off-set Perpétuelle 99 ans | Contrepoids collatéral et stabilisation | 99 ans | Cycle de 10 ans |
| Li99PpAvB10 | Obligation Avail Perpétuelle 99 ans | Conduit d'expansion et de disponibilité | 99 ans | Cycle de 10 ans |

## 3. Exemple d'Acquisition (Base €100M)
Hypothèse de prix d'achat à prix réduit : 15% (remise de 85%)
```
Notionnel = 100M / 0.15 = 666.667M
Allocation Par Obligation = 666.667M / 2 ≈ 333.333M
Couverture par obligation ≈ 250M
```

## 4. Boucle de Service Triangulaire
Service d'obligations intégré à l'émission atomique et aux cycles 40/40/20 :
- Le dépôt entre dans l'Assistance Bancaire
- Trois boucles atomiques exécutées (n=3)
- Liquidité nette attribuée à la couverture + stabilisation
- Les coupons canalisés vers le renforcement des réserves et le séquestre de rachat futur

### Diagramme du Cycle d'Obligations
Le diagramme suivant illustre le chemin de liquidité en boucle fermée pour les obligations de la série Li99 sur l'horizon de coupon et de rachat de 10 ans :

![Boucle de Liquidité du Cycle d'Obligations](../../media/bond_cycle.pdf)

## 5. Flux de Coupon
| Étape | Action | Impact |
|-------|--------|--------|
| Accumulation | Les coupons s'accumulent | Augmente la capacité de réinvestissement |
| Allocation | Partie au séquestre de rachat | Garantit l'achèvement du cycle de 10 ans |
| Roulement | Excédent réinvesti | Élargit le coussin de réserve / réduit la volatilité |

## 6. Logique de Stabilité
| Mécanisme | Fonction | Résultat |
|-----------|---------|---------|
| Achat à Prix Réduit | Débours initial faible | Levier de couverture élevé |
| Réinvestissement de Coupon | Composition | Durabilité autofinancée |
| Protocole de Rachat | Retraite du principal | Maintient la confiance et la solvabilité |
| Structure d'Obligation Double | Séparation fonctionnelle | Réponse de liquidité prévisible |

## 7. Ratios Clés
- Multiplicateur de couverture : ≈ 2.5× réserve de base par cycle
- Objectif d'efficacité de coupon : ≥ 65% rétention de réinvestissement
- Seuil de financement de rachat : 100% du principal réduit d'ici l'année 10

## 8. Gouvernance et Surveillance
- Géré par la Chambre de Service des Obligations (BSC)
- Audité trimestriellement par la Chambre d'Audit des Réserves (RAC)
- Surveillance en temps réel via le registre d'obligations DSL

## 9. Risque et Atténuation
| Risque | Description | Atténuation |
|------|-------------|-----------|
| Sous-performance du coupon | Compression du marché ou du rendement | Matrice d'ajustement du rendement adaptatif |
| Volatilité de la remise | Dérive de tarification du marché | Fenêtres de tarification d'émission liantes pré-engagées |
| Épuisement du séquestre | Stress de marché inattendu | Recharge de surplus dynamique via tranche de stabilisation |
| Désajustement d'échéance | Glissement de cycle | Points de contrôle forcés par contrat intelligent |

## 10. Améliorations Futures
- Obligations multi-courbes (tranching de coupons par niveaux de vélocité)
- Canal de coupon lié ESG (pool d'expansion de réserve verte)
- Wrappers d'obligations synthétiques pour accès institutionnel secondaire

### Intégration de Vélocité Pondérée par Couverture (Aperçu)
Les révisions à venir aligneront le rythme de réinvestissement des coupons avec la vélocité pondérée par couverture (v_cov), en mettant à l'échelle dynamiquement les recharges de séquestre lorsque la vélocité transactionnelle s'adoucit, préservant la certitude du financement de rachat.

## Résumé
Les obligations de la série Li99 permettent une expansion de liquidité évolutive et auto-rachetable sans levier externe, garantissant une stabilité perpétuelle grâce à des cycles de coupons structurés et des mécanismes de rachat liés aux réserves.
