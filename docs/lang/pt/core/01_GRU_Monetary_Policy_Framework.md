---
title: Quadro de Política Monetária GRU
version: 1.0.0
status: estável
last_updated: 2025-10-24
layer: política
checksum: pendente
language: Português
---
# Quadro de Política Monetária GRU

## Visão Geral
A Global Reserve Unit (GRU) estabelece um sistema monetário multi-níveis apoiado por ativos, ancorando toda a liquidez via XAU (ouro) para garantir valor intrínseco, paridade auditável e convertibilidade entre domínios.

### Diagrama do Ciclo de Emissão
![Ciclo de Emissão GRU](../../media/issuance_cycle.pdf)
*Figura: Reserva → Emissão → Circulação com ciclo de reciclagem de liquidez e manutenção de cobertura.*

## Índices Centrais
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Coeficientes dinâmicos (x, y) são pesos de distribuição ajustados pela política entre as camadas M0 (institucional) e M1 (comercial).

## Valores Nominais e de Ativos
```
1 XAU GRU = 1.2 XAU
1 M0 GRU = 1.2 XAU GRU
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
LiXAU é um índice de reserva híbrido composto usado para diversificação e alinhamento ESG.

## Estrutura de Camadas
| Camada | Função | Descrição |
|-------|----------|-------------|
| M00 | Emissão Soberana | Criação base vinculada 1:1 às reservas auditadas |
| M0  | Reserva Institucional | Instrumento de liquidez de nível interbancário e de autoridade |
| M1  | Circulação Comercial | Camada de eMoney de mercado e liquidação |

## Política de Reservas
- Cobertura mínima: ≥ 120% do valor GRU em circulação.
- Níveis de ativos: Primário (XAU), secundário (Li, Pt, REE, ETFs soberanos), dinâmico (ativos verificados tokenizados).
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

*Veja Glossary e GRU_Formulas para especificação completa e campos de auditoria.*
