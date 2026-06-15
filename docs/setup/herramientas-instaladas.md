# 🛠️ Herramientas Instaladas — Madre (Arch Linux)

> Registro de todo el software instalado en el sistema, organizado por categoría.
> Última actualización: 2026-06-15

---

## Virtualización

| Herramienta | Instalación | Estado | Notas |
|---|---|---|---|
| `qemu-full` | `pacman` | ✅ Instalado | QEMU completo con todas las arquitecturas |
| `virt-manager` | `pacman` | ✅ Instalado | GUI para gestionar VMs |
| `virt-viewer` | `pacman` | ✅ Instalado | Visor de consola de VMs |
| `libvirt` | `pacman` | ✅ Corriendo | Servicio: `libvirtd.service` habilitado |
| `dnsmasq` | `pacman` | ✅ Instalado | DNS/DHCP para redes virtuales |
| `bridge-utils` | `pacman` | ✅ Instalado | Puentes de red para VMs |

```bash
# Comandos de instalación
sudo pacman -S qemu-full virt-manager virt-viewer libvirt dnsmasq bridge-utils
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
```

---

## Herramientas de Sistema

| Herramienta | Instalación | Estado | Notas |
|---|---|---|---|
| `wget` | `pacman` | ✅ Instalado | Descargas desde terminal con reanudación |
| `curl` | sistema | ✅ Nativo | Descargas y peticiones HTTP |
| `git` | sistema | ✅ Nativo | Control de versiones |

```bash
# Instalación
sudo pacman -S wget
```

---

## Lab Android — Recuperación de Dispositivos

| Herramienta | Instalación | Estado | Notas |
|---|---|---|---|
| `sfd_tool` | compilado | ✅ Funcionando | Nativo Linux — Unisoc/Spreadtrum |
| `mtkclient` | Python/pip | ✅ Instalado | MediaTek — diagnóstico rápido USB |
| SPD UpgradeDownload | Windows VM | ⏸ Pendiente | Instalar dentro de la VM |
| Spreadtrum USB Driver | Windows VM | ⏸ Pendiente | Instalar dentro de la VM |
| Odin3 | Windows VM | ⏸ Pendiente | Samsung — instalar dentro de la VM |
| Samsung USB Drivers | Windows VM | ⏸ Pendiente | Instalar dentro de la VM |

> 📁 Ver guía completa: `docs/setup/android-rescue-lab/README.md`

---

## Descargas en curso / pendientes

| Archivo | Tamaño | Destino | Comando |
|---|---|---|---|
| ROM Redmi A5 Global `.tgz` | 4.9GB | `~/isos/redmi-a5/` | `wget -c <url>` |
| ISO Windows 11 | ~6GB | `~/isos/` | Navegador — microsoft.com |

```bash
# ROM Redmi A5 Global (serenity)
cd ~/isos/redmi-a5
wget -c "https://bkt-sgp-miui-ota-update-alisgp.oss-ap-southeast-1.aliyuncs.com/A15.0.26.0.VGWMIXM/serenity_global-images-A15.0.26.0.VGWMIXM-user-20260427.0000.00-15.0-global-26c6dc7975.tgz"
```

---

## Próximos pasos

- [ ] Descargar ISO Windows 11 (~6GB)
- [ ] Descargar ROM Redmi A5 Global (4.9GB)
- [ ] Crear VM Windows 11 en virt-manager
- [ ] Configurar USB passthrough (VID Unisoc: `0x1782`)
- [ ] Instalar herramientas Windows dentro de la VM
- [ ] Flashear Redmi A5 con la ROM descargada

---

> ⚠️ **Nota:** Las herramientas marcadas como "Windows VM" NO se instalan en Arch.
> Todo lo propietario va dentro de la máquina virtual para mantener Arch limpio.
