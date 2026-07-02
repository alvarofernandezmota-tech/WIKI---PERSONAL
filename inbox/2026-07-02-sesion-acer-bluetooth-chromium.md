---
tags: [tipo/sesion, estado/sin-empezar, infra, hardware]
fecha: 2026-07-02
maquina: theodora (Acer)
actualizado: 2026-07-02
---

# 📥 Sesión 02-jul-2026 — Acer Bluetooth + Chromium/Perplexity

> Estado: `sin-empezar` → pendiente de cristalizar en destino definitivo
> Destino probable: `hardware/acer.md` + `docs/infra/bluetooth.md` + `docs/herramientas/chromium.md`

---

## 1. Bluetooth Acer — Diagnóstico y Resolución ✅

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
```

`bluetoothctl` detecta:
- `[NEW] Media /org/bluez/hci0`
- `[CHG] Controller E0:0A:F6:B6:02:14 Pairable: yes`
- `hci0 new_settings: powered bondable ssp br/edr le secure-conn ...`

### Nota
El mensaje `Failed to set default system config for hci0` aparece en journalctl pero **no impide el funcionamiento**. Es un warning conocido de bluez 5.86 en Arch.
→ Ver: https://github.com/bluez/bluez/issues/1905

### Estado final
🟢 **RESUELTO** — Bluetooth operativo en Theodora. Servicio habilitado para arranque automático.

### Comandos definitivos para Acer/Theodora
```bash
# Primer setup (ya ejecutado)
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Verificación rápida
systemctl status bluetooth
rfkill list

# Entrar a gestión Bluetooth
bluetoothctl
# Dentro: power on → agent on → default-agent → scan on
```

---

## 2. Chromium / Perplexity — Conectores no persisten 🔴

### Problema
En la versión web de Perplexity en Chromium, los conectores (GitHub, Google Drive, Web, etc.) no se guardan entre mensajes; hay que reconectarlos en cada nueva consulta.

### Hipótesis
- Sesión o caché corrupta en Chromium
- Extensión o VPN interfiriendo con WebSocket/SSE de Perplexity
- Conflicto de cookies/storage en Chromium (posible sandboxing)

### Pendiente de investigar
- [ ] Verificar si el problema ocurre también en modo incógnito de Chromium
- [ ] Probar en otro navegador (Firefox) para aislar si es de Chromium o de cuenta
- [ ] Revisar extensiones activas en Chromium que puedan interceptar requests
- [ ] Comprobar si hay VPN activa que rompa la sesión persistente
- [ ] Hard refresh: `Ctrl+F5` y borrar caché de perplexity.ai

### Estado
🔴 **PENDIENTE** — No investigado en profundidad aún. Próximo paso: prueba en incógnito.

---

## Cristalización pendiente

| Contenido | Destino |
|---|---|
| Comandos Bluetooth Acer | `hardware/acer.md` o `docs/infra/bluetooth.md` |
| Warning bluez 5.86 | `docs/infra/bluetooth.md` |
| Problema Chromium/Perplexity | `docs/herramientas/chromium.md` |

---

_Generado por Perplexity vía MCP · 02-jul-2026 19:08 CEST_
