---
tags: [proyecto, thdora, python, telegram, docker, activo]
fecha-actualizacion: 2026-06-20
---

# 🤖 THDORA — Bot Telegram TOKI

## Qué es

Bot de Telegram personal llamado **TOKI**.
Backend FastAPI + bot aiogram + Docker en [[setup/madre]].
Repo: https://github.com/alvarofernandezmota-tech/thdora

## Estado actual (20 jun 2026)

- Versión: **v0.22.1** en `main`
- Stack Docker en Madre: **6/6 contenedores** ✅
- API FastAPI: **healthy** puerto 8000 ✅
- Bot Telegram: **healthy** ✅
- Prometheus + Grafana: ✅ corriendo
- CI/CD: ✅ `deploy.yml` con `--build` y notificación Telegram

## Stack técnico

| Componente | Tecnología |
|---|---|
| API | FastAPI + Uvicorn |
| ORM | SQLAlchemy + Alembic |
| Bot | aiogram (Telegram) |
| IA | LangGraph + Groq + Ollama |
| Infra | Docker Compose · red `thdora-net` |
| Monitoreo | Prometheus + Grafana |
| CI/CD | GitHub Actions |

## Decisiones técnicas

- `@lru_cache` en `Settings` para evitar errores de importación en CI
- Healthcheck del bot: `python3 -c "import sys; sys.exit(0)"` — no curl (bot no expone HTTP)
- `fastapi<0.137.0` fijado — compat con prometheus-fastapi-instrumentator
- Imagen multi-stage, usuario no-root, `/app/data` y `/app/logs` con permisos

## Próximo paso

- [ ] Verificar `/start` en Telegram
- [ ] `docs/DEPLOY.md` — guía de deploy paso a paso
- [ ] `docs/SERVIDOR_MADRE.md` — documentar ruta repo en Madre
- [ ] PostgreSQL (sustituir SQLite en producción)
- [ ] Handler `/diario` — escribir en yggdrasil-dew desde Telegram

## Historial clave

| Fecha | Hito |
|---|---|
| Jun 2026 | v0.22.1 — Sprint 5 completo, stack Docker operativo |
| Jun 2026 | Fix healthcheck bot (falso positivo curl→python3) |
| Jun 2026 | 14 bugs críticos B12–B25 resueltos |

---

_Ver también: [[setup/madre]] · [[diarios/2026-06-20]] · [[HOME]]_
