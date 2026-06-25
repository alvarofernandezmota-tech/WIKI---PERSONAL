# KVM + QEMU en Arch Linux

## Instalación de dependencias

```bash
sudo pacman -S qemu-full libvirt virt-manager virt-viewer dnsmasq bridge-utils
```

## Activar servicios

```bash
sudo systemctl enable --now libvirtd
```

## Usar sin sudo (sesión de usuario)

Usar `qemu:///session` en lugar de `qemu:///system` para no necesitar root:

```bash
virt-install --connect qemu:///session ...
virsh --connect qemu:///session list --all
```

## Comandos útiles

```bash
# Listar VMs
virsh --connect qemu:///session list --all

# Iniciar VM
virsh --connect qemu:///session start <nombre>

# Apagar VM
virsh --connect qemu:///session destroy <nombre>

# Eliminar VM y almacenamiento (incluye NVRAM)
virsh --connect qemu:///session undefine <nombre> --nvram --remove-all-storage

# Abrir consola gráfica
virt-viewer --connect qemu:///session <nombre>
```

## Notas importantes

- `--remove-all-storage` borra TAMBIÉN los ISOs registrados como almacenamiento — usar con cuidado
- Para Windows 11 es necesario NVRAM (UEFI), por eso hay que usar `--nvram` al hacer undefine
