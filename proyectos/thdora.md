---
date: 2026-06-16
tags: [proyecto, thdora, toki, investigacion]
source: manual
title: "THDORA — Bot Telegram + FastAPI — Documento maestro"
---

# THDORA — Bot Telegram + FastAPI

> Repo: [github.com/alvarofernandezmota-tech/thdora](https://github.com/alvarofernandezmota-tech/thdora)
> Última revisión: **16 junio 2026**

---

## Qué es

Asistente personal en Telegram con backend FastAPI. Gestiona citas médicas, hábitos diarios y texto libre con NLP. Parte del ecosistema THEA IA.

Es la **plantilla base** de futuros agentes personales: la arquitectura es 100% reutilizable cambiando solo el system prompt, los endpoints y los handlers.

---

## Stack

| Capa | Tecnología | Detalle |
|------|------------|---------|
| Bot | python-telegram-bot v20+ | Polling, ConversationHandlers, inline buttons |
| API | FastAPI | Puerto 8001 externo, 8000 interno Docker |
| DB | SQLite | Volumen Docker persistente en `data/thdora.db` |
| NLP | Groq API | `llama-3.3-70b-versatile` (128k contexto, free tier) |
| Deploy | Docker Compose | 2 contenedores: `thdora-api` + `thdora-bot` |
| Servidor | Madre | Ubuntu, i5-8400, 16GB RAM, Docker, Tailscale |
| Red | Tailscale | IP `100.91.112.32` |
| Git | SSH | `git@github.com:alvarofernandezmota-tech/thdora.git` |

---

## Estado actual

| Item | Estado |
|------|--------|
| Versión en producción | v0.16.4 en `main` |
| Versión en desarrollo | v0.17.0 en `feature/v0.17.0-nlp-llm-multiuser` (sin mergear) |
| Desplegado en Madre | ✅ Operativo desde 14 jun 2026 |
| `thdora-api` Healthy | ✅ |
| `thdora-bot` corriendo | ✅ |
| Scheduler F12 (notificaciones) | ✅ |
| NLP Groq operativo | ✅ — modelo 70b, sin errores 401 |
| Git remoto SSH | ✅ |
| Ollama local integrado | ⏳ Backlog largo plazo |
| Handler `/diario` (GitHub API) | ❌ Pendiente — tarea inmediata |
| `src/config.py` pydantic-settings | ❌ Pendiente — orden 0 |

---

## Variables de entorno

```bash
TELEGRAM_BOT_TOKEN=   # @BotFather en Telegram → /mybots
GROQ_API_KEY=         # console.groq.com → API Keys → Create
GROQ_MODEL=llama-3.3-70b-versatile   # modelo activo jun 2026
# THDORA_API_URL se define en docker-compose.yml como http://api:8000

# Pendiente añadir para /diario:
GITHUB_TOKEN=
GITHUB_OWNER=alvarofernandezmota-tech
GITHUB_REPO=yggdrasil-dew
```

> ⚠️ `GROQ_MODEL=llama3-8b-8192` está **deprecado** desde junio 2026. Usar `llama-3.3-70b-versatile`.

---

## Lo que sabe hacer el bot

- `/start` `/citas` `/habitos` `/habito` `/nueva` `/semana` `/resumen` `/config` `/cancelar`
- Crear, editar y borrar citas con confirmación
- Navegación por días y semanas con botones inline
- Registro y seguimiento de hábitos diarios
- **Modo Toki** — texto libre entendido por NLP (Groq)
- Notificaciones: buenos días con citas del día, última llamada noche
- Conflicto de horario al crear/editar cita

---

## Comandos Docker

```bash
# Arrancar
cd ~/dev/thdora
docker compose up -d

# Ver estado
docker compose ps

# Ver logs en tiempo real
docker compose logs -f bot

# Reiniciar recargando .env
docker compose down && docker compose up -d

# ⚠️ docker compose restart NO recarga .env — usar down+up siempre que cambies variables

# Parar
docker compose down

# Consola SQLite
docker compose exec api sqlite3 /app/data/thdora.db
```

---

## Plan de trabajo — Sesión 16 junio 2026

1. **Auditoría rápida**
   - Revisar `docker-compose.yml`, `Dockerfile`, `src/`.
   - Validar que no hay hardcodes de IDs ni tokens.

2. **Revisión de rama v0.17.0**
   - Comparar `main` vs `feature/v0.17.0-nlp-llm-multiuser`.
   - Modelo de datos multiuser (cómo se identifica cada usuario).
   - Confirmar migraciones SQLAlchemy/Alembic al día.

3. **Integrar handler `/diario` (GitHub Contents API)**
   - `src/config.py` con pydantic-settings **(orden 0, desbloquea todo lo demás)**.
   - `src/services/github_client.py` (GET + PUT + retry en 409).
   - `src/bot/handlers/diario.py` enganchado al bot.

4. **Despliegue y pruebas en Madre**
   - Añadir secrets a GitHub Actions: `SERVER_HOST`, `SERVER_USER`, `SSH_PRIVATE_KEY`, `BOT_TOKEN`, `OWNER_CHAT_ID`.
   - Ejecutar `alembic upgrade head`.
   - Probar `/start`, `/diario` end-to-end.

---

## Decisiones de arquitectura aplicadas

- `/diario` usa **GitHub Contents API** (no Git local), PUT atómico sobre `yggdrasil-dew/diarios/YYYY-MM-DD.md`.
- Un solo archivo por día con secciones `## 🤖 TOKI (auto)` y `## ✍️ Manual`.
- Config vía pydantic-settings, nunca `os.environ` directo.
- Si PUT devuelve 409 (SHA obsoleto): reintento automático 1 vez, luego mensaje de error al usuario.
- yggdrasil-dew es la única fuente de verdad del diario personal/TOKI.

---

## Historial de incidencias

| Fecha | Incidencia | Causa | Fix |
|-------|------------|-------|-----|
| 14 jun 2026 | `401 Invalid API Key` en NLP | Key revocada + modelo deprecado | Rotar key + actualizar a `llama-3.3-70b-versatile` |
| 14 jun 2026 | `TimedOut` al responder en Telegram | Modelo 70b tarda más, timeout corto | 🔲 Pendiente fix en `groq_router.py` |
| 31 may 2026 | Bot parado | Servidor Acer apagado | Migrar a Madre (resuelto 14 jun) |

---

## Próximos pasos (backlog)

- [ ] Fix `TimedOut` — subir timeout en cliente Telegram de `groq_router.py`
- [ ] `src/config.py` con pydantic-settings
- [ ] `src/services/github_client.py` (GitHub Contents API client)
- [ ] `src/bot/handlers/diario.py`
- [ ] Mejorar system prompt — rol claro, contexto del usuario, límites
- [ ] Contexto dinámico — pasar citas del día + hábitos a cada llamada Groq
- [ ] Function calling — crear/borrar citas desde texto libre
- [ ] Limpiar `SyntaxWarning` en `scheduler.py`
- [ ] Multiusuario — merge v0.17.0
- [ ] Voz — Whisper para mensajes de audio

---

## Investigación de competidores — Ficha Toki (AI Scheduling Agent)

> Fuente original: `thdora/proyectos/thdora/investigacion/competidores-detalle/toki.md`
> Análisis: 15 junio 2026 | Fuente: Grok (xAI)

### Descripción general

Toki es un asistente IA de planificación y agenda que convierte lenguaje natural (texto, voz, capturas de pantalla, imágenes o emails) en eventos de calendario de forma automática.

- **Canal principal**: App móvil (iOS/Android) + integraciones nativas con WhatsApp, Telegram, Apple Messages.
- **Madurez**: Activo en 2025-2026 con +4M usuarios. Versión 2.0 (2026) enfatiza agentic behavior.
- **Precio**: Freemium (~14 eventos/semana gratis) + Pro/Super $3.59–$9.99/mes.
- **Calidad en español**: 7.5/10.

### Diferenciación vs THDORA

| Dimensión | Toki | THDORA |
|-----------|------|--------|
| Scheduling | ✅ muy fuerte | ✅ presente |
| Emocional / hábitos profundos | ❌ débil | ✅ core del proyecto |
| Canal | App + multi-canal | Telegram-first |
| Tono | Agente de calendario | Anti-complaciente |
| Privacidad | Dudosa (marketing) | GDPR-first, local-first |
| Precio | $3.59–$9.99/mes | 0€ (personal) |

### Qué copiar de Toki

- Captura multimodal (screenshots, voz) y triggers proactivos.
- Integración fluida WhatsApp/Telegram.

### Hueco que deja Toki (oportunidad THDORA)

Toki cubre muy bien la agenda pero ignora el bienestar emocional integrado y hábitos a largo plazo. THDORA puede ocupar el espacio de "asistente de vida completo" en Telegram/WhatsApp hispanohablante, con tono anti-complaciente y privacidad europea fuerte.

---

## Visión — Plantilla de agentes

THDORA es la base de un ecosistema de agentes personales. Cada agente nuevo hereda la misma infraestructura Docker, el mismo patrón FastAPI + SQLite y el mismo bot Telegram; solo cambia: system prompt + endpoints + handlers específicos.

| Agente futuro | Propósito |
|---------------|-----------|
| Agente gastos | Tickets, presupuesto mensual |
| Agente estudio | Flashcards, progreso académico |
| Agente trabajo | Tareas, deadlines, reuniones |
| Bego Bot | Asistente personalizado para Bego |

---

## Relación con el ecosistema

- **thdora** → cara ante el usuario (Telegram).
- **yggdrasil-dew** → memoria larga (diarios, contexto, este documento).
- **ai-toolkit** → taller de herramientas (OpenCode, LiteLLM, scripts).

_Ver también: [repo thdora](https://github.com/alvarofernandezmota-tech/thdora) · [ROADMAP thdora](https://github.com/alvarofernandezmota-tech/thdora/blob/main/ROADMAP.md)_

_Última actualización: 16 junio 2026 — 23:06 CEST_
