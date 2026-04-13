---
title: Quadro de Política Monetária GRU
version: 1.0.1
status: estável
last_updated: 2026-03-31
layer: política
checksum: pendente
lang: pt
---
# Quadro de Política Monetária GRU

## Visão Geral
A Global Reserve Unit (GRU) estabelece um sistema monetário multi-níveis apoiado por ativos, ancorando toda a liquidez via XAU (ouro) para garantir valor intrínseco, paridade auditável e convertibilidade entre domínios. Na prática operacional, todo FX é triangulado via XAU com referência on-chain em `cXAUC/cXAUT`.

### Diagrama do Ciclo de Emissão
![Ciclo de Emissão GRU](/assets/media/issuance_cycle.png)
*Figura: Reserva → Emissão → Circulação com ciclo de reciclagem de liquidez e manutenção de cobertura.*

## Índices Centrais
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Coeficientes dinâmicos (x, y) são pesos de distribuição ajustados pela política entre as camadas M0 (institucional) e M1 (comercial).

## Valor nominal atribuído vs valor de ativo de suporte
```text
Valor nominal / paridade (face, contabilidade, liquidação):
1 GRU = 1 XAU
1 M0 GRU = 1 XAU
1 M1 GRU = 1 XAU

Valor de ativo de suporte (cobertura no lado das reservas):
1 M0 GRU = 1.2 XAU de ativos de suporte
1 M00 GRU = 6.0 XAU de ativos de suporte
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
Para evitar dúvidas, valor nominal atribuído e valor de ativo de suporte são medidas diferentes. O valor nominal é a unidade usada para paridade, contabilização, liquidação e controle de política. O valor de ativo de suporte é a quantidade de ativos de reserva exigida para sustentar essa unidade em uma dada camada. Fórmulas antigas como `1 XAU GRU = 1.2 XAU` referem-se apenas ao valor de suporte e não alteram a paridade nominal de `1 GRU = 1 XAU`.

LiXAU é um índice de reserva de ouro. No quadro Li, há cinco componentes de valor equivalente que formam o composto operacional:
- `LiXAU` = índice de reserva de ouro
- `LiPMG` = índice do Precious Metals Group
- `LiBMG1` = índice do Base Metals Group
- `LiBMG2` = índice do Battery Materials Group
- `LiBMG3` = índice do Building Metals Group

## Estrutura de Camadas
| Camada | Função | Descrição |
|-------|----------|-------------|
| M00 | Emissão Soberana | Criação base vinculada 1:1 às reservas auditadas |
| M0  | Reserva Institucional | Instrumento de liquidez de nível interbancário e de autoridade |
| M1  | Circulação Comercial | Camada de eMoney de mercado e liquidação |

Mapeamento de implementação atual: os ativos canônicos `c*` na Chain 138 são instrumentos GRU M1. Os ativos `cW*` em redes públicas são representações de transporte espelhadas da mesma camada GRU M1 e não constituem uma classe monetária separada.

## Política de Reservas
- Cobertura mínima: ≥ 120% do valor GRU em circulação.
- Níveis de ativos: Primário (XAU via `cXAUC/cXAUT`), secundário (Li, Pt, REE, ETFs soberanos), dinâmico (ativos verificados tokenizados).
- Limite de desvio de paridade: ±2.5% aciona MPAP (Protocolo de Ajuste de Paridade Monetária).

## Governança
Opera sob a Sovereign Hybrid Trust Entity (SHTE) com câmaras:
- Câmara de Política Monetária (MPC)
- Câmara de Auditoria de Reservas (RAC)
- Câmara de Serviço de Títulos (BSC)
- Câmara de Tecnologia e Livro-Razão (TLC)
- Câmara de Ética e Conformidade (ECC)

## Instrumentos de Controle
| Instrumento | Propósito | Gatilho |
|------------|---------|---------|
| MPAP | Ajustar paridade ao XAU | Deriva de paridade > 2.5% |
| ACP | Compressão / queima de liquidez | Excesso de oferta > banda alvo |
| Modulação de Rendimento de Títulos | Elasticidade de oferta | Sinais de velocidade / inflação |

## Transparência
- Proof-of-Reserves (PoR) Trimestral
- Painel de Reservas Público (planejado)
- Atestações de transações em livro-razão inteligente

## Teto de Inflação
Expansão líquida anual limitada a 2.75% a menos que override de crise seja executado por voto unânime MPC + RAC.

## Resumo
O quadro combina emissão matematicamente disciplinada, paridade de ouro e roteamento de liquidez multi-camadas para formar um padrão de reserva neutro-soberano auditável.

---

## Índices Compostos Li e Colateral M00 — Referência

- **LiCRI (Composto de Valor Nominal):**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  Usado para relatórios, benchmarking e painéis.

- **Composto M00 (Colateral Apoiado por Ativos):**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  Usado para magnitude de reserva e colateral de emissão.

Este quadro usa Diamond deliberadamente para que as camadas monetárias, de conformidade, de índice e de ativos evoluam separadamente sem quebrar uma única superfície de governança.

*Veja também [índice de especificações determinísticas](../../../meta/Deterministic_Specifications_Index.md), [referência rápida de paridade canónica](../../../meta/Canonical_Parity_Quick_Reference.md) e [estado de implementação](../../../meta/Implementation_Status_and_Control_Disclosure.md); além disso, Glossary e GRU_Formulas para especificação completa e campos de auditoria.*
