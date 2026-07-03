# 🗓️ SPRINTS — Ecosistema Yggdrasil

> Un sprint = una semana. Foco en completar, no en empezar.
> Regla: no abrir Sprint N+1 sin cerrar Sprint N al 80%.

---

## ✅ Sprint 6 — CERRADO (2026-07-03)

| Tarea | Estado |
|---|---|
| Fix close-session.sh (blink compat) | ✅ |
| ECOSYSTEM-ARCHITECTURE.md | ✅ |
| CI scripts GitHub Action | ✅ |
| Raíz parcialmente limpia | ✅ |
| ESTADO-SISTEMA.md con Docker real | ✅ |
| Regla SINE documentada | ✅ |
| Scripts de sesión funcionando | ✅ |
| SCRIPTS.md con índice completo | ✅ |
| fix(config): CONVERSATION_TIMEOUT — issue #10 | ✅ |
| requirements-dev.txt con pytest | ✅ |

---

## 🔄 Sprint 7 — EN CURSO (semana 2026-07-03)

### Prioridad ALTA
- [ ] Fix `tailscale_monitor` — añadir `TS_AUTHKEY` en docker-compose
- [ ] Fix `local_tripwire` — healthcheck endpoint o estado persistente
- [ ] Notify-on-change en `yggdrasil_watchdog`
- [ ] Ema como módulo en `thdora/src/tools/ema/` — no repo separado
- [ ] Issue #12 código zombie en thdora — ejecutar ai_audit.py

### Prioridad MEDIA
- [ ] Fusionar `osint/` y `osint-stack/` en uno solo
- [ ] `notify-telegram.yml` GitHub Action para CI failures
- [ ] `agentes/ROLES.md` revisado y completo ← ya creado hoy
- [ ] `setup/bootstrap.sh` completar y testear ← ya creado hoy
- [ ] Telegram `/notify` endpoint — fix 404

### Prioridad BAJA
- [ ] Raíz limpia completa (mover macro-noche.sh y bootstrap.sh legacy)
- [ ] `auto-pull-madre.yml` GitHub Action

---

## 📋 Sprint 8 — PLANIFICADO

### Proyectos
- [ ] `palma-pentester` — retomar rama, definir scope completo
- [ ] `investigador-maestro` — crear repo y estructura base
- [ ] Cámara/datos/control del entorno ("La Gerda") — análisis y estructura

### Infraestructura
- [ ] Clevis + TPM o Dropbear para auto-unlock de Madre en reboot
- [ ] `auto-pull-madre.yml` — git pull automático al hacer push
- [ ] Uptime Kuma — configurar alertas por Telegram
- [ ] Grafana dashboard — panel de estado del ecosistema

### Bots nuevos
- [ ] `investigador-maestro` bot — OSINT automatizado
- [ ] Roles finales definidos para todos los bots existentes

---

## 📌 Backlog (sin sprint asignado)

- [ ] Microservicios — evaluar cuando el ecosistema esté estable (no antes de Sprint 10)
- [ ] Kubernetes — solo si Madre se queda pequeña
- [ ] Segundo nodo (replicar ecosistema en otra máquina)

_Actualizado: 2026-07-03_
