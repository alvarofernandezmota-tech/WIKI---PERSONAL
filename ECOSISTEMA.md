---
tags: [ecosistema, repos, docker, arquitectura, mapa]
fecha-actualizacion: 2026-07-02
---

# 🌳 ECOSISTEMA — Mapa completo del sistema

> Fuente de verdad de TODOS los repos, herramientas y stacks.
> Actualizar cada vez que se crea un repo o se añade una herramienta.
> Última actualización: **02-jul-2026 17:30 CEST**

---

## ⚠️ REGLA FIJA — Nombres de máquinas (NO confundir)

| Nombre | Hostname real | Hardware | Rol |
|---|---|---|---|
| **madre** | `varopc` | PC torre i5-8400 | Servidor principal — SSH target |
| **theodora** | `varo12f` | Acer portátil | Máquina de trabajo — SSH source |
| **iPhone** | `iphone` | iPhone 11 | Móvil personal — terminal vía Termius |

> **Regla:** `ssh madre` se ejecuta SIEMPRE desde theodora o iPhone.
> Los comandos docker, ADB, etc. corren en **madre** después de SSH.

---

## 📱 Acceso móvil — iPhone → madre

| Componente | App | Estado |
|---|---|---|
| VPN | **Tailscale iOS** | ✅ activo |
| Terminal SSH | **Termius** (App Store, gratis) | ⏳ pendiente configurar |
| Target | madre `100.91.112.32` | ✅ operativo |

> **Termius** es la app de terminal SSH para iPhone.
> Instalar desde App Store: [Termius — SSH client](https://apps.apple.com/es/app/termius-ssh-sftp-client/id549039908)
> Configurar con clave ed25519 de madre + IP Tailscale `100.91.112.32`
> Ver issue dew #8 para pasos completos.

---

## 📱 Dispositivos Tailscale — Red mesh completa

| Dispositivo | Hostname | IP Tailscale | Estado | Notas |
|---|---|---|---|---|
| PC torre | **madre** (`varopc`) | `100.91.112.32` | ✅ activo | Servidor principal |
| Portátil Acer | **theodora** (`varo12f`) | `100.86.119.102` | ✅ activo | Máquina de trabajo |
| iPhone 11 | iPhone de varo | `100.81.187.99` | ✅ activo | Terminal vía Termius |
| Xiaomi | xiaomi | `100.106.133.70` | ✅ activo | Detectado por Tailscale Monitor |
| Redmi A5 | redmi-a5 | ⏳ pendiente login | ⚠️ instalado | App instalada vía ADB ✅ |

---

## 🖥️ Hardware del ecosistema

### madre — PC torre (servidor principal)
| Parámetro | Valor |
|---|---|
| CPU | i5-8400 |
| RAM | 16GB |
| Disco | HDD 1TB |
| GPU | GTX 1060 6GB |
| OS | Linux |
| IP local | `10.48.234.18` (interfaz `enp0s20f0u3`) |
| IP Tailscale | `100.91.112.32` |
| Rol | Docker · Ollama · AP WiFi · servidor principal |

### theodora — Acer portátil (máquina de trabajo)
| Parámetro | Valor |
|---|---|
| CPU | AMD Ryzen 5 |
| OS | Arch Linux · Hyprland |
| IP Tailscale | `100.86.119.102` |
| Rol | Desarrollo · Obsidian · terminal · SSH a madre |

### Redmi A5 — móvil Android (hotspot + control remoto)
| Parámetro | Valor |
|---|---|
| OS | Android 13 · MIUI |
| IP Tailscale | ⏳ pendiente login |
| Conectado a madre por | USB (ADB) · MadreAP WiFi |
| Rol principal | **Hotspot 4G** → da internet a madre |

---

## 🌐 Red — Madre

| Interfaz | IP | Rol |
|---|---|---|
| `wlan0` (RTL8188FTV USB) | `192.168.72.1/24` | AP WiFi MadreAP |
| `tailscale0` | `100.91.112.32` | VPN mesh |
| `enp0s20f0u3` (USB tethering Redmi) | `10.48.234.18` | Internet upstream (4G) |
| `enp4s0` (Ethernet Gigabit) | — | DOWN / sin cable |

---

## 🔐 Seguridad del ecosistema

| Dispositivo | Tailscale | Firewall | SSH hardening | Notas |
|---|---|---|---|---|
| madre | ✅ | UFW + fail2ban | ✅ completado | ed25519, no password, no root |
| theodora | ✅ | UFW + fail2ban | ⚠️ parcial | PasswordAuth desactivado |
| iPhone 11 | ✅ | iOS nativo | — | Terminal vía Termius (pendiente) |
| Redmi A5 | ⚠️ pendiente | Android nativo | ADB activo | |

### Pendientes seguridad
- [ ] **SEC-001** — Cerrar FTP puerto 21 router Digi (`79.116.247.44`) 🔴 CRÍTICO → secops #1
- [ ] Auditar APIs sin auth: Ollama `:11434`, Qdrant `:6333`
- [ ] Desactivar ADB Redmi cuando no se use

---

## 🤖 Stack de Bots — yggdrasil-secops

> Repo: [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) (privado)

### ⚠️ DOS BOTS TELEGRAM — NO confundir

| Bot | Repo | Función | Estado |
|---|---|---|---|
| **thdora-bot** | `thdora` | Bot del proyecto THDORA — FastAPI + Ollama + handlers | 🔧 handlers pendientes |
| **guardian-bot** | `yggdrasil-secops` | Bot de seguridad — notificaciones de todos los bots watchdog | ✅ activo y estable |

> guardian-bot es un bot **nuevo e independiente**, NO es thdora-bot.
> Su revisión completa (qué alertas llegan, formato, comandos) está planificada en **Fase 5**.

### Bots activos (Docker en madre)

| Bot | Contenedor | Rol | Estado |
|---|---|---|---|
| **Yggdrasil Watchdog** | `yggdrasilwatchdog` | Vigila 7 contenedores, reinicia unhealthy | ✅ Activo |
| **Tailscale Monitor** | `tailscalemonitor` | Ping ICMP a 4 nodos VPN | ✅ Activo ⚠️ crash-loop |
| **Network Radar** | `networkradar` + `radarbackup` | Escanea LAN 192.168.1.0/24 | ✅ Activo |
| **Log Guardian** | `logguardianbot` | Vigila auth.log, ufw.log, syslog | ✅ Activo ⚠️ crash-loop |
| **Local Tripwire** | `localtripwire` | Integridad archivos | ⚠️ Sin rutas (WATCH_PATHS vacío) |
| **Guardian Bot** | `guardianbot` | Notificaciones Telegram centrales | ✅ Activo y estable |

### 🐛 Issues detectados (secops)

| Bot | Problema | Issue |
|---|---|---|
| `log_guardian_bot` | Crash-loop ~8 min | secops #2 |
| `tailscale_monitor` | Crash-loop ~10 min | secops #2 |
| `local_tripwire` | 0 archivos vigilados | secops #2 |

---

## 🐳 Docker Stack completo — Madre

### ✅ Levantado y healthy
| Contenedor | Puerto | Rol |
|---|---|---|
| ollama | 11434 | Motor LLM local |
| ollama-embeddings | 11435 | Embeddings |
| open-webui | 3001 | UI chat IA |
| qdrant | 6333 | Base vectorial RAG |
| uptime-kuma | 3002 | Monitor servicios |
| thdora | 8000 | FastAPI backend |
| thdora-bot | — | Bot Telegram THDORA |
| grafana | 3000 | Dashboards |
| prometheus | 9090 | Métricas |
| portainer | 9000 | Panel Docker |
| code-server | 8443 | VSCode web |
| n8n | 5678 | Automatización workflows |
| gitea | 3003 | Git self-hosted |
| spiderfoot | 5001 | OSINT automatizado |

### ⏳ Pendiente levantar
| Contenedor | Puerto | Estado |
|---|---|---|
| kali-pentest | 6901 | ⏳ descargando imagen (3.7GB) |
| wazuh | 1514/55000 | 🔜 pendiente |
| suricata | — | 🔜 pendiente (IDS pasivo wlan0) |
| pihole | 53/80 | 🔜 pendiente |
| searxng | 8080 | 🔜 pendiente |

### 🔜 Propuestos (Fase 5)
| Contenedor | Puerto | Razón |
|---|---|---|
| AlertManager | 9093 | Enruta alertas Prometheus → Telegram |
| Loki + Promtail | 3100 | Logs de todos los contenedores → Grafana |
| CrowdSec | 8080 | Complementa fail2ban |
| Ntfy | 80/443 | Notificaciones push ligeras |

---

## 🤖 Modelos Ollama — Madre

| Modelo | Tamaño | Uso |
|---|---|---|
| qwen2.5-coder:7b | 4.7GB | Código · thdora |
| qwen2.5:3b | 1.9GB | Chat rápido |
| llama3.1:8b | 4.7GB | Chat general |
| bge-m3 | 1.2GB | Embeddings RAG |
| nomic-embed-text | 0.3GB | Embeddings rápidos |

---

## 📡 Monitorización

| Servicio | URL | Estado |
|---|---|---|
| Netdata madre | `http://100.91.112.32:19999` | ✅ activo |
| Netdata theodora | `http://100.86.119.102:19999` | ✅ activo |
| Grafana | `http://100.91.112.32:3000` | ✅ up |
| Uptime Kuma | `http://100.91.112.32:3002` | ✅ up |
| Portainer | `http://100.91.112.32:9000` | ✅ up |

### 🔔 Cadena de alertas (objetivo Fase 5)
```
Suricata → Wazuh → AlertManager → Telegram (guardian-bot)
                              ↕
                         Grafana (histórico)
```

---

## 📦 Repos GitHub

| Repo | Descripción | Privado | Estado |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Second brain — conocimiento + diarios | ❌ público | ✅ activo |
| [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | Bots watchdog + defensa | ✅ privado | ✅ activo |
| [thdora](https://github.com/alvarofernandezmota-tech/thdora) | Bot Telegram + FastAPI + Ollama | ❌ público | 🔧 handlers pendientes |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | Ollama, RAG, embeddings | ✅ privado | 🔧 en desarrollo |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | SpiderFoot, OSINT | ✅ privado | 🔧 en desarrollo |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | Open source AI dev stack | ❌ público | ✅ activo |
| [personal](https://github.com/alvarofernandezmota-tech/personal) | Vida personal | ❌ público | ✅ activo |
| `batcueva` | Infra ejecutable — Docker, SOPS, configs | — | 🔜 pendiente crear |

### Relación entre repos
```
          yggdrasil-dew (cerebro central)
          ├── thdora              (bot THDORA + FastAPI)
          ├── local-brain         (RAG + embeddings)
          ├── osint-stack         (OSINT)
          ├── yggdrasil-secops    (bots watchdog + defensa)
          ├── ai-toolkit          (herramientas IA)
          └── batcueva            (infra ejecutable — pendiente)
```

---

## 📊 Fases del plan — estado actual

| Fase | Nombre | Estado |
|---|---|---|
| Fase 1 | Repos limpias | 🟡 en proceso (Issue #7) |
| Fase 2 | GitHub profesional | 🟡 en proceso (labels pendientes) |
| Fase 3 | Documentación árbol | 🟡 en proceso |
| Fase 4 | Auditoría gobernanza | 🔜 pendiente (Issue #10) |
| Fase 5 | Técnica | 🔜 pendiente (después de 1-4) |

---

## 🔗 Referencias

- [[HOME]] — punto de entrada diario
- [[CONTEXT]] — contexto para agentes IA
- [[ESTADO-SISTEMA]] — estado operativo ahora mismo
- [[MASTER-PENDIENTES]] — tareas pendientes + Issues GitHub
- [[CONVENCIONES]] — reglas del vault
- [[docs/bots/guardian-bot-nuevo]] — bot guardian independiente

---
_Actualizado: 02-jul-2026 17:30 CEST — Perplexity vía MCP_
