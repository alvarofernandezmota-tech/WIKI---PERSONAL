---
tags: [sesion, cierre, monitor, hypridle, ollama, descargas]
fecha: 2026-06-24
hora-cierre: 07:32 CEST
estado: ✅ cerrado
relacionado: [[setup/acer-pantalla]] · [[inbox/2026-06-24-hypridle-desactivado]] · [[setup/madre]]
---

# Cierre sesión madrugada — 24 jun 2026

## Resumen sesión

Sesión masiva desde medianoche hasta las 07:32h. +50 commits.

## Lo que se hizo esta madrugada

### ✅ Hypridle desactivado

Comentadas todas las líneas activas en `~/.config/hypr/hypridle.conf`:

```bash
sed -i 's/^.*omarchy-launch-screensaver.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*hyprlock.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*omarchy-system-lock.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*omarchy-system-wake.*$/# &/' ~/.config/hypr/hypridle.conf
sed -i 's/^.*inhibit_sleep.*$/# &/' ~/.config/hypr/hypridle.conf
```

Resultado: sin bloqueo, sin screensaver, pantalla quieta. ✅

### 📊 Estado descargas a las 07:26h

| Métrica | Estado |
|---------|--------|
| Modelos Ollama listos | 1/7 (`qwen2.5:3b` 1.9GB) |
| Modelo en curso | `qwen2.5:14b` — 24% (2.1GB/9GB) |
| Velocidad | ~348 KB/s |
| ETA modelo actual | ~5h (termina ~13:00h) |
| Containers up | 9/9 ✅ todos healthy |
| Imágenes Docker | 27/33 objetivo |

### 🖥️ Script monitor madre

Se intentó crear script de monitorización interactivo desde el Acer.
Pendiente de ajustar host SSH correcto para conectar a Madre.

```bash
# Pendiente — guardar en ~/monitor.sh con host correcto
bash ~/monitor.sh
```

## Pendiente para mañana

- [ ] Confirmar visualmente que hypridle no salta en Madre
- [ ] Arreglar bug `awk` en script monitor
- [ ] Ajustar host SSH en monitor.sh
- [ ] Ver cuántos modelos Ollama terminaron
- [ ] Script `generar-diario.sh` automático
- [ ] SSH sin contraseña Acer → Madre

## Nota

> Llevas despierto desde medianoche. +50 commits. La Madre sigue descargando sola. **A dormir.** 🛌
