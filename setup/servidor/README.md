# Setup Servidor — Índice completo

> Cada aplicación tiene su propio archivo. Lee este README primero.
> Última actualización: 13 junio 2026

---

## Arquitectura del sistema

```
Madre (Servidor)  ─────────────────────  Acer (Cliente)
100.91.112.32                            100.86.119.102

  [sshd]        ←── SSH (Tailscale) ──←  [ssh / VSCode Remote]
  [wayvnc]      ←── VNC (LAN/T.scale)─←  [vncviewer]
  [Ollama]      ←── API :11434 ─────←  [Open WebUI]
  [PostgreSQL]  ←── :5432 ─────────←  [DBeaver]
  [Tailscale]   ←── VPN mesh P2P ───←  [Tailscale]
```

---

## 🚨 Pendiente mañana — ir físicamente a Madre

```bash
sudo systemctl enable --now sshd
```

Después seguir checklist completo: [rescate.md](rescate.md)

---

## Aplicaciones — Índice completo

### Acceso y red

| App | Host | Estado | Doc |
|---|---|---|---|
| **Tailscale** | Madre + Acer | ✅ Activo | [tailscale.md](tailscale.md) |
| **sshd** | Madre | 🔴 Pendiente activar | [ssh.md](ssh.md) |
| **wayvnc** | Madre | ⚠️ Instalado, sin autostart | [vnc.md](vnc.md) |
| **tigervnc** | Acer | ✅ Instalado | [vnc.md](vnc.md) |

### Seguridad

| App | Host | Estado | Doc |
|---|---|---|---|
| **UFW** | Acer ✅ / Madre 🔴 | Acer activo, Madre pendiente | [ufw.md](ufw.md) |
| **fail2ban** | Madre | ⏳ Pendiente (bootstrap) | [fail2ban.md](fail2ban.md) |

### Servicios (Docker)

| App | Host | Estado | Doc |
|---|---|---|---|
| **Docker** | Madre | ⏳ Pendiente instalar | [bootstrap-madre.sh](bootstrap-madre.sh) |
| **Ollama** | Madre | ⏳ Pendiente | [ollama.md](ollama.md) |
| **Open WebUI** | Madre | ⏳ Pendiente | [ollama.md](ollama.md) |
| **PostgreSQL** | Madre | ⏳ Pendiente | — |
| **Pi-hole** | Madre | ⏳ Pendiente | — |
| **Uptime Kuma** | Madre | ⏳ Pendiente | [uptime-kuma.md](uptime-kuma.md) |
| **THDORA** | Madre | ⏳ Migrar desde Acer | — |

### Monitorización y auditoría

| App | Host | Estado | Doc |
|---|---|---|---|
| **btop** | Acer + Madre | ✅ Acer / Madre pendiente | — |
| **lynis** | Madre | ⏳ Pendiente (bootstrap) | — |
| **rkhunter** | Madre | ⏳ Pendiente (bootstrap) | — |

### Desarrollo

| App | Host | Estado | Doc |
|---|---|---|---|
| **VSCode** | Acer → Madre (Remote SSH) | ⏳ Pendiente configurar | [vscode.md](vscode.md) |
| **DBeaver** | Acer → Madre | ⏳ Pendiente instalar | [dbeaver.md](dbeaver.md) |
| **GitHub SSH** | Madre | ⏳ Pendiente configurar | [github-setup.md](github-setup.md) |
| **Google Colab** | Cloud | ⏳ Por configurar | [colab-aistudio.md](colab-aistudio.md) |
| **AI Studio** | Cloud | ⏳ Por configurar | [colab-aistudio.md](colab-aistudio.md) |

### Descartadas

| App | Motivo |
|---|---|
| Input Leap | Bloqueo sesión Wayland — 12 jun 2026 |
| WireGuard | Sustituido por Tailscale |

---

## Instalación automatizada

Una vez dentro de Madre por SSH:

```bash
bash <(curl -s https://raw.githubusercontent.com/alvarofernandezmota-tech/personal-v2/main/setup/servidor/bootstrap-madre.sh)
```

Ver: [bootstrap-madre.sh](bootstrap-madre.sh) · [herramientas.md](herramientas.md)

---

## Capas de red

| Capa | Tecnología | Para qué |
|---|---|---|
| VPN mesh | Tailscale | Conectar equipos desde cualquier red |
| LAN local | Router | Red en casa (`10.176.x.x`) |
| VNC en casa | wayvnc + LAN | Escritorio remoto dentro de casa |
| VNC fuera | wayvnc + Tailscale | Escritorio remoto desde exterior |

---

_Plan maestro y tareas: [plan-maestro.md](plan-maestro.md)_
_Protocolo de rescate: [rescate.md](rescate.md)_
_Volver al índice: [README.md](../../README.md)_
