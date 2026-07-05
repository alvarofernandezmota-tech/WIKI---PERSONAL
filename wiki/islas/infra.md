---
title: Isla Infraestructura
tipo: isla
nombre: Infraestructura
descripcion: Mapa conceptual de los servidores, dispositivos y servicios del ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/madre-config
github_issues: https://github.com/alvarofernandezmota-tech/madre-config/issues
obsidian_link: "[[infra]]"
depende_de: []
sirve_a: [ia-local, thdora, seguridad, cerebro]
estado: estable
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
tags: [infra, madre, docker, servicios]
---

# 🖥️ Isla: Infraestructura

La infraestructura es la **base física y de red** sobre la que corre todo el ecosistema.
Esta isla es el mapa conceptual — los procedimientos técnicos viven en [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config).

> ⚡ Procedimientos técnicos → [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config)

---

## Dispositivos

| Dispositivo | CPU | RAM | OS | IP Tailscale |
|---|---|---|---|---|
| **Madre** (varpc — Torre ASUS) | Intel i5-8400 6c 4GHz | 16GB | Arch Linux + Hyprland | `100.91.112.32` |
| **Acer** (varo12f — Portátil) | AMD Ryzen + iGPU | 16GB | Arch Linux + Hyprland | `100.86.119.102` |
| **iPhone 11** | — | — | iOS + Blink Shell | cliente |

---

## Platform Stack — Service Ownership

Cada contenedor pertenece a una isla. Este es el mapa oficial.

### 🛡️ Isla Seguridad

| Contenedor | Función | Estado |
|---|---|---|
| `yggdrasil_watchdog` | Vigila todos los contenedores, reinicia fallos, alerta Telegram | ✅ healthy |
| `tailscale_monitor` | Vigila que la VPN Tailscale esté activa | ✅ healthy |
| `log_guardian_bot` | Analiza logs buscando intrusiones y anomalías | ⚠️ unhealthy |
| `network_radar` | Escanea la red buscando dispositivos no autorizados | ✅ healthy |
| `local_tripwire` | Detecta modificaciones en archivos críticos del sistema | 🔄 starting |
| `guardian_bot` | Bot Telegram que centraliza alertas de seguridad | ✅ healthy |

> Repo canónico: [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)

### 🏗️ Isla Infraestructura

| Contenedor | Función | Estado |
|---|---|---|
| `radar_backup` | Backups automáticos | ✅ running |
| `uptime-kuma` | Dashboard de estado de servicios | ✅ healthy |
| `grafana` | Métricas y dashboards (CPU, RAM, disco, red) | ✅ running |
| `prometheus` | Recolección de métricas | ✅ running |
| `portainer` | Gestión visual de Docker | ✅ running |

> Repo canónico: [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config)

### 🧠 Isla Cerebro

| Contenedor | Función | Estado |
|---|---|---|
| `n8n` | Automatizaciones y flujos de trabajo | ✅ running |
| `gitea` | Git local privado | ✅ running |
| `code-server` | VS Code en el navegador | ✅ running |

> Repo canónico: [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)

### 🤖 Isla THDORA

| Contenedor | Función | Estado |
|---|---|---|
| `thdora` | Backend del bot (API, lógica) | ✅ healthy |
| `thdora-bot` | Bot Telegram (interfaz) | ✅ healthy |

> Repo canónico: [`thdora`](https://github.com/alvarofernandezmota-tech/thdora)

### 🧪 Isla Labs

| Contenedor | Función | Estado |
|---|---|---|
| `kali-pentest` | Entorno Kali Linux en navegador (uso puntual) | ✅ running |
| `spiderfoot` | OSINT automatizado | ✅ running |

> Uso puntual — no son servicios permanentes críticos

---

## Red

| Acceso | Restricción |
|---|---|
| Todos los servicios | Solo `100.64.0.0/10` (Tailscale) |
| SSH puerto 22 | ⚠️ Abierto a internet — HAL-006 pendiente |
| Default UFW | `deny incoming` |

---

## Conexiones entre islas

- → [[ia-local]] (Madre corre Ollama + modelos)
- → [[thdora]] (Madre corre el bot vía Docker)
- → [[seguridad]] (UFW, fail2ban, watchdog, guardian)
- → [[cerebro]] (n8n, gitea, code-server)
- ← [[labs]] (kali, spiderfoot en Madre)

---

> Docs técnicos → `madre-config/docs/` · Scripts → `madre-config/scripts/`
> Hallazgos de seguridad → [`yggdrasil-secops/issues`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues)

_Actualizado: 2026-07-05 23:43 CEST · Perplexity-MCP_
