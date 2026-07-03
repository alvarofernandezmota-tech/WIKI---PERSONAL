# 🤖 ROLES DE BOTS Y AGENTES — Ecosistema Yggdrasil

> Cada bot tiene UN rol claro. Si un bot hace demasiadas cosas, se divide.
> Regla: un bot = una responsabilidad principal.

---

## Mapa de agentes activos

| Bot / Agente | Contenedor Docker | Rol principal | Canal |
|---|---|---|---|
| **thdora** | `thdora` | Asistente IA principal — responde, razona, ejecuta | Telegram |
| **thdora-bot** | `thdora-bot` | Interfaz Telegram de thdora | Telegram |
| **guardian_bot** | `guardian_bot` | Monitoriza salud del ecosistema | Telegram |
| **log_guardian_bot** | `log_guardian_bot` | Analiza logs en busca de anomalías | Interno |
| **yggdrasil_watchdog** | `yggdrasil_watchdog` | Vigila que los contenedores estén healthy | Interno |
| **network_radar** | `network_radar` | Monitoriza la red (intrusiones, anomalías) | Interno |
| **tailscale_monitor** | `tailscale_monitor` | Estado de la VPN Tailscale | Interno |
| **local_tripwire** | `local_tripwire` | Detecta cambios en ficheros del sistema | Interno |
| **radar_backup** | `radar_backup` | Verifica que los backups se ejecutan | Interno |

---

## Flujo de notificaciones

```
Contenedor interno
  → detecta evento
  → yggdrasil_watchdog (agrega)
  → guardian_bot (filtra: notify-on-change)
  → thdora-bot (solo si es alerta real)
  → Telegram (tú)
```

**Regla notify-on-change**: solo llega a Telegram si algo CAMBIA de estado.
Si todo está igual → silencio en Telegram, registro en log.

---

## Bots pendientes de crear

| Bot | Rol | Sprint | Repo destino |
|---|---|---|---|
| **investigador-maestro** | OSINT automatizado, búsquedas | Sprint 8 | `~/Projects/investigador-maestro` |
| **palma-pentester** | Pentesting automatizado en red local | Sprint 8 | rama en thdora |
| **ema** | Auditoría de código, análisis estático | Sprint 7 | módulo en thdora |

---

## Reglas de creación de nuevos bots

```
1. ¿Ya existe un bot que haga esto? → No duplicar, extender el existente
2. ¿Es un módulo de thdora o un bot independiente?
   - Si necesita Telegram → bot independiente con su contenedor
   - Si es análisis interno → módulo en thdora (src/tools/)
3. Todo bot nuevo tiene:
   - Dockerfile en docker/
   - healthcheck definido
   - restart: unless-stopped
   - documentación en agentes/ROLES.md
   - issue de creación en GitHub
```

_Actualizado: 2026-07-03_
