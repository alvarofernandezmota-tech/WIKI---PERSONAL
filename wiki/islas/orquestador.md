---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
ruta: wiki/islas/orquestador.md
tags: [orquestador, agentes, ia, ecosistema, protocolos, mcp]
status: activa
---

# Isla: Orquestador

> El orquestador es el cerebro de arranque del ecosistema Yggdrasil.
> Coordina agentes, carga contexto por repo, ejecuta protocolos de sesion y conecta todos los repos del ecosistema bajo una unica capa de inteligencia.

---

## Que es el orquestador

El orquestador es un sistema (repo propio: `yggdrasil-orquestador`) que:

1. Lee el `AGENT.md` del repo objetivo para conocer su identidad y reglas
2. Lee el `CONTEXT.md` del repo objetivo para conocer su estado actual
3. Carga el `PROTOCOLO-INICIO-SESION` desde `yggdrasil-dew`
4. Ejecuta la sesion de trabajo sobre ese repo
5. Al finalizar, ejecuta `PROTOCOLO-CIERRE-SESION` y actualiza `CONTEXT.md`

**Principio clave:** ningun agente arranca sin haber leido su `AGENT.md` + `CONTEXT.md`. El orquestador lo garantiza.

---

## Arquitectura

```
yggdrasil-orquestador/
  AGENT.md                  <- identidad del orquestador mismo
  CONTEXT.md                <- estado del orquestador
  README.md
  protocols/
    boot.md                 <- protocolo de arranque general
    session.md              <- protocolo de sesion por repo
    shutdown.md             <- protocolo de cierre y commit
  agents/
    dew.md                  <- configuracion agente DEW
    wiki.md                 <- configuracion agente WIKI
    tracking.md             <- configuracion agente TRACKING
    formacion.md            <- configuracion agente FORMACION
    thdora.md               <- configuracion agente THDORA
    madre.md                <- configuracion agente MADRE
```

---

## Flujo de una sesion orquestada

```
[INICIO]
  1. orquestador lee AGENT.md del repo objetivo
  2. orquestador lee CONTEXT.md del repo objetivo
  3. orquestador carga PROTOCOLO-INICIO-SESION desde yggdrasil-dew
  4. agente arranca con contexto completo
  5. sesion de trabajo
[CIERRE]
  6. orquestador ejecuta PROTOCOLO-CIERRE-SESION
  7. orquestador actualiza CONTEXT.md del repo
  8. orquestador hace commit canon con fecha + version
  9. orquestador actualiza MASTER-PENDIENTES en yggdrasil-dew
```

---

## Repos del ecosistema gestionados

| Repo | AGENT.md | CONTEXT.md | Estado |
|---|---|---|---|
| `yggdrasil-dew` | yes | yes | Operativo |
| `yggdrasil-wiki` | yes | yes | Operativo |
| `yggdrasil-tracking` | yes | yes | Operativo |
| `THDORA-PERSONAL` | yes | yes | Operativo |
| `yggdrasil-formacion` | yes | yes | Operativo |
| `madre-config` | pendiente | pendiente | F21 |
| `yggdrasil-secops` | pendiente | pendiente | F21 |
| `ollama-stack` | pendiente | pendiente | F21 |
| `yggdrasil-orquestador` | pendiente | pendiente | F22 |

---

## Reglas canon del orquestador

- **Un agente, un repo.** Cada repo tiene su propio agente con su propio `AGENT.md`.
- **El contexto se actualiza en cada cierre.** `CONTEXT.md` refleja el estado real post-sesion.
- **El DEW es la fuente de verdad.** Todos los protocolos y plantillas viven en `yggdrasil-dew/docs/canon/`.
- **Sin AGENT.md no hay sesion.** Si un repo no tiene `AGENT.md`, el orquestador lo crea antes de arrancar.
- **El orquestador no decide.** Coordina y ejecuta. Las decisiones son del humano (Alvaro).

---

## Issues relacionadas

- [F22 — Crear repo yggdrasil-orquestador](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)
- [F21 — AGENT.md en madre-config, secops, ollama-stack](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

---

## ADRs relacionados

- ADR-001 — Estructura canon del ecosistema
- ADR-007 — Separacion de responsabilidades por repo
- ADR-012 — AGENT.md como contrato de agente

---

_Actualizado: 2026-07-16 — F20 activa — Perplexity MCP_
