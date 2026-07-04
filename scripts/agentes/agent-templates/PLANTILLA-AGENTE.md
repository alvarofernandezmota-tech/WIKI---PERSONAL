# PLANTILLA — Nuevo Agente

## Descripción
<!-- Qué hace este agente en una frase -->

## Rol
<!-- auditor | generador | contextualizador | monitor | generico -->

## Responsabilidades
- [ ] Responsabilidad 1
- [ ] Responsabilidad 2

## Entradas
- inbox/
- docs/COPILOT-CONTEXT.md

## Salidas
- reports/<nombre-agente>/

## Dependencias
- scripts/agentes/llm-router.sh
- mcp/server.py

## Notas
- Crear PR en draft para cambios significativos
- Enmascarar PII antes de llamar a LLMs externos
