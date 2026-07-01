---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-07-01
hora: 05:32
---

# 📊 ESTADO DEL SISTEMA — 01 jul 2026 (05:32)

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.

---

## ⚠️ REGLA FIJA — Nombres máquinas
> **madre** = `varopc` = servidor (SSH destino) — al que se hace `ssh madre` desde theodora
> **theodora** = Acer portátil = cliente (desde donde se lanza `ssh madre`)

---

## 📱 Red Tailscale — COMPLETA ✅

| Dispositivo | Hostname Tailscale | IP Tailscale | Estado |
|---|---|---|---|
| madre (PC torre) | `varpc` | `100.91.112.32` | ✅ activo |
| theodora (Acer) | `varo12f` | `100.86.119.102` | ✅ activo directo |
| iPhone 11 | `iphone-11` | `100.81.187.99` | ✅ activo |
| Redmi A5 | `xiaomi-22101316g` | `100.106.133.70` | ✅ activo |

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **madre** | ✅ activa | IP local `10.48.234.18` · MadreAP activo |
| **theodora** | ✅ activo | Tailscale activo · Netdata activo |
| **iPhone 11** | ✅ activo | `100.81.187.99` |
| **Redmi A5** | ✅ activo | `100.106.133.70` · batería 90% · 36.6°C |

---

## 🛠 Red

| Servicio | Estado | Detalle |
|---|---|---|
| Tailscale madre | ✅ | `100.91.112.32` |
| Tailscale theodora | ✅ | `100.86.119.102` |
| Tailscale iPhone | ✅ | `100.81.187.99` |
| Tailscale Redmi | ✅ | `100.106.133.70` |
| MadreAP (hostapd) | ✅ | SSID: MadreAP · WPA2 · canal 6 |
| dnsmasq DHCP | ✅ | `192.168.72.50-150` |
| UFW madre | ⚠️ en hardening | Reglas 192.168.1.0/24 incorrectas — corrigiendo |

---

## 🔐 Seguridad

| ID | Hallazgo | Riesgo | Estado |
|---|---|---|---|
| SEC-001 | FTP puerto 21 abierto `79.116.247.44` | 🟡 MEDIO | ❌ pendiente |
| SEC-002 | Reglas UFW `192.168.1.0/24` inexistente | 🔴 ALTO | ⚠️ en proceso |
| SEC-003 | input-leaps puerto 24800 expuesto | 🔴 ALTO | ✅ DENY aplicado |
| SEC-004 | Ollama+Qdrant sin auth | 🔴 ALTO | ❌ pendiente |
| SEC-005 | Portainer sin HTTPS | 🟡 MEDIO | ❌ pendiente |

```bash
# Completar hardening:
bash ~/yggdrasil-dew/scripts/hardening-ufw.sh

# Verificar puertos tras hardening:
ss -tlnp | grep -v '127.0.0'
```

> Ver audit completo: `docs/setup/seguridad/audit-ufw-2026-07-01.md`

---

## 🐳 Docker — madre

### ✅ Levantado (14/14)
| Contenedor | Puerto | Estado |
|---|---|---|
| ollama | 11434 | ✅ healthy |
| ollama-embeddings | 11435 | ✅ healthy |
| qdrant | 6333 | ✅ healthy |
| open-webui | 3001 | ✅ healthy |
| thdora | 8000 | ✅ healthy |
| thdora-bot | — | ✅ healthy |
| uptime-kuma | 3002 | ✅ healthy |
| portainer | 9000 | ✅ up |
| grafana | 3000 | ✅ up |
| prometheus | 9090 | ✅ up |
| n8n | 5678 | ✅ up |
| gitea | 3003 | ✅ up |
| code-server | 8443 | ✅ up |
| spiderfoot | 5001 | ✅ up |

### ⏳ Descargando (tmux activo)
| Sesión | Contenido | Estado |
|---|---|---|
| `kali` | kasmweb/kali-rolling-desktop:1.16.0 (3.7GB) | ⏳ ~35%+ |
| `fase5` | wazuh-manager + wazuh-dashboard + suricata | ⏳ en curso |

```bash
tmux attach -t kali    # Ctrl+B D para salir
tmux attach -t fase5   # Ctrl+B D para salir
```

### Imágenes descargadas listas para levantar
| Imagen | Tamaño | Fecha |
|---|---|---|
| searxng/searxng | 376MB | 2026-07-01 |
| pihole/pihole | 150MB | ya estaba |
| crowdsecurity/crowdsec | 497MB | ya estaba |
| hashicorp/vault | 740MB | ya estaba |
| linuxserver/wireguard | 169MB | ya estaba |

---

## 📱 ADB / Redmi A5

| Cosa | Estado |
|---|---|
| ADB USB | ✅ `mvj78dnnljlzukk7 device` |
| Tailscale | ✅ `100.106.133.70` |
| Batería | ✅ 90% · 36.6°C |
| ADB TCP 5555 | ❌ bloqueado por Android |
| input keyevent | ❌ bloqueado MIUI Android 13 |

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

## 📋 Próximas acciones

### 🔴 URGENTE
1. **SEC-002** — Borrar reglas UFW incorrectas: `bash ~/yggdrasil-dew/scripts/hardening-ufw.sh`
2. **SEC-001** — Cerrar FTP puerto 21 router Digi
3. **Verificar Kali UP** — `tmux attach -t kali` → `docker ps | grep kali`

### 🟡 PRÓXIMO
4. **SEC-004** — Auth en Ollama y Qdrant
5. **SEC-005** — HTTPS en Portainer
6. Escaneo red desde Kali cuando esté UP
7. Auditar redes Docker (todos en bridge)

### 🟢 PLANIFICADO
8. Levantar Wazuh SIEM
9. Pipeline RAG bge-m3 → Qdrant → Open WebUI
10. SSH clave pública madre y theodora
11. Eliminar `tailscale-full.apk` vacío del repo

---
_Actualizado: 01 jul 2026 05:32 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[ECOSISTEMA]] · [[diarios/2026-07-01]]_
