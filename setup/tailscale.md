# 🔒 Tailscale — Setup Servidor Madre

> Referencia técnica viva. Última actualización: **17 junio 2026**

---

## Estado actual

| Máquina | IP Tailscale | Estado |
|---|---|---|
| Madre | `100.91.112.32` | ✅ Activo |
| varopc | `100.86.119.102` | ✅ Activo |

---

## ⚠️ Open Source — Transparencia

| Componente | Licencia | Notas |
|---|---|---|
| Cliente `tailscaled` (Linux) | ✅ BSD-3-Clause | Open source completo |
| Control plane (coordinación) | ❌ Propietario | Servidor cerrado de Tailscale |

**Alternativa 100% open source:** [Headscale](https://github.com/juanfont/headscale) — control server self-hosted compatible con el cliente oficial.

> Decisión pendiente: ¿migrar a Headscale? Ver sección abajo.

---

## Instalación en Madre (Linux)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled
sudo tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX --accept-routes
```

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

> ⚠️ Guarda la authkey en `/etc/tailscale/authkey` con `chmod 600` y usa `$(cat /etc/tailscale/authkey)` en ExecStart — nunca hardcodeada.

---

## IP forwarding (para subnet-router / exit-node)

```bash
# Temporal
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1

# Permanente — añadir a /etc/sysctl.conf
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
```

---

## Verificación

```bash
tailscale status
tailscale ping 100.86.119.102    # ping a varopc
journalctl -u tailscaled -f      # logs en tiempo real
```

---

## Headscale — Migración futura (opcional)

Si la filosofía open source es prioritaria:

| | Tailscale | Headscale |
|---|---|---|
| Control plane | ❌ Propietario | ✅ Open source |
| Setup | ✅ 5 min | ⚠️ ~1h |
| Mantenimiento | ✅ Cero | ⚠️ Manual |
| Vendor lock-in | ⚠️ Sí | ✅ No |

Repo: https://github.com/juanfont/headscale

> **Decisión:** Mantener Tailscale ahora. Evaluar Headscale cuando el servidor Madre esté completamente configurado.

---

_Parte de [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) · setup del ecosistema_
