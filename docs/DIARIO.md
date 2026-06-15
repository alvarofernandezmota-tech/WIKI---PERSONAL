# Diario de Desarrollo — personal-v2

---

## 2026-06-15 — Sesión: Lab Android + Virtualización Windows

### Estado de descargas en curso
- 📥 **ROM Redmi A5 Global** (`A15.0.26.0.VGWMIXM`) — 4.9GB descargando
- 📥 **ISO Windows 11** — ~6GB descargando desde Microsoft oficial
- 📥 **QEMU/KVM + virt-manager** — instalando via `pacman`

### Lo que hicimos hoy
1. Identificamos el modelo exacto del Redmi A5 de Bego: `25028RN03Y` → versión **Global**
2. Localizamos y lanzamos descarga de la ROM Fastboot Global correcta
3. Iniciamos instalación de stack de virtualización KVM en Arch:
   ```bash
   sudo pacman -S qemu-full virt-manager virt-viewer libvirt dnsmasq bridge-utils
   sudo systemctl enable --now libvirtd
   sudo usermod -aG libvirt $USER
   ```
4. Lanzada descarga de ISO Windows 11 desde navegador (microsoft.com oficial)

### Pendiente — próxima sesión
- [ ] Terminar instalación QEMU y reiniciar sesión
- [ ] Crear VM Windows 11 en virt-manager
- [ ] Configurar USB passthrough para Unisoc (VID: `0x1782`)
- [ ] Instalar Spreadtrum USB Driver dentro de la VM
- [ ] Instalar SPD UpgradeDownload en la VM
- [ ] Flashear Redmi A5 con ROM descargada

### Documentación completa
> 📁 Ver guía completa del laboratorio en:
> `docs/setup/android-rescue-lab/README.md`
> ↳ Incluye SOP completo, stack de herramientas, checklist VM y tabla de dispositivos

---

## Índice de documentación (dónde va cada cosa)

| Tema | Archivo |
|---|---|
| Lab recuperación Android (Unisoc + Samsung) | `docs/setup/android-rescue-lab/README.md` |
| Instalación KVM/QEMU paso a paso | `docs/setup/android-rescue-lab/README.md#4-checklist-vm-windows-kvmqemu` |
| ROM Redmi A5 + procedimiento flash | `docs/setup/android-rescue-lab/README.md#unisoc--redmi-a5-25028rn03y` |
| Configuración Arch Linux (Madre) | `docs/setup/` (pendiente expandir) |

---

> **Nota:** Este diario se actualiza al final de cada sesión de trabajo.
> Cuando la documentación de un tema madure, se mueve a su archivo definitivo en `docs/setup/`.
