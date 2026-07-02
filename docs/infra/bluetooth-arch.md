---
tags: [infra, bluetooth, arch, bluez]
fecha-actualizacion: 2026-07-02
---

# 🔵 Bluetooth en Arch Linux — Diagnóstico y Fix

## Síntoma típico
`bluetoothctl` → `Waiting to connect to bluetoothd...` — el daemon no está corriendo.

## Causa
En Arch, `bluetooth.service` viene **deshabilitado por defecto**. Hay que habilitarlo manualmente.

## Fix
```bash
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
systemctl status bluetooth  # verificar Active: running
```

## Diagnóstico previo
```bash
rfkill list        # verificar que no hay soft/hard block
dmesg | grep -i bluetooth  # errores a nivel kernel
journalctl -u bluetooth -n 50  # logs del servicio
```

## Warning conocido — bluez 5.86
```
Failed to set default system config for hci0
```
Este warning aparece en `journalctl -u bluetooth` con bluez 5.86 en Arch. **No impide el funcionamiento**. Issue upstream: https://github.com/bluez/bluez/issues/1905

## Paquetes necesarios
```bash
sudo pacman -S bluez bluez-utils
```

---
_Documentado: 02-jul-2026 en Theodora (Acer) — Perplexity vía MCP_
