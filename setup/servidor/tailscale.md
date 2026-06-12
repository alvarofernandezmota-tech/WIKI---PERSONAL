# Tailscale — VPN mesh

> Última actualización: 12 junio 2026

---

## Qué es

Red privada virtual entre todos tus equipos. Cada máquina tiene una IP fija `100.x.x.x` accesible desde cualquier red del mundo.

> Tailscale es la **VPN**. No es SSH. No es VNC. Es la capa de red que los hace posibles desde fuera de casa.

---

## IPs permanentes

| Máquina | Hostname | IP Tailscale | Estado |
|---|---|---|---|
| **Madre** | `varpc` | `100.91.112.32` | ✅ Online |
| **Acer** | `varo12f` | `100.86.119.102` | ✅ Online |
| **MacBook** | pendiente | pendiente | ⏳ |

---

## Comandos esenciales

```bash
# Ver todos los nodos y estado
tailscale status

# Monitorizar en continuo (refresca cada 5s)
watch -n 5 tailscale status

# Comprobar latencia con Madre
tailscale ping 100.91.112.32

# Ver tu propia IP Tailscale
tailscale ip

# Activar
sudo tailscale up

# Desactivar
sudo tailscale down

# Ver logs en directo
sudo journalctl -u tailscaled -f
```

---

## Mantener Acer siempre conectado (para acceso exterior)

Tailscale arranca automáticamente con el sistema en Arch. Verificar:

```bash
sudo systemctl status tailscaled
sudo systemctl enable tailscaled  # si no está habilitado
```

---

## SSH sobre Tailscale

```bash
# Desde cualquier red del mundo
ssh varo@100.91.112.32
```

> ⚠️ **BLOQUEADO** — `sshd` no está activo en Madre.
> Primer comando al llegar a Madre:
> ```bash
> sudo systemctl enable --now sshd
> ```
> Después SSH funcionará desde cualquier sitio.

---

## VNC sobre Tailscale (exterior)

Una vez sshd activo en Madre:

```bash
ssh -L 5900:localhost:5900 -f -N varo@100.91.112.32 && vncviewer localhost:5900
```

---

_Volver al índice: [README.md](README.md)_
