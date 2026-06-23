# 🔒 Tailscale — Setup Servidor Madre

> Referencia técnica viva. Última actualización: **23 junio 2026**

---

## Estado actual

| Máquina | IP Tailscale | Estado |
|---|---|---|
| Madre | `100.91.112.32` | ✅ Activo |
| varopc | `100.86.119.102` | ✅ Activo |

---

## Historial de problemas resueltos

### 2026-06-23 — `tailscale.service not found` en Madre

**Problema:** Al hacer `sudo systemctl restart tailscale.service` daba error.
El servicio correcto en Arch Linux es `tailscaled` (con d al final), no `tailscale`.
Además el daemon no estaba habilitado para arrancar con el sistema.

**Causa:** Madre se suspendía (pantalla negra) y al despertar Tailscale no reconectaba.
La suspensión cortaba Tailscale + Docker + SSH completamente.

**Solución aplicada:**
```bash
# 1. Reinstalar Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# 2. El script habilitó automáticamente:
sudo systemctl enable --now tailscaled

# 3. Deshabilitar suspensión para siempre
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# 4. Reconectar
sudo tailscale up
```

**Estado post-fix:** ✅ tailscaled habilitado + suspensión desactivada permanentemente.

---

## ⚠️ Open Source — Transparencia

| Componente | Licencia | Notas |
|---|---|---|
| Cliente `tailscaled` (Linux) | ✅ BSD-3-Clause | Open source completo |
| Control plane (coordinación) | ❌ Propietario | Servidor cerrado de Tailscale |

**Alternativa 100% open source:** [Headscale](https://github.com/juanfont/headscale) — control server self-hosted compatible con el cliente oficial.

---

## Instalación en Madre (Linux / Arch)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled
sudo tailscale up
```

> En Arch el servicio se llama `tailscaled`, NO `tailscale`.

---

## Autoconexión al boot (systemd)

Crea `/etc/systemd/system/tailscale-autoconnect.service`:

```ini
[Unit]
Description=Automatic Tailscale connection
After=network-online.target tailscaled.service
Wants=network-online.target tailscaled.service

[Service]
Type=oneshot
ExecStart=/usr/bin/tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX --accept-routes --reset
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable tailscale-autoconnect.service
```

> ⚠️ Guarda la authkey en `/etc/tailscale/authkey` con `chmod 600` y usa `$(cat /etc/tailscale/authkey)` en ExecStart.

---

## Verificación

```bash
tailscale status
tailscale ip -4                   # ver IP asignada
tailscale ping 100.86.119.102     # ping a varopc
journalctl -u tailscaled -f       # logs en tiempo real
```

---

## Headscale — Migración futura (opcional)

| | Tailscale | Headscale |
|---|---|---|
| Control plane | ❌ Propietario | ✅ Open source |
| Setup | ✅ 5 min | ⚠️ ~1h |
| Mantenimiento | ✅ Cero | ⚠️ Manual |
| Vendor lock-in | ⚠️ Sí | ✅ No |

> **Decisión:** Mantener Tailscale ahora. Evaluar Headscale cuando Madre esté completamente configurada.

---

_Parte de [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) · setup del ecosistema_
_Ver: [[setup/madre]] · [[setup/red]] · [[setup/2026-06-23-systemd-plan]]_
