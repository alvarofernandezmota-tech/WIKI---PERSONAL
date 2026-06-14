# THDORA — Bot Telegram + FastAPI

> Repo: [github.com/alvarofernandezmota-tech/thdora](https://github.com/alvarofernandezmota-tech/thdora)
> Última revisión: **14 junio 2026**

---

## Qué es

Asistente personal en Telegram con backend FastAPI. Gestiona citas médicas, hábitos diarios y texto libre con NLP. Parte del ecosistema THEA IA.

Es la **plantilla base** de futuros agentes personales: la arquitectura es 100% reutilizable cambiando solo el system prompt, los endpoints y los handlers.

---

## Stack

| Capa | Tecnología | Detalle |
|------|------------|--------|
| Bot | python-telegram-bot v20+ | Polling, ConversationHandlers, inline buttons |
| API | FastAPI | Puerto 8001 externo, 8000 interno Docker |
| DB | SQLite | Volumen Docker persistente en `data/thdora.db` |
| NLP | Groq API | `llama-3.3-70b-versatile` (128k contexto, free tier) |
| Deploy | Docker Compose | 2 contenedores: `thdora-api` + `thdora-bot` |
| Servidor | Madre | Omarchy (Arch Linux + Hyprland), i5-8400, 16GB RAM |
| Red | Tailscale | IP `100.91.112.32` |
| Git | SSH | `git@github.com:alvarofernandezmota-tech/thdora.git` |

---

## Estado actual — v0.16.4

| Item | Estado |
|------|--------|
| Repo estructurado + docs completos | ✅ |
| Dockerfile + docker-compose.yml | ✅ |
| `.env.example` documentado | ✅ |
| Keys en repo | ❌ NO — `.gitignore` protegido |
| Desplegado en Madre | ✅ Operativo desde 14 jun 2026 |
| `thdora-api` Healthy | ✅ |
| `thdora-bot` corriendo | ✅ |
| Scheduler F12 (notificaciones) | ✅ |
| NLP Groq operativo | ✅ — modelo 70b, sin errores 401 |
| Git remoto SSH | ✅ |
| Ollama local integrado | ⏳ Backlog largo plazo |

---

## Variables de entorno

```bash
TELEGRAM_BOT_TOKEN=   # @BotFather en Telegram → /mybots
GROQ_API_KEY=         # console.groq.com → API Keys → Create
GROQ_MODEL=llama-3.3-70b-versatile   # modelo activo jun 2026
# THDORA_API_URL se define en docker-compose.yml como http://api:8000
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

## Historial de incidencias

| Fecha | Incidencia | Causa | Fix |
|-------|------------|-------|-----|
| 14 jun 2026 | `401 Invalid API Key` en NLP | Key revocada + modelo deprecado | Rotar key + actualizar a `llama-3.3-70b-versatile` |
| 14 jun 2026 | `TimedOut` al responder en Telegram | Modelo 70b tarda más, timeout corto | 🔲 Pendiente fix en `groq_router.py` |
| 31 may 2026 | Bot parado | Servidor Acer apagado | Migrar a Madre (resuelto 14 jun) |

---

## Próximos pasos

- [ ] Fix `TimedOut` — subir timeout en cliente Telegram de `groq_router.py`
- [ ] Mejorar system prompt — rol claro, contexto del usuario, límites
- [ ] Contexto dinámico — pasar citas del día + hábitos a cada llamada Groq
- [ ] Function calling — crear/borrar citas desde texto libre
- [ ] Limpiar `SyntaxWarning` en `scheduler.py` (escape sequences)
- [ ] Multiusuario — `user_id` de Telegram en API
- [ ] Voz — Whisper para mensajes de audio

---

## Visión — Plantilla de agentes

THDORA es la base de un ecosistema de agentes personales. Cada agente nuevo hereda:
- La misma infraestructura Docker
- El mismo patrón FastAPI + SQLite
- El mismo bot Telegram con ConversationHandlers
- Solo cambia: system prompt + endpoints + handlers específicos

| Agente futuro | Propósito |
|---------------|-----------|
| Agente gastos | Tickets, presupuesto mensual |
| Agente estudio | Flashcards, progreso academico |
| Agente trabajo | Tareas, deadlines, reuniones |
| Bego Bot | Asistente personalizado para Bego |

---

_Ver también: [repo thdora](https://github.com/alvarofernandezmota-tech/thdora) · [ROADMAP thdora](https://github.com/alvarofernandezmota-tech/thdora/blob/main/ROADMAP.md)_

_Última actualización: 14 junio 2026 — 23:58 CEST_
