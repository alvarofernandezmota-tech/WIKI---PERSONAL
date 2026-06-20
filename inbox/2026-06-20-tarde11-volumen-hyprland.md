---
fecha: 2026-06-20
hora: ~21:48
tags: [varopc, hyprland, volumen, pipewire, keybinds]
estado: pendiente-prueba
relacionado: [[2026-06-20-tarde9-monitores-volumen]]
---

# Sesión tarde11 — Volumen Hyprland + PipeWire

## Contexto

No había ningún keybind de volumen configurado en Hyprland. Los botones físicos no hacían nada.

## Sistema de audio detectado

```bash
pactl info | grep "Server Name"
# Server Name: PulseAudio (on PipeWire 1.6.5)
```

Usa **PipeWire 1.6.5** con capa de compatibilidad PulseAudio. El control nativo es `wpctl`.

## Fix aplicado

Añadido al final de `~/.config/hypr/hyprland.conf`:

```ini
# Volume controls
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```

```bash
hyprctl reload
# ok
```

## Estado

- ✅ Config añadida y Hyprland recargado
- ⏳ Pendiente probar teclas físicas de volumen

## Pendiente

- [ ] Probar botones volumen físicos del teclado
- [ ] Si no funcionan: verificar con `wev` qué keysym emiten las teclas
- [ ] Opcional: añadir OSD (indicador visual de volumen) con `swayosd` o `dunst`
