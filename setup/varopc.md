---
tags: [setup, hardware, varopc, arch, acer]
fecha-actualizacion: 2026-06-20
---

# 💻 varopc — Acer Theodora (Terminal de trabajo)

## Qué es

Portátil de trabajo principal. El único cliente activo del ecosistema.
Nombre dispositivo: **alvaro** · Alias en el sistema: **varopc**.

> ⚠️ Este equipo es el terminal — desde aquí se controla todo. No es el servidor.

## Hardware real

| Componente | Detalle |
|---|---|
| Modelo | Acer (Theodora) |
| CPU | AMD Ryzen 5 5500U @ 2.10GHz |
| RAM | 8 GB (7.35 GB usable) |
| GPU | AMD Radeon Graphics (497 MB) |
| Almacenamiento | 477 GB (127 GB usado) |
| OS | Arch Linux + Hyprland / Wayland |
| IP Tailscale | `100.86.119.102` |
| IP local | `10.134.31.171` |

> ⚠️ RAM al límite con cargas pesadas. Upgrade recomendado: **RAM 16GB DDR4 SO-DIMM (~40-50€)**.

## Para qué se usa

- Terminal principal de desarrollo: Python, Docker, Git
- Obsidian — vault `~/Projects/yggdrasil-dew`
- SSH a Madre vía Tailscale
- Navegador: Brave (Perplexity, GitHub, navegación)
- IAs: Perplexity (principal), Claude, Gemini, Grok

## Programas instalados (relevantes)

| Programa | Para qué |
|---|---|
| Obsidian v1.12.7 | Vault yggdrasil-dew — segundo cerebro |
| Ollama | Modelos LLM locales |
| tmux v3.6_b-2 | Sesiones persistentes en terminal |
| yay | AUR helper de Arch Linux |
| Git | Control de versiones |
| Brave | Navegador principal |
| SSH | Conexión a Madre |
| nmap | OSINT / auditoría red — ⏳ instalar |
| theHarvester | OSINT — ⏳ instalar |

## Rutas importantes

| Ruta | Contenido |
|---|---|
| `~/Projects/yggdrasil-dew/` | Vault Obsidian + cerebro |
| `~/Projects/` | Repos de desarrollo |
| `~/dev/` | Verificar contenido |

## Conectar a Madre

```bash
# Siempre por Tailscale
ssh alvaro@100.91.112.32

# Antes de builds largos — tmux primero
tmux new -s deploy
```

> ⚠️ AP Isolation en el router bloquea UDP LAN. Tailscale P2P funciona siempre.

## Upgrades pendientes

| Upgrade | Coste | Impacto | Prioridad |
|---|---|---|---|
| RAM 16GB DDR4 SO-DIMM | ~40-50€ | Máximo — va al límite con 8GB | 🔴 Alta |

## Próximos pasos

- [ ] Instalar nmap: `yay -S nmap`
- [ ] Instalar theHarvester: `yay -S theharvester`
- [ ] Plugin Git en Obsidian
- [ ] Verificar contenido `~/dev/`

---

_Ver también: [[setup/madre]] · [[setup/red]] · [[HOME]]_
