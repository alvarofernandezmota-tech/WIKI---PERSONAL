---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-18 01:30 CEST
ruta: wiki/islas/thdora.md
tags: [thdora, telegram, bot, personal, tracking, rediseno]
status: caida
---

# Isla: THDORA

> THDORA es el bot personal de Álvaro en Telegram.
> Es un proyecto **independiente del ecosistema Yggdrasil** — no forma parte del orquestador ni de la capa IA.
> Su único puente con el ecosistema es que desde él se puede iniciar sesiones orquestadas.

---

## Qué es THDORA

Repo: `THDORA-PERSONAL`

THDORA es un bot de Telegram con identidad propia:
- Interfaz conversacional personal de Álvaro
- **Lleva el diario de tracking en el chat** (entrada principal de diarios)
- Puede llamar al orquestador del ecosistema (puente, no componente)
- Tiene su propio ciclo de vida, su propio stack, su propia filosofía
- Necesita ser **rediseñado completamente** (ver estado actual abajo)

> THDORA NO es el orquestador. NO es un agente del ecosistema.
> Es la interfaz personal de Álvaro con su mundo digital.

---

## Estado actual

| Item | Estado | Issue |
|---|---|---|
| Bot Telegram | 🔴 Caído | [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) |
| Token Telegram | 🔴 Caducado | [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) |
| Diseño actual | ⚠️ Obsoleto | Rediseño completo pendiente |
| Diario tracking via chat | ⚠️ Inoperativo | Hasta que se rehaga |

---

## Arquitectura actual (a rehacer)

```
THDORA-PERSONAL/
  src/
    bot/        ← handlers Telegram
    api/        ← API interna
  .env          ← NUNCA trackear en git
  docker-compose.yml
```

---

## Rediseño pendiente

THDORA necesita ser rehecho desde cero. Funciones objetivo:

1. **Diario tracking** — entrada de diario personal desde Telegram, guardado en `yggdrasil-tracking`
2. **Consulta rápida** — preguntar al ecosistema desde el móvil
3. **Puente orquestador** — iniciar sesiones o ejecutar runbooks simples
4. **Alertas** — recibir alertas críticas del sistema (Wazuh, servicios caídos)

Este rediseño requiere:
- Decisión de stack (¿Node.js? ¿Python? ¿n8n?)
- Sesión dedicada con Álvaro
- Terminal para deploy en Madre

---

## Relación con el ecosistema

```
THDORA (Telegram)
  │
  ├── escribe → yggdrasil-tracking (diarios)
  ├── puede llamar → yggdrasil-orquestador
  ├── recibe alertas ← yggdrasil-secops (Wazuh)
  └── consulta → local-brain (RAG) [futuro]
```

---

## Próximos pasos

1. 🔴 **Urgente (terminal):** Renovar token — runbook en `docs/runbooks/RUNBOOK-THDORA-TOKEN.md`
2. 🟡 **Sesión dedicada:** Diseño del nuevo THDORA con Álvaro
3. 🟡 **Terminal:** Deploy del nuevo stack en Madre

---

## Issues relacionados

- [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) — Token caducado (urgente)
- [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) — HAL-008 secretos expuestos
- [#36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36) — Auditoría THDORA-PERSONAL
- [#46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) — log_guardian_bot crash

---

_Actualizado: 2026-07-18 01:30 CEST · F24b — isla independiente, rediseño pendiente · Perplexity-MCP_
