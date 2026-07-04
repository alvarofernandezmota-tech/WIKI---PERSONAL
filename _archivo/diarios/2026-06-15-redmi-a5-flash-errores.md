# 📱 Diario Técnico — 15 Junio 2026
## Intento de flash Redmi A5 (Serenity) con ROM MIUI/HyperOS

---

## 🎯 Objetivo
Flashear ROM `serenity_global_images_A15.0.26.0.VGWMIXM_15.0` en Redmi A5 (codename: serenity, chipset: Unisoc T760) usando SFD Tool en Arch Linux / Hyprland.

---

## 🛠️ Entorno
- **OS:** Arch Linux con Hyprland (Wayland)
- **Herramienta:** SFD Tool (compilado desde source en `~/sfd_tool/build/sfd_tool`)
- **ROM:** `serenity_global_images_A15.0.26.0.VGWMIXM_15.0` en `~/isos/redmi-a5/`
- **Dispositivo detectado en fastboot:** `863d0058304831323851135e23407c`

---

## ❌ Errores encontrados

### 1. Bootloader bloqueado (Flashing Lock)
```
fastboot flash fbootlogo images/logo.bin
→ FAILED (remote: 'Flashing Lock Flag is locked. Please unlock it first!')
```

### 2. Comandos de desbloqueo no implementados
```
fastboot oem flashing_unlock  → FAILED (remote: 'unknown cmd.')
fastboot flashing unlock_critical → FAILED (remote: 'Not implement.')
fastboot oem edl              → FAILED (remote: 'unknown cmd.')
fastboot oem get-brom         → FAILED (remote: 'unknown cmd.')
fastboot oem sprd-brom        → FAILED (remote: 'unknown cmd.')
fastboot reboot-edl           → fastboot: usage: unknown command reboot-edl
fastboot oem unlock           → FAILED (remote: 'Unlock failed - Err:0xffffffff')
```

### 3. ADB unauthorized
```
adb devices → 863d0058304831323851135e23407c  unauthorized
adb reboot bootloader → error: device unauthorized
```
El móvil está dañado y no arranca para mostrar el popup de autorización ADB.

### 4. SFD Tool GUI no abre con sudo (problema Wayland/XWayland)
```
(sfd_tool): Gtk-WARNING: cannot open display: :0
→ Authorization required, but no authorization protocol specified
```
**Solución encontrada:** Crear script con variables explícitas:
```bash
sudo DISPLAY=:0 XAUTHORITY=/home/varopc/.Xauthority -E /home/varopc/sfd_tool/build/sfd_tool \
  --fdl1 .../fdl1-sign.bin \
  --fdl2 .../lk-fdl2-sign.bin \
  --xml .../serenity_k515_in.xml \
  --port sprd4
```
La GUI abre pero el dispositivo no conecta en modo BROM.

### 5. BROM no accesible por hardware
- `Vol Abajo + USB` → no entra en BROM
- `Vol Arriba + USB` → no entra en BROM  
- `Vol Arriba + Vol Abajo + USB` → no entra en BROM
- El móvil está dañado — no arranca normalmente

### 6. lsusb — BROM detectado brevemente
```
Bus 001 Device 089: ID 1782:4d00 Spreadtrum Communications Inc.
```
En un intento se detectó `1782:4d00` (BROM) pero SFD Tool no lo capturó a tiempo.

---

## ✅ Lo que funciona
- `fastboot devices` detecta el dispositivo correctamente
- `fastboot oem get_identifier_token` devuelve token: `4d4335343057313134313437`
- SFD Tool compila y abre GUI correctamente con el script de entorno

---

## 🔄 Estado actual
- **Bloqueado** en: no se puede entrar en modo BROM de forma estable
- **Próximo paso A:** Instalar Wine + MiUnlock para desbloqueo oficial con token
- **Próximo paso B:** Test point físico en placa madre (última opción hardware)
- **Pendiente también:** Flash Samsung (otro dispositivo)

---

## 📝 Notas
- El test point del Redmi A5 está documentado en: https://romprovider.com/xiaomi-redmi-a5-test-point-reboot-edl-mod/
- MiUnlock requiere cuenta Mi vinculada al dispositivo
- El `.tgz` de la ROM descargado está corrupto (`gzip: stdin: unexpected end of file`) pero la carpeta extraída previamente tiene todos los archivos correctos

---
*Entrada generada automáticamente por Perplexity AI — sesión 15 Jun 2026*
