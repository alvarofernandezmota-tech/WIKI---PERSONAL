---
tags: [hardware, theodora, acer, bluetooth]
fecha-actualizacion: 2026-07-02
---

# 💻 Theodora — Acer Aspire

> Máquina de trabajo principal (Arch Linux). Tailscale IP: gestionada vía Tailscale.

---

## Bluetooth

### Estado
🟢 **RESUELTO** — 2026-07-02

### Problema original
`bluetoothctl` se quedaba en `Waiting to connect to bluetoothd...`. El servicio `bluetooth.service` estaba `disabled` por defecto en la instalación de Arch.

### Diagnóstico
```bash
systemctl status bluetooth
# → bluetooth.service: inactive (dead)
rfkill list
# → hci0: Soft blocked: no / Hard blocked: no
```

### Solución
```bash
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

### Comandos de gestión
```bash
# Verificación rápida
systemctl status bluetooth
rfkill list

# Gestión interactiva
bluetoothctl
# Dentro: power on → agent on → default-agent → scan on → pair <MAC> → trust <MAC> → connect <MAC>
```

### Nota bluez 5.86
El warning `Failed to set default system config for hci0` en journalctl **no impide el funcionamiento**. Es un bug conocido de bluez 5.86 en Arch.
Referencia: https://github.com/bluez/bluez/issues/1905

---

## Especificaciones

| Campo | Valor |
|---|---|
| Hostname | theodora |
| OS | Arch Linux |
| Bluetooth | E0:0A:F6:B6:02:14 |
| Chromium | 148.0.7778.178 Arch Linux |

---
_Actualizado: 02-jul-2026 — Perplexity vía MCP_
