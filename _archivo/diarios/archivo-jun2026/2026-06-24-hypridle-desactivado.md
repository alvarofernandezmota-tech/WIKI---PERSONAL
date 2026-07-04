---
tags: [setup, hyprland, hypridle, pantalla, omarchy, madre]
fecha: 2026-06-24
estado: ✅ hecho
relacionado: [[setup/acer-pantalla]] · [[setup/madre]] · [[setup/varopc]]
---

# Hypridle desactivado — sin bloqueo ni screensaver

## Problema

La Madre bloqueaba la pantalla y lanzaba el screensaver tras inactividad mediante `hypridle` + `omarchy-system-lock`.

## Solución aplicada

Comentadas todas las líneas activas en `~/.config/hypr/hypridle.conf` desde terminal sin entrar en editor:

```bash
# Comentar screensaver
sed -i 's/^.*omarchy-launch-screensaver.*$/# &/' ~/.config/hypr/hypridle.conf

# Comentar hyprlock
sed -i 's/^.*hyprlock.*$/# &/' ~/.config/hypr/hypridle.conf

# Comentar lock y wake
sed -i 's/^.*omarchy-system-lock.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*omarchy-system-wake.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*inhibit_sleep.*$/# &/' ~/.config/hypr/hypridle.conf
```

## Verificar

```bash
cat ~/.config/hypr/hypridle.conf
```

Todas las líneas con `omarchy` deben aparecer comentadas con `#`.

## Resultado esperado

- ✅ Sin bloqueo de pantalla por inactividad
- ✅ Sin screensaver
- ✅ Pantalla se queda en el escritorio sin moverse
- ✅ No pide contraseña si no se toca el teclado

## Pendiente

- [ ] Confirmar visualmente que funciona en la Madre
- [ ] Migrar nota a [[setup/acer-pantalla]] como referencia permanente
