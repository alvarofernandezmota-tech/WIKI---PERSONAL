# Acer — Pantalla siempre activa (sin bloqueo ni salvapantallas)

> Objetivo: que el Acer se quede en la pantalla de inicio de sesión sin bloquearse, sin pedir contraseña y sin salvapantallas.
> Fecha: 24 junio 2026

---

## Contexto

El Acer (hostname `theodora`) corre **Arch Linux sin escritorio**. No tiene Hyprland, hyprctl ni xset. El bloqueo de pantalla era gestionado por `hypridle`.

---

## Lo que se hizo

### 1. Parar y desactivar hypridle

```bash
systemctl --user stop hypridle
systemctl --user disable hypridle
```

✅ Resultado: hypridle parado y desactivado permanentemente.

### 2. Notas sobre comandos que NO aplican en Acer

Estos comandos son **solo para máquinas con escritorio (Hyprland/X11)** — NO funcionan en Acer:

```bash
# SOLO MADRE/varopc — NO ejecutar en Acer
hyprctl keyword misc:no_direct_scanout true   # requiere Hyprland
xset s off                                     # requiere X11
xset -dpms                                    # requiere X11
```

---

## Para la Madre (varopc) — quitar bloqueo en Hyprland

Si quieres hacer lo mismo en la Madre (que tiene Hyprland):

### 1. Parar hypridle

```bash
systemctl --user stop hypridle
systemctl --user disable hypridle
```

### 2. Editar hypridle.conf

```bash
nano ~/.config/hypr/hypridle.conf
```

Comenta o borra todos los bloques `listener` y deja solo:

```bash
# hypridle desactivado — no bloquear, no apagar pantalla
```

### 3. Quitar hyprlock del autostart

```bash
# Buscar si está en el autostart de Hyprland
grep -r "hyprlock\|hypridle" ~/.config/hypr/

# Si aparece exec-once = hypridle → comentar con #
nano ~/.config/hypr/hyprland.conf
```

### 4. Quitar apagado de pantalla (DPMS) en Hyprland

En `~/.config/hypr/hyprland.conf` añadir:

```bash
misc {
    # Desactivar apagado automático de pantalla
}

# Y en monitor:
monitor = ,preferred,auto,1
```

O desde terminal:

```bash
hyprctl dispatch dpms on
```

---

## Estado

| Máquina | hypridle | Pantalla siempre activa |
|---|---|---|
| Acer (theodora) | ✅ Desactivado | ✅ Sí |
| Madre (varopc) | ⏳ Pendiente | ⏳ Pendiente |

---

_Ver también: [[setup/acer]] · [[setup/madre]] · [[setup/varopc]]_
