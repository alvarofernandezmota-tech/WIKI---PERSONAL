# 📱 Móvil — Hotspot Permanente y ADB

> Migrado/consolidado: 2026-06-25
> Origen: `inbox/2026-06-24-hotspot-red-situacion.md` + `inbox/2026-06-24-SESION-NOCHE-MOVIL.md`

## Situación actual
- El móvil actúa como hotspot/gateway para la Madre cuando no hay red fija
- Problema: el hotspot se desactiva solo (ahorro de batería, DUN required)
- Objetivo: hotspot **siempre activo** sin intervención manual

## Fix 1: ADB — Desactivar DUN required
```bash
# Conectar móvil por USB con depuración ADB activa
adb devices

# Fix hotspot tethering
adb shell settings put global tether_dun_required 0

# Verificar
adb shell settings get global tether_dun_required
# Debe devolver: 0
```

## Fix 2: Desactivar ahorro de batería para hotspot
```bash
# En el móvil (o via ADB)
adb shell dumpsys battery set level 100  # solo para testing
adb shell settings put global stay_on_while_plugged_in 7
```

## Fix 3: Tailscale como alternativa de conectividad
- Instalar Tailscale en el móvil
- La Madre se conecta via Tailscale (VPN mesh) aunque el hotspot cambie de IP
- APK: descargar de https://tailscale.com/download/android

## Fix 4: systemd keepalive (en la Madre)
```bash
# Crear timer que monitorice la conexión y reconecte
# Ver: scripts/hotspot-keepalive.sh
```

## Estado de pruebas

| Fix | Estado | Fecha |
|-----|--------|-------|
| ADB tether_dun_required | 🔄 Probando | 2026-06-25 |
| Tailscale APK | ⏳ Pendiente | - |
| systemd keepalive | ⏳ Pendiente | - |

## Notas
- El hotspot activo siempre bloquea que la VM/Docker pueda tirar modelos grandes
- Considerar: cuando la Madre tenga red fija, el móvil pasa a modo secundario
