# agente-investigador

## Función única
Buscar contexto para otros agentes mediante RAG local sobre el ecosistema Yggdrasil-dew.

## Entradas
- Pregunta o query de otro agente
- Repositorio local indexado (docs/, diary/, inbox/)

## Salidas
- Contexto relevante para el agente solicitante
- Fuente documentada en `inbox/_meta/`

## Relación con otros agentes
- Sirve contexto a todos los demás agentes
- Alimenta al `agente-roadmap-master` con hallazgos
- Requiere MCP server operativo para funcionar plenamente

## Estado
pendiente-implementar (bloqueado: MCP socket no operativo)
