# agente-sync-reglas

## Función única
Alinear reglas, plantillas y estructura entre Madre, islas e inbox.
Garantiza que si nace una isla nueva en la repo, nace su espejo en inbox.

## Entradas
- Estructura actual de la repo (raíz)
- Estructura actual de inbox/
- Reglas en `inbox/_meta/REGLAS-INBOX.md`

## Salidas
- Carpetas espejo creadas si faltan
- Reglas sincronizadas
- Traza en `inbox/_meta/`

## Relación con otros agentes
- Complementa al `orquestador-inbox`
- Informa al `agente-roadmap-master` si hay deriva estructural

## Estado
pendiente-implementar
