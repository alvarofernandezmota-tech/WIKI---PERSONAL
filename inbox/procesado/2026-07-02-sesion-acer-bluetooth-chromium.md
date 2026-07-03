---
tags: [tipo/sesion, estado/en-proceso, infra, hardware]
fecha: 2026-07-02
maquina: theodora (Acer)
actualizado: 2026-07-02T19:19
---

# 📥 Sesión 02-jul-2026 — Acer Bluetooth + Chromium/Perplexity

> Estado: `en-proceso` → pendiente de cristalizar en destino definitivo
> Destino probable: `hardware/acer.md` + `docs/infra/bluetooth.md` + `docs/herramientas/chromium.md`

---

## 1. Bluetooth Acer — Diagnóstico y Resolución ✅ RESUELTO

### Problema
`bluetoothctl` se quedaba en `Waiting to connect to bluetoothd...` en Theodora.

### Diagnóstico
```bash
systemctl status bluetooth
# → bluetooth.service: inactive (dead) — el servicio estaba disabled
rfkill list
# → 1: acer-bluetooth: Soft blocked: no / Hard blocked: no
# → 2: hci0:           Soft blocked: no / Hard blocked: no
```
Sin bloqueo físico ni software. El problema era simplemente que el servicio nunca se habilitó.

### Solución ejecutada
```bash
sudo systemctl enable bluetooth   # Crea symlinks dbus-org.bluez.service
sudo systemctl start bluetooth
sudo systemctl status bluetooth
```

### Resultado
```
● bluetooth.service - Bluetooth service
   Active: active (running) since Thu 2026-07-02 19:00:28 CEST
   Main PID: 4449 (bluetoothd)
   Status: "Running"
   Bluetooth daemon 5.86
   Controller: E0:0A:F6:B6:02:14 Pairable: yes
   hci0: powered bondable ssp br/edr le secure-conn wide-band-speech
```

### Notas importantes
- El mensaje `Failed to set default system config for hci0` aparece en journalctl pero **no impide el funcionamiento**. Es un warning conocido de bluez 5.86 en Arch → https://github.com/bluez/bluez/issues/1905
- El servicio estaba `disabled` por defecto en la instalación. Con `enable` queda activo en cada arranque.

### 🟢 Estado final: RESUELTO
Bluetooth operativo en Theodora. Servicio habilitado para arranque automático.

### Comandos definitivos Acer/Theodora
```bash
# Setup inicial (ya ejecutado — no repetir)
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Verificación rápida
systemctl status bluetooth
rfkill list

# Gestión Bluetooth interactiva
bluetoothctl
# Dentro:
#   power on
#   agent on
#   default-agent
#   scan on
#   pair <MAC>
#   trust <MAC>
#   connect <MAC>
```

---

## 2. Chromium / Perplexity — Conectores no persisten 🔴 EN PROCESO

### Problema
En la versión web de Perplexity en Chromium (Arch Linux), los conectores (GitHub, Google Drive, Web, etc.) **no se guardan entre mensajes**; hay que reconectarlos en cada nueva consulta del chat.

### Datos recogidos
| Variable | Valor |
|---|---|
| Versión Chromium | `148.0.7778.178 Arch Linux` |
| Modo incógnito | Sigue fallando |
| Móvil | **Funciona correctamente** |
| VPN activa | Por verificar |
| Extensiones | Por revisar |

### Diagnóstico ejecutado
```bash
chromium --version
# → Chromium 148.0.7778.178 Arch Linux

chromium --disable-extensions --incognito --no-first-run
# → Abre sesión limpia sin extensiones — problema persiste
```

### Análisis
- Perplexity soporta oficialmente Chrome 122+ pero documenta comportamiento sobre Chrome 137 como referencia estable.
- **Chromium 148 en Arch** es una versión muy reciente que puede tener cambios de SameSite, cookies o storage que rompan la persistencia de sesión de conectores.
- El hecho de que **móvil funcione** y **escritorio no** descarta problema de cuenta/plan y apunta a navegador/entorno.
- `--disable-extensions` no resuelve → el problema no son extensiones de Chromium.

### Hipótesis activa
🎯 **Chromium 148 tiene cambios de manejo de cookies/storage** que Perplexity aún no gestiona correctamente en el handshake OAuth de conectores.

### Pendiente de verificar
- [ ] Probar en **Firefox** para aislar si es específico de Chromium o del entorno desktop
- [ ] Instalar **app nativa de Perplexity** en Arch Linux (AUR o Flatpak) como alternativa
- [ ] Crear **perfil nuevo limpio** en Chromium (`chrome://settings/manageProfile`)
- [ ] Revisar si hay **VPN activa** que rompa el OAuth de conectores
- [ ] Probar `chrome://flags` → **Reset all** → reiniciar

### 🔴 Estado: EN PROCESO — siguiente paso: Firefox o app nativa Arch

---

## 3. App Perplexity en Arch Linux — Por investigar 🔜

### Opciones conocidas
- **AUR**: buscar `perplexity` o `perplexity-ai` en AUR
- **Flatpak**: buscar en Flathub si hay paquete oficial
- **AppImage**: buscar en releases oficiales de Perplexity
- **Comet**: el navegador propio de Perplexity (basado en Chromium) — disponible para Linux

### Ventaja de app nativa vs Chromium web
Una app nativa (o Comet) gestiona la sesión y los conectores en su propio contexto, aislado del perfil de Chromium con posibles conflictos.

### 🔜 Estado: PENDIENTE — investigar AUR/Flatpak + Comet

---

## Cristalización pendiente

| Contenido | Destino |
|---|---|
| Comandos Bluetooth Acer | `hardware/acer.md` + `docs/infra/bluetooth.md` |
| Warning bluez 5.86 | `docs/infra/bluetooth.md` |
| Diagnóstico Chromium/Perplexity | `docs/herramientas/chromium.md` |
| App Perplexity Arch | `docs/herramientas/perplexity.md` |

---

_Actualizado por Perplexity vía MCP · 02-jul-2026 19:19 CEST_
