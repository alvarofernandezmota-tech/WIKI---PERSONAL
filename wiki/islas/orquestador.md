---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-13
ruta: wiki/islas/orquestador.md
tags: [isla, orquestador, n8n, automatizacion, agentes, mcp]
status: vigente
---

# 🎼 Isla Orquestador

> El tejido conectivo del ecosistema. Orquestador no ejecuta ni almacena — conecta, dispara y coordina.
> Cualquier flujo automático que cruza dos islas pasa por aquí.

---

## Rol en el ecosistema

Orquestador es la isla que hace que el ecosistema se comporte como un sistema, no como una colección de herramientas. Gestiona:

- **Automatizaciones** — flujos n8n que conectan servicios
- **Agentes IA** — THDORA, Perplexity, Claude actuando sobre el sistema
- **MCP (Model Context Protocol)** — protocolo de contexto para agentes
- **Webhooks y triggers** — eventos que disparan acciones cross-isla

---

## Repos

| Repo | Rol | Estado |
|---|---|---|
| [n8n](https://github.com/alvarofernandezmota-tech) (en Madre) | Motor de automatizaciones | 🟡 Running, sin auditar |
| [THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot IA orquestador personal | 🔴 Caído |

---

## Servicios en Madre

| Servicio | Puerto | Rol | Estado |
|---|---|---|---|
| n8n | 5678 | Motor de flujos | 🟡 Running |
| thdora-bot | — | Agente Telegram | 🔴 Caído (HAL-007) |
| thdora-api | — | API del bot | 🔴 Caído (HAL-007) |

---

## Automatizaciones activas

> Pendiente de documentar tras AUDIT-003 ([DEW #36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36))

- [ ] Flujos n8n activos — listar y documentar
- [ ] Webhooks de THDORA — qué eventos dispara
- [ ] Integraciones Telegram activas

---

## Dependencias

| Depende de | Por qué |
|---|---|
| 🏗️ Infra (Madre) | n8n y thdora corren en Madre |
| 🧬 IA Local | Modelos locales que THDORA puede invocar |
| 🛡️ Seguridad | Token Telegram gestionado por Vaultwarden |

---

## Issues relacionados

- [DEW #36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36) — AUDIT-003 thdora-personal
- [DEW #42](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/42) — AUDIT-005 consolidar agentes/ y MCP
- [DEW #44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) — HAL-007 .env malformado (bloquea thdora)
- [DEW #45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) — HAL-008 rotar token Telegram

---

## Próximos pasos

1. Cerrar HAL-007 (#44) y HAL-008 (#45) → desbloquea thdora-bot
2. Ejecutar AUDIT-003 (#36) → auditoría completa del repo
3. Ejecutar AUDIT-005 (#42) → consolidar documentación MCP/agentes
4. Documentar flujos n8n activos en esta ficha

---

_Creado: 2026-07-13 · Perplexity-MCP_
