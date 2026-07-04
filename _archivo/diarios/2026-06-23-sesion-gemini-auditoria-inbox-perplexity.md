---
tags: [diario, sesion, gemini, perplexity, auditoria, inbox]
fecha: 2026-06-23
tipo: diario-sesion
ruta-obsidian: diarios/2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md
fuente: inbox/2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md
---

# Sesión Gemini + Perplexity — Auditoría inbox 2026-06-23

> Sesión de auditoría de inbox con Gemini y Perplexity como procesadores.

## Lo que se intentó

- Usar Gemini para vaciar la inbox via API GitHub
- Perplexity tiene acceso MCP directo al repo
- Se generó el prompt maestro de vaciado
- Se ejecutó parcialmente (bloque 1 iniciado)

## Aprendizaje del flujo

**Gemini** puede ejecutar el vaciado si tiene:
1. El prompt con el mapa completo
2. Token GitHub con permisos de escritura
3. Acceso a la API de GitHub

**Perplexity MCP** puede ejecutarlo directamente sin token adicional.
Limitación: necesita leer cada archivo antes de copiarlo (35 lecturas + 35 escrituras = 70 llamadas API).

## Prompt generado

Ver [[agentes/prompts/2026-06-23-prompt-gemini-auditoria-inbox]]

## Referencias
- [[inbox/2026-06-23-VACIADO-MAESTRO-GEMINI]]
- [[agentes/prompts/]]
