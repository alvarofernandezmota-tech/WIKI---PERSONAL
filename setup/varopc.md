# 💻 varopc — Acer Theodora

---
tags: [setup, hardware, varopc, arch]
fecha-actualizacion: 2026-06-20
---

## Qué es

PC de desarrollo principal. El único cliente activo del ecosistema.
Nombre real de máquina: **Acer Theodora**. Alias en el sistema: **varopc**.

> ⚠️ No hay MacBook. Este es el único equipo de desarrollo.

## Hardware

| Componente | Detalle |
|---|---|
| Modelo | Acer Theodora |
| OS | Arch Linux |
| Escritorio | Hyprland / Wayland |
| IP Tailscale | `100.86.119.102` |
| IP local | `10.134.31.171` |

> Hardware interno (CPU/RAM/disco): **pendiente documentar** — hacer `neofetch` o `inxi -F` y añadir aquí.

## Para qué se usa

- Desarrollo activo: Python, FastAPI, Docker, Git
- Obsidian — vault `~/Projects/yggdrasil-dew`
- Terminal: Hyprland + Wayland
- SSH a Madre vía Tailscale
- IAs: Perplexity (principal), Claude, Gemini, Grok, ChatGPT

## Programas instalados (relevantes)

| Programa | Para qué |
|---|---|
| Obsidian v1.12.7 | Vault yggdrasil-dew — segundo cerebro |
| Docker | Desarrollo local (si aplica) |
| Ollama | Modelos LLM locales |
| tmux v3.6_b-2 | Sesiones persistentes en terminal |
| yay | AUR helper de Arch Linux |
| Git | Control de versiones |
| SSH | Conexión a Madre |
| nmap | OSINT / auditoría red — ⏳ instalar |
| theHarvester | OSINT — ⏳ instalar |

## Rutas importantes

| Ruta | Contenido |
|---|---|
| `~/Projects/yggdrasil-dew/` | Vault Obsidian + cerebro |
| `~/Projects/` | Repos de desarrollo |
| `~/dev/` | (verificar contenido) |
| `~/Downloads/` | Descargas |

## Conectar a Madre

```bash
# Siempre por Tailscale (funciona aunque estén en la misma LAN)
ssh alvaro@100.91.112.32

# Antes de builds largos — abrir tmux primero
tmux new -s deploy
```

> ⚠️ AP Isolation en el router bloquea UDP LAN — lan-mouse no funciona por LAN.
> Tailscale P2P funciona correctamente.

## Próximo paso

- [ ] Ejecutar `inxi -F` y documentar CPU/RAM/disco aquí
- [ ] Instalar nmap y theHarvester
- [ ] Configurar plugin Git en Obsidian

---

_Ver también: [[setup/madre]] · [[setup/red]] · [[HOME]]_
