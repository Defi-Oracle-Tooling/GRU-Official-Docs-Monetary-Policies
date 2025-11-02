---
title: Sistema de Títulos GRU e Gestão de Liquidez
version: 1.0.0
status: estável
last_updated: 2025-10-24
layer: instrumentos
checksum: pendente
language: Português
---
# Sistema de Títulos GRU e Gestão de Liquidez

## 1. Visão Geral
Títulos híbridos perpétuos de ciclo fechado (série Li99) fornecem liquidez elástica enquanto preservam a solvência apoiada por reservas.

## 2. Instrumentos
| Código | Nome | Propósito | Prazo | Recompra |
|------|------|---------|------|----------|
| Li99PpOsB10 | Título Off-set Perpétuo de 99 anos | Contrapeso colateral e estabilização | 99 anos | Ciclo de 10 anos |
| Li99PpAvB10 | Título Avail Perpétuo de 99 anos | Conduíte de expansão e disponibilidade | 99 anos | Ciclo de 10 anos |

## 3. Exemplo de Aquisição (Base €100M)
Pressuposição de preço de compra com desconto: 15% (desconto de 85%)
```
Nocional = 100M / 0.15 = 666.667M
Alocação Por Título = 666.667M / 2 ≈ 333.333M
Cobertura por título ≈ 250M
```

## 4. Loop de Serviço Triangular
Serviço de títulos integrado com emissão atômica e ciclos 40/40/20:
- Depósito entra na Assistência Bancária
- Três loops atômicos executados (n=3)
- Liquidez líquida atribuída à cobertura + estabilização
- Cupões canalizados para reforço de reservas e depósito de recompra futura

### Diagrama do Ciclo de Títulos
O diagrama a seguir ilustra o caminho de liquidez de ciclo fechado para títulos da série Li99 ao longo do horizonte de cupom e recompra de 10 anos:

![Loop de Liquidez do Ciclo de Títulos](../../media/bond_cycle.pdf)

## 5. Fluxo de Cupom
| Estágio | Ação | Impacto |
|-------|--------|--------|
| Acumulação | Cupões acumulam | Aumenta capacidade de reinvestimento |
| Alocação | Parte para depósito de recompra | Garante conclusão do ciclo de 10 anos |
| Rolagem | Excesso reinvestido | Expande almofada de reserva / reduz volatilidade |

## 6. Lógica de Estabilidade
| Mecanismo | Função | Resultado |
|-----------|---------|---------|
| Compra com Desconto | Desembolso inicial baixo | Alta alavancagem de cobertura |
| Reinvestimento de Cupom | Composição | Sustentabilidade autofinanciada |
| Protocolo de Recompra | Aposentadoria principal | Mantém confiança e solvência |
| Estrutura de Título Duplo | Separação funcional | Resposta de liquidez previsível |

## 7. Índices Chave
- Multiplicador de cobertura: ≈ 2.5× reserva base por ciclo
- Meta de eficiência de cupom: ≥ 65% retenção de reinvestimento
- Limite de financiamento de recompra: 100% do principal com desconto no ano 10

## 8. Governança e Supervisão
- Gerenciado pela Câmara de Serviço de Títulos (BSC)
- Auditado trimestralmente pela Câmara de Auditoria de Reservas (RAC)
- Monitoramento em tempo real através do registro de títulos DSL

## 9. Risco e Mitigação
| Risco | Descrição | Mitigação |
|------|-------------|-----------|
| Desempenho inferior do cupom | Compressão de mercado ou rendimento | Matriz de ajuste de rendimento adaptativo |
| Volatilidade de desconto | Deriva de precificação de mercado | Janelas de precificação de emissão vinculadas pré-comprometidas |
| Esgotamento de depósito | Estresse de mercado inesperado | Recarga de excedente dinâmico via tranche de estabilização |
| Desencontro de vencimento | Deslizamento de ciclo | Checkpoints forçados por contrato inteligente |

## 10. Aprimoramentos Futuros
- Títulos multi-curva (tranching de cupões por níveis de velocidade)
- Canal de cupom vinculado a ESG (pool de expansão de reserva verde)
- Wrappers de títulos sintéticos para acesso institucional secundário

### Integração de Velocidade Ponderada por Cobertura (Preview)
As revisões futuras alinharão o ritmo de reinvestimento de cupom com a velocidade ponderada por cobertura (v_cov), escalando dinamicamente recargas de depósito quando a velocidade transacional diminui, preservando a certeza de financiamento de recompra.

## Resumo
Os títulos da série Li99 permitem expansão de liquidez escalável e auto-redimível sem alavancagem externa, garantindo estabilidade perpétua através de ciclos de cupom estruturados e mecânicas de recompra vinculadas a reservas.
