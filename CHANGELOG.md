# CHANGELOG — yggdrasil-dew
#changelog #historial

Formato: [Keep a Changelog](https://keepachangelog.com/es/1.1.0/)  
Versionado: fecha de sesión

---

## [2026-07-03] — Fase 0 GitHub completa (85%)

### Added
- `.github/CODEOWNERS` — ownership completo del repo
- `.github/PULL_REQUEST_TEMPLATE.md` — checklist de calidad
- `.github/ISSUE_TEMPLATE/bug.yml` — form de bug con máquina y error
- `.github/ISSUE_TEMPLATE/tarea.yml` — form con fase y mobile-ok/needs-terminal
- `.github/ISSUE_TEMPLATE/seguridad.yml` — form con severidad
- `.github/ISSUE_TEMPLATE/config.yml` — deshabilita issues en blanco
- `.github/workflows/context-reminder.yml` — alerta CONTEXT.md >7 días
- `.github/workflows/lint-commits.yml` — Conventional Commits forzados
- `.github/workflows/inbox-health.yml` — alerta inbox >10 ficheros
- `docs/operativa/workflow-inbox.md` — flujo 6 pasos inbox
- `docs/operativa/migraciones-inbox.md` — log histórico migraciones
- `docs/operativa/github-actions.md` — workflows activos y planificados
- `docs/operativa/github-pillars.md` — los 4 pilares documentados
- `docs/operativa/mcp-setup-multi-ia.md` — Cursor + Gemini CLI con token full
- `docs/operativa/pendientes-labels-milestones.md` — spec 22 labels
- `docs/operativa/pendientes-sesion-2026-07-03.md` — cierre sesión
- `scripts/migrar-inbox.sh` — script semi-automático migraciones
- `docs/diarios/2026-07-02.md` — diario completo del día
- `docs/diarios/2026-07-01.md` — diario del día 01
- `docs/seguridad/hallazgos/ftp-puerto21.md` — hallazgo puerto 21
- `docs/seguridad/ssh-hardening.md` — estado hardening SSH Madre
- `docs/proyectos/thdora/arquitectura-bots.md` — TOKI-DEW + GUARDIAN
- `docs/herramientas/ollama-modelos.md` — modelos en Madre
- `docs/infra/acer/setup-bluetooth-chromium.md` — setup Acer
- `docs/infra/madre/auditoria-compose.md` — divergencias Docker

### Changed
- `CONTEXT.md` — actualizado al cierre de sesión 2026-07-03
- `docs/herramientas/github-ecosystem.md` — estado post-implementación

### Pending
- Labels 22 personalizados (needs Cursor con token full)
- Milestones Fase 0 + Fase 2
- Branch protection main

---

## [2026-07-02] — Auditoría ecosistema + arquitectura bots

### Added
- Auditoría herramientas GitHub
- Diseño arquitectura TOKI-DEW + TOKI-GUARDIAN
- Roadmap bots y scripts
- Análisis productividad sesiones

---

## [2026-07-01] — Fase 1 completada + SSH hardening + hallazgo FTP

### Added
- Tailscale en Madre y Acer — Fase 1 ✅
- SSH hardening parcial en Madre
- Hallazgo puerto 21 FTP expuesto
- Modelos Ollama descargados
- Auditoría Docker Compose

---

## [2026-06-28] — Auditoría de sesión completa

### Added
- Estructura inicial del repo
- CONVENCIONES.md, ECOSISTEMA.md, PLAN-SEGURIDAD-Y-DESPLIEGUE.md
- Primeras sesiones documentadas
