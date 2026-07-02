---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-07-02T20:23+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-07-02 20:23 CEST** — Sesión noche (iPhone 11 · Escalona) — Fase 0: CONVENCIONES reescrito + AGENT.md + CONTRIBUTING.md + auditoría herramientas GitHub

---

## 👤 Perfil del dueño

Álvaro — ingeniero de sistemas autodidacta · Python · Docker · Linux · IA local · OSINT · homelab

---

## 🗂️ Repos del ecosistema — estado REAL

| Repo | Privado | Estado | Notas |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ público | ✅ activo | Cerebro + infra + docs — Fase 0 en progreso |
| [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | ✅ | ✅ activo | Tripwire + OSINT defensivo |
| [alvarofernandezmota-tech](https://github.com/alvarofernandezmota-tech) | ❌ | ❌ pendiente crear | Profile README — Fase 0 pendiente |
| [personal](https://github.com/alvarofernandezmota-tech/personal) | ❌ | ✅ activo | Histórico |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ❌ | 🔧 handlers pendientes | FastAPI + bot TOKI |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | ✅ | 🔧 en desarrollo | Ollama + RAG + Qdrant |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | ✅ | 🔧 Kali descargándose | docker-compose.kali.yml listo |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ❌ | ✅ estable | — |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | ❌ | 🟡 mantenimiento | — |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | ❌ | ✅ estable | — |

---

## 🖥️ Hardware

| Máquina | Hostname | Rol | IP Tailscale | Estado |
|---|---|---|---|---|
| PC torre | **Madre** (varpc) | Servidor Docker 24/7 + Ollama + AP WiFi | `100.91.112.32` | ✅ encendida |
| Portátil Acer | **Thdora** (varo12f) | Dev + Obsidian + terminal | `100.86.119.102` | ✅ disponible |
| iPhone 11 | móvil | Control remoto · Perplexity MCP | Tailscale activo | ✅ activo (sesión actual) |
| Redmi A5 | Android | Control remoto | ⚠️ Tailscale pendiente | — |
| HP TouchSmart | HP | Dashboard / visualización | — | ⏳ pendiente configurar |

---

## 🐳 Docker — Madre — estado 2026-07-02

### ✅ Stack Fase 1 — HARDENED (puertos Tailscale only)

| Contenedor | Puerto | Estado |
|---|---|---|
| ollama | 100.91.112.32:11434 | ✅ healthy |
| ollama-embeddings | 100.91.112.32:11435 | ✅ healthy |
| qdrant | 100.91.112.32:6333 | ✅ healthy |
| open-webui | 100.91.112.32:3001 | ✅ healthy |

### ⚠️ Stack batcueva + THDORA — hardening pendiente

| Contenedor | Puerto actual | Prioridad |
|---|---|---|
| grafana | 0.0.0.0:3000 | 🔴 alta |
| prometheus | 0.0.0.0:9090 | 🔴 alta |
| n8n | 0.0.0.0:5678 | 🔴 alta |
| thdora (FastAPI) | 0.0.0.0:8000 | 🔴 alta |
| gitea | 0.0.0.0:3003 | 🟠 media |
| code-server | 0.0.0.0:8443 | 🟠 media |
| portainer | 0.0.0.0:9000 | 🟠 media |
| uptime-kuma | 0.0.0.0:3002 | 🟡 baja |

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

## 🌐 Red — estado

| Servicio | Estado |
|---|---|
| MadreAP (hostapd r8852be) | ✅ activo |
| Tailscale Madre | ✅ 100.91.112.32 |
| Tailscale Thdora | ✅ 100.86.119.102 |
| Tailscale iPhone | ✅ activo |
| fail2ban sshd | ✅ activo ambas máquinas |
| UFW Madre | ✅ activo — reglas Fase 1 |
| SSH hardening | ✅ Fase 1 completada |

---

## 🤖 Agentes activos

| Agente | Rol | MCP | Estado |
|---|---|---|---|
| **Perplexity** | Principal · docs · repo · móvil | ✅ Space yggdrasil | ✅ activo |
| **Claude** | Código · arquitectura · terminal | ✅ Cursor (pendiente Thdora) | ⏳ pendiente setup |
| **Gemini 2.5 Pro** | Auditorías masivas · contexto grande | ❌ | ✅ listo para lanzar |
| **Grok** | Datos frescos · investigación | ❌ | ✅ disponible |
| **TOKI** | Bot Telegram · FastAPI | — | ⚠️ handlers pendientes |
| **Ollama local** | LLM local en Madre | local | ✅ 2 modelos activos |

---

## 📋 Plan de fases — estado 2026-07-02

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo limpio + documentado | 🟡 85% — migración estructura + herramientas GitHub pendientes |
| **1** | Tailscale + red segura | ✅ 100% |
| **1.5** | Hardening puertos Docker | ✅ Fase 1 done — batcueva pendiente |
| **2** | SSH hardening completo | 🔴 pendiente |
| **3** | Wazuh SIEM | 🟡 en progreso |
| **4** | Suricata IDS | 🟡 en progreso |
| **5** | GitHub Actions automatización | 🔴 no iniciado — workflows draftados en inbox |
| **6** | Cursor + MCP Thdora | 🔴 pendiente |
| **7** | Ollama agentes + RAG | 🟡 20% (modelos base listos) |

---

## 📌 Próximas acciones prioritarias

### Mobile-ok (ahora mismo — Perplexity)
1. Crear repo público `alvarofernandezmota-tech` con Profile README
2. Crear labels personalizados en yggdrasil-dew (ver inbox 2026-07-02-auditoria-herramientas-github.md)
3. Crear milestones Fase 0 y Fase 2
4. Crear `.github/CODEOWNERS` y `.github/PULL_REQUEST_TEMPLATE.md`
5. Actualizar CHANGELOG.md con formato Keep a Changelog

### Needs-terminal (Thdora)
1. `git rm --cached tailscale-full.apk ly && git rm -r --cached .obsidian/`
2. `git mv diarios/ docs/diarios/` + mover osint-stack/, cli-tools/, setup/, thdora/, mocs/
3. Instalar Cursor + configurar MCP GitHub con token
4. Desplegar GitHub Actions workflows (lint-commits, update-diario-index, context-reminder)
5. Configurar branch protection en Settings
6. Hardening batcueva Docker (pasar de 0.0.0.0 a Tailscale IP)

---

## 📚 Reglas de alineación

1. Abrir sesión → leer AGENT.md + CONTEXT.md + MASTER-PENDIENTES.md
2. Cerrar sesión → diario + CONTEXT.md + inbox procesado + commit
3. Inbox → máx 10 ficheros · siempre con frontmatter + destino
4. Nuevo repo → añadir a CONTEXT.md + ECOSISTEMA.md en mismo commit
5. Nuevo Docker → actualizar tabla CONTEXT.md + ECOSISTEMA.md
6. MASTER-PENDIENTES.md → única lista de tareas, no duplicar en diarios

---
_Ver: HOME.md · ECOSISTEMA.md · ESTADO-SISTEMA.md · MASTER-PENDIENTES.md_
_Actualizado: 02-jul-2026 20:23 CEST — iPhone 11 — Perplexity vía MCP_
