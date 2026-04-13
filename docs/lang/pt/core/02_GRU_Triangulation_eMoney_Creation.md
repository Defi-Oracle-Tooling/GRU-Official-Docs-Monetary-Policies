---
title: Triangulação GRU e Criação de eMoney
version: 1.0.1
status: estável
last_updated: 2026-03-31
layer: mecânica
checksum: pendente
lang: pt
---
# Quadro de Triangulação GRU e Criação de eMoney

## 1. Conceito
A triangulação converte qualquer ativo de origem → XAU → GRU → ativo de destino, impondo integridade e paridade apoiadas por ativos. Todo FX é roteado via XAU, com âncora operacional em `cXAUC/cXAUT`.

## 2. Caminho de Triangulação
1. Ativo de Origem → avaliação XAU (paridade spot; referência de ativo `cXAUC/cXAUT`)
2. XAU → conversão GRU (paridade atribuida `1 GRU = 1 XAU`; valor de ativo de suporte M0 `= 1.2 XAU`)
3. GRU → Ativo de Destino (triangulação reversa)

Todas as triangulações GRU passam por XAU independentemente da classe de destino (commodity, moeda, título, outro). Isso mantém o roteamento FX preso à mesma âncora de ouro antes da conversão para GRU ou de volta ao ativo de destino.

### Diagrama de Fluxo de Triangulação
![Fluxo de Triangulação](/assets/media/triangulation_flow.png)
*Figura: Reserva (M0) → Emissão (M1) → Distribuição (M2+) com caminho de feedback de instrumento de controle.*

## 3. Lógica de Emissão Atômica (Protocolo 7:10)
Para cada 7 unidades de entrada (equivalente fiduciário), 10 unidades GRU M1 são cunhadas.
```
GRU_M1 = (Entrada × 10) / 7
```
Após uma taxa de câmbio (f ≤ 0.045), o restante líquido reingressa no próximo ciclo.

### Exemplo Micro
| Ciclo | Entrada (€) | GRU Cunhado (€) | Após Taxa (€) |
|-------|----------:|---------------:|--------------:|
| 1 | 7.0000 | 10.0000 | 9.5500 |
| 2 | 9.5500 | 13.6429 | 13.0289 |
| 3 | 13.0289 | 18.6128 | 17.7752 |

### Exemplo Macro (€100M)
| Ciclo | Entrada (€M) | GRU Cunhado (€M) | Após Taxa (€M) |
|-------|-----------:|----------------:|---------------:|
| 1 | 100.0000 | 142.8571 | 136.4286 |
| 2 | 136.4286 | 194.8980 | 186.1276 |
| 3 | 186.1276 | 265.8965 | 253.9312 |

## 4. Função de Expansão
```
E = I × (10/7) × (1 - f)^n
```
Onde:
- E = Liquidez expandida
- I = Entrada inicial
- f = Taxa de câmbio por ciclo
- n = Número de loops atômicos (padrão 3)

## 5. Regra 40/40/20
Dado depósito D:
```
Reserva Base    = 0.40 D
Expansão        = 0.40 D (emissão atômica)
Estabilização   = 0.20 D (buffer de volatilidade)
Cobertura Alvo ≈ 2.5 × Reserva Base
```

## 6. Conformidade e Auditoria
- Cada loop atômico registrado no Distributed Sovereign Ledger (DSL)
- Tolerância de paridade ±0.05% aplicada via ajuste automático
- Taxas publicadas para transparência; cronograma de taxa dinâmica (f) ajustável por velocidade e condições de congestionamento

## 7. Considerações de Estabilidade
| Risco | Mitigação |
|------|------------|
| Volatilidade em XAU | Reponderação dinâmica de reserva (adjunto LiXAU) |
| Manipulação de taxa | Cronograma transparente + governança multi-assinatura |
| Exploração de loop | Limite de ciclo de contrato inteligente (n = 3) |

## 8. Aprimoramentos Futuros (Planejado)
- Contagem de ciclo atômico adaptativa baseada na velocidade de reserva
- Triangulação multi-âncora (cesta XAU/XAG/XPT) com contingências de fallback, mantendo XAU como a âncora principal de FX
- Rede de redundância de oráculo on-chain

## Especificações relacionadas

- **Verdade de implementação:** [Estado de implementação e divulgação de controle](../../../meta/Implementation_Status_and_Control_Disclosure.md) (`live` / `partial` / `placeholder`).
- **Paridade (resumo):** [Referência rápida de paridade canónica](../../../meta/Canonical_Parity_Quick_Reference.md).
- **Eventos normativos (alvo):** [Propagação do estado da transação](../../../meta/Transaction_State_Propagation_Specification.md).
- **Índice:** [Índice de especificações determinísticas](../../../meta/Deterministic_Specifications_Index.md).

## Resumo
O sistema de triangulação e emissão atômica produz expansão de liquidez controlada e ancorada em ativos com estabilidade e auditabilidade incorporadas, formando a espinha dorsal mecânica da circulação GRU.
