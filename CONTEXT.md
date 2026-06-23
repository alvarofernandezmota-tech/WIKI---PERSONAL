---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-06-23
revision: semanal
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> Archivo de contexto para agentes. Se actualiza con cada sesión importante.
> Los agentes leen este archivo para entender el estado real del ecosistema.

## Fecha de última actualización

2026-06-23 — Sesión completa de arquitectura y auditoría

## Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

## Estado del repo (yggdrasil-dew)

- `filosofia.md` v3.0 — 3 leyes + ADRs definidos ✅
- `agentes/` — referencia perfecta, 25+ fichas ✅ NO tocar
- `ollama/modelos/` — fichas bge-m3, qwen2.5-7b, qwen2.5-3b ✅
- `inbox/` — clasificado y documentado, pendiente vaciar a destinos
- Resto de carpetas — READMEs creados, pendiente auditar a fondo

## Estado del homelab (Madre)

- Ollama + Open WebUI + Qdrant — ⏳ descargando (2026-06-23 20:38)
- repo `ollama-stack` — 🔴 pendiente crear (prompt listo en inbox)
- thdora (bot TOKI) — ✅ activo
- Netdata multi-nodo — ✅ Madre + Acer
- UFW + fail2ban — ✅ activo

## Agentes activos

| Agente | Rol | Estado |
|---|---|---|
| Perplexity | Documenta en tiempo real, MCP GitHub | ✅ activo |
| Claude Sonnet 4.6 | Ejecuta con MCP, código, commits | ✅ listo |
| Gemini 2.5 Pro | Auditorías masivas, Deep Research | ✅ listo |
| TOKI (thdora) | Bot Telegram | ✅ activo |
| Ollama local | LLM local en Madre | ⏳ instalando |

## Repos del ecosistema

| Repo | Estado |
|---|---|
| alvarofernandezmota-tech/yggdrasil-dew | ✅ activo |
| alvarofernandezmota-tech/thdora | ✅ activo |
| alvarofernandezmota-tech/ai-toolkit | ✅ activo |
| alvarofernandezmota-tech/ollama-stack | 🔴 pendiente crear |
| alvarofernandezmota-tech/osint-stack | 🔴 pendiente crear |

## Próximo paso inmediato

1. Claude MCP → crear repo `ollama-stack` (prompt en [[inbox/2026-06-23-prompt-claude-ecosistema-docker]])
2. Cuando terminen descargas → `docker compose up -d`
3. Pull modelos: qwen2.5:7b, qwen2.5:3b, bge-m3

## ADRs vigentes

- agentes/ = solo IAs externas con API
- ollama/ = todo lo local
- setup/servidor/ = homelab Batcueva
- proyectos/ = repos GitHub propios
- Todo Docker → repo propio + doc en cerebro
- Nunca duplicar — wikilinks [[]] siempre

---
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[filosofia]] · [[inbox/MASTER-PENDIENTES]]_
