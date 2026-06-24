---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-06-24T22:26+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Debe estar SIEMPRE alineado con inbox/MASTER-PENDIENTES y ESTADO-SISTEMA.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-06-24 22:26 CEST** — Sesión noche móvil — alineación completa repos + Docker + inbox

---

## 👤 Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

---

## 🗂️ Repos del ecosistema — estado REAL

| Repo | Privado | Estado | Último commit |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ | ✅ activo | 24 jun 22:26 |
| [personal](https://github.com/alvarofernandezmota-tech/personal) | ❌ | ✅ activo | 24 jun 02:19 |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ❌ | 🔧 handlers pendientes | 24 jun 03:12 |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | ✅ | ⚠️ creado, README pendiente | 24 jun 03:13 |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | ✅ | ⚠️ creado, README pendiente | 24 jun 03:13 |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ❌ | ✅ estable | 16 jun |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | ❌ | 🟡 mantenimiento | feb 2026 |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | ❌ | ✅ estable | abr 2026 |
| [impresion-3d](https://github.com/alvarofernandezmota-tech/impresion-3d) | ❌ | ✅ estable | may 2026 |

**Pendientes crear:** `ollama-stack` · `chatbot-control` · `terminal-ia`

---

## 🖥️ Hardware

| Máquina | Nombre | Rol | Estado |
|---|---|---|---|
| PC torre | Madre | Servidor Docker + Ollama | 🟡 encendida, sin verificar esta noche |
| Portátil | varopc / Acer | Dev + Obsidian | ✅ activo |
| Móvil | Redmi A5 | Control remoto + thdora | ✅ activo (sesión actual) |

---

## 🐳 Docker — Madre

**37 imágenes descargadas** (verificado 24 jun 19:00). Stack completo listo.

| Fase | Contenedores | Estado |
|---|---|---|
| Fase 1 — Base IA | ollama, open-webui, qdrant | ⚠️ pendiente `docker compose up` |
| Fase 2 — Gateway | litellm, nginx-pm | ⚠️ pendiente |
| Fase 3 — Productividad | n8n, gitea, paperless, vaultwarden | ⚠️ pendiente |
| Fase 4 — Monitorización | portainer, uptime-kuma, grafana | ⚠️ pendiente |
| Fase 5 — Seguridad | fail2ban, crowdsec, traefik, vault | ⚠️ pendiente |
| Fase 6 — OSINT | searxng, perplexica, pihole | ⚠️ pendiente |

> Ver compose files: [[setup/servidor/README]]

---

## 🤖 Ollama — Madre

| Modelo | Estado |
|---|---|
| qwen2.5:3b | ✅ listo |
| qwen2.5:7b | ✅ listo |
| qwen2.5:14b | ✅ listo |
| llama3.1:8b | ❌ pendiente ~4.7GB |
| mistral:7b | ❌ pendiente ~4.1GB |
| bge-m3 | ❌ pendiente ~1.2GB |
| nomic-embed-text | ❌ pendiente ~0.3GB |

---

## 📥 Inbox — estado REAL

- ⚠️ **~100 archivos** pendientes de migrar a carpetas definitivas
- ✅ Script migración generado — ejecutar `bash migrate-inbox.sh` desde PC
- ✅ `MASTER-PENDIENTES.md` actualizado 22:17
- Regla: inbox = zona de paso · máx 10 archivos · se vacía cada sesión

---

## 🤖 Agentes activos

| Agente | Rol | Estado |
|---|---|---|
| Perplexity | Documenta en tiempo real, MCP GitHub | ✅ activo |
| Claude Sonnet 4.6 | Ejecuta con MCP, código, commits | ✅ listo |
| Gemini 2.5 Pro | Auditorías masivas, vaciado inbox | ✅ listo |
| TOKI (thdora) | Bot Telegram | ⚠️ handlers pendientes |
| Ollama local | LLM local en Madre | ✅ 3 modelos listos |

---

## 🔐 Red

| Servicio | Estado |
|---|---|
| Tailscale varopc | ✅ activo (100.86.119.102) |
| Tailscale Madre | ⚠️ pendiente systemctl enable |
| SSH Madre→varopc sin pass | ⚠️ pendiente |
| UFW Madre | ⚠️ pendiente activar |

---

## 📋 Próxima acción

1. **Desde móvil ahora** → thdora handlers con Perplexity
2. **Al llegar al PC** → `bash migrate-inbox.sh`
3. **Verificar Madre** → `ollama list && docker images`
4. **Levantar fases** → `docker compose up -d` por orden

---

## 📚 Reglas de alineación (NUEVO)

> Estas reglas evitan que CONTEXT, ECOSISTEMA y el inbox se desincronicen.

1. **Al abrir sesión** — leer CONTEXT.md antes de hacer nada
2. **Al cerrar sesión** — actualizar CONTEXT.md + diario del día
3. **Inbox** — máx 10 archivos · cada archivo nuevo tiene wikilink al diario del día
4. **Nuevo repo** — añadir a CONTEXT.md + ECOSISTEMA.md en el mismo commit
5. **Nuevo Docker** — actualizar tabla fases en CONTEXT.md + ECOSISTEMA.md
6. **MASTER-PENDIENTES** — es la única lista de tareas · no duplicar en otros sitios

---
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[ESTADO-SISTEMA]] · [[inbox/MASTER-PENDIENTES]] · [[filosofia]]_
