---
tags: [inbox, debug, android, adb, tailscale, uup, windows]
fecha: 2026-06-25
estado: en-progreso
dispositivo: mvj78dnnljlzukk7
---

# 🐛 Sesión Debug — ADB · Tailscale · UUP · 2026-06-25

## Contexto

Sesión de troubleshooting multitarea en el homelab. Tres frentes abiertos en paralelo:
1. Control remoto de Android por ADB (inyección de eventos)
2. Instalación de Tailscale en el móvil vía ADB
3. Descarga de imagen ISO Windows 11 mediante UUP Dump

---

## Problema 1 — INJECT_EVENTS denegado en Android 14

### Síntoma
```
adb -s mvj78dnnljlzukk7 shell input keyevent 26
→ SecurityException: Injecting input events requires INJECT_EVENTS permission
```

### Causa
Android 14 (posiblemente Xiaomi/HyperOS) bloquea la inyección de eventos por ADB si no está activada la opción "Depuración USB (Configuración de seguridad)".

### Solución
1. Ir a **Ajustes → Opciones de desarrollador**
2. Activar **"Depuración USB (Configuración de seguridad)"**
3. Reiniciar el dispositivo
4. En Xiaomi: verificar que la cuenta Mi esté vinculada

### Alternativa sin permiso
Usar [[scrcpy]] o [[Appium]] que gestionan la capa de eventos de forma más robusta.

---

## Problema 2 — WRITE_SECURE_SETTINGS denegado

### Síntoma
```
adb shell settings put global oem_unlock_supported 1
→ SecurityException: Permission denial, must have WRITE_SECURE_SETTINGS
```

### Causa
Android 14 no permite escribir ajustes seguros desde ADB sin root ni autorización explícita.

### Estado
⚠️ Bloqueado sin root. El OEM unlock debe hacerse manualmente desde el móvil:
- Ajustes → Opciones de desarrollador → Desbloqueo OEM (actívalo manualmente)

> **Nota:** El desbloqueo OEM borra todos los datos del dispositivo.

---

## Problema 3 — Tailscale APK (404 en pkgs.tailscale.com)

### Síntoma
```
wget https://pkgs.tailscale.com/stable/tailscale-latest.apk
→ ERROR 404: Not Found
```

### Causa
El endpoint `/stable/tailscale-latest.apk` no existe. Tampoco la URL con versión hardcodeada `tailscale-1.80.3-android.apk`.

### Solución ✅
```bash
# Descarga desde GitHub Releases oficial
wget https://github.com/tailscale/tailscale-android/releases/latest/download/tailscale-release.apk \
  -O tailscale.apk

adb -s mvj78dnnljlzukk7 install tailscale.apk
```

Fuente oficial: https://github.com/tailscale/tailscale-android

---

## Problema 4 — uup_download_linux.sh: No such file or directory

### Síntoma
```
./uup_download_linux.sh
→ bash: No such file or directory
```

### Causa
El script se ejecutó desde un directorio diferente al raíz del proyecto UUP.

### Solución ✅
```bash
cd ~/Downloads/uup
bash uup_download_linux.sh
```

### Estado descarga UUP
- ✅ Archivos OK descargados correctamente
- ❌ Archivos ERR (se reanudan automáticamente al relanzar el script):
  - `Microsoft-Windows-LanguageFeatures-TextToSpeech-es-es`
  - `Microsoft-Windows-Client-LanguagePack-Package-es-ES.esd`
  - `Windows11.0-KB5102558-x64.cab`
  - `Windows11.0-KB5043080-x64.msu`
  - `Microsoft-Windows-Client-Features-Package.ESD`
  - `professional_es-es.esd`
  - `Microsoft-Windows-Client-Desktop-Required-Package.ESD`
  - `Windows11.0-KB5087054-x64-NDP481.cab`
  - `HyperV-OptionalFeature-VirtualMachinePlatform-Client-Disabled`
  - `Windows11.0-KB5095093-x64.msu`

Para reanudar:
```bash
cd ~/Downloads/uup && bash uup_download_linux.sh
```

---

## Paso a paso resumen

```
[ ] 1. Activar "Depuración USB (Seg.)" en opciones desarrollador del móvil
[ ] 2. Reiniciar móvil
[ ] 3. wget tailscale desde GitHub Releases → adb install
[ ] 4. cd ~/Downloads/uup && bash uup_download_linux.sh (reanudar ERR)
[ ] 5. Verificar instalación Tailscale en móvil y conectar a la red
```

---

## Comandos de verificación

| Checks | Comando |
|---|---|
| Permisos ADB activos | `adb shell dumpsys input` |
| Tailscale instalado | `adb shell pm list packages \| grep tailscale` |
| Estado descarga UUP | `ls -lh ~/Downloads/uup/UUPs/*.aria2` |

---

## Referencias
- [[android-adb]]
- [[tailscale-homelab]]
- [[windows-iso-uup]]
- [[ECOSISTEMA]]
