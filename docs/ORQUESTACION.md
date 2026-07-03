# 🎼 ORQUESTACIÓN MAESTRO — Arquitectura Yggdrasil

> Un ecosistema maduro no hace las cosas de una en una.
> Todo encadenado, todo automatizado, todo documentado.

---

## La arquitectura de orquestación

```
┌─────────────────────────────────────────────────────┐
│                    TÚ (Blink/SSH)                   │
└──────────────────────────┬──────────────────────────┘
                           │ git push
                           ▼
┌─────────────────────────────────────────────────────┐
│              GITHUB ACTIONS (CI/CD)                  │
│                                                     │
│  orquestador-maestro.yml                            │
│    ├── 1. Lint & validación scripts                 │
│    ├── 2. Auditoría seguridad (secrets scan)        │
│    ├── 3. Tests automáticos                         │
│    └── 4. Notificar Telegram (on-change)            │
│                                                     │
│  resumen-diario.yml (06:00 UTC cada día)            │
│    └── Estado general → Telegram                    │
└──────────────────────────┬──────────────────────────┘
                           │ webhook (futuro)
                           ▼
┌─────────────────────────────────────────────────────┐
│                   MADRE (Docker)                    │
│                                                     │
│  CAPA 1 — Core (siempre activo)                     │
│    thdora ────────── Bot principal IA               │
│    thdora-bot ─────── Interfaz Telegram             │
│    guardian_bot ────── Monitorización               │
│                                                     │
│  CAPA 2 — Vigilancia (siempre activo)               │
│    yggdrasil_watchdog ── Orquestador containers     │
│    log_guardian_bot ──── Análisis logs              │
│    network_radar ──────── Red/intrusiones           │
│    local_tripwire ──────── Cambios en ficheros      │
│    tailscale_monitor ───── VPN status               │
│    radar_backup ──────────  Backups                 │
│                                                     │
│  CAPA 3 — Infraestructura                           │
│    prometheus + grafana ── Métricas                 │
│    uptime-kuma ─────────── Dashboard uptime         │
│    portainer ───────────── Gestión Docker           │
│    gitea ───────────────── Git local                │
│    code-server ─────────── VSCode web               │
│    n8n ─────────────────── Automatización workflows │
│                                                     │
│  CAPA 4 — Especialistas (bajo demanda)              │
│    kali-pentest ─────────── Pentesting manual       │
│    spiderfoot ──────────── OSINT                    │
│                                                     │
│  CAPA 5 — Próximos (Sprint 7-8)                     │
│    ema ──────────────────── Auditora código ⏳      │
│    investigador-maestro ─── OSINT auto ⏳           │
│    palma-pentester ──────── Pentest auto ⏳         │
└─────────────────────────────────────────────────────┘
```

---

## GitHub Actions disponibles

| Action | Cuándo se dispara | Qué hace |
|---|---|---|
| `orquestador-maestro.yml` | Push, PR, diario 06:00 | Lint → Audit → Tests → Notify |
| `resumen-diario.yml` | Diario 06:00 UTC | Resumen estado → Telegram |

---

## Configurar secrets en GitHub

Para que las Actions notifiquen a Telegram:
```
GitHub repo → Settings → Secrets and variables → Actions

Añadir:
  TELEGRAM_TOKEN    = token del bot de Telegram
  TELEGRAM_CHAT_ID  = tu chat ID personal
```

---

## Bots dockerizados disponibles

| Bot | Dockerfile | Estado |
|---|---|---|
| `ema` | `docker/bots/ema/` | ✅ Listo para build |
| `investigador-maestro` | `docker/bots/investigador-maestro/` | ✅ Listo para build |
| `palma-pentester` | `docker/bots/palma-pentester/` | ✅ Listo para build |

Para añadir al docker-compose principal:
```yaml
investigador-maestro:
  build: ./docker/bots/investigador-maestro
  restart: unless-stopped
  environment:
    - TELEGRAM_TOKEN=${TELEGRAM_TOKEN}
    - TELEGRAM_CHAT_ID=${TELEGRAM_CHAT_ID}
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:8091/health"]
    interval: 30s
    timeout: 10s
    retries: 3
    start_period: 60s
```

---

## Script notify-on-change

El watchdog inteligente que solo habla cuando algo cambia:
```bash
# Ejecutar en Madre (añadir a crontab o como servicio)
python3 ~/yggdrasil-dew/scripts/maintenance/notify-on-change.py

# Como servicio systemd:
# Ver docs/SYSTEMD-SERVICES.md (próximo Sprint 7)
```

_Actualizado: 2026-07-03_
