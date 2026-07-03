---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 02:19 CEST
actualizado: 2026-07-03 02:19 CEST
ruta: infra/madre/estado-actual.md
tags: [madre, infra, ssh, docker, tailscale, red]
status: vigente
---

# Madre — Estado actual

> Snapshot de infraestructura capturado vía SSH desde Thdora · 2026-07-03 02:05 CEST

---

## Identidad

| Campo | Valor |
|---|---|
| Hostname | `varpc` |
| Usuario principal | `varopc` |
| Uptime capturado | 12h 15m (sesión 2026-07-03) |
| Carga (load average) | 2.27 / 2.68 / 2.77 |
| Usuarios activos | 2 |

---

## Red

| Interfaz | IP | Estado | Notas |
|---|---|---|---|
| `enp4s0` | — | DOWN | Ethernet sin cable |
| `wlan0` | `192.168.72.1/24` | UP | LAN WiFi principal |
| `tailscale0` | `100.91.112.32/32` | UP | VPN Tailscale activa |
| `enp0s20f0u3` | `10.48.234.2/24` | UP (dynamic) | USB tethering / adaptador externo |
| `docker0` | `172.17.0.1/16` | UP | Bridge Docker por defecto |
| `br-*` | `172.18-24.x.1/16` | varios | Bridges Docker redes personalizadas |

> ⚠️ `enp4s0` (ethernet) está DOWN — Madre opera por WiFi + Tailscale, no por cable ethernet.

---

## SSH

| Campo | Valor |
|---|---|
| Puerto | `22` |
| Escucha | `0.0.0.0:22` + `[::]:22` |
| PasswordAuthentication | `no` |
| PubkeyAuthentication | `yes` |
| PermitRootLogin | no declarado explícitamente (revisar) |

### Claves públicas autorizadas (`~/.ssh/authorized_keys`)

| Clave | Alias | Dispositivo |
|---|---|---|
| `AAAAC3...hxnn` | `acer` | Thdora (Acer) |
| `AAAAC3...Yp9V` | `varopc@madre` | Localhost |
| `AAAAC3...7nms` | `varo12f-to-madre` | iPhone 12 (Shellfish) |

> Para conectar desde iPhone: `ssh varopc@100.91.112.32` con la clave `varo12f-to-madre`.

---

## Stack Docker

> Capturado: 2026-07-03 ~02:05 CEST

### Servicios principales

| Contenedor | Estado | Puerto(s) expuestos | Notas |
|---|---|---|---|
| `thdora` | ✅ healthy | `0.0.0.0:8000->8000` | API THDORA |
| `thdora-bot` | ✅ healthy | — | Bot Telegram THDORA |
| `grafana` | ▶ running | `0.0.0.0:3000->3000` | Dashboard métricas |
| `prometheus` | ▶ running | `0.0.0.0:9090->9090` | Scraping métricas |
| `uptime-kuma` | ✅ healthy | `0.0.0.0:3002->3001` | Monitor disponibilidad |
| `portainer` | ▶ running | `0.0.0.0:9000->9000` | UI Docker |
| `gitea` | ▶ running | `0.0.0.0:3003->3000`, `0.0.0.0:2222->22` | Git local |
| `n8n` | ▶ running | `0.0.0.0:5678->5678` | Automatización |
| `code-server` | ▶ running | `0.0.0.0:8443->8443` | VSCode web |
| `spiderfoot` | ▶ running | `0.0.0.0:5001->5001` | OSINT |
| `kali-pentest` | ▶ running | `0.0.0.0:6901->6901`, `4901`, `5901` | Kali VNC/noVNC |
| `radar_backup` | ▶ running | — | Backup radar |
| `network_radar` | ✅ healthy | — | Escáner red |
| `guardian_bot` | ✅ healthy | — | Bot guardián |

### Contenedores con problemas ⚠️

| Contenedor | Estado | Acción recomendada |
|---|---|---|
| `log_guardian_bot` | ❌ unhealthy | Revisar logs: `docker logs log_guardian_bot` |
| `yggdrasil_watchdog` | ❌ unhealthy | Revisar logs: `docker logs yggdrasil_watchdog` |
| `tailscale_monitor` | 🔄 health: starting | Normal si recién reiniciado |
| `local_tripwire` | 🔄 health: starting | Normal si recién reiniciado |

---

## Acceso desde iPhone (Shellfish)

```
App:      Shellfish (App Store)
Host:     100.91.112.32     ← Tailscale (desde cualquier lugar)
          192.168.72.1      ← LAN WiFi (solo en casa)
Puerto:   22
Usuario:  varopc
Auth:     SSH Key (varo12f-to-madre)
```

> La clave `varo12f-to-madre` ya está en `authorized_keys` — solo hay que cargarla en Shellfish.

---

## TODOs técnicos detectados

- [ ] Investigar por qué `log_guardian_bot` y `yggdrasil_watchdog` están unhealthy
- [ ] Añadir `PermitRootLogin no` explícito en `/etc/ssh/sshd_config`
- [ ] Verificar que ethernet `enp4s0` está sin cable por diseño o es un problema
- [ ] Confirmar que el watcher de puertos vigila los puertos expuestos por Docker
- [ ] Documentar por qué hay 6+ bridges Docker distintos
