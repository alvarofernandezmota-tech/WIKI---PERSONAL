---
tags: [tipo/sesion, estado/draft, #infra/docker]
---

# Auditoría Compose — Divergencia Repo vs Realidad

> 📥 inbox — procesado parcialmente, ver `docker/madre/AUDITORIA-COMPOSE.md`

**Fecha:** 2026-07-01  
**Hallazgo:** 14 servicios corriendo en madre, solo 4 documentados en repo

## Compose real localizado

- `~/docker-compose.yml` — **SSOT actual** (ollama x2, qdrant, open-webui)
- `~/Projects/thdora/docker-compose.yml` — thdora + thdora-bot
- `~/spiderfoot/docker-compose.yml` — spiderfoot
- Resto de servicios (grafana, prometheus, n8n, gitea, etc.) — **compose no localizado aún**

## Acción tomada

- `~/docker-compose.yml` subido a `docker/madre/docker-compose.fase1-real.yml` ✅
- `docker/madre/AUDITORIA-COMPOSE.md` creado con mapa completo ✅

## Pendiente

- [ ] Localizar compose de los 10 servicios restantes
- [ ] Hardening puertos `0.0.0.0` → `127.0.0.1`

*🔧 WIP*
