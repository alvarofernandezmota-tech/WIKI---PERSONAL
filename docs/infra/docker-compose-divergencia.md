---
tags: [tipo/auditoria, estado/activo, docker, madre, infra]
fecha: 2026-07-01
---

# 🐳 Divergencia Docker Composes — Auditoria

> Detectado: versiones en disco en madre divergen de repos GitHub.
> Fuente: `inbox/2026-07-01-auditoria-compose-divergencia.md`

## Problema

Los `docker-compose.yml` en madre (`/home/varo/docker/`) tienen cambios locales que no están commiteados en los repos correspondientes. Riesgo de perder configuraciones si se reinstala o resetea madre.

## Repos afectados (pendiente sincronizar)

- [ ] `yggdrasil-secops` — bots secops
- [ ] `thdora` — FastAPI + Ollama
- [ ] `local-brain` — Qdrant + embeddings
- [ ] `osint-stack` — SpiderFoot

## Acción requerida (Fase 5)

1. SSH a madre
2. `diff` entre cada compose en disco vs repo clonado
3. Commitear diferencias en cada repo
4. Validar que el compose en repo funciona limpio

> ⚠️ No urgente ahora pero antes de reinstalar cualquier cosa en madre.
