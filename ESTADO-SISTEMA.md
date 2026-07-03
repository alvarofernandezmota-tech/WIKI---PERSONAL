# 🌳 ESTADO DEL SISTEMA — Yggdrasil

> Actualizado: 2026-07-03 07:02 CEST
> Próxima revisión: inicio de sesión siguiente

---

## 💻 MADRE (Acer — 100.91.112.32)

**Estado: ACTIVA — NO APAGAR**

> Madre es el servidor central del ecosistema. Contiene Docker, todos los bots,
> datos históricos y el estado de los proyectos. Apagarla rompe TODO.
> Si necesitas reiniciar algo, reinicia contenedores individuales, nunca la máquina.

---

## 🐳 DOCKER — Estado actual

### ✅ Healthy (funcionando)

| Contenedor | Estado | Notas |
|---|---|---|
| `thdora` | Up 17h ✅ healthy | Bot principal — OK |
| `thdora-bot` | Up 17h ✅ healthy | Telegram bot — OK |
| `guardian_bot` | Up 17h ✅ healthy | Monitoriza el ecosistema |
| `uptime-kuma` | Up 17h ✅ healthy | Dashboard de uptime |
| `network_radar` | Up 17h ✅ healthy | Radar de red |
| `log_guardian_bot` | Up ~1min 🔄 starting | Recién arrancado, normalizar |

### ⚠️ Unhealthy (revisar en próxima sesión)

| Contenedor | Estado | Causa probable | Acción |
|---|---|---|---|
| `tailscale_monitor` | Up 5min ❌ unhealthy | Tailscale config/token | `docker logs tailscale_monitor` |
| `local_tripwire` | Up 11min ❌ unhealthy | Config inicial | `docker logs local_tripwire` |
| `yggdrasil_watchdog` | Up 17h ❌ unhealthy | Healthcheck falla | `docker logs yggdrasil_watchdog` |

### ℹ️ Sin healthcheck (normal)

| Contenedor | Estado | Notas |
|---|---|---|
| `radar_backup` | Up 17h | Sin healthcheck definido |
| `kali-pentest` | Up 17h | Herramienta, no servicio |
| `spiderfoot` | Up 17h | OSINT tool |
| `code-server` | Up 17h | VSCode en navegador |
| `n8n` | Up 17h | Automatización workflows |
| `gitea` | Up 17h | Git server local |
| `grafana` | Up 17h | Dashboards métricas |
| `prometheus` | Up 17h | Métricas |
| `portainer` | Up 17h | Gestión Docker |

---

## 🚨 ISSUES ACTIVOS

| # | Descripción | Prioridad | Sprint |
|---|---|---|---|
| fix unhealthy x3 | tailscale_monitor, local_tripwire, yggdrasil_watchdog | MEDIA | Sprint 7 |
| Telegram /notify 404 | `{"detail":"Not Found"}` — endpoint no existe aún | BAJA | Sprint 6 |
| Raiz limpia | macro-noche.sh + bootstrap.sh sueltos | BAJA | Sprint 7 |
| investigador-maestro | Proyecto no creado aún | MEDIA | Sprint 7 |

---

## 📊 REPOS

| Repo | Ruta en Madre | Estado |
|---|---|---|
| yggdrasil-dew | `~/yggdrasil-dew` | ✅ Clonado y actualizado |
| thdora | `~/Projects/thdora` | ✅ Sin cambios |
| investigador-maestro | `~/Projects/investigador-maestro` | ❌ No creado |

---

## 🔑 REGLA: NO APAGAR MADRE

```
Madre = servidor 24/7
Si necesitas "reiniciar" algo:
  docker restart <nombre_contenedor>

Si necesitas parar un contenedor:
  docker stop <nombre_contenedor>

NUNCA: sudo shutdown / sudo reboot (sin avisar al equipo)
```

---

## 📅 HISTORIAL DE SESIONES

| Fecha | Qué se hizo |
|---|---|
| 2026-07-03 | Fix close-session.sh (blink compat), ECOSYSTEM-ARCHITECTURE.md, regla escalado, smoke tests, CI scripts, raiz limpia parcial |
| 2026-07-02 | Regla SINE documentada, scripts de sesión, ruta thdora confirmada |

_Actualizado automáticamente al cerrar sesión_
