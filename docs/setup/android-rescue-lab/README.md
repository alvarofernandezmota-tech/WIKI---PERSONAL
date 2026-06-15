# 🛠️ Laboratorio de Recuperación de Dispositivos Android

> **Repo:** `personal-v2` — Documentación del entorno de reparación profesional.
> **Host:** Arch Linux (Madre) + KVM/QEMU para herramientas Windows propietarias.

---

## Estado actual

| Componente | Estado | Notas |
|---|---|---|
| `sfd_tool` nativo en Arch | ✅ Compilado | Capturas de señal funcionando |
| Permisos udev + grupos | ✅ Configurado | `uucp`, `lock` |
| VM Windows (KVM/QEMU) | 🔨 En progreso | Pendiente montar |
| ROM Redmi A5 Global | 🔨 Descargando | `A15.0.26.0.VGWMIXM` 4.9GB |
| Heimdall (Samsung Linux) | ⏸ Pendiente | Para cuando llegue Samsung |

---

## 1. Fase de Preparación del Host (Arch Linux)

- [x] **Compilación de herramientas:** `sfd_tool` nativo en Arch
- [x] **Gestión de permisos:** grupos `uucp`, `lock` + políticas `udev` para puertos serial/USB
- [ ] **Virtualización KVM/QEMU:** entorno Windows para herramientas propietarias
  - Objetivo: USB passthrough nativo sin latencia

---

## 2. Stack de Software

### Unisoc — Redmi A5 (25028RN03Y)

| Herramienta | Entorno | Uso |
|---|---|---|
| `sfd_tool` | Linux nativo | Diagnóstico, dumps, FRP |
| SPD UpgradeDownload | Windows VM | Flash con binarios FDL firmados |

**Chip:** Unisoc T7250 (12nm)  
**Modelo:** Redmi A5 Global — codename `serenity`  
**ROM descargada:** `serenity_global-images-A15.0.26.0.VGWMIXM`

### Samsung (Futura incorporación)

| Herramienta | Entorno | Uso |
|---|---|---|
| `heimdall` | Linux nativo | Flash estándar Exynos/Snapdragon |
| Odin3 | Windows VM | Flash oficial Samsung |

---

## 3. Procedimiento Estándar (SOP)

Para cada dispositivo seguir este protocolo:

### Paso 1 — Diagnóstico inicial
```bash
# Conectar en modo BROM/EDL
# Volcar chip_uid y tabla de particiones
sfd_tool --port /dev/ttyUSB0 --cmd read_info
```

### Paso 2 — Backup crítico (ANTES de cualquier modificación)
```bash
# Particiones vitales:
# nvram, persist, frp, boot
sfd_tool --port /dev/ttyUSB0 --cmd read_spec --partition nvram
sfd_tool --port /dev/ttyUSB0 --cmd read_spec --partition persist
sfd_tool --port /dev/ttyUSB0 --cmd read_spec --partition frp
sfd_tool --port /dev/ttyUSB0 --cmd read_spec --partition boot
```

### Paso 3 — Acción (FRP / Repair)
```bash
# Borrado de FRP
sfd_tool --port /dev/ttyUSB0 --cmd erase --partition frp
```

### Regla de oro
> Si el dispositivo **no bootea** → re-flasheo completo:
> - **Unisoc:** archivo `.pac` completo
> - **Samsung:** PIT + AP + BL + CP + CSC via Odin/Heimdall

---

## 4. Checklist VM Windows (KVM/QEMU)

- [ ] Instalar `virt-manager` + KVM en Arch
- [ ] Crear VM Windows 11 desde ISO oficial
- [ ] Instalar **Spreadtrum USB Driver** (para Unisoc)
- [ ] Instalar **Samsung USB Drivers** (para Samsung)
- [ ] Configurar USB passthrough por Vendor ID / Product ID
- [ ] Instalar **SPD UpgradeDownload** (Unisoc)
- [ ] Instalar **Odin3** (Samsung)

### Instalar KVM en Arch
```bash
sudo pacman -S qemu-full virt-manager virt-viewer libvirt dnsmasq
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
```

### USB Passthrough en virt-manager
```xml
<!-- En la config XML de la VM, añadir el dispositivo USB por VID:PID -->
<hostdev mode='subsystem' type='usb'>
  <source>
    <vendor id='0x1782'/>   <!-- Spreadtrum/Unisoc -->
    <product id='0x4d00'/>
  </source>
</hostdev>
```

---

## 5. Dispositivos documentados

| Dispositivo | Chip | Modelo | Estado | ROM |
|---|---|---|---|---|
| Redmi A5 (Bego) | Unisoc T7250 | 25028RN03Y Global | 🔨 En proceso | A15.0.26.0.VGWMIXM |
| Samsung (TBD) | TBD | TBD | ⏸ Pendiente | TBD |

---

## Prompt para consultas futuras

```
Tengo un entorno de laboratorio basado en Arch Linux con sfd_tool y KVM/QEMU.
Documenta el procedimiento para realizar un volcado de seguridad (dump) de
particiones críticas en dispositivos Unisoc T7250 y el flujo de trabajo
estándar para flashear archivos .pac utilizando el passthrough de USB
en la máquina virtual.
```
