---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-18 01:30 CEST
ruta: wiki/islas/orquestador.md
tags: [orquestador, agentes, ia, ecosistema, protocolos, mcp, sesiones]
status: activa
---

# Isla: Orquestador

> El orquestador es el sistema de coordinación de sesiones del ecosistema Yggdrasil.
> Garantiza que cualquier agente IA arranca con contexto completo, trabaja según el canon, y cierra dejando el sistema mejor de lo que lo encontró.

---

## Qué es el orquestador

Repo: `yggdrasil-orquestador`

El orquestador NO es un bot, NO es una interfaz. Es el **protocolo de arranque y cierre de sesiones** del ecosistema. Su función:

1. Lee el `AGENT.md` del repo objetivo — identidad y reglas del agente
2. Lee el `CONTEXT.md` del repo objetivo — estado actual
3. Carga el `PROTOCOLO-INICIO-SESION` desde `yggdrasil-dew`
4. El agente (Perplexity, Claude, etc.) ejecuta la sesión
5. Al finalizar, ejecuta `PROTOCOLO-CIERRE-SESION`
6. Actualiza `CONTEXT.md` + commit canon + actualiza `MASTER-PENDIENTES`

**Principio clave:** ningún agente arranca sin haber leído su `AGENT.md` + `CONTEXT.md`. El orquestador lo garantiza.

> THDORA es un bot personal independiente. No forma parte del orquestador.
> Ver isla [`thdora.md`](thdora.md) para su arquitectura y estado.

---

## Arquitectura

```
yggdrasil-orquestador/
  AGENT.md            ← identidad del orquestador
  CONTEXT.md          ← estado actual
  BOOTSTRAP.md        ← prompt de contexto para arrancar cualquier agente
  README.md
  protocols/
    boot.md           ← protocolo de arranque general
    session.md        ← protocolo de sesión por repo
    shutdown.md       ← protocolo de cierre y commit
  agents/
    dew.md            ← configuración agente DEW
    wiki.md           ← configuración agente WIKI
    tracking.md       ← configuración agente TRACKING
    formacion.md      ← configuración agente FORMACION
    madre.md          ← configuración agente MADRE
```

---

## Flujo de una sesión orquestada

```
[INICIO]
  1. Agente lee BOOTSTRAP.md (contexto completo del ecosistema)
  2. Agente lee AGENT.md del repo objetivo
  3. Agente lee CONTEXT.md del repo objetivo
  4. Agente carga PROTOCOLO-INICIO-SESION desde yggdrasil-dew
  5. Sesión de trabajo
[CIERRE]
  6. Agente ejecuta PROTOCOLO-CIERRE-SESION
  7. Actualiza CONTEXT.md del repo
  8. Commit canon con fecha + versión
  9. Actualiza MASTER-PENDIENTES en yggdrasil-dew
  10. Crea diario sesión en docs/sesiones/
```

---

## Capa IA del ecosistema

El orquestador coordina y consume estas capas:

```
ORQUESTADOR (yggdrasil-orquestador)
│  └─ coordina sesiones, carga contexto, cierra limpio
├── MCP (protocolo) ← isla mcp.md
│   └─ cómo hablan los agentes con herramientas externas
└── IA LOCAL (motor) ← isla ia-local.md
    └─ Ollama + RAG + Qdrant + local-brain
```

THDORA (bot personal) puede **llamar al orquestador** desde Telegram, pero no es un componente interno de él.

---

## Repos gestionados (estado F24 — 2026-07-18)

| Repo | AGENT.md | CONTEXT.md | Estado |
|---|---|---|---|
| `yggdrasil-dew` | ✅ | ✅ | Operativo |
| `WIKI---PERSONAL` | ✅ | ✅ | Operativo |
| `yggdrasil-tracking` | ✅ | ✅ | Operativo |
| `yggdrasil-formacion` | ✅ | ✅ | Operativo |
| `madre-config` | ✅ | ✅ | Operativo |
| `yggdrasil-secops` | ✅ | ✅ | Operativo |
| `ollama-stack` | ✅ | ✅ | Operativo |
| `yggdrasil-orquestador` | ✅ | ✅ | Operativo |
| `yggdrasil-scripts` | ✅ | ✅ | Operativo |
| `acer-config` | ✅ | ✅ | Operativo |

---

## Reglas canon del orquestador

- **Un agente, un repo.** Cada repo tiene su propio agente con su propio `AGENT.md`.
- **El contexto se actualiza en cada cierre.** `CONTEXT.md` refleja el estado real post-sesión.
- **El DEW es la fuente de verdad.** Todos los protocolos y plantillas viven en `yggdrasil-dew/docs/canon/`.
- **Sin AGENT.md no hay sesión.** Si un repo no tiene `AGENT.md`, el orquestador lo crea antes de arrancar.
- **El orquestador no decide.** Coordina y ejecuta. Las decisiones son del humano (Álvaro).
- **THDORA no es el orquestador.** Es un punto de acceso personal, no un componente interno.

---

## Issues relacionados

- [#49 Auditoría isla Orquestador](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49)
- [#79 BOOTSTRAP.md agentes](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/79)

## ADRs relacionados

- ADR-001 — Estructura canón del ecosistema
- ADR-007 — Separación de responsabilidades por repo
- ADR-012 — AGENT.md como contrato de agente

---

_Actualizado: 2026-07-18 01:30 CEST · F24 — THDORA separado, estado repos actualizado · Perplexity-MCP_
