# VNC — Acceso remoto con escritorio

> Última actualización: 12 junio 2026

---

## Estado

| Item | Estado |
|---|---|
| `wayvnc` en Madre | ⚠️ No activo — `Connection timed out` el 12 jun |
| Puerto | `5900` |
| Protocolo | RFB sobre Wayland (wayvnc) |
| Acceso desde Acer | `vncviewer 100.91.112.32:5900` (requiere SSH activo primero) |

---

## 🚨 Rescate — Mañana en Madre (paso 2, después de SSH)

> wayvnc requiere sesión Wayland/Hyprland activa. No funciona desde TTY.

```bash
# Lanzar manualmente
/usr/bin/wayvnc --seat=seat0 --output=DP-1 0.0.0.0 5900

# Verificar que escucha
ss -tlnp | grep 5900
```

Desde Acer:
```bash
vncviewer 100.91.112.32:5900   # por Tailscale
vncviewer 10.176.119.171:5900  # por LAN
```

---

## Autostart en Hyprland (pendiente configurar)

Añadir en `~/.config/hypr/hyprland.conf`:

```ini
exec-once = /usr/bin/wayvnc --seat=seat0 --output=DP-1 0.0.0.0 5900
```

Así wayvnc arranca solo con cada sesión de Hyprland.

---

## VNC por Tailscale (exterior)

Si SSH está activo, tunnel seguro:

```bash
ssh -L 5900:localhost:5900 -f -N varo@100.91.112.32 && vncviewer localhost:5900
```

---

_Ver también: [rescate.md](rescate.md) · [ssh.md](ssh.md) · [tailscale.md](tailscale.md)_
_Volver al índice: [README.md](README.md)_
