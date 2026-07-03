# agente-vigilante

## Función única
Monitor continuo del ecosistema: servicios, red, disco, procesos críticos.

## Entradas
- Estado de servicios Docker
- Estado del socket MCP
- Espacio en disco
- Conectividad de red

## Salidas
- Alerta en `inbox/infra/` si hay fallo
- Issue GitHub si el fallo es crítico
- Traza en `inbox/_meta/`

## Relación con otros agentes
- Llama a `agente-self-heal` si un servicio falla
- Informa a `agente-roadmap-master` si hay deuda técnica nueva

## Estado
pendiente-implementar
