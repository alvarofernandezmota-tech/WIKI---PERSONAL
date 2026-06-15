# Laboratorio de Rescate y Recuperación Android

> Documentado: 15 junio 2026  
> Máquina host: varopc (Arch Linux + Hyprland)

---

## 🎯 Objetivo

Crear un entorno híbrido **(Nativo Arch Linux + Virtualización Windows)** para la recuperación, diagnóstico y desbloqueo (FRP) de dispositivos móviles con procesadores **Unisoc** (Redmi A5) y **Samsung** (Exynos/Snapdragon).

---

## 🖥️ Dispositivos

| Dispositivo | Chip | Rol | Estado |
|-------------|------|-----|--------|
| **varopc** | x86 | PC principal (Arch Linux) | ✅ activo |
| **Samsung (Madre)** | Exynos/Snapdragon | Servidor THDORA producción | ✅ activo |
| **Redmi A5** | Unisoc T765 (Qogirl6) | Objetivo rescate/FRP | 🔄 en proceso |

---

## ✅ Estado infraestructura

### Host (Arch Linux)
- [x] Entorno: Hyprland + Terminal
- [x] `sfd_tool` compilada y funcional en `~/sfd_tool`
- [x] Permisos USB: `/dev/ttyUSB0` y `ttyACM0` (grupos `uucp`, `lock`)
- [x] `xhost` configurado para evitar bloqueos con `sudo`
- [x] `android-tools 35.0.2-25` instalado (incluye `adb` y `fastboot`)
- [x] `android-udev 20260423-1` instalado — grupo `adbusers` creado
- [x] `usbutils 019-1` instalado — `lsusb` disponible

### Virtualización
- [x] `qemu-full`, `virt-manager`, `libvirt` instalados (139 paquetes)
- [ ] Crear VM Windows (10 Tiny / 11) para software propietario
- [ ] Configurar USB passthrough automático

### Redmi A5
- [x] Chip identificado: **Unisoc T765** (Qogirl6), modelo 25028RN03
- [x] ROM descargada y extraída: `A15.0.26.0.VGWMIXM` — ruta: `~/isos/redmi-a5/serenity_global_images_A15.0.26.0.VGWMIXM_15.0/`
- [x] `.tgz` corrupto (EOF al final) pero imágenes críticas extraídas correctamente
- [x] Bootloader bloqueado por Xiaomi OEM → fastboot completamente cerrado
- [x] Recovery (ISO del móvil) dañado
- [ ] Entrar en modo BROM con `sfd_tool`
- [ ] Flasheo completo

---

## 📦 Stack instalado

```bash
sudo pacman -S qemu-full libvirt virt-manager virt-install virt-viewer dnsmasq
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER

sudo pacman -S android-tools android-udev usbutils
sudo usermod -aG adbusers varopc
newgrp adbusers
```

> ⚠️ `wget` NO está en varopc — usar siempre `curl -L -C -` para descargas reanudables.

---

## 📱 Redmi A5 — ROM

- **Versión:** `A15.0.26.0.VGWMIXM` (Android 15, MIUI Global, build 27/04/2026)
- **Tamaño:** 4.54 GB | **Ruta:** `~/isos/redmi-a5/serenity_global.tgz`
- **Estado:** Extraída con error EOF (archivo corrupto/descarga incompleta) pero imágenes principales presentes

### Imágenes disponibles
```
blackbox.img, boot.img, cache.img, init_boot.img
l_gdsp.img, l_modem.img, pm_sys.img, prodnv.img
super.img (4.3GB), userdata.img, vbmeta*.img, vendor_boot.img
logo.bin, fdl1-sign.bin, lk-fdl2-sign.bin, lk-sign.bin
sml-sign.bin, teecfg-sign.bin, tos-sign.bin, u-boot-spl-16k-emmc-sign.bin
qogirl6_pubcp_MHM_customer_deltanv.bin
```

### Imágenes faltantes (al final del .tgz corrupto)
```
dtbo.img, rescue.img, cust.img, l_ldsp.img, l_agdsp.img
vbmeta_system_ext.img, qogirl6_pubcp_MHM_customer_nvitem.bin
```

```bash
# Descarga ROM oficial
mkdir -p ~/isos/redmi-a5 && cd ~/isos/redmi-a5
curl -L -C - -o serenity_global.tgz \
  "https://bkt-sgp-miui-ota-update-alisgp.oss-ap-southeast-1.aliyuncs.com/A15.0.26.0.VGWMIXM/serenity_global-images-A15.0.26.0.VGWMIXM-user-20260427.0000.00-15.0-global-26c6dc7975.tgz"
```

---

## 🔬 Sesión 15/06/2026 tarde — Diagnóstico completo y pivot a BROM

### Metodología de diagnóstico (de arriba a abajo)
1. Recovery → ❌ dañado
2. ADB → ❌ `unauthorized` (pantalla rota, no se puede aceptar diálogo)
3. `fastboot oem unlock` → ❌ `Err:0xffffffff`
4. `fastboot flashing unlock` → ❌ `unknown cmd`
5. Flash directo → ❌ `Flashing Lock Flag is locked. Please unlock it first!`
6. `fastboot oem flashing_unlock` → ❌ `unknown cmd`
7. `fastboot flashing unlock_critical` → ❌ `Not implement`
8. **Conclusión: fastboot 100% cerrado por Xiaomi. Única salida: BROM via `sfd_tool`**

### Tabla de estado

| Comando | Resultado |
|---|---|
| `fastboot flash fbootlogo` | ❌ `Flashing Lock Flag is locked` |
| `fastboot oem unlock` | ❌ `Err:0xffffffff` |
| `fastboot flashing unlock` | ❌ `unknown cmd` |
| `fastboot oem flashing_unlock` | ❌ `unknown cmd` |
| `fastboot flashing unlock_critical` | ❌ `Not implement` |
| `fastboot reboot` | ✅ funciona |
| `fastboot devices` | ✅ detecta el serial |
| `lsusb` en modo BROM | ❌ sin resultado (no entró en BROM) |

---

## 🔄 Pipeline validado (BROM con sfd_tool)

```
1. CONEXIÓN EN FRÍO   → Apagado + Vol↓ + USB = modo BROM (pantalla negra)
2. VERIFICAR BROM     → lsusb | grep -i "1782\|spreadtrum\|unisoc\|sprd"
3. IDENTIFICACIÓN     → sfd_tool → chip_uid
4. DUMP (OBLIGATORIO) → frp + persist + nvram
5. FLASH              → sfd_tool con ROM .pac o imágenes directas
6. VERIFICACIóN       → reboot + validar AVB
```

### Comandos sfd_tool (próximos pasos)

```bash
# 1. Verificar BROM (móvil apagado + Vol↓ + USB)
lsusb | grep -i "1782\|spreadtrum\|unisoc\|sprd"

# 2. Identificar dispositivo
cd ~/sfd_tool
sudo ./sfd_tool --scan

# 3. Dump de seguridad antes de flashear
sudo ./sfd_tool --read frp --output ~/isos/redmi-a5/backup/frp.bin
sudo ./sfd_tool --read persist --output ~/isos/redmi-a5/backup/persist.bin

# 4. Flash con XML de la ROM
sudo ./sfd_tool --flash ~/isos/redmi-a5/serenity_global_images_A15.0.26.0.VGWMIXM_15.0/images/serenity_k515_in.xml
```

---

## 💻 VM Windows — passthrough USB

```bash
lsusb
# En virt-manager → Hardware → Add Hardware → USB Host Device
```

---

## 🔧 Flujos por dispositivo

| Dispositivo | Herramienta | Necesita VM |
|-------------|-------------|-------------|
| Redmi A5 (Unisoc T765) | sfd_tool nativo Arch | ❌ No |
| Samsung (Knox) | Software propietario | ✅ Sí |

---

## ⏭️ Pendientes

- [ ] Entrar en BROM: apagar → Vol↓ + USB → verificar con `lsusb`
- [ ] `sfd_tool --scan` para identificar dispositivo en BROM
- [ ] Dump backup: frp + persist antes de flashear
- [ ] Flash con `sfd_tool` usando `serenity_k515_in.xml`
- [ ] Verificar imágenes faltantes (re-descargar ROM completa si falla)
- [ ] Crear VM Windows en virt-manager
- [ ] Configurar USB passthrough
- [ ] Documentar reinstalación Samsung (Madre)
