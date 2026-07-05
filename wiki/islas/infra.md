---
tipo: isla
nombre: Infraestructura
descripcion: Mapa conceptual de los servidores y dispositivos del ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/madre-config
github_issues: https://github.com/alvarofernandezmota-tech/madre-config/issues
obsidian_link: "[[infra]]"
depende_de: []
sirve_a: [ia-local, thdora, seguridad, cerebro]
estado: estable
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
---

# 🖥️ Isla: Infraestructura

La infraestructura es la **base física y de red** sobre la que corre todo el ecosistema. Esta isla es el mapa conceptual — los procedimientos técnicos viven en los repos correspondientes.

> ⚡ Procedimientos técnicos → [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config)

---

## Dispositivos del ecosistema

### 🖥️ Madre (varpc — Torre ASUS)
- **CPU:** Intel i5-8400 6 núcleos 4GHz
- **GPU:** NVIDIA GTX 1060 6GB (CUDA) → IA local
- **RAM:** 16GB
- **Disco:** HDD WD 1TB LUKS+btrfs ⚠️ 28k horas
- **OS:** Arch Linux + Hyprland kernel 7.0.9
- **Red:** WiFi USB RTL8188FTV + Tailscale `100.91.112.32`
- **Internet:** 4G USB tethering ~20Mbps

### 💻 Acer (varo12f — Portátil principal)
- **CPU:** AMD Ryzen + iGPU
- **RAM:** 16GB
- **Disco:** NVMe LUKS+btrfs
- **OS:** Arch Linux + Hyprland
- **Red:** WiFi iwd + Tailscale `100.86.119.102`
- **Batería:** 67.8% salud (degradación 32%)

### 📱 iPhone 11
- **Acceso SSH:** Blink Shell + Tailscale
- **MCP:** Perplexity MCP activo

---

## Red Tailscale

| Dispositivo | IP Tailscale | Acceso |
|---|---|---|
| Madre | `100.91.112.32` | `ssh madre` |
| Acer | `100.86.119.102` | `ssh acer` |
| iPhone | — | cliente |

---

## Servicios en Madre (mapa)

| Servicio | Puerto | Estado |
|---|---|---|
| SSH | 22 | ✅ solo Tailscale |
| Ollama | 11434 | ✅ |
| Open WebUI | 3000 | ✅ |
| Qdrant | 6333 | ✅ |
| THDORA bot | 8000 | ✅ |
| Portainer | — | ✅ |
| Grafana + Prometheus | — | ✅ |
| Nextcloud + Vaultwarden | — | ✅ |
| Pi-hole + Unbound | — | ✅ |
| log_guardian_bot | — | ⚠️ unhealthy |
| yggdrasil_watchdog | — | ⚠️ unhealthy |
| UFW | — | ✅ deny incoming |
| fail2ban | — | ✅ |

---

## Repos

| Repo | Propósito | URL |
|---|---|---|
| `madre-config` | Config, scripts, docs del servidor Madre | https://github.com/alvarofernandezmota-tech/madre-config |
| `acer-config` | Dotfiles Acer: Hyprland, zsh, Neovim | https://github.com/alvarofernandezmota-tech/acer-config |

---

## Conexiones

- → [[ia-local]] (Madre corre Ollama + modelos)
- → [[thdora]] (Madre corre el bot vía Docker)
- → [[seguridad]] (Madre: UFW, fail2ban, Wazuh pendiente)
- ← [[cerebro]] (los scripts y estado se documentan en dew)

---

> Docs técnicos en `madre-config/docs/` · Scripts en `madre-config/scripts/`

_Actualizado: 2026-07-05 21:00 CEST · Perplexity-MCP_
