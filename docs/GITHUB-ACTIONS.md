# ⚡ GITHUB ACTIONS vs BOTS — Diferencia y flujo

---

## La diferencia clave

| | GitHub Actions | Bots en Madre |
|---|---|---|
| **Dónde corre** | Servidores de GitHub | Docker en Madre |
| **Cuándo se activa** | Push, PR, schedule, webhook | Siempre activo (24/7) |
| **Acceso a Madre** | No (a menos que se configure) | Sí, acceso total |
| **Coste** | Gratis (límite minutos/mes) | Recursos de Madre |
| **Uso ideal** | CI/CD, tests, linting, deploy | Monitorización, Telegram, OSINT |

---

## Flujo correcto del ecosistema

```
Tú haces push a GitHub
  ↓
GitHub Action se dispara (CI)
  → Lint + tests automáticos
  → Si falla → notificación email/Telegram via webhook
  → Si pasa → OK
  ↓
En Madre: git pull automático (via cron o webhook)
  → Bot detecta nuevo código
  → Reinicia contenedor si es necesario
```

---

## GitHub Actions que existen ahora

```
.github/
  workflows/
    → ver contenido con: cat .github/workflows/*.yml
```

---

## GitHub Actions que faltan (Sprint 7)

| Action | Qué hace | Prioridad |
|---|---|---|
| `notify-telegram.yml` | Notifica a Telegram cuando falla CI | ALTA |
| `auto-pull-madre.yml` | Hace git pull en Madre al hacer push | MEDIA |
| `lint-scripts.yml` | Verifica que todos los .sh son válidos | MEDIA |
| `check-docker-health.yml` | Verifica docker-compose.yml en cada PR | BAJA |

---

## La lógica final: Actions + Bots juntos

```
GitHub Actions = automatización en GitHub (CI/CD)
Bots en Madre  = automatización en producción (24/7)

Juntos:
  Action detecta código nuevo → webhook → bot en Madre actúa
  Bot detecta problema → Telegram → tú actúas
```

No son lo mismo pero son **complementarios**.
Las Actions no reemplazan a los bots, los disparan.

_Actualizado: 2026-07-03_
