# UFW — Firewall

> Última actualización: 13 junio 2026

---

## Estado

| Máquina | Estado | Política |
|---|---|---|
| **Acer** | ✅ Activo | `deny incoming` por defecto |
| **Madre** | 🔴 Pendiente configurar | — |

---

## Acer — Reglas activas

| Puerto | Protocolo | Servicio | Desde |
|---|---|---|---|
| `22` | TCP | SSH | Solo `100.91.112.32` (Madre) |
| `5900` | TCP | VNC | LAN local |
| Todo lo demás | — | BLOQUEADO | — |

```bash
sudo ufw status verbose
sudo ufw allow from 100.91.112.32 to any port 22
sudo ufw deny incoming
sudo ufw enable
```

---

## Madre — Configurar mañana (ver [rescate.md](rescate.md) § C)

```bash
sudo pacman -S ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Solo permitir desde Acer (Tailscale)
sudo ufw allow from 100.86.119.102 to any port 22
sudo ufw allow from 100.86.119.102 to any port 5900

# Activar y persistir
sudo ufw enable
sudo systemctl enable ufw

# Verificar
sudo ufw status verbose
```

**Reglas objetivo para Madre:**

| Puerto | Servicio | Desde |
|---|---|---|
| `22` | SSH | Solo Acer (`100.86.119.102`) |
| `5900` | VNC | Solo Acer (`100.86.119.102`) |
| Todo lo demás | BLOQUEADO | — |

---

## Comandos de diagnóstico

```bash
sudo ufw status verbose      # ver reglas activas
ss -tlnp                     # ver puertos escuchando
sudo ufw app list            # apps conocidas por UFW
```

---

_Ver también: [rescate.md](rescate.md) · [ssh.md](ssh.md) · [tailscale.md](tailscale.md)_
_Volver al índice: [README.md](README.md)_
