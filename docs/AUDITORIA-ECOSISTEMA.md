# 🔍 AUDITORÍA Y MONITORIZACIÓN DEL ECOSISTEMA

> Todo lo que pasa en el ecosistema queda registrado.
> Si algo cambia sin permiso — se detecta, se registra, se alerta.

---

## Qué se monitoriza y dónde

| Qué | Quién lo monitoriza | Dónde va la alerta |
|---|---|---|
| Containers Docker (salud) | `yggdrasil_watchdog` | Log interno |
| Containers Docker (cambio estado) | `notify-on-change.py` | Telegram |
| Ficheros del sistema (cambios) | `local_tripwire` | Telegram |
| Red local (intrusiones) | `network_radar` | Telegram |
| VPN Tailscale | `tailscale_monitor` | Telegram |
| Backups | `radar_backup` | Telegram |
| Logs de todos los containers | `log_guardian_bot` | Telegram |
| Repo GitHub (cambios no autorizados) | GitHub Action `tripwire-repo` | Email + Telegram |
| CI/CD (fallos de build) | GitHub Action `orquestador-maestro` | Telegram |
| Inbox no procesada | GitHub Action `inbox-processor` | GitHub Issue |
| Código (calidad, zombie) | `ema` (Sprint 7) | Telegram + GitHub Issue |

---

## Niveles de alerta

```
🔴 CRÍTICO   → Telegram inmediato + log
               Container caído, fichero crítico modificado, intrusión

🟡 WARNING   → Telegram (horario 07:00-23:00) + log
               Container unhealthy, backup fallido, tripwire alerta

🔵 INFO      → Solo log (silencio en Telegram)
               Container arrancando, estado sin cambio, CI OK

📋 RESUMEN   → Telegram 08:00 diario
               Estado general del ecosistema
```

---

## Auditoría del repositorio GitHub

### ¿Qué se detecta?
- Push a main sin pasar por PR (si se configura branch protection)
- Ficheros sensibles (.env, tokens) accidentalmente commiteados
- Cambios en ficheros críticos: NORMAS-ECOSISTEMA.md, ECOSYSTEM-ARCHITECTURE.md
- Scripts con sintaxis incorrecta
- Secretos en el código

### ¿Cómo?
GitHub Action `tripwire-repo.yml` se ejecuta en cada push y PR.

---

## Auditoría local (Madre)

### local_tripwire
Monitoriza 87.918 ficheros. Detecta:
- Modificación de ficheros del sistema
- Nuevos ficheros en rutas sensibles
- Cambios de permisos

**Estado actual**: crash loop — pendiente fix en Sprint 7

### Comando manual de auditoría
```bash
# Ver qué ha cambiado en el repo desde el último commit:
git -C ~/yggdrasil-dew diff --stat HEAD~1 HEAD
git -C ~/Projects/thdora diff --stat HEAD~1 HEAD

# Ver ficheros modificados recientemente en Madre:
find /home/varopc -newer /home/varopc/.bashrc -not -path '*/.git/*' -type f 2>/dev/null | head -20
```

---

## Estructura de etiquetas para la inbox

Cada fichero en `inbox/` debe tener en su cabecera YAML:

```yaml
---
tags: [categoria, subcategoria]
fecha: YYYY-MM-DD
estado: pendiente-clasificar | pendiente-implementar | en-progreso | hecho
destino: carpeta/destino/final.md
prioridad: ALTA | MEDIA | BAJA | CRITICA
bot-destino: thdora | guardian | ema | investigador | ninguno
---
```

### Categorías válidas de tags
```
regla          → norma del ecosistema
docker         → containers, compose, dockerfiles
bot            → bots y agentes
script         → scripts bash/python
infra          → infraestructura, red, hardware
osint          → investigación, recon
seguridad      → pentesting, alertas, tripwire
docs           → documentación
deuda-tecnica  → cosas a arreglar
sprint         → tareas de sprint
idea           → ideas sin validar
```

_Actualizado: 2026-07-03_
