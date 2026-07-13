---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/acer.md
tags: [isla, acer, dotfiles, arch, hyprland, neovim, zsh]
status: auditada
repo_principal: acer-config
---

# Isla: Acer (Dotfiles + Dev local)

> Laptop de desarrollo personal. Arch Linux con Hyprland como WM.
> El entorno completo vive en `acer-config` — dotfiles, scripts, configuración.

---

## Identidad

| Campo | Valor |
|-------|-------|
| Máquina | Acer Aspire (laptop) |
| OS | Arch Linux |
| WM | Hyprland (Wayland) |
| Shell | zsh |
| Editor | Neovim |
| Terminal | Kitty / Alacritty |
| Repo dotfiles | [`acer-config`](https://github.com/alvarofernandezmota-tech/acer-config) |
| Rol en ecosistema | Desarrollo local, acceso a Madre vía Tailscale/SSH |

---

## Stack de herramientas

| Herramienta | Estado | Notas |
|-------------|--------|-------|
| Hyprland | ✅ Activo | WM principal Wayland |
| Neovim | ✅ Activo | Editor principal |
| zsh + plugins | ✅ Activo | Shell |
| Tailscale | ✅ Activo | VPN acceso a Madre |
| SSH keys | ✅ Activo | Acceso a Madre y GitHub |
| Docker local | ⚪ Sin verificar | ¿Instalado? ¿Se usa? |
| acer-config | 🔴 Vacío | Solo README — pendiente versionar |

---

## Relación con el ecosistema

```
Acer (dev local)
  ├── SSH/Tailscale → Madre (ejecutar servicios)
  ├── Git push → GitHub → CI Actions
  ├── MCP → Perplexity/Claude (gestión repos)
  └── acer-config → dotfiles versionados (pendiente)
```

---

## Estado real — 2026-07-13

🟡 **acer-config existe pero está prácticamente vacío** (solo README de 87 bytes).

Pendiente:
- [ ] Versionar dotfiles reales: `~/.config/hypr/`, `~/.config/nvim/`, `~/.zshrc`
- [ ] Añadir script de instalación/bootstrap (`install.sh`)
- [ ] Documentar qué scripts comparte con Madre
- [ ] Verificar si tiene Docker instalado y para qué se usa
- [ ] Confirmar acceso Tailscale operativo
- [ ] Actualizar esta ficha tras auditoría (#51 DEW)

---

## Issues DEW relacionados

- [DEW #51 — AUDIT-008 Auditoría Acer](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/51)

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
