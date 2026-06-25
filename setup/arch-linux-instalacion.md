---
tags: [setup, arch-linux, instalacion, bios, uefi, particionado]
fecha: 2026-06-25
author: alvarofernandezmota-tech
equipo: Acer
---

# Auditoría y Plan de Instalación Arch Linux

## 1. Configuración de BIOS/UEFI (Punto Crítico)

- **Acceso:** F2 en equipos Acer
- **Reset a defaults:** F9
- **Secure Boot:** Disabled
- **Arranque:** Seleccionar siempre la opción `UEFI: [Nombre del USB]` en Boot Menu (F12)

## 2. Auditoría de Conectividad

Si `iwd` falla con "Operation failed", usar `wpa_supplicant`:

```bash
ip link set wlan0 up
wpa_passphrase "NOMBRE_RED" "CONTRASEÑA" > /etc/wpa_supplicant.conf
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
dhcpcd wlan0
ping -c 3 8.8.8.8
```

## 3. Esquema de Particionado GPT/UEFI

Usar `cfdisk /dev/nvme0n1`:

| Partición | Tamaño | Tipo |
|---|---|---|
| p1 | 512 MiB | EFI System |
| p2 | 8 GiB | Linux swap |
| p3 | Resto | Linux filesystem |

## 4. Montaje y Base

```bash
mkfs.vfat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
swapon /dev/nvme0n1p2
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
pacstrap -K /mnt base linux linux-firmware nano networkmanager
```
