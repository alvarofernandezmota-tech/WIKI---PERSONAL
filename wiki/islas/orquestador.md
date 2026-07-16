---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-16
ruta: wiki/islas/orquestador.md
tags: [isla, orquestador, n8n, automatizacion, agentes, mcp, protocolos]
status: vigente
---

# 🎄 Isla Orquestador

> El tejido conectivo del ecosistema. Orquestador no ejecuta ni almacena — conecta, dispara y coordina.
> Cualquier flujo automático que cruza dos islas pasa por aquí.
> Los protocolos de sesión que gobiernan cómo los agentes trabajan en el ecosistema viven aquí.

---

## Rol en el ecosistema

Orquestador es la isla que hace que el ecosistema se comporte como un sistema, no como una colección de herramientas. Gestiona:

- **Protocolos de sesión** — cómo arrancan y cierran los agentes en cada repo
- **Automatizaciones** — flujos n8n que conectan servicios
- **Agentes IA** — THDORA, Perplexity, Claude actuando sobre el sistema
- **MCP (Model Context Protocol)** — protocolo de contexto para agentes
- **Webhooks y triggers** — eventos que disparan acciones cross-isla

---

## Estructura del ecosistema — 4 repos principales

| Repo | Rol | `AGENT.md` | `CONTEXT.md` | Protocolos |
|---|---|---|---|---|
| [yggdrasil-wiki](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki) | Conocimiento / documentación | ✅ | ✅ | `protocolo/por-repo/yggdrasil-wiki.md` |
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Trabajo activo / issues | ✅ | ✅ | `protocolo/` completo |
| [THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot Telegram + API personal | ✅ | ✅ | `docs/sesiones/` |
| madre-config | Infra / servidores / Docker | ✅ | ✅ | `protocolo/por-repo/madre-config.md` |

---

## Protocolo de inicio de sesión (universal)

Cualquier agente que arranque en el ecosistema:

```
1. Identificar repo objetivo
2. Leer AGENT.md del repo
3. Leer CONTEXT.md del repo
4. Revisar issues abiertos en yggdrasil-dew
5. Verificar bloqueantes (HAL) antes de proponer trabajo
6. Declarar objetivo de sesión
```

→ Protocolo completo: [yggdrasil-dew/protocolo/inicio-sesion.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/protocolo/inicio-sesion.md)

---

## Protocolo de cierre de sesión (universal)

Cualquier agente al terminar:

```
1. Actualizar CONTEXT.md del repo
2. Crear issues en yggdrasil-dew para trabajo pendiente
3. Crear log en docs/sesiones/YYYY-MM-DD.md
4. Actualizar CHANGELOG.md si hubo cambios de código
5. Cerrar issues resueltos con comentario
```

→ Protocolo completo: [yggdrasil-dew/protocolo/cierre-sesion.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/protocolo/cierre-sesion.md)

---

## Servicios en Madre

| Servicio | Puerto | Rol | Estado |
|---|---|---|---|
| n8n | 5678 | Motor de flujos | 🟡 Running, sin auditar |
| thdora-bot | — | Agente Telegram | 🔴 Caído (HAL-007) |
| thdora-api | — | API del bot | 🔴 Caído (HAL-007) |
| Ollama | 11434 | Modelos locales | 🟢 Running |
| Qdrant | 6333 | Vector DB | 🟢 Running |

---

## Automatizaciones

> Pendiente documentar tras AUDIT-003 ([DEW #36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36))

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

## Issues activos

| Issue | Título | Prioridad |
|---|---|---|
| [DEW #44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | HAL-007 — .env THDORA malformado | 🚨 P0 |
| [DEW #45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | HAL-008 — Rotar token Telegram | 🚨 P0 |
| [DEW #36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36) | AUDIT-003 — thdora-personal completo | 🟡 P1 |
| [DEW #42](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/42) | AUDIT-005 — MCP/agentes | 🟡 P1 |

---

## Próximos pasos

1. **Cerrar HAL-007 (#44)** → corregir `.env` → desbloquea thdora-bot + thdora-api
2. **Cerrar HAL-008 (#45)** → rotar token Telegram en Vaultwarden
3. **Ejecutar AUDIT-003 (#36)** → auditoría completa THDORA-PERSONAL
4. **Ejecutar AUDIT-005 (#42)** → consolidar documentación MCP/agentes
5. **Documentar flujos n8n** → actualizar sección automatizaciones de esta isla

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
