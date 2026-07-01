---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-07-01
hora: 05:16
---

# 📊 ESTADO DEL SISTEMA — 01 jul 2026 (05:16)

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.

---

## ⚠️ REGLA FIJA — Nombres máquinas
> **madre** = `varopc` = servidor (SSH destino)
> **theodora** = Acer = cliente (desde donde se lanza `ssh madre`)

---

## 📱 Red Tailscale — COMPLETA ✅

| Dispositivo | Hostname Tailscale | IP Tailscale | Estado |
|---|---|---|---|
| madre (PC torre) | `varpc` | `100.91.112.32` | ✅ activo |
| theodora (Acer) | `varo12f` | `100.86.119.102` | ✅ activo directo |
| iPhone 11 | `iphone-11` | `100.81.187.99` | ✅ activo |
| Redmi A5 | `xiaomi-22101316g` | `100.106.133.70` | ✅ activo 🆕 |

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **madre** (`varopc`) | ✅ encendida y accesible | SSH OK · AP MadreAP activo · IP local `10.48.234.18` |
| **theodora** (Acer) | ✅ operativo | Tailscale activo · Netdata activo |
| **iPhone 11** | ✅ Tailscale activo | `100.81.187.99` |
| **Redmi A5** | ✅ Tailscale activo | `100.106.133.70` · hotspot 4G → madre |

---

## 🛠 Red

| Servicio | Estado | Detalle |
|---|---|---|
| Tailscale madre | ✅ activo | `100.91.112.32` |
| Tailscale theodora | ✅ activo | `100.86.119.102` · relay `mad` |
| Tailscale iPhone 11 | ✅ activo | `100.81.187.99` |
| Tailscale Redmi A5 | ✅ activo | `100.106.133.70` |
| **MadreAP (hostapd)** | ✅ estable | SSID: MadreAP · WPA2 · canal 6 |
| **dnsmasq DHCP** | ✅ activo | `192.168.72.50-150` · wlan0 |
| **UFW madre** | ✅ activo | |
| **UFW theodora** | ✅ activo | |
| SSH hardening | ⚠️ parcial | Clave pública pendiente |

---

## 📱 ADB / Redmi A5

| Acción | Estado | Notas |
|---|---|---|
| ADB USB | ✅ funcional | `mvj78dnnljlzukk7 device` |
| ADB TCP/IP 5555 | ❌ bloqueado | Android bloquea puerto 5555 vía red por defecto |
| `adb input keyevent` | ❌ bloqueado | `INJECT_EVENTS` denegado Android 13 MIUI |
| Tailscale instalado | ✅ | F-Droid 87MB |
| Tailscale login | ✅ | IP `100.106.133.70` asignada |
| Screencap | ✅ | `adb shell screencap -p /sdcard/s.png && adb pull /sdcard/s.png ~/screen.png` |
| Abrir apps | ✅ | `adb shell monkey -p <package> 1` |

---

## 🐳 Docker — varopc

### ✅ 14/14 contenedores UP (validado 01-jul 02:00)

| Contenedor | Puerto | Estado |
|---|---|---|
| `ollama` | 11434 | ✅ healthy |
| `ollama-embeddings` | 11435 | ✅ healthy |
| `qdrant` | 6333 | ✅ healthy |
| `open-webui` | 3001 | ✅ healthy |
| `thdora` | 8000 | ✅ healthy |
| `thdora-bot` | — | ✅ healthy |
| `uptime-kuma` | 3002 | ✅ healthy |
| `portainer` | 9000 | ✅ up |
| `grafana` | 3000 | ✅ up |
| `prometheus` | 9090 | ✅ up |
| `n8n` | 5678 | ✅ up |
| `gitea` | 3003 | ✅ up |
| `code-server` | 8443 | ✅ up |
| `spiderfoot` | 5001 | ✅ up |

### ⏳ Pendiente
| Contenedor | Estado | Notas |
|---|---|---|
| `kali-pentest` | ⏳ Descargando en `tmux -t kali` | 3.7GB total |
| `wazuh` | 🔜 pendiente | prereq `vm.max_map_count=262144` |
| `suricata` | 🔜 pendiente | |

```bash
# Verificar kali:
tmux attach -t kali
docker ps | grep kali
# Acceder: https://100.91.112.32:6901  user: kasm_user  pass: batcueva2026
```

---

## 🔐 Seguridad

| Servicio | Estado |
|---|---|
| fail2ban madre | ✅ activo |
| fail2ban theodora | ✅ activo |
| UFW madre | ✅ activo |
| SSH PasswordAuth | ✅ `no` |
| Clave pública SSH | ❌ pendiente |

### Hallazgos abiertos
| ID | Hallazgo | Riesgo | Estado |
|---|---|---|---|
| SEC-001 | Puerto 21 FTP abierto `79.116.247.44` | 🟡 MEDIO | ❌ PENDIENTE |

---

## 📡 Monitorización

| Servicio | URL | Estado |
|---|---|---|
| Netdata madre | `http://100.91.112.32:19999` | ✅ |
| Netdata theodora | `http://100.86.119.102:19999` | ✅ |
| Grafana | `http://100.91.112.32:3000` | ✅ |
| Uptime Kuma | `http://100.91.112.32:3002` | ✅ |
| Portainer | `http://100.91.112.32:9000` | ✅ |

---

## 🤖 THDORA

| Componente | Estado |
|---|---|
| thdora (FastAPI) | ✅ healthy · v0.12.1 |
| thdora-bot | ✅ healthy |
| Handlers Telegram | ⚠️ básicos — no tocar hasta pentest estable |

---

## 📋 Próximas acciones

### 🔴 URGENTE
1. **SEC-001** — Cerrar FTP puerto 21 router Digi
2. **Verificar Kali** — `tmux attach -t kali` → `docker ps | grep kali`

### 🟡 PRÓXIMO
3. Escaneo red local desde Kali — `nmap -sn 192.168.72.0/24`
4. Auditar aislamiento redes Docker
5. Auditar APIs sin auth: Ollama `:11434`, Qdrant `:6333`

### 🟢 PLANIFICADO
6. Prereq Wazuh — `sudo sysctl -w vm.max_map_count=262144`
7. Levantar Wazuh SIEM
8. Pipeline RAG — bge-m3 → Qdrant → Open WebUI
9. SSH clave pública ambos nodos
10. Eliminar `tailscale-full.apk` vacío del repo
11. Reorganizar filesystem madre — composes a `~/docker/`

---
_Actualizado: 01 jul 2026 05:16 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[ECOSISTEMA]] · [[diarios/2026-07-01]]_
