# Windows 11 VM en KVM/QEMU

## Obtener la ISO

Microsoft no permite descarga directa desde terminal. Usar **UUP dump**:

```bash
# Instalar dependencias
sudo pacman -S aria2 cabextract cdrtools chntpw wimlib

# Descargar script de UUP dump (build 26100.x amd64, es-es, Pro)
wget "https://uupdump.net/get.php?id=fe1f1547-38fb-4867-a152-ddec85a47b37&pack=es-es&edition=professional&autodl=2&updates=1" \
  -O ~/Downloads/uup_win11.zip

# Extraer y ejecutar
cd ~/Downloads
unzip uup_win11.zip -d uup
cd uup
chmod +x uup_download_linux.sh
./uup_download_linux.sh

# Mover ISO resultante
mv ~/Downloads/uup/*.iso ~/Downloads/win11.iso
```

> ⚠️ Los IDs de UUP dump cambian con cada build. Buscar la más reciente en https://uupdump.net/known.php?q=Windows+11+24H2&search=1

## Crear la VM

```bash
virt-install \
  --name win11 \
  --ram 4096 \
  --vcpus 2 \
  --disk path=/home/varopc/win11.qcow2,size=50 \
  --cdrom /home/varopc/Downloads/win11.iso \
  --os-variant win11 \
  --graphics spice \
  --boot cdrom,hd \
  --connect qemu:///session \
  --noautoconsole
```

## Abrir consola

```bash
virt-viewer --connect qemu:///session win11
```

## Problemas conocidos

### Error NVRAM al undefine
```
error: Cannot undefine domain with NVRAM/varstore
```
**Solución:** Usar `--nvram` al hacer undefine:
```bash
virsh --connect qemu:///session undefine win11 --nvram --remove-all-storage
```

### --remove-all-storage borra la ISO
`--remove-all-storage` elimina todos los volúmenes registrados, **incluyendo la ISO**. Hacer copia de seguridad antes o volver a descargarla.

## Estado instalación (2026-06-25)

- [x] KVM/QEMU instalado
- [x] Dependencias UUP dump instaladas
- [x] Script UUP dump descargado
- [ ] ISO generada
- [ ] VM instalada
