---
tags: [hardware, madre, servidor]
fecha-actualizacion: 2026-07-05
---

# 🖥️ Madre — varopc

## Hardware
- CPU: Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz
- RAM: 15Gi
- Kernel: 7.0.9-arch2-1
- OS: Arch Linux

## Discos
NAME       SIZE TYPE  MOUNTPOINT
sda      931.5G disk  
├─sda1       2G part  /boot
└─sda2   929.5G part  
  └─root 929.5G crypt /home
zram0        4G disk  [SWAP]

## Red
- Hostname: varpc
- 127.0.0.1/8
- 100.91.112.32/32
- 172.23.0.1/16
- 172.24.0.1/16
- 172.17.0.1/16
- 172.21.0.1/16
- 172.18.0.1/16
- 172.22.0.1/16
- 172.19.0.1/16
- 172.20.0.1/16
- 192.168.72.1/24
- 10.48.234.2/24
- 172.25.0.1/16


## Programas clave
| Programa | Versión | Para qué |
|---|---|---|
| Docker | $(docker --version 2>/dev/null | cut -d' ' -f3 | tr -d ',') | Contenedores |
| Git | $(git --version | cut -d' ' -f3) | Control de versiones |

## BIOS
- Versión: PENDIENTE — ejecutar `sudo dmidecode -s bios-version`
- XMP: PENDIENTE
- Boot order: PENDIENTE

## Notas
- Usuario principal: varopc
- Tailscale IP: 100.91.112.32
