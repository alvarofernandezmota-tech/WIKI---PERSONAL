# Red LAN — Mapa de red y puertos

> Última actualización: 26 junio 2026

---

## Hardware — Números de serie

| Máquina | Número de serie |
|---|---|
| **Acer** | `NXA82EB00D21212C8F7600` |
| **Madre** | pendiente |

---

## IPs Tailscale (permanentes)

| Máquina | IP Tailscale | Rol |
|---|---|---|
| **Madre** | `100.91.112.32` | Workstation + wayvnc server |
| **Acer** | `100.86.119.102` | Soporte 24/7 + puerta exterior |
| **MacBook** | pendiente | Cliente opcional |

## IPs LAN (DHCP — pueden cambiar)

| Máquina | IP LAN | Nota |
|---|---|---|
| Acer | `10.176.119.171` | ⏳ Fijar por MAC en router |
| MacBook | `10.176.119.229` | DHCP |
| Madre | pendiente | ⏳ Fijar por MAC en router |

> ⚠️ **VNC usa IP LAN**, no Tailscale. Hay que fijar la IP de Madre en el router.
> Para VNC remoto (fuera de casa): tunelizar sobre SSH+Tailscale.

---

## Puertos abiertos en Acer (UFW)

| Puerto | Protocolo | Servicio | Desde |
|---|---|---|---|
| `22` | TCP | SSH | Solo `100.91.112.32` (Madre) |
| `5900` | TCP | VNC | LAN local |
| Todo lo demás | — | BLOQUEADO | — |

> Puerto 24800 (Input Leap) — ya no necesario, se puede eliminar.

---

## Servicios activos

| Puerto | Servicio | Máquina | Estado |
|---|---|---|---|
| `5900` | wayvnc (VNC) | Madre | ✅ Activo |
| `22` | SSH | Acer | ✅ Activo |

## Servicios planificados

| Puerto | Servicio | Máquina |
|---|---|---|
| `5432` | PostgreSQL | Acer |
| `53` | Pi-hole DNS | Acer |
| `3000` | Open WebUI | Madre |
| `11434` | Ollama API | Madre |

---

_Regla: ningún puerto abierto al mundo. Todo vía Tailscale o LAN._
