---
tags: [proyecto, activo, bot, telegram, fastapi, python, produccion]
---

# 🤖 thdora — Bot TOKI (Asistente Personal IA)

> Repo: [alvarofernandezmota-tech/thdora](https://github.com/alvarofernandezmota-tech/thdora)
> Creado: marzo 2026 · Estado: **activo — v0.17.2 en producción**

## Qué es

Bot Telegram + FastAPI. Asistente personal de salud mental y gestión de vida. El asistente se llama **TOKI**. Corre en Madre (servidor de producción).

## Diferenciador

Ningún competidor (Wysa / Woebot / Replika / Youper / Bearable) usa Telegram en español — ese es el hueco.

## Stack

- Python · FastAPI · SQLAlchemy · Alembic · Docker
- Telegram Bot API (python-telegram-bot)
- LLM: Groq (cloud) + Ollama (local en Madre)
- CI/CD: GitHub Actions → deploy en Madre

## Estructura

```
thdora/
├── src/
│   ├── bot/      → handlers Telegram
│   ├── ai/       → LLMBackend: Groq + Ollama
│   ├── api/      → FastAPI endpoints
│   ├── agents/   → (planificado)
│   ├── core/     → lógica de negocio
│   └── db/       → SQLAlchemy + Alembic
├── docker-compose.yml · Dockerfile
└── .github/workflows/deploy.yml
```

## Estado actual — v0.17.2

| Servicio | Estado |
|---|---|
| thdora API | ✅ healthy |
| thdora-bot | ✅ healthy (fix healthcheck hoy) |
| Prometheus | ✅ up |
| Grafana | ✅ up |

## Historial relacionado

- [[diarios/2026-06-20]] — fix healthcheck bot (FailingStreak 86 → healthy)
- [[proyectos/thdora-vision-producto]] — visión de producto
- [[proyectos/thdora-casos-uso]] — casos de uso
- [[proyectos/thdora-v0.17.0-y-mas-alla]] — roadmap
- [[proyectos/toki-comercializacion]] — estrategia comercial

## Origen

Evolución de [[proyectos/thea-ia]] (oct 2025).

## Pendiente

- [ ] Verificar `/start` en Telegram
- [ ] Handler `/diario` → escribe en [[proyectos/yggdrasil-dew]]
- [ ] PostgreSQL (actualmente SQLite)
- [ ] `src/agents/` — implementar agentes

---

Volver a [[HOME]] · [[ECOSISTEMA]]
