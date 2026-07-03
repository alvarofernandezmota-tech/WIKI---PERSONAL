---
tags: [regla, docker, alerting, bot, inbox]
fecha: 2026-07-03
estado: pendiente-implementar
destino: docs/thdora-guardian/REGLAS-ALERTING.md
prioridad: MEDIA
---

# 🔔 REGLA: ALERTING INTELIGENTE — Notify-on-Change

> El bot no debe spammear. Solo notifica cuando algo CAMBIA.
> Si está todo OK → silencio. Registra en log, no en Telegram.

---

## El problema

El watchdog y los monitors mandan notificaciones en cada ciclo,
aunque todo esté igual que antes. Resultado: spam en Telegram,
ruido que oculta alertas reales.

---

## La regla: NOTIFY-ON-CHANGE

```
Si estado_actual == estado_anterior → solo log (silencio en Telegram)
Si estado_actual != estado_anterior → notificar Telegram

Ejemplos:
  healthy → healthy    : silencio (registrar en log)
  healthy → unhealthy  : 🚨 ALERTA Telegram inmediata
  unhealthy → healthy  : ✅ RECOVERY Telegram (buena noticia)
  unknown → healthy   : ℹ️ INFO Telegram (solo primera vez)
```

---

## Implementación en el watchdog

Añadir un fichero de estado persistente `/tmp/watchdog-state.json`
que recuerde el último estado conocido de cada contenedor.

```python
# Pseudocódigo para el watchdog
state_file = "/tmp/watchdog-state.json"

def check_and_notify(container, current_status):
    prev = load_state(container)  # leer estado anterior
    
    if current_status != prev:
        notify_telegram(container, prev, current_status)  # cambio real
        save_state(container, current_status)
    else:
        log_only(container, current_status)  # solo log, silencio
```

---

## Niveles de notificación

| Evento | Canal | Urgencia |
|--------|-------|----------|
| Container caído (running → exited) | Telegram 🚨 | Inmediata |
| Container unhealthy (healthy → unhealthy) | Telegram ⚠️ | Inmediata |
| Container recuperado (unhealthy → healthy) | Telegram ✅ | Normal |
| Container arrancando (starting) | Solo log | Silencio |
| Todo OK sin cambios | Solo log | Silencio |
| Reboot de Madre detectado | Telegram 🔄 | Informativa |

---

## Intervalo de chequeo recomendado

```
Chequeo interno:   cada 30s  (para detectar rápido)
Notificación:      solo on-change (no cada 30s)
Resumen diario:    1 vez al día a las 08:00 si hay algo pendiente
Silencio nocturno: 23:00 — 07:00 solo alertas críticas
```

---

## Diagnóstico de hoy (2026-07-03)

### yggdrasil_watchdog — ✅ funciona correctamente
Lo que parecía unhealthy era el periodo de gracia esperando
a que otros contenedores terminen de arrancar. Comportamiento correcto.

### tailscale_monitor — ❌ crash loop real
Arranca y se cae en bucle. Causa probable: falta variable de entorno.
```bash
# Verificar en Madre:
docker inspect tailscale_monitor | grep -A 20 'Env'
# Buscar: TS_AUTHKEY o TAILSCALE_TOKEN
```

### local_tripwire — ❌ crash loop real  
Carga baseline (87.918 ficheros) y se cae después.
Causa probable: healthcheck espera endpoint que no levanta.
```bash
# Verificar en Madre:
docker inspect local_tripwire | grep -A 10 'Healthcheck'
docker logs local_tripwire --tail=50 2>&1 | grep -i 'error\|fail\|exception'
```

---

## Regla: antes de reiniciar Madre

```
1. ¿Estás físicamente en Madre o con acceso SSH? → Si NO, NO reiniciar
2. Avisar en Telegram antes: /notify "Reiniciando Madre en 5min"
3. docker compose down (guarda estado limpio)
4. Reiniciar Madre
5. Verificar que Docker levanta: docker ps (esperar 2-3min)
6. Confirmar en Telegram: bash close-session.sh
```

_Creado: 2026-07-03 07:10 CEST_
