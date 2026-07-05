---
tipo: isla
isla: infraestructura
repos: [madre-config, acer-config]
actualizado: 2026-07-05 15:03 CEST
tags: [infra, madre, acer, docker, servidor, dotfiles]
---

# 🖥️ Isla: Infraestructura

> Los dos equipos del ecosistema y toda su configuración.
> Madre es el servidor central. Acer es el equipo de trabajo.

---

## Repos

### [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) 🔒 Privado
Servidor HP Ubuntu — el corazón físico del ecosistema:
- Todos los `docker-compose.yml` del sistema
- Scripts de sesión (`inicio` / `fin`)
- Configuración SSH y seguridad del servidor
- Monitoreo y estado de servicios
- Acceso: `ssh madre` via Tailscale `100.91.112.32`

### [`acer-config`](https://github.com/alvarofernandezmota-tech/acer-config) 🔒 Privado
Dotfiles del portátil Acer con Arch Linux:
- Hyprland (compositor Wayland)
- zsh + plugins
- Neovim config
- Herramientas CLI del día a día

---

## Servicios corriendo en Madre

| Servicio | Puerto | Estado |
|---|---|---|
| Open WebUI | 3000 | ✅ |
| Ollama | 11434 | ✅ |
| Qdrant | 6333 | ✅ |
| THDORA-PERSONAL | 8000 | ✅ |
| log_guardian_bot | — | ⚠️ unhealthy |
| yggdrasil_watchdog | — | ⚠️ unhealthy |

---

## Herramientas
- **Docker / Docker Compose** — orquestación de servicios
- **Tailscale** — VPN privada entre dispositivos
- **SSH** — acceso remoto desde Acer e iPhone
- **Blink Shell** — SSH desde iPhone
- **systemd** — servicios del servidor
- **UFW** — firewall

---

← [HOME](../../HOME.md)
