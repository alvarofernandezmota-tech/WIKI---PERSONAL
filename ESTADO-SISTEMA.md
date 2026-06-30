---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-07-01
hora: 01:12
---

# 📊 ESTADO DEL SISTEMA — 01 jul 2026 (01:12)

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **varopc (Madre)** | ✅ encendida y accesible | SSH OK · AP MadreAP activo · Tailscale `100.91.112.32` |
| **Acer (theodora)** | ✅ operativo | Tailscale `100.86.119.102` · Netdata activo |
| **iPhone 11** | ✅ Tailscale activo | `100.81.187.99` |
| **Redmi A5** | ⚠️ sin Tailscale | Pendiente instalar desde Play Store |

---

## 🛠 Red

| Servicio | Estado | Detalle |
|---|---|---|
| Tailscale varopc | ✅ activo | `100.91.112.32` |
| Tailscale Acer | ✅ activo | `100.86.119.102` · relay `mad` |
| Tailscale iPhone 11 | ✅ activo | `100.81.187.99` |
| Tailscale Redmi A5 | ❌ pendiente | Instalar desde Play Store |
| **MadreAP (hostapd)** | ✅ estable | SSID: MadreAP · WPA2 · canal 6 · sin caídas |
| **dnsmasq DHCP** | ✅ activo | `192.168.72.50-150` · wlan0 |
| **UFW varopc** | ✅ activo | Reglas completas |
| **UFW Acer** | ✅ activo | Reglas completas |
| SSH hardening | ⚠️ parcial | `PasswordAuthentication no` ✅ · clave pública pendiente |

---

## 🐳 Docker — Estado varopc

### Stack base — 13/13 CONTENEDORES UP ✅ (validado 01-jul 01:10 CEST)

| Contenedor | Puerto | Estado | Bloque |
|---|---|---|---|
| `ollama` | 11434 | ✅ healthy | IA |
| `ollama-embeddings` | 11435 | ✅ healthy | IA |
| `qdrant` | 6333 | ✅ healthy | IA |
| `open-webui` | 3001 | ✅ healthy | IA |
| `thdora` | 8000 | ✅ healthy | Bot |
| `thdora-bot` | — | ✅ healthy | Bot |
| `uptime-kuma` | 3002 | ✅ healthy | Obs |
| `portainer` | 9000 | ✅ up | Obs |
| `grafana` | 3000 | ✅ up | Obs |
| `prometheus` | 9090 | ✅ up | Obs |
| `n8n` | 5678 | ✅ up | Dev |
| `gitea` | 3003 | ✅ up | Dev |
| `code-server` | 8443 | ✅ up | Dev |

### 🔜 Pendiente levantar — Bloque Pentest/OSINT/SIEM

| Contenedor | Puerto | Prereq | Prioridad |
|---|---|---|---|
| `kali-desktop` | 6901 | ninguno | 🔴 Alta |
| `spiderfoot` | 5001 | ninguno | 🔴 Alta |
| `wazuh` | 1514/55000 | `vm.max_map_count=262144` | 🟡 Media |
| `suricata` | — | modo pasivo en wlan0 | 🟡 Media |
| `defectdojo` | 8080 | wazuh activo | 🟢 Baja |

**Para levantar Kali + SpiderFoot ahora mismo:**
```bash
# prereq Wazuh (solo para wazuh, no para kali/spiderfoot):
sudo sysctl -w vm.max_map_count=262144

# levantar solo pentest:
docker compose -f docker/batcueva-pentest.yml up -d

# levantar solo OSINT:
docker compose -f docker/batcueva-osint.yml up -d
```

### Modelos Ollama

| Modelo | Tamaño | Estado |
|---|---|---|
| `qwen2.5-coder:7b` | 4.7 GB | ✅ descargado |
| `qwen2.5:3b` | 1.9 GB | ✅ descargado |
| `llama3.1:8b` | 4.7 GB | ✅ descargado |
| `nomic-embed-text` | 274 MB | ✅ descargado |
| `bge-m3` | 1.2 GB | ✅ descargado |

---

## 🔐 Seguridad

| Servicio | varopc | Acer |
|---|---|---|
| fail2ban | ✅ activo · jail sshd | ✅ activo · jail sshd |
| UFW | ✅ activo | ✅ activo |
| SSH PasswordAuth | ✅ `no` | ✅ `no` |
| Puerto 53317 | ✅ cerrado | ✅ cerrado |
| Clave pública SSH | ❌ pendiente | ❌ pendiente |

---

## 📡 Monitorización

| Servicio | Estado | URL |
|---|---|---|
| Netdata varopc | ✅ activo | `http://100.91.112.32:19999` |
| Netdata Acer | ✅ activo | `http://100.86.119.102:19999` |
| Grafana | ✅ up | `http://100.91.112.32:3000` |
| Uptime Kuma | ✅ up | `http://100.91.112.32:3002` |
| Portainer | ✅ up | `http://100.91.112.32:9000` |

---

## 🤖 THDORA

| Componente | Estado |
|---|---|
| thdora (FastAPI) | ✅ healthy · v0.12.1 |
| thdora-bot | ✅ healthy |
| Handlers Telegram | ⚠️ básicos — no tocar hasta stack pentest estable |

---

## 📂 Git

| Repo | Estado |
|---|---|
| yggdrasil-dew | ✅ sincronizado — 01-jul commit |
| docker/madre/docker-compose.fase1.yml | ✅ subido — compose real validado |
| docker/README.md | ✅ estructura documentada |
| CONVENCIONES.md | ✅ Regla 14 añadida |

---

## 📋 Próximas acciones (orden prioridad)

1. 🔴 **Levantar Kali Desktop** — `docker compose -f docker/batcueva-pentest.yml up -d`
2. 🔴 **Levantar SpiderFoot** — primer scan OSINT real
3. 🟡 **Prereq Wazuh** — `sudo sysctl -w vm.max_map_count=262144`
4. 🟡 **Levantar Wazuh SIEM** — `docker compose -f docker/batcueva-siem.yml up -d`
5. 🟢 Pipeline RAG — bge-m3 → Qdrant → Open WebUI
6. 🟢 SSH clave pública ambos nodos
7. 🟢 Tailscale Redmi A5

---
_Actualizado: 01 jul 2026 01:12 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[ECOSISTEMA]] · [[diarios/]]_
