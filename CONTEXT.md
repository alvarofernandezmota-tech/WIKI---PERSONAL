---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-06-28T22:47+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Debe estar SIEMPRE alineado con MASTER-PENDIENTES, ESTADO-SISTEMA y ECOSISTEMA.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-06-28 22:47 CEST** — Sesión noche iPhone — auditoría completa repo + alineación total

---

## 👤 Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

---

## 🗂️ Repos del ecosistema — estado REAL

| Repo | Privado | Estado | Notas |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ | ✅ activo | Último commit 28-jun 22:47 |
| [personal](https://github.com/alvarofernandezmota-tech/personal) | ❌ | ✅ activo | — |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ❌ | 🔧 handlers pendientes | FastAPI + bot corriendo en Docker |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | ✅ | 🔧 en desarrollo | Ollama, RAG, Qdrant |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | ✅ | 🔧 en desarrollo | `docker-compose.kali.yml` listo |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ❌ | ✅ estable | — |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | ❌ | 🟡 mantenimiento | — |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | ❌ | ✅ estable | — |
| [impresion-3d](https://github.com/alvarofernandezmota-tech/impresion-3d) | ❌ | ✅ estable | — |

**Pendientes crear:** `chatbot-control` · `terminal-ia`

---

## 🖥️ Hardware

| Máquina | Hostname | Rol | IP Tailscale | Estado |
|---|---|---|---|---|
| PC torre | **varpc (Madre)** | Servidor Docker + Ollama + AP WiFi | `100.91.112.32` | ✅ encendida |
| Portátil | **varo12f (theodora/Acer)** | Dev + Obsidian | `100.86.119.102` | ✅ activo |
| Móvil Android | Redmi A5 | Control remoto + Telegram | ⚠️ Tailscale pendiente | Sesión actual |
| Móvil iPhone | iPhone | Control remoto remoto | ⚠️ Tailscale + Termius pendiente | — |

---

## 🐳 Docker — Madre

### ✅ 13 contenedores HEALTHY (desde 25-jun-2026)

| Contenedor | Puerto | Estado |
|---|---|---|
| ollama | 11434 | ✅ healthy |
| ollama-embeddings | 11435 | ✅ healthy |
| open-webui | 3001 | ✅ healthy |
| qdrant | 6333 | ✅ healthy |
| uptime-kuma | 3002 | ✅ healthy |
| thdora | 8000 | ✅ healthy |
| thdora-bot | — | ✅ healthy |
| grafana | 3000 | ✅ up |
| prometheus | 9090 | ✅ up |
| portainer | 9000 | ✅ up |
| code-server | 8443 | ✅ up |
| n8n | 5678 | ✅ up |
| gitea | 3003 | ✅ up |

### ⏳ Pendiente levantar
- Kali Desktop (6901) · SpiderFoot (5001) · Bettercap · Wazuh · Suricata · PiHole
- **Bloqueado:** Fase 9 (pentest/OSINT) requiere Fase 1 completada primero

---

## 🤖 Ollama — Madre

| Modelo | Estado |
|---|---|
| qwen2.5-coder:7b | ✅ descargado (4.7GB) |
| qwen2.5:3b | ✅ descargado (1.9GB) |
| llama3.1:8b | ❌ pendiente pull |
| bge-m3 | ❌ pendiente pull |
| nomic-embed-text | ❌ pendiente pull |

---

## 🌐 Red — estado REAL

| Servicio | Estado | Detalle |
|---|---|---|
| MadreAP (hostapd) | ✅ activo | SSID: MadreAP · WPA2 · canal 6 |
| dnsmasq DHCP wlan0 | ✅ activo | `192.168.72.50-150` · 12h lease |
| Tailscale Madre | ✅ activo | `100.91.112.32` |
| Tailscale Acer | ✅ activo | `100.86.119.102` |
| Tailscale Redmi A5 | ❌ pendiente | Play Store |
| Tailscale iPhone | ❌ pendiente | App Store |
| fail2ban sshd | ✅ activo | Madre + Acer · maxretry:5 · bantime:86400 |
| UFW Madre | ✅ activo | Reglas completas wlan0 + tailscale0 |
| UFW Acer | ✅ activo | — |
| SSH hardening | ⚠️ documentado, no aplicado | PasswordAuthentication pendiente |
| Driver RTL8188FTV | ⚠️ inestable | AP cae solo — fix pendiente modprobe.d |

---

## 📱 iPhone — cómo entrar en la red

```
1. App Store → Tailscale → instalar → login
2. App Store → Termius → nuevo host 100.91.112.32 usuario varopc
→ terminal completa en Madre desde iPhone
```

---

## 📋 Plan de fases — estado 28-jun

| Fase | Nombre | Estado |
|---|---|---|
| 0 | Repo y docs | 🟡 95% — solo falta git pull en Madre |
| 1 | Seguridad red | 🔴 0% — **PRÓXIMA SESIÓN** |
| 2 | Script start-batcueva.sh | 🔴 0% |
| 3 | Backup Restic | 🔴 0% |
| 4 | Monitorización completa | 🟡 50% |
| 5 | Seguridad avanzada | 🔴 0% |
| 6 | Handlers THDORA | 🔴 0% |
| 7 | Modelos Ollama + RAG | 🔴 20% |
| 8 | Seguridad Acer | 🔴 0% |
| 9 | Pentest + OSINT real | 🔴 0% — bloqueado hasta Fase 1 |

---

## 🤖 Agentes activos

| Agente | Rol | Estado |
|---|---|---|
| Perplexity | Documenta en tiempo real vía MCP GitHub | ✅ activo |
| Claude Sonnet 4.6 | Ejecuta con MCP, código, commits | ✅ listo |
| Gemini 2.5 Pro | Auditorías masivas, vaciado inbox | ✅ listo |
| TOKI (thdora) | Bot Telegram — FastAPI | ⚠️ handlers pendientes |
| Ollama local | LLM local en Madre | ✅ 2 modelos listos |

---

## 📌 Próxima acción

1. **Ahora desde iPhone** → instalar Tailscale + Termius
2. **Próxima sesión** → Fix RTL8188FTV + git pull + **Fase 1 completa**
3. **Esta semana** → Modelos Ollama + THDORA handlers + Fase 2

---

## 📚 Reglas de alineación

1. **Al abrir sesión** — leer CONTEXT.md antes de hacer nada
2. **Al cerrar sesión** — actualizar CONTEXT.md + diario del día
3. **Inbox** — máx 10 archivos · cada archivo nuevo tiene wikilink al diario del día
4. **Nuevo repo** — añadir a CONTEXT.md + ECOSISTEMA.md en el mismo commit
5. **Nuevo Docker** — actualizar tabla fases en CONTEXT.md + ECOSISTEMA.md
6. **MASTER-PENDIENTES** — es la única lista de tareas · no duplicar en otros sitios

---
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[ESTADO-SISTEMA]] · [[MASTER-PENDIENTES]] · [[filosofia]]_
_Actualizado: 28 jun 2026 22:47 CEST — Perplexity vía MCP_
