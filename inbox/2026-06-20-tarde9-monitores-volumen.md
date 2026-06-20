---
fecha: 2026-06-20
hora: ~19:20–20:00
tags: [setup, hyprland, monitores, volumen, madre, pendiente]
estado: parcialmente-completado
relacionado: [[2026-06-20-tarde5-cierre-acer-inicio-madre]], [[2026-06-20-tarde8-madre-ia-local]]
---

# Sesión tarde9 — Monitores, Sony Bravia, Volumen

## Contexto

Sesión de configuración del escritorio en la madre (PC nuevo). Continuación de la tarde8. Se trabaja sobre Hyprland + Omarchy con 2 monitores activos.

## Hardware detectado

GPU conectada a `card1` (PCI 0000:01:00.0). Puertos disponibles:

| Puerto | Estado |
|--------|--------|
| DP-1 | ✅ Conectado — monitor principal |
| HDMI-A-1 | ✅ Conectado — Sony Bravia |
| DVI-D-1 | ⬜ Libre |
| DVI-D-2 | ⬜ Libre |

## Configuración monitors.conf

Archivo: `~/.config/hypr/monitors.conf`  
Config activa al inicio de la sesión (problemática — scale 2 en pantallas 1080p):

```ini
monitor=DP-1,preferred,0x0,2
env = GDK_SCALE,2
monitor=,preferred,auto,auto
```

### ✅ Fix aplicado

```ini
env = GDK_SCALE,1
monitor = DP-1, 1920x1080@60, 0x0, 1
monitor = HDMI-A-1, 1920x1080@60, 1920x0, 1
```

Workspaces configurados en `hyprland.conf`:
- WS 1–5 → DP-1
- WS 6–10 → HDMI-A-1

## Sony Bravia — Overscan

**Problema:** No se veía el escritorio completo en la tele Sony.  
**Causa:** Overscan activado por defecto en las Bravia.  
**Solución:** Menú Sony → Ajustes → Pantalla → **Área de visualización → Full Pixel**

> ✅ Resuelto desde el menú de la tele, sin tocar Linux.

## Salvapantallas hypridle

**Problema:** Comportamiento raro del screensaver.  
**Solución:** Comentar los dos listeners de timeout en `~/.config/hypr/hypridle.conf`:

```ini
# listener {
#     timeout = 150
#     on-timeout = pidof hyprlock || omarchy-launch-screensaver
# }
# listener {
#     timeout = 152
#     on-timeout = omarchy-system-lock
#     on-resume = omarchy-system-wake
# }
```

> ✅ Resuelto.

## Pendientes de esta sesión

- [ ] **Volumen** — Los botones físicos no controlan el volumen del sistema. Falta mapear `XF86AudioRaiseVolume` / `XF86AudioLowerVolume` en Hyprland. Primero verificar con `pactl info` si usa PipeWire o PulseAudio.
- [ ] **Tercera pantalla** — Posible conexión de un 3er monitor por DVI-D. Necesita adaptador DVI-D → HDMI si el monitor solo tiene HDMI.
- [ ] **Configuración completa de la madre** — Documentar el setup completo del PC (hardware, particiones, servicios, etc.) en `setup/` de yggdrasil. Está pendiente desde tarde5.

## Comandos útiles de la sesión

```bash
# Ver puertos GPU disponibles
ls /sys/class/drm/

# Ver qué keybinds de volumen hay configurados
grep -n "volume\|XF86Audio" ~/.config/hypr/hyprland.conf

# Verificar backend de audio
pactl info | grep "Server Name"

# Recargar configuración Hyprland
hyprctl reload
```
