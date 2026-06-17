# 💻 varopc (Acer Theodora) — Setup

> PC de desarrollo principal.
> Última actualización: 17 junio 2026

---

## Hardware

| Campo | Valor |
|---|---|
| Nombre | varopc / Acer Theodora |
| CPU | Ryzen 5 5500U |
| RAM | 8GB |
| OS | Arch Linux + Hyprland/Wayland (Omarchy) |
| IP Tailscale | `100.86.119.102` |
| IP local | `10.134.31.171` |

---

## Software instalado

| Herramienta | Estado | Notas |
|---|---|---|
| Arch Linux + Hyprland | ✅ | Omarchy |
| Tailscale | ✅ | IP `100.86.119.102` |
| UFW | ✅ | Activo |
| whisrs | ✅ | Voz — Super+V |
| Docker | ✅ | Instalado |
| Git | ✅ | Nativo |
| Python 3 | ✅ | Nativo |
| KVM / QEMU | ✅ | qemu-full + virt-manager |
| libvirtd | ✅ | Activo y habilitado |
| Ollama | ✅ | qwen2.5-coder:14b · deepseek-r1:14b · qwen3:8b |
| LiteLLM proxy | ✅ | Puerto :8000 |
| OpenCode | ✅ | Configurado con opencode.json |
| curl | ✅ | Nativo |
| wget | ⏳ Pendiente | `sudo pacman -S wget` |
| Obsidian | ⏳ Pendiente | Ver [obsidian.md](obsidian.md) |

---

## Red

- Tailscale P2P con Madre ✅
- AP Isolation en router bloquea UDP LAN → lan-mouse no funciona ⚠️
- Solución: desactivar AP Isolation en panel router

---

## Lab Android (varopc)

| Herramienta | Estado |
|---|---|
| sfd_tool | ✅ Compilado y funcionando |
| mtkclient | ✅ Instalado |
| KVM para Windows VM | ✅ Listo |
| ROM Redmi A5 | ⏳ Descargando (curl en curso) |

---

## Próximos pasos

```bash
# 1. wget
sudo pacman -S wget

# 2. Obsidian
yay -S obsidian
# Abrir vault: ~/repos/yggdrasil-dew

# 3. Clonar yggdrasil-dew para Obsidian
mkdir -p ~/repos
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git ~/repos/yggdrasil-dew
```

---

_Parte de [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)_
