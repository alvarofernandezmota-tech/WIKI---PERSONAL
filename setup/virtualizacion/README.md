# Virtualización en varopc

> Stack de virtualización local con KVM/QEMU en Arch Linux.

## Índice

- [kvm-qemu-arch.md](./kvm-qemu-arch.md) — Instalación y configuración de KVM, QEMU, libvirt y virt-manager en Arch Linux
- [win11-vm.md](./win11-vm.md) — Proceso completo de instalación de Windows 11 como VM

## Estado actual

| VM | Estado | Notas |
|---|---|---|
| win11 | 🔄 En instalación | ISO descargándose vía UUP dump (2026-06-25) |

## Stack

- **Hypervisor:** KVM + QEMU
- **Gestión:** libvirt (qemu:///session)
- **Gráficos:** SPICE
- **Host:** Arch Linux (varopc)
