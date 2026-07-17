---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-18
actualizado: 2026-07-18
ruta: wiki/islas/agentes-personales.md
tags: [thdora, thea, agentes, telegram, fastapi, python, ia, bot]
status: auditado
repos: [THDORA-PERSONAL, thea-ia]
---

# 🤖 Agentes Personales — THDORA + Thea

> Interfaz del ecosistema hacia Álvaro. Bot Telegram (THDORA) + core IA Python (thea-ia).
> Corre en Madre como contenedores Docker.

| Campo | Valor |
|---|---|
| **Repos** | [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) · [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) |
| **Máquina** | Madre (Docker) |
| **Estado operativo** | 🔴 Caído — token Telegram caducado (#74) |
| **Última auditoría** | 2026-07-18 |

---

## 📌 Qué es

Dos repos íntimamente ligados que juntos forman la interfaz personal del ecosistema:

- **THDORA-PERSONAL** — Bot Telegram + API FastAPI. Álvaro interactúa con el ecosistema a través de él. Corre en Docker en Madre (`thdora-bot` + `thdora-api`). Conecta con LiteLLM → Ollama para respuestas LLM locales, y con n8n para automatizaciones.
- **thea-ia** — Core Python IA. Librería base que originalmente alimentaba THDORA. Sin actividad desde febrero 2026. Decisión arquitectural pendiente (DEW #49).

---

## 🏗️ Arquitectura

```
Telegram (Álvaro)
    └── thdora-bot (Docker en Madre)
            ├── thdora-api (FastAPI — Docker en Madre)
            │       ├── LiteLLM → Ollama (IA local)
            │       └── n8n (flujos automatización)
            └── Responde comandos

thea-ia (core Python — sin actividad desde feb 2026)
    └── pendiente decisión: archivar / fusionar / librería
```

---

## 💬 Comandos THDORA (cuando operativo)

- `/status` — estado del ecosistema
- `/docker` — estado contenedores en Madre
- Alertas automáticas vía n8n → Telegram

> Documentación completa pendiente tras resolución #74 y auditoría #49.

---

## 📊 Estado actual — 2026-07-18

| Componente | Estado | Bloqueante |
|---|---|---|
| thdora-bot | 🔴 Caído | Token Telegram caducado — #74 |
| thdora-api | 🔴 Caído | Depende de thdora-bot |
| thea-ia | 🔴 Sin actividad | Decisión pendiente — #49 |
| LiteLLM → Ollama | ✅ Disponible | En espera de THDORA |

---

## 🔴 Bloqueantes — resolver en terminal

```bash
# 1. Renovar token en BotFather
# 2. Actualizar .env en Madre
# 3. Reiniciar contenedores
docker compose up -d --force-recreate thdora-bot thdora-api
docker ps --filter 'name=thdora'
```

| Issue | Problema | Acción | Prioridad |
|---|---|---|---|
| [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) | Token Telegram caducado | BotFather → renovar + actualizar .env | 🔴 CRÍTICO |
| [#44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | HAL-007: `.env` malformado | Fix manual en Madre | 🔴 |
| [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | HAL-008: Token anterior revocado | Ya en proceso via #74 | 🟡 |
| [#49](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49) | Decisión arquitectural thea-ia | Sesión dedicada | 🟡 |

---

## 🗺️ Relaciones con el ecosistema

```
Agentes Personales
  ├── corre en    → Madre (Docker)
  ├── consume     → Ollama (LLM local via LiteLLM)
  ├── consume     → n8n (flujos)
  ├── alimenta    → TOKI (bot memoria futura)
  └── investiga   → investigacion-ia (nuevas capacidades)
```

---

## 📝 Decisiones pendientes

- [ ] **P0:** Renovar token THDORA — DEW #74 (terminal)
- [ ] Resolver arquitectura thea-ia — DEW #49 (opciones: A archivar / B fusionar / C librería)
- [ ] Documentar todos los comandos disponibles tras reactivación
- [ ] Conectar THDORA con RAG local-brain una vez #71 resuelto

---

> ⚠️ **Creada 2026-07-18** — fusión de `thdora.md` + `thea.md`. Ambas islas eliminadas.

_Actualizado: 2026-07-18 · Perplexity-MCP · F21 fusión_
