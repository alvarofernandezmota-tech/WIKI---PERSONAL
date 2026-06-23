---
tags: [thdora, stack-tecnologico, docker-compose, dev-environment]
fecha: 2026-06-20
estado: referencia
ruta-obsidian: proyectos/thdora/estado-stack.md
repo-externo: thdora
ruta-repo: deployment/docker-compose.yml
---

# THDORA — Estado stack Docker

> Movido desde inbox/ · Auditoría Grok 23/06/2026

## Contenedores (Madre)

| Contenedor | Puerto | Estado |
|---|---|---|
| thdora (API) | :8000 | ✅ healthy |
| thdora-bot | — | ✅ healthy |
| PostgreSQL | — | ✅ |
| Prometheus | :9090 | ✅ |
| Grafana | :3000 | ✅ |

## Versión
- v0.22.1 · Stack 6/6 ✅
