---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-06-27
hora: 03:56
---

# 📊 ESTADO DEL SISTEMA — 27 jun 2026 (03:56)

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **Madre** | ✅ encendida y accesible | SSH OK · AP MadreAP activo · Tailscale activo |
| **Acer (theodora)** | ✅ operativo | Conectado a MadreAP `192.168.72.26` |
| **Redmi A5** | ✅ activo | Tailscale pendiente instalar desde Play Store |

---

## 🛜 Red — Estado RESUELTO ✅

| Servicio | Estado | Detalle |
|---|---|---|
| Tailscale madre | ✅ activo | `100.91.112.32` |
| Tailscale varopc | ✅ activo | — |
| **MadreAP (hostapd)** | ✅ activo | SSID: MadreAP · WPA2 · canal 6 |
| **DHCP wlan0** | ✅ activo | `192.168.72.1/24` · pool .10-.60 |
| **NAT/IPMasquerade** | ✅ activo | Clientes WiFi tienen internet |
| **UFW** | ✅ activo | Reglas wlan0 permanentes |
| SSH hardening | ⚠️ documentado, no aplicado | — |

---

## 🐳 Docker — Estado Madre

### Stack completo — 13 CONTENEDORES HEALTHY ✅

| Contenedor | Puerto | Estado |
|---|---|---|
| `ollama` | 11434 | ✅ healthy |
| `ollama-embeddings` | 11435 | ✅ healthy |
| `open-webui` | 3001 | ✅ healthy |
| `qdrant` | 6333 | ✅ healthy |
| `uptime-kuma` | 3002 | ✅ healthy |
| `thdora` | 8000 | ✅ healthy |
| `thdora-bot` | — | ✅ healthy |
| `grafana` | 3000 | ✅ up |
| `prometheus` | 9090 | ✅ up |
| `portainer` | 9000 | ✅ up |
| `code-server` | 8443 | ✅ up |
| `n8n` | 5678 | ✅ up |
| `gitea` | 3003 | ✅ up |

### Modelos Ollama

| Modelo | Estado |
|---|---|
| `qwen2.5-coder:7b` | ✅ descargado (4.7GB) |
| `qwen2.5:3b` | ✅ descargado (1.9GB) |
| `llama3.1:8b` | ❌ pendiente pull |
| `bge-m3` | ❌ pendiente pull |
| `nomic-embed-text` | ❌ pendiente pull |

---

## 🔐 SSH

| Conexión | Estado |
|---|---|
| varopc → Madre | ✅ sin contraseña |
| Madre → GitHub | ✅ sin passphrase (id_ed25519_github) |

---

## 🗂️ Git — Estado repos

| Repo | Estado |
|---|---|
| yggdrasil-dew (GitHub) | ✅ sincronizado |
| yggdrasil-dew (Madre) | ⚠️ pendiente `git pull --rebase` |
| thdora | 🔧 pendiente handlers |

---

## 📥 Inbox — Estado

| Fichero | Estado |
|---|---|
| `2026-06-25-auditoria-infraestructura` | ✅ procesado |
| `2026-06-25-sesion-tarde` | ✅ procesado |
| `2026-06-27-madre-ap-wifi-debug` | ✅ migrado → `diarios/2026-06-27-madre-ap-wifi-resuelto.md` |

---

## 📋 Próximas acciones (orden prioridad)

1. `git pull --rebase` en Madre
2. **Optimizar AP**: activar HT40 en hostapd para más velocidad
3. **Instalar Prey** en el Acer (rastreo antirrobo)
4. **Verificar Computrace** en BIOS del Acer
5. **Extraer número de serie** del Acer y documentar
6. **Mitmproxy/tcpdump** en `wlan0` para interceptar tráfico
7. Pulls modelos Ollama: `llama3.1:8b` + `bge-m3` + `nomic-embed-text`
8. Script Restic backup
9. Uptime Kuma → THDORA alertas Telegram

---
_Actualizado: 27 jun 2026 03:56 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[diarios/2026-06-27-madre-ap-wifi-resuelto]] · [[inbox/README]]_
