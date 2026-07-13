---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/thdora.md
tags: [isla, thdora, bot, telegram, fastapi, python, orquestador]
status: auditada
repo_principal: THDORA-PERSONAL
---

# Isla: THDORA (Bot + Orquestador personal)

> Bot de Telegram personal + API FastAPI que actúa como interfaz del ecosistema.
> Corre en Madre como contenedores Docker (`thdora-bot` + `thdora-api`).

---

## Arquitectura

```
Telegram (Alvaro)
    └── thdora-bot (Docker en Madre)
            ├── thdora-api (FastAPI — Docker en Madre)
            │       ├── LiteLLM → Ollama (modelos locales)
            │       └── n8n (flujos automatización)
            └── Responde a comandos de Alvaro
```

---

## Repos

| Repo | Contenido | Estado |
|------|-----------|--------|
| [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot Telegram + FastAPI | 🔴 Caído |
| [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) | Core Python IA (base) | 🔴 Sin actividad |

---

## Comandos disponibles (cuando el bot está operativo)

> Pendiente de documentar tras auditoría AUDIT-007 (#49).

Ejemplos habituales:
- `/status` — estado del ecosistema
- `/docker` — estado de contenedores en Madre
- Alertas automáticas vía n8n → Telegram

---

## Estado real — 2026-07-13

🔴 **Bot caído.** Dos bloqueantes activos:

| Issue | Problema | Acción |
|-------|----------|--------|
| [HAL-007 #44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | `.env` malformado en Madre | Fix manual en servidor |
| [HAL-008 #45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | Token Telegram expuesto, pendiente rotar | BotFather → revocar + actualizar `.env` |

```bash
# Una vez cerrados #44 y #45:
docker compose up -d --force-recreate thdora-bot thdora-api
docker ps --filter 'name=thdora'
```

---

## Issues DEW relacionados

- [DEW #44 — HAL-007 .env malformado](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) 🔴
- [DEW #45 — HAL-008 rotar token](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) 🔴
- [DEW #49 — AUDIT-007 Orquestador completo](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49)
- [DEW #36 — AUDIT-003 thdora-personal](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36)

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
