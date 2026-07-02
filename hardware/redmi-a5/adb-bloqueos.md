---
tags: [hardware, redmi, adb, android, bloqueos]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
---

# 📱 Redmi A5 — Bloqueos ADB

## Síntoma

ADB se desconecta o bloquea tras períodos de uso o cuando la pantalla se apaga.

## Causas identificadas

- MIUI agresivo con la gestión de batería desconecta procesos USB
- La pantalla al apagarse puede interrumpir la sesión ADB
- Configuración de desarrollador puede resetearse tras reinicios

## Soluciones

```bash
# Mantener pantalla encendida mientras carga (evita bloqueo ADB)
adb shell settings put system screen_off_timeout 0

# Si ADB se desconecta — reconectar
adb kill-server && adb start-server
adb devices

# Verificar que sigue conectado
adb shell echo 'ok'

# Ver nivel batería
adb shell dumpsys battery | grep level

# Ver temperatura (evitar >40°C)
adb shell dumpsys battery | grep temperature
```

## Configuración recomendada MIUI

- Ajustes → Batería → No restricción para apps de sistema
- Ajustes → Opciones desarrollador → Mantener pantalla activa
- Desactivar optimización de batería para ADB

## Estado Tailscale

⚠️ App instalada vía ADB ✅ pero pendiente hacer login.
Una vez con login → aparecerá en `tailscale status` con su IP asignada.

## Ver también
- [[ECOSISTEMA]]

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
