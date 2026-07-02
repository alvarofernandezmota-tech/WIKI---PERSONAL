---
tags: [hardware, redmi, adb, android, bloqueos]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
---

# 📱 Redmi A5 — Bloqueos ADB

## Síntoma

ADB se desconecta tras períodos de uso o cuando la pantalla se apaga.

## Causas

- MIUI agresivo con gestión de batería — desconecta procesos USB
- Pantalla al apagarse interrumpe sesión ADB
- Config de desarrollador puede resetearse tras reinicios

## Soluciones

```bash
# Mantener pantalla encendida
adb shell settings put system screen_off_timeout 0

# Reconectar si cae
adb kill-server && adb start-server && adb devices

# Verificar conexión
adb shell echo 'ok'

# Monitor batería
adb shell dumpsys battery | grep -E 'level|temperature'
```

## Config MIUI recomendada

- Ajustes → Batería → No restricción para apps de sistema
- Ajustes → Opciones desarrollador → Mantener pantalla activa
- Desactivar optimización de batería para ADB

## Estado Tailscale en Redmi

⚠️ App instalada vía ADB ✅ pero pendiente hacer login.
Una vez con login → aparecerá en `tailscale status` con su IP asignada.

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
