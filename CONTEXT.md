---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-06-23T21:24+02:00
revision: semanal
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> Archivo de contexto para agentes. Se actualiza con cada sesión importante.
> Los agentes leen este archivo para entender el estado real del ecosistema.

## Fecha de última actualización

2026-06-23 21:24 CEST — Vaciado completo de inbox + descarga dockers LLM

## Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

## Estado del repo (yggdrasil-dew)

- `filosofia.md` v3.0 — 3 leyes + ADRs definidos ✅
- `agentes/` — 25+ fichas + bloque ollama migrado desde inbox ✅
- `agentes/ollama/` — auditoria, bge-m3, qwen2.5-3b/7b, rag, ecosistema-prep, v4-pendiente ✅
- `agentes/prompts/` — prompts reutilizables Claude + Gemini ✅
- `ollama/modelos/` — fichas originales del repo ✅
- `docs/adr/` — 2 ADRs migrados desde inbox ✅
- `docs/decisiones/` — 2 decisiones arquitectónicas migradas ✅
- `docs/` — 10 documentos migrados desde inbox ✅
- `setup/` — 5 notas setup + instalacion-3-dockers-llm + pull-stack-estado ✅
- `proyectos/thdora/`, `proyectos/chatbot-control/`, `proyectos/local-brain/`, `proyectos/terminal-ia/` — proyectos activos documentados ✅
- `osint/` — auditoria + rag migrados ✅
- `diarios/` — 4 sesiones migradas desde inbox ✅
- `formacion/` — auditoria migrada ✅
- `yo/` — auditoria migrada ✅
- `tools/` — script vaciado Gemini + pull-stack-robusto.sh ✅
- `inbox/` — **VACIADA** — solo permanentes: README, MASTER-PENDIENTES, .gitkeep, inbox-clasificado, VACIADO-MAESTRO ✅

## Estado del homelab (Madre)

- Ollama — ❌ descarga fallida `tls: bad record MAC` — ⏳ reintentando
- Open WebUI — ⏳ descargando capas
- Qdrant — ⏳ pendiente (imagen descargada, pendiente compose)
- Acceso actual: SSH remoto — sync local pendiente al llegar a casa
- repo `ollama-stack` — 🔴 pendiente crear
- thdora (bot TOKI) — ✅ activo
- Netdata multi-nodo — ✅ Madre + Acer
- UFW + fail2ban — ✅ activo

## Agentes activos

| Agente | Rol | Estado |
|---|---|---|
| Perplexity | Documenta en tiempo real, MCP GitHub | ✅ activo |
| Claude Sonnet 4.6 | Ejecuta con MCP, código, commits | ✅ listo |
| Gemini 2.5 Pro | Auditorías masivas, vaciado inbox, Deep Research | ✅ listo |
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

## Estructura de carpetas activa (post-vaciado)

```
yggdrasil-dew/
├── CONTEXT.md          ← este archivo
├── AGENT.md
├── ECOSISTEMA.md
├── HOME.md
├── CHANGELOG.md
├── filosofia.md
├── agentes/
│   ├── ollama/             (10 fichas)
│   └── prompts/            (3 prompts reutilizables)
├── cli-tools/
├── diarios/            (4 sesiones 2026-06-23)
├── docs/
│   ├── adr/               (2 ADRs)
│   └── decisiones/        (2 decisiones)
├── formacion/          (1 auditoria)
├── inbox/              (✅ VACIADA — solo 5 permanentes)
├── ollama/             (modelos originales)
├── osint/              (2 docs OSINT)
├── proyectos/
│   ├── chatbot-control/
│   ├── local-brain/
│   ├── terminal-ia/
│   └── thdora/
├── setup/              (7 docs: setup + LLM + pull-stack)
├── templates/
├── tools/              (script Gemini + pull-stack-robusto.sh)
├── yo/                 (auditoria personal)
└── .github/
```

## Próximo paso inmediato

1. ⏳ Esperar a que terminen las descargas Docker en Madre
2. Retry Ollama: `docker pull ollama/ollama:latest` (o `bash tools/pull-stack-robusto.sh`)
3. `docker compose up -d` cuando las 3 imágenes estén listas
4. Pull modelos: `ollama pull qwen2.5:3b && ollama pull qwen2.5:7b && ollama pull bge-m3`
5. Crear repo `ollama-stack` con Claude MCP
6. Al llegar a casa: `git pull` en local para sincronizar todo

## ADRs vigentes

- `agentes/` = IAs externas con API + fichas ollama
- `ollama/` = config y modelos locales
- `setup/` = homelab Batcueva
- `proyectos/` = repos GitHub propios
- Todo Docker → repo propio + doc en cerebro
- Nunca duplicar — wikilinks [[]] siempre
- inbox = solo zona de paso, se vacía con cada sesión

---
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[filosofia]] · [[inbox/MASTER-PENDIENTES]] · [[docs/2026-06-23-registro-migracion-inbox]]_
