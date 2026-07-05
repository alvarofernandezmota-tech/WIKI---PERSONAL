---
tipo: isla
nombre: Infraestructura
descripcion: Servidores, redes, configuraciones y hardware del ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/madre-config
github_issues: https://github.com/alvarofernandezmota-tech/madre-config/issues
obsidian_link: "[[infra]]"
depende_de: []
sirve_a: [ia-local, thdora, seguridad, cerebro]
estado: activo
---

# 🖥️ Isla: Infraestructura

La infraestructura es la **base física y de red** sobre la que corre todo el ecosistema. Sin ella no hay IA local, no hay THDORA, no hay seguridad activa.

## Repos

| Repo | Propósito | URL |
|---|---|---|
| `madre-config` | Scripts, docs y config del servidor Madre (torre ASUS) | https://github.com/alvarofernandezmota-tech/madre-config |
| `acer-config` | Config y scripts del portátil Acer | https://github.com/alvarofernandezmota-tech/acer-config |

## Hardware documentado

### Madre (varpc — Torre ASUS)
- **CPU:** Intel i5-8400 6 núcleos 4GHz
- **GPU:** NVIDIA GTX 1060 6GB (CUDA 13) → IA local
- **RAM:** 16GB
- **Disco:** HDD WD 1TB LUKS+btrfs (28k horas ⚠️)
- **Red:** WiFi USB RTL8188FTV + Tailscale `100.91.112.32`
- **OS:** Arch Linux, Hyprland, kernel 7.0.9
- **Internet:** 4G Xiaomi USB tethering (~20Mbps)

### Acer (varo12f — Portátil)
- **CPU:** AMD Ryzen + iGPU
- **RAM:** 16GB
- **Disco:** NVMe LUKS+btrfs
- **Red:** WiFi iwd + Tailscale `100.86.119.102`
- **OS:** Arch Linux, Hyprland
- **Batería:** 67.8% salud (degradación 32%)

## Servicios activos en Madre

| Servicio | Puerto | Estado |
|---|---|---|
| SSH | 22 | ✅ activo (solo Tailscale) |
| Ollama | 11434 | ✅ activo |
| Docker | — | ✅ activo |
| Tailscaled | — | ✅ activo |
| UFW | — | ✅ deny incoming |
| fail2ban | — | ✅ activo |
| Netdata | 19999 | ✅ activo |
| THDORA bot | 8000 | ✅ activo |

## Conexiones

- → [[ia-local]] (Madre corre Ollama + modelos)
- → [[thdora]] (Madre corre el bot)
- → [[seguridad]] (Madre tiene UFW, fail2ban, Wazuh pendiente)
- ← [[cerebro]] (los scripts de Madre se documentan en dew)

## Docs clave

- `madre-config/docs/estado-actual.md` → estado real de servicios
- `madre-config/docs/MAPA-FICHEROS-MADRE.md` → mapa de rutas y aliases
- `madre-config/scripts/sesion-inicio.sh` → inicio de sesión en Madre
- `madre-config/scripts/sesion-fin.sh` → cierre de sesión en Madre

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
