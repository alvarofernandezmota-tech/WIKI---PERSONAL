---
title: Isla Infraestructura
tipo: isla
nombre: Infraestructura
descripcion: Dispositivos, red Tailscale, contenedores Docker y flujo de acceso del ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/madre-config
github_issues: https://github.com/alvarofernandezmota-tech/madre-config/issues
obsidian_link: "[[infra]]"
depende_de: []
sirve_a: [ia-local, thdora, seguridad, cerebro, labs]
estado: estable
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-06
tags: [infra, madre, acer, iphone, docker, tailscale, red]
---

# 🖥️ Isla: Infraestructura

La infraestructura es la **base física y de red** sobre la que corre todo el ecosistema.
Esta isla es el mapa conceptual — los procedimientos técnicos viven en [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config).

> ⚡ Procedimientos técnicos → [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config)  
> ⚡ Decisiones de arquitectura → [ADR-001](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ADR-001-platform-stack.md)

---

## Dispositivos del ecosistema

| Dispositivo | Rol | CPU | RAM | OS | IP Tailscale |
|---|---|---|---|---|---|
| **Madre** (`varpc`) | Servidor principal — corre todos los servicios Docker | Intel i5-8400 6c/4GHz | 16 GB | Arch Linux + Hyprland | `100.91.112.32` |
| **Acer** (`varo12f`) | Máquina de desarrollo | AMD Ryzen + iGPU | 16 GB | Arch Linux + Hyprland | `100.86.119.102` |
| **iPhone 11** | Cliente móvil de acceso | — | — | iOS + Blink Shell + Tailscale | cliente |

---

## Red — Cómo se conecta todo

Toda la comunicación entre dispositivos y hacia los servicios pasa por **Tailscale** — una VPN mesh punto a punto basada en WireGuard.

```
┌─────────────┐        Tailscale VPN (100.64.0.0/10)
│ iPhone 11  │ ───────────────────────┬────────────────────┐
└─────────────┘                     │                    │
                            ↓                    ↓
               ┌──────────────────┐  ┌─────────────────┐
               │ Madre (varpc)    │  │ Acer (varo12f) │
               │ 100.91.112.32    │  │ 100.86.119.102 │
               │ Arch + Docker    │  │ Arch + dev     │
               └──────────────────┘  └─────────────────┘
```

**Reglas de red en Madre:**

| Acceso | Estado | Nota |
|---|---|---|
| Todos los servicios Docker | Solo `100.64.0.0/10` (Tailscale) | Nunca expuestos a internet |
| SSH (puerto 22) | ⚠️ Abierto a internet | HAL-006 — pendiente cerrar y mover a Tailscale |
| UFW default | `deny incoming` | Base segura |

**Flujo de acceso desde el iPhone:**
1. Abrir Tailscale en iOS → conecta automáticamente a la red privada
2. Blink Shell → SSH a `100.91.112.32` (Madre) o `100.86.119.102` (Acer)
3. Portainer → `http://100.91.112.32:9000` (gestión Docker desde Safari)
4. code-server → `http://100.91.112.32:8080` (VS Code en navegador)
5. Uptime Kuma → `http://100.91.112.32:3001` (estado de servicios)

---

## Platform Stack — Contenedores por isla

Cada contenedor pertenece a una isla. Este es el mapa oficial.

### 🛡️ Isla Seguridad

| Contenedor | Función | Estado |
|---|---|---|
| `yggdrasil_watchdog` | Vigila todos los contenedores, reinicia fallos, alerta Telegram | ✅ healthy |
| `tailscale_monitor` | Vigila que la VPN esté activa | ✅ healthy |
| `log_guardian_bot` | Analiza logs buscando intrusiones y anomalías | ⚠️ unhealthy (HAL pendiente) |
| `network_radar` | Detecta dispositivos no autorizados en la red | ✅ healthy |
| `local_tripwire` | Detecta cambios en archivos críticos del sistema | 🔄 starting |
| `guardian_bot` | Bot Telegram — canal único de alertas de seguridad | ✅ healthy |

> Repo → [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)

### 🏗️ Isla Infraestructura

| Contenedor | Función | Estado |
|---|---|---|
| `uptime-kuma` | Dashboard visual de estado de servicios | ✅ healthy |
| `grafana` | Métricas y dashboards (CPU, RAM, disco, red) | ✅ running |
| `prometheus` | Colección de métricas | ✅ running |
| `portainer` | Gestión visual de Docker (accesible desde iPhone) | ✅ running |
| `radar_backup` | Backups automáticos (HDD 28.715h — crítico) | ✅ running |

> Repo → [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config)

### 🧠 Isla Cerebro

| Contenedor | Función | Estado |
|---|---|---|
| `n8n` | Automatizaciones y flujos entre servicios | ✅ running |
| `gitea` | Mirror local de repos GitHub | ✅ running |
| `code-server` | VS Code en navegador — programar desde iPhone | ✅ running |

> Repo → [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)

### 🤖 Isla THDORA

| Contenedor | Función | Estado |
|---|---|---|
| `thdora` | Backend del bot (API, lógica) | ✅ healthy |
| `thdora-bot` | Bot Telegram (interfaz de usuario) | ✅ healthy |

> Repo → [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL)  
> ⚠️ HAL-001/003: token en historial git — rotar urgente

### 🧪 Isla IA Local

| Contenedor | Función | Estado |
|---|---|---|
| `ollama` | Servidor de modelos LLM locales | ✅ running |
| `open-webui` | Interfaz web para Ollama | ✅ running |

> Repo → [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack)

### 🧪 Isla Labs

| Contenedor | Función | Estado |
|---|---|---|
| `kali-pentest` | Kali Linux en navegador (uso puntual) | ✅ running |
| `spiderfoot` | OSINT automatizado self-hosted | ✅ running |

> Uso puntual — no son servicios permanentes críticos

---

## Conexiones entre islas

```
Madre (servidor base)
  ├── → isla:seguridad   (watchdog, guardian, tripwire, radar)
  ├── → isla:ia-local    (Ollama + Open WebUI)
  ├── → isla:thdora      (bot Telegram personal)
  ├── → isla:cerebro     (n8n, gitea, code-server)
  └── → isla:labs        (kali, spiderfoot)

Acer (desarrollo)
  └── → Madre via Tailscale (SSH, code-server)

iPhone (cliente)
  ├── → Madre via Tailscale + Blink Shell
  └── → Portainer, code-server, Uptime Kuma (Safari)
```

---

## Riesgos activos

| HAL | Descripción | Prioridad |
|---|---|---|
| HAL-001/003 | Token Telegram en historial git — rotar | 🔴 urgente |
| HAL-004 | `log_guardian_bot` unhealthy (falta `procps`) | 🟡 esta semana |
| HAL-006 | SSH puerto 22 abierto a internet | 🟡 esta semana |
| — | HDD Madre 28.715h — verificar backup destino | 🟠 pendiente |

---

> Docs técnicos → `madre-config/docs/`  
> Scripts → `madre-config/scripts/`  
> Hallazgos → [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues)  
> Decisiones → [ADR-001](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ADR-001-platform-stack.md)

_Actualizado: 2026-07-06 · Perplexity-MCP_
