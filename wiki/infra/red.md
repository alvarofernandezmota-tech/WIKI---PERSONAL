# 🌐 Red — Topología y Acceso Remoto

---

## Tailscale (VPN mesh)

Tailscale conecta todos los dispositivos del ecosistema en una red privada, sin importar dónde estén.

| Dispositivo | IP Tailscale | Rol |
|---|---|---|
| Madre (servidor) | 100.91.112.32 | Nodo principal |
| Acer (portátil) | _pendiente_ | Cliente principal |

```bash
# Ver estado de Tailscale en cualquier máquina
tailscale status

# Ver tu IP de Tailscale
tailscale ip

# Ping entre dispositivos
tailscale ping madre
```

---

## Red local

| Campo | Valor |
|---|---|
| Router | _pendiente documentar_ |
| Rango IP local | _pendiente (ej: 192.168.1.0/24)_ |
| IP Madre local | _pendiente documentar_ |

---

## Puertos expuestos al exterior

| Puerto | Servicio | Notas |
|---|---|---|
| _pendiente_ | — | — |

→ Ver política de seguridad en [`seguridad.md`](./seguridad.md)
