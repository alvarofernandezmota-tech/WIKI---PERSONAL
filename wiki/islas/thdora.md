---
tipo: isla
isla: thdora
repos: [THDORA-PERSONAL]
actualizado: 2026-07-05 15:03 CEST
tags: [thdora, telegram, bot, fastapi, ia, personal]
---

# 🦾 Isla: THDORA

> El bot personal. Interfaz de voz y texto con el ecosistema desde Telegram.
> Evolución natural de `thea-ia` (archivado).

---

## Repos

### [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) 🌐 Público
Bot Telegram personal con IA local integrada:
- **FastAPI** — backend y webhook Telegram
- **Ollama** — respuestas con LLM local
- **local-brain** — memoria y contexto personal
- Gestiona: recordatorios, consultas, notas rápidas
- Fase actual: 10 (multi-agente en desarrollo)

---

## Arquitectura

```
iPhone (Telegram)
    ↓
THDORA-PERSONAL (FastAPI en Madre)
    ├──→ ollama-stack (respuesta LLM)
    └──→ local-brain (memoria RAG)
```

---

## Herramientas
- **Python / FastAPI** — backend
- **python-telegram-bot** — cliente Telegram
- **Ollama** — modelos LLM locales
- **Docker** — despliegue en Madre
- **Qdrant** — memoria vectorial

---

## Historial
- `thea-ia` — proyecto original (archivado, delegado aquí)
- `ai-toolkit` — stack IA anterior (archivado, delegado en ollama-stack)

---

← [HOME](../../HOME.md)
