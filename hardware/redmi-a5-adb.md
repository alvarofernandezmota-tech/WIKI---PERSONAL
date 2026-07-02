---
tags: [tipo/debug, estado/activo, hardware, redmi, adb, android]
fecha: 2026-07-01
---

# 📱 Redmi A5 — ADB bloqueos y workarounds

> Host: madre (`varopc`) → USB → Redmi A5
> Fuente: `inbox/2026-07-01-redmi-adb-bloqueos.md`

## Estado

| Parámetro | Valor |
|---|---|
| Rol principal | Hotspot 4G → internet a madre |
| ADB | ✅ instalado y funcional |
| Tailscale iOS | ✅ instalado vía ADB |
| Tailscale login | ⚠️ pendiente (requiere abrir app en pantalla) |

## Bloqueos detectados y workarounds

### 1. `adb devices` no detecta tras reboot

```bash
# Workaround
adb kill-server
adb start-server
adb devices
# Si sigue sin aparecer: desconectar y reconectar USB
```

### 2. Depuración USB se desactiva sola

- MIUI desactiva la depuración USB tras 7 días sin uso si el móvil está bloqueado
- **Workaround:** Mantener pantalla activa peridicamente o desactivar ahorro batería para ADB
- Config → Opciones desarrollador → Depuración USB = ON (verificar tras cada reboot)

### 3. Instalar APK vía ADB sin pantalla

```bash
adb install -r tailscale-full.apk
# -r = reemplazar si ya existe
# No requiere confirmación en pantalla
```

### 4. Ver logs Tailscale desde madre

```bash
adb logcat | grep -i tailscale
```

## 🗓️ Pendientes

- [ ] Iniciar sesión Tailscale en Redmi (requiere tocar pantalla físicamente)
- [ ] Desactivar ADB cuando Tailscale esté activo y no se necesite ADB
- [ ] Documentar si MIUI bloquea Tailscale en background
