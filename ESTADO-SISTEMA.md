---
tags: [estado, sistema, live]
fecha-actualizacion: 2026-07-03T06:45
---

# 📊 ESTADO DEL SISTEMA — 2026-07-03 06:45 CEST

> Actualizado al cierre de cada sesión. Ver MASTER-PENDIENTES.md para tareas detalladas.

---

## 🔴 Bloqueos activos

| Bloqueo | Impacto | Desbloqueo |
|---------|---------|------------|
| Docker thdora no confirmado arriba | Smoke test Telegram bloqueado | `docker compose up -d` en Madre |
| Token GitHub `repo` full | Labels, milestones, branch protection | Generar token y meter en MCP |
| Puerto 21 FTP abierto en router | Riesgo seguridad P0 | Acceso panel router Digi |
| `PasswordAuthentication` SSH activo | Riesgo seguridad P1 | 2 terminales SSH simultáneas |

---

## 🟢 Servicios activos

| Servicio | Estado | Notas |
|---------|--------|-------|
| Tailscale Madre | ✅ Activo | VPN funcional |
| Tailscale Acer | ✅ Activo | |
| UFW Madre | ✅ Activo | Reglas estrictas |
| Fail2ban | ✅ Activo | |
| Ollama Madre | ✅ Activo | qwen2.5:7b + qwen2.5:3b |
| Docker thdora | ⏳ En despliegue | Build en progreso 2026-07-03 |
| n8n | ❌ No activo | Pendiente Fase 6 |
| Wazuh | ❌ No activo | Pendiente Fase 4 |

---

## 📊 Estado fases (resumen)

| Fase | Nombre | % | Próximo paso |
|------|--------|---|---------------|
| 1 | Seguridad base Madre | 90% | Deshabilitar SSH password |
| 2 | GitHub profesional | 70% | Labels + milestones |
| 3 | Governance repo | 50% | Unificar numeración fases |
| 4 | Stack técnico Madre | 10% | Hardening batcueva |
| 5 | GitHub Actions | 30% | Deploy desde thdora |
| **6** | **Thdora Guardián** | **20%** | **⭐ FOCO ACTUAL: handlers /estado /inbox** |
| 6d | Multi-IA n8n | 0% | Después de Fase 6 |
| 7 | Ollama + RAG | 20% | Qdrant + bge-m3 |
| 8 | MCP server Madre | 0% | Después de Fase 7 |
| 9 | Mobile completo | 30% | a-Shell + SSH iPhone |

---

## 🧟 Deuda técnica pendiente

### Thdora (Sprint 6)
- [ ] `MessageLog` real en scheduler_tasks.py
- [ ] Tests de regresión handlers
- [ ] Verificar Docker arriba + smoke test `/start`

### Scripts yggdrasil-dew
- [ ] Eliminar zombies: `inbox-cleanup-jun2024.sh`, `bc`, `inicio-sesion.sh`
- [ ] Mover scripts sueltos a subdirectorios
- [ ] Unificar numeración 01-10 con ROADMAP
- [ ] Registrar cron night-cron.sh en crontab Madre

### Repo que falta
- [ ] **Batcueva / IA stack repo** — documentar Ollama + RAG + n8n en repo dedicado
  o dentro de yggdrasil-dew en carpeta `infra/batcueva/`
  - Decisión pendiente: ¿repo aparte o dentro de yggdrasil-dew?

---

## 📝 Acciones de cierre sesión 2026-07-03

```bash
# En Madre ahora mismo:
bash ~/yggdrasil-dew/scripts/maintenance/close-session.sh

# Cron nocturno (añadir una sola vez):
crontab -e
# Añadir: 0 2 * * * bash ~/yggdrasil-dew/scripts/maintenance/night-cron.sh >> /tmp/night-cron.log 2>&1
```

---

## 📅 Próxima sesión — foco

1. **Confirmar Docker thdora arriba** (`docker ps` en Madre)
2. **Smoke test** `/start` en Telegram
3. **Handlers Fase 6**: implementar `/estado`, `/inbox`, `/pendientes`
4. **Eliminar zombies** (3 scripts confirmados)
5. **Decidir**: batcueva/IA — ¿repo aparte o carpeta en yggdrasil-dew?

---

_Actualizado: 2026-07-03 06:45 CEST — cierre sesión Perplexity MCP_
