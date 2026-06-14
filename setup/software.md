# Software instalado — Madre

> Programas instalados en el ordenador Madre (Omarchy / Arch Linux).
> **Frecuencia de actualización: al instalar o desinstalar software relevante.**
> Última actualización: 14 junio 2026

---

## Gestor de paquetes

| Herramienta | Descripción |
|---|---|
| `pacman` | Gestor oficial de Arch Linux |
| `yay` | AUR helper — instalado desde fuente en `~/yay/` |

---

## Editores

| Programa | Versión | Instalación | Notas |
|---|---|---|---|
| **VSCodium** | 1.121.03429-1 | AUR (`yay -S vscodium-bin`) | VS Code sin telemetría Microsoft. Flags en `~/.config/codium-flags.conf` |

---

## Terminal y shell

Ver [`setup/terminal.md`](terminal.md) para configuración completa de zsh, starship y herramientas CLI.

---

## Entorno de desarrollo

Ver [`setup/python.md`](python.md) para entorno Python (pyenv, uv, etc.).

---

## Sistema y escritorio

| Programa | Notas |
|---|---|
| **Omarchy** | Meta-paquete Hyprland + Wayland — base del sistema |
| **Input Leap** | KVM software — Madre actúa como servidor |
| **Ollama** | LLM local — usa GPU GTX 1060 6GB |
| **Open WebUI** | Interfaz web para Ollama |

---

_Ver hardware completo en [`setup/equipos.md`](equipos.md)_
_Ver servicios activos en [`setup/servicios.md`](servicios.md)_
