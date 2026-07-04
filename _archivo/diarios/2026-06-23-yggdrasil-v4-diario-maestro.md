---
tags: [diario, maestro, yggdrasil, v4, 2026-06-23]
fecha: 2026-06-23
tipo: diario-maestro
ruta-obsidian: diarios/2026-06-23-yggdrasil-v4-diario-maestro.md
fuente: inbox/2026-06-23-yggdrasil-v4-diario-maestro.md
---

# Yggdrasil v4 — Diario Maestro 2026-06-23

> El día que el cerebro pasó de caos a estructura de ingeniero software.

## Contexto del día

Sesión larga e intensa. Se tomaron decisiones arquitectónicas fundamentales
que definen cómo crece el ecosistema a partir de ahora.

## Decisiones tomadas

### 1. Separación agentes/ vs ollama/
- `agentes/` = IAs con API externa (Claude, Gemini, GPT...)
- `ollama/` = todo lo local (modelos, RAG, embeddings)
- Ver [[docs/adr/2026-06-23-adr-ollama-en-agentes]]

### 2. Batcueva = homelab, no proyecto
- `setup/servidor/` = Batcueva
- `proyectos/` = solo cosas que construyes
- Ver [[docs/decisiones/2026-06-23-decision-homelab-vs-proyectos]]

### 3. Repos separados para proyectos
- Cada proyecto activo tiene su repo GitHub
- El cerebro documenta, el repo implementa
- Ver [[docs/decisiones/2026-06-23-decision-arquitectura-proyectos]]

### 4. Stack Batcueva definitivo
- Ollama + Open WebUI + Qdrant (IA local)
- SpiderFoot + IVRE (OSINT)
- Portainer + Uptime Kuma (gestión)

## Flujo de trabajo del día

```
Investigación RAG (Claude + Gemini paralelo)
        ↓
Auditoría completa repo
        ↓
ADRs + Decisiones documentadas
        ↓
Descarga Docker Madre
        ↓
Migración inbox
        ↓
Repo en estado v4 ✅
```

## Referencias
- [[diarios/2026-06-23-sesion-completa]]
- [[inbox/MASTER-PENDIENTES]]
- [[docs/adr/]]
- [[docs/decisiones/]]
