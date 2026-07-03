---
tags: [tipo/incidencia, estado/pendiente, android, adb, tailscale, redmi]
fecha: 2026-07-01
hora: 04:38 CEST
prioridad: media
---

# Redmi A5 — Bloqueos ADB y pendiente Tailscale

## Estado del dispositivo

```
Modelo:    Redmi A5
Serial:    mvj78dnnljlzukk7
Conexion:  USB a varopc ✅
ADB:       detectado (device) ✅
Pantalla:  BLOQUEADA con PIN ❌
Estado:    After First Unlock — requiere desbloqueo físico
```

## Bloqueos encontrados esta sesión

### 1. INJECT_EVENTS — no se puede inyectar input por ADB
```
SecurityException: Injecting input events requires INJECT_EVENTS permission
```
- `adb shell input keyevent 82` → ❌
- `adb shell input keyevent 26` → ❌
- `adb shell input keyevent KEYCODE_WAKEUP` → ❌
- **Causa**: pantalla bloqueada con PIN tras reinicio (After First Unlock)
- **Solución**: desbloquear físicamente una vez

### 2. APK Tailscale vacío — GitHub/pkgs bloquea descarga directa
```bash
curl -L "https://pkgs.tailscale.com/stable/tailscale-latest.apk"  → 10 bytes
curl -L "https://github.com/tailscale/tailscale-android/releases/latest/download/tailscale-release.apk" → 9 bytes
```
- GitHub devuelve redirect HTML, no el APK real
- **Solución**: descargar con `--user-agent` o desde APKMirror

### 3. ADB TCP cerrado tras tcpip 5555
```
restarting in TCP mode port: 5555
error: closed
```
- Se cierra porque la pantalla está bloqueada
- Se necesita desbloqueo físico primero

## ✅ Acción requerida (orden)

- [ ] **1. Desbloquear Redmi físicamente** (PIN/patrón)
- [ ] **2. Aceptar popup ADB** "Permitir siempre desde este ordenador"
- [ ] **3. Descargar APK Tailscale correcto**:
```bash
curl -L -A "Mozilla/5.0" \
  "https://github.com/tailscale/tailscale-android/releases/latest/download/tailscale-release.apk" \
  -o ~/tailscale.apk
ls -lh ~/tailscale.apk   # debe ser ~30-40MB
adb install ~/tailscale.apk
```
- [ ] **4. Configurar Tailscale en el Redmi** (misma cuenta que varopc e iPhone)
- [ ] **5. Anotar IP Tailscale** en `hardware/mobile-security/devices_inventory.md`
- [ ] **6. Pasar ADB a TCP** para control remoto permanente:
```bash
adb -s mvj78dnnljlzukk7 tcpip 5555
adb shell ip route   # obtener IP local del Redmi
adb connect <IP_REDMI>:5555
```

## Referencia
- Guía ADB completa: `hardware/mobile-security/adb-scrcpy-guia.md`
- Inventario dispositivos: `hardware/mobile-security/devices_inventory.md`

---
_Documentado por Perplexity vía MCP — 01 jul 2026 04:38 CEST_
