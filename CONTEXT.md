---
tags: [contexto, estado, sistema, agentes]
fecha-actualizacion: 2026-06-30T04:41+02:00
revision: cada-sesion
ruta-obsidian: CONTEXT.md
---

# CONTEXT.md — Estado actual del sistema

> ⚠️ ARCHIVO CRÍTICO — los agentes leen esto para entender el ecosistema.
> Debe estar SIEMPRE alineado con MASTER-PENDIENTES, ESTADO-SISTEMA y ECOSISTEMA.
> Actualizar al inicio Y al final de cada sesión importante.

---

## 🕐 Última actualización

**2026-06-30 04:41 CEST** — Sesión noche móvil — Fase 1 completada + reboot ejecutado + scripts 07-10 creados

---

## 👤 Perfil del dueño

Álvaro — dev Python · pentest Linux · ingeniero IA local · homelab

---

## 🗂️ Repos del ecosistema — estado REAL

| Repo | Privado | Estado | Notas |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ❌ | ✅ activo | Último commit 30-jun 04:41 |
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
| PC torre | **varpc (Madre)** | Servidor Docker + Ollama + AP WiFi | `100.91.112.32` | ✅ encendida · post-reboot Fase 1 |
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

> ⚠️ Pendiente verificar post-reboot Fase 1 que todos siguen healthy (bash 06-verificacion-post-reboot.sh)

### ⏳ Pendiente levantar
- Kali Desktop (6901) · SpiderFoot (5001) · Bettercap · Wazuh · Suricata · PiHole
- **Fase 9** requiere verificación Fase 1 completa en Madre

---

## 🤖 Ollama — Madre

| Modelo | Estado |
|---|---|
| qwen2.5-coder:7b | ✅ descargado (4.7GB) |
| qwen2.5:3b | ✅ descargado (1.9GB) |
| llama3.1:8b | ❌ pendiente pull — script 05 listo |
| bge-m3 | ❌ pendiente pull — script 05 listo |
| nomic-embed-text | ❌ pendiente pull — script 05 listo |

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
| UFW Madre | ✅ activo | Reglas completas wlan0 + tailscale0 · Fase 1 ✅ |
| UFW Acer | ✅ activo | — |
| SSH hardening | ✅ Fase 1 ejecutada | PasswordAuthentication — Fase 1 completada 28-jun |
| Driver RTL8188FTV | ⚠️ inestable | fix modprobe.d pendiente verificar post-reboot (script 01) |

---

## 📱 iPhone — cómo entrar en la red

```
1. App Store → Tailscale → instalar → login
2. App Store → Termius → nuevo host 100.91.112.32 usuario varopc
→ terminal completa en Madre desde iPhone
```

---

## 📋 Plan de fases — estado 30-jun-2026

| Fase | Nombre | Estado |
|---|---|---|
| 0 | Repo y docs | ✅ 100% — docs + scripts + CONTEXT actualizados |
| 1 | Seguridad red | ✅ 100% — SSH + UFW + Tailscale + suspensión + reboot ejecutado |
| 2 | Script start-batcueva.sh | 🟡 50% — script 04 listo, pendiente ejecutar y verificar en Madre |
| 3 | Backup Restic | 🟡 30% — script 07 listo, pendiente configurar .env.restic + ejecutar |
| 4 | Monitorización completa | 🟡 50% — stack up, dashboards y webhook THDORA pendientes |
| 5 | Seguridad avanzada | 🔴 0% — SOPS, rootless Docker, VLANs pendientes |
| 6 | Handlers THDORA | 🟡 30% — script 08 listo, wiring handlers pendiente |
| 7 | Modelos Ollama + RAG | 🟡 20% — script 05 listo, pull pendiente en Madre |
| 8 | Seguridad Acer | 🟡 30% — script 09 listo, ejecutar en theodora |
| 9 | Pentest + OSINT real | 🟡 20% — script 10 listo, Fase 1 ✅ desbloqueada |

---

## 📁 Scripts disponibles en scripts/

| Script | Fase | Estado |
|---|---|---|
| `01-fix-driver-rtl8188ftu.sh` | Fix AP WiFi | ✅ listo |
| `02-git-pull-rebase.sh` | Sync repo | ✅ listo |
| `03-fase1-seguridad.sh` | Fase 1 | ✅ ejecutado 28-jun |
| `04-fase2-start-batcueva.sh` | Fase 2 | ✅ listo — pendiente ejecutar |
| `05-fase7-ollama-pull.sh` | Fase 7 | ✅ listo — pendiente ejecutar |
| `06-verificacion-post-reboot.sh` | Verificación | ✅ listo — ejecutar al entrar en Madre |
| `07-fase3-restic-backup.sh` | Fase 3 | ✅ creado 30-jun — pendiente .env.restic |
| `08-fase6-thdora-handlers.sh` | Fase 6 | ✅ creado 30-jun — pendiente wiring |
| `09-fase8-seguridad-acer.sh` | Fase 8 | ✅ creado 30-jun — ejecutar en Acer |
| `10-fase9-osint-stack.sh` | Fase 9 | ✅ creado 30-jun — pendiente docker-compose reales |

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

## 📌 Próximas acciones (al entrar en Madre)

1. `bash 06-verificacion-post-reboot.sh` — verificar estado post-reboot Fase 1
2. `bash 01-fix-driver-rtl8188ftu.sh` — estabilizar AP MadreAP
3. `bash 04-fase2-start-batcueva.sh` — levantar batcueva Docker
4. `bash 05-fase7-ollama-pull.sh` — descargar llama3.1:8b + bge-m3 + nomic-embed-text
5. Configurar `.env.restic` → `bash 07-fase3-restic-backup.sh`
6. Wiring THDORA handlers → `bash 08-fase6-thdora-handlers.sh`
7. En Acer: `bash 09-fase8-seguridad-acer.sh`

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
_Actualizado: 30 jun 2026 04:41 CEST — Perplexity vía MCP_
