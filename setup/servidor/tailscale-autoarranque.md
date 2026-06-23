---
tags: [tailscale, systemd, arch, autoarranque, seguridad]
fecha: 2026-06-24
maquina: madre
---

# Tailscale Autoarranque Permanente — Arch Linux

## Activar servicio systemd

```bash
sudo systemctl enable --now tailscaled
sudo systemctl status tailscaled   # debe decir active (running)
```

## Auth con authkey (sin intervención manual)

1. Genera la key en https://admin.tailscale.com/settings/keys
   - Marca: **Reusable** + **No expiry**
2. Ejecuta:

```bash
sudo tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX
```

## Verificar que nunca se cae

```bash
tailscale status
journalctl -u tailscaled -f   # logs en tiempo real
```

## Reinicio test

```bash
sudo reboot
# Tras reiniciar:
tailscale status
```

## IP Tailscale Madre

- `100.91.112.32` — IP fija asignada por Tailscale
