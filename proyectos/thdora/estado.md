---
tags: [proyecto, thdora, bot, telegram, fastapi, estado]
fecha-creacion: 2026-06-30
ultima-actualizacion: 2026-07-02
version: v0.12.1
estado: congelado
---

# 🤖 THDORA — Estado del proyecto

## Estado actual: CONGELADO en v0.12.1

> Decisión tomada 01-jul-2026: THDORA se congela mientras se estabiliza el stack pentest.
> Handlers Telegram pendientes hasta Fase 4.

## Stack

| Componente | Estado |
|---|---|
| FastAPI backend | ✅ healthy — 20 endpoints mapeados |
| Bot Telegram | ✅ activo |
| Ollama (qwen2.5-coder:7b) | ✅ conectado |
| Qdrant RAG | ⚠️ sin datos cargados |

## Handlers Telegram pendientes (Fase 4)

- [ ] `/hoy` — resumen del día
- [ ] `/semana` — resumen semanal
- [ ] `/habitos` — tracking hábitos
- [ ] `/agenda` — agenda del día
- [ ] `/proximas` — tareas próximas

## Acciones pendientes pre-handlers

- [ ] Leer `~/Projects/thdora/src/` — mapa completo handlers actuales
- [ ] Evaluar revocar token Telegram en @BotFather
- [ ] Conectar Uptime Kuma → webhook THDORA

## Repo

https://github.com/alvarofernandezmota-tech/thdora

## Ver también
- [[docs/ias/modelos-ollama]]
- [[MASTER-PENDIENTES]]

---
_Creado desde inbox 2026-06-30 — Perplexity vía MCP_
