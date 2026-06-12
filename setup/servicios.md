# Servicios — Arquitectura Home Server

> Todos los servicios corriendo o planificados en el ecosistema.
> Última actualización: 13 junio 2026

---

## Arquitectura real

```
Madre (Servidor — siempre encendida, sin pantalla)
├── sshd            acceso remoto terminal
├── Tailscale       VPN mesh (100.91.112.32)
├── wayvnc          acceso escritorio remoto
├── Ollama          LLMs locales (GPU)
├── PostgreSQL      base de datos producción
├── THDORA          bot Telegram 24/7
├── Pi-hole         DNS local + bloqueo ads
└── Docker          contenedores de servicios

Acer (Cliente — uso diario, portabilidad)
├── Tailscale       VPN mesh (100.86.119.102)
├── vncviewer       cliente VNC a Madre
├── VSCode          desarrollo (SSH remoto a Madre)
├── DBeaver         gestión PostgreSQL remoto
├── Open WebUI      interfaz Ollama (conecta a Madre)
├── btop            monitorización local y SSH
└── whisrs          STT offline (instalado 12 jun)
```

> **Regla:** Madre produce y sirve. Acer usa y gestiona.

---

## Estado de servicios

| Servicio | Host | Estado | Notas |
|---|---|---|---|
| sshd | Madre | 🔴 Pendiente | Activar mañana. Ver [rescate.md](servidor/rescate.md) |
| Tailscale | Madre + Acer | ✅ Operativo | IPs fijas asignadas |
| wayvnc | Madre | ⚠️ Instalado | Sin autostart. Ver [vnc.md](servidor/vnc.md) |
| UFW | Acer | ✅ Activo | Madre pendiente. Ver [ufw.md](servidor/ufw.md) |
| Ollama | Madre | ⏳ Pendiente instalar | Ver [ollama.md](servidor/ollama.md) |
| PostgreSQL | Madre | ⏳ Pendiente | Migración desde SQLite |
| THDORA | Madre | ⏳ Pendiente migrar | Viene de Acer |
| Pi-hole | Madre | ⏳ Pendiente | DNS local |
| Docker | Madre | ⏳ Pendiente auditar | |
| Nextcloud | Madre | ⏳ Pendiente | Alternativa a Google Drive |
| whisrs | Acer | ✅ Instalado | STT offline, modelo base.en español |
| Open WebUI | Acer | ⏳ Pendiente | Conectar a Ollama en Madre |
| Drive Sync | GitHub Actions | ⏳ Pendiente | rclone + secret RCLONE_CONF |

---

## Servicios descartados

| Servicio | Motivo |
|---|---|
| Input Leap | Bloqueo definitivo sesión Wayland (12 jun 2026) |
| WireGuard | Sustituido por Tailscale |

---

## Drive Sync — GitHub Actions + rclone (pendiente)

```yaml
# .github/workflows/sync-drive.yml
name: Sync to Google Drive
on:
  schedule:
    - cron: '0 22 * * *'  # 23:00 CEST
  workflow_dispatch:
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup rclone
        uses: AnimMouse/setup-rclone@v1
        with:
          rclone_config: ${{ secrets.RCLONE_CONF }}
      - name: Sync to Drive
        run: rclone sync . gdrive:personal-v2 --exclude ".git/**"
```

---

_Ver: [plan-maestro.md](servidor/plan-maestro.md) · [rescate.md](servidor/rescate.md)_
