---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-07-01T19:51+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Debe estar SIEMPRE alineado con MASTER-PENDIENTES, ESTADO-SISTEMA y ECOSISTEMA.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-07-01 19:51 CEST** — Sesión tarde — Hardening Docker completo fase1 + satélite yggdrasil-secops creado

---

## 👤 Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

---

## 🗂️ Repos del ecosistema — estado REAL

| Repo | Privado | Estado | Notas |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ | ✅ activo | Cerebro + infra |
| [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | ✅ | ✅ nuevo 01-jul | Tripwire + OSINT defensivo |
| [personal](https://github.com/alvarofernandezmota-tech/personal) | ❌ | ✅ activo | — |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ❌ | 🔧 handlers pendientes | FastAPI + bot |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | ✅ | 🔧 en desarrollo | Ollama + RAG + Qdrant |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | ✅ | 🔧 Kali descargándose | docker-compose.kali.yml listo |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ❌ | ✅ estable | — |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | ❌ | 🟡 mantenimiento | — |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | ❌ | ✅ estable | — |

---

## 🖥️ Hardware

| Máquina | Hostname | Rol | IP Tailscale | Estado |
|---|---|---|---|---|
| PC torre | **varpc (Madre)** | Servidor Docker + Ollama + AP WiFi | `100.91.112.32` | ✅ encendida |
| Portátil | **varo12f (Acer)** | Dev + Obsidian | `100.86.119.102` | ✅ activo |
| Móvil Android | Redmi A5 | Control remoto | ⚠️ Tailscale pendiente | — |
| Móvil iPhone | iPhone | Control remoto | ⚠️ Tailscale + Termius pendiente | — |

---

## 🐳 Docker — Madre — ESTADO 2026-07-01

### ✅ Stack Fase 1 — HARDENED (puertos Tailscale only)

| Contenedor | Puerto | Estado |
|---|---|---|
| ollama | 100.91.112.32:11434 | ✅ healthy |
| ollama-embeddings | 100.91.112.32:11435 | ✅ healthy |
| qdrant | 100.91.112.32:6333 | ✅ healthy |
| open-webui | 100.91.112.32:3001 | ✅ healthy |

### ⚠️ Stack batcueva + THDORA — AÚN 0.0.0.0 — HARDENING PENDIENTE

| Contenedor | Puerto actual | Prioridad |
|---|---|---|
| grafana | 0.0.0.0:3000 | 🔴 alta |
| prometheus | 0.0.0.0:9090 | 🔴 alta |
| n8n | 0.0.0.0:5678 | 🔴 alta |
| gitea | 0.0.0.0:3003 | 🟠 media |
| code-server | 0.0.0.0:8443 | 🟠 media |
| portainer | 0.0.0.0:9000 | 🟠 media |
| uptime-kuma | 0.0.0.0:3002 | 🟡 baja |
| thdora | 0.0.0.0:8000 | 🔴 alta |

### ⏳ Pendiente levantar
- Kali Desktop (6901) · SpiderFoot (5001) — Kali descargándose en tmux

---

## 🤖 Ollama — Madre

| Modelo | Estado |
|---|---|
| qwen2.5:7b | ✅ descargado |
| qwen2.5:3b | ✅ descargado |
| llama3.1:8b | ❌ pendiente pull |
| bge-m3 | ❌ pendiente pull |
| nomic-embed-text | ❌ pendiente pull |

---

## 🌐 Red — estado REAL

| Servicio | Estado |
|---|---|
| MadreAP (hostapd) | ✅ activo |
| Tailscale Madre | ✅ 100.91.112.32 |
| Tailscale Acer | ✅ 100.86.119.102 |
| fail2ban sshd | ✅ activo ambas máquinas |
| UFW Madre | ✅ activo — reglas Fase 1 |
| SSH hardening | ✅ Fase 1 completada |

---

## 📋 Plan de fases — 2026-07-01

| Fase | Nombre | Estado |
|---|---|---|
| 0 | Repo y docs | ✅ 100% |
| 1 | Seguridad red | ✅ 100% |
| 1.5 | Hardening puertos Docker | ✅ fase1 HOY — resto pendiente |
| 2 | start-batcueva.sh | 🟡 50% |
| 3 | Backup Restic | 🟡 30% |
| 4 | Monitoring completo | 🟡 50% |
| 5 | Seguridad avanzada | 🔴 0% |
| 6 | Handlers THDORA | 🟡 30% |
| 7 | Modelos Ollama + RAG | 🟡 20% |
| 8 | Seguridad Acer | 🟡 30% |
| 9 | Pentest + OSINT real | 🟡 20% |

---

## 🤖 Agentes activos

| Agente | Rol | Estado |
|---|---|---|
| Perplexity | Documenta en tiempo real vía MCP GitHub | ✅ activo |
| Claude | Ejecuta con MCP, código, commits | ✅ listo |
| Gemini 2.5 Pro | Auditorías masivas — prompt listo en inbox | ✅ listo para lanzar |
| TOKI (thdora) | Bot Telegram — FastAPI | ⚠️ handlers pendientes |
| Ollama local | LLM local en Madre | ✅ 2 modelos listos |

---

## 📌 Próximas acciones prioritarias

1. **Lanzar Gemini** con `inbox/GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md`
2. **Hardening batcueva + THDORA** — aplicar sed a fases 2+3 y compose THDORA
3. **Pull modelos** — `bash scripts/05-fase7-ollama-pull.sh`
4. **Restic backup** — configurar `.env.restic` + ejecutar script 07
5. **THDORA handlers** — wiring completo con script 08

---

## 📚 Reglas de alineación

1. **Al abrir sesión** — leer CONTEXT.md antes de hacer nada
2. **Al cerrar sesión** — actualizar CONTEXT.md + diario del día
3. **Inbox** — máx 10 archivos · wikilink al diario del día
4. **Nuevo repo** — añadir a CONTEXT.md + ECOSISTEMA.md mismo commit
5. **Nuevo Docker** — actualizar tabla en CONTEXT.md + ECOSISTEMA.md
6. **MASTER-PENDIENTES** — única lista de tareas, no duplicar

---
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[ESTADO-SISTEMA]] · [[MASTER-PENDIENTES]]_
_Actualizado: 01 jul 2026 19:51 CEST — Perplexity vía MCP_
