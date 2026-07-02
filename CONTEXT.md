---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-07-02T20:30+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-07-02 20:30 CEST** — Sesión noche (iPhone 11) — Fase 0 cerrada en documentación. Prompt Gemini mega-completo listo. Script audit-repo.sh draftado. Inbox: 26 ficheros (necesita procesado con terminal).

---

## 👤 Perfil

Álvaro — ingeniero de sistemas autodidacta · Python · Docker · Linux · IA local · OSINT · homelab

---

## 🗂️ Repos — estado 2026-07-02

| Repo | Priv | Estado | Notas |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ | ✅ activo | Cerebro — Fase 0 documentación completada |
| [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | ✅ | ✅ activo | Tripwire + OSINT defensivo |
| [alvarofernandezmota-tech](https://github.com/alvarofernandezmota-tech) | ❌ | ❌ PENDIENTE CREAR | Profile README — tarea 5 del prompt Gemini |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ❌ | 🔧 handlers pendientes | FastAPI + TOKI |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | ✅ | 🔧 en desarrollo | Ollama + RAG |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | ✅ | 🔧 Kali descargándose | docker-compose listo |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ❌ | ✅ estable | — |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | ❌ | 🟡 mantenimiento | — |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | ❌ | ✅ estable | — |

---

## 🖥️ Hardware

| Máquina | Rol | IP Tailscale | Estado |
|---|---|---|---|
| **Madre** (varpc) | Docker 24/7 + Ollama + AP WiFi | `100.91.112.32` | ✅ |
| **Thdora** (varo12f Acer) | Dev + terminal + Obsidian | `100.86.119.102` | ✅ |
| **iPhone 11** | Control remoto · Perplexity MCP | Tailscale activo | ✅ sesión actual |
| Redmi A5 | Control remoto | ⚠️ Tailscale pendiente | — |
| HP TouchSmart | Dashboard visual | — | ⏳ pendiente |

---

## 🐳 Docker — Madre

### ✅ Stack Fase 1 — HARDENED
| Contenedor | Puerto | Estado |
|---|---|---|
| ollama | 100.91.112.32:11434 | ✅ |
| ollama-embeddings | 100.91.112.32:11435 | ✅ |
| qdrant | 100.91.112.32:6333 | ✅ |
| open-webui | 100.91.112.32:3001 | ✅ |

### ⚠️ Stack batcueva + THDORA — hardening pendiente (0.0.0.0)
| Contenedor | Puerto | Prioridad |
|---|---|---|
| grafana | 0.0.0.0:3000 | 🔴 |
| prometheus | 0.0.0.0:9090 | 🔴 |
| n8n | 0.0.0.0:5678 | 🔴 |
| thdora FastAPI | 0.0.0.0:8000 | 🔴 |
| gitea | 0.0.0.0:3003 | 🟠 |
| code-server | 0.0.0.0:8443 | 🟠 |
| portainer | 0.0.0.0:9000 | 🟠 |
| uptime-kuma | 0.0.0.0:3002 | 🟡 |

---

## 🤖 Modelos Ollama — Madre
| Modelo | Estado |
|---|---|
| qwen2.5:7b | ✅ |
| qwen2.5:3b | ✅ |
| llama3.1:8b | ❌ pendiente pull |
| bge-m3 | ❌ pendiente pull |
| nomic-embed-text | ❌ pendiente pull |

---

## 🤖 Agentes

| Agente | Rol | Estado |
|---|---|---|
| **Perplexity** | Documenta + commits MCP · móvil | ✅ activo |
| **Gemini 2.5 Pro** | Tareas masivas · mega-prompt listo | ✅ listo para lanzar |
| **Claude** | Código + terminal · Cursor pendiente | ⏳ pendiente setup Thdora |
| **Grok** | Investigación + datos frescos | ✅ disponible |
| **TOKI** | Bot Telegram FastAPI | ⚠️ handlers pendientes |
| **Ollama local** | LLM local en Madre | ✅ 2 modelos activos |

---

## 📋 Fases — estado 2026-07-02

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo limpio + docs | 🟡 90% — labels/milestones/actions pendientes (prompt Gemini listo) |
| **1** | Tailscale + red | ✅ 100% |
| **1.5** | Hardening Docker Fase 1 | ✅ done — batcueva pendiente |
| **2** | SSH hardening | ✅ Fase 1 done — avanzado pendiente |
| **3** | Wazuh SIEM | 🔴 0% |
| **4** | Suricata IDS | 🔴 0% |
| **5** | GitHub Actions | 🔴 workflows draftados en inbox |
| **6** | Cursor + MCP Thdora | 🔴 pendiente |
| **7** | Ollama + RAG | 🟡 20% |

---

## 📌 Próximas acciones

### 📱 Ahora — Gemini (copiar prompt del inbox)
```
inbox/2026-07-02-prompt-gemini-fase0-tareas-completas.md
```
Ejecuta tareas 1-7: labels, milestones, CODEOWNERS, CHANGELOG, Profile README, audit-repo.sh, Actions.

### 📱 Mobile-ok — Perplexity (mientras Gemini trabaja)
- Confirmar resultados de Gemini y hacer commit de cierre
- Procesar inbox cuando haya terminal

### 🖥️ Needs-terminal — Thdora (siguiente sesión)
1. `git rm --cached tailscale-full.apk ly && git rm -r --cached .obsidian/`
2. Migraciones estructura (diarios/, osint-stack/, cli-tools/, setup/, thdora/, mocs/)
3. Instalar Cursor + MCP GitHub token
4. Desplegar 3 GitHub Actions workflows del inbox
5. Hardening batcueva Docker (0.0.0.0 → Tailscale IP)
6. Procesar inbox: mover 26 ficheros a docs/ según CONVENCIONES.md

---

## 📚 Reglas de alineación

1. Abrir sesión → leer AGENT.md + CONTEXT.md + MASTER-PENDIENTES.md
2. Cerrar sesión → diario + CONTEXT.md + commit
3. Inbox → máx 10 ficheros · frontmatter obligatorio · con destino
4. Nuevo repo → añadir a CONTEXT.md + ECOSISTEMA.md en mismo commit
5. Nuevo Docker → actualizar tablas CONTEXT.md + ECOSISTEMA.md
6. MASTER-PENDIENTES.md → única fuente de verdad de tareas

---
_Ver: HOME.md · ECOSISTEMA.md · MASTER-PENDIENTES.md_
_Actualizado: 02-jul-2026 20:30 CEST — iPhone 11 · Escalona — Perplexity vía MCP_
