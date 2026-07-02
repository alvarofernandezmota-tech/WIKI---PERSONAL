# CHANGELOG — yggdrasil-dew
#changelog #historial

Formato: [Keep a Changelog](https://keepachangelog.com/es/1.1.0/)  
Versionado: fecha de sesión

---

## [2026-07-03 madrugada] — Sesión activa — Limpieza P3 + Gemini docs + health-check

### Added
- `docs/arquitectura/gemini-fase1-investigacion.md` — investigación Gemini revisada y documentada (Btrfs NoCoW, Docker UFW bypass, modelos GTX1060, bugs corregidos)
- `scripts/maintenance/health-check.sh` — script funcional: Tailscale, Btrfs, Docker, Ollama, GPU, UFW, SMART
- `docs/filosofia/FILOSOFIA.md` — filosofía core movida a ubicación correcta (docs/filosofia/)

### Removed
- `ly` — fichero vacío basura borrado de raíz
- `tailscale-full.apk` — fichero vacío basura borrado de raíz  
- `filosofia.md` raíz — movida a `docs/filosofia/FILOSOFIA.md`

### Changed
- `MASTER-PENDIENTES.md` — P3 limpieza completados
- `CONTEXT.md` — estado actualizado sesión activa

### En proceso esta sesión
- Labels 22 personalizados (pendiente token `repo` full o GitHub web)
- Milestones Fase 0 + Fase 2
- Issue #16 Setup Cursor + MCP Acer
- a-Shell + Tailscale iOS (pendiente instalación iPhone)

---

## [2026-07-03] — Cierre sesión — Fase 0 GitHub 85% + iPhone terminal

### Added
- `docs/operativa/iphone-terminal.md` — a-Shell + Tailscale iOS, operar sin ordenador
- `docs/diarios/2026-07-02.md` — diario cerrado definitivo con COMPLETADO/PENDIENTE
- `docs/diarios/2026-07-01.md` — diario día 01 SSH hardening + FTP + Fase 1
- `docs/seguridad/hallazgos/ftp-puerto21.md` — hallazgo p0-critico puerto 21
- `docs/seguridad/ssh-hardening.md` — estado hardening SSH Madre
- `docs/proyectos/thdora/arquitectura-bots.md` — TOKI-DEW + GUARDIAN diseño
- `docs/herramientas/ollama-modelos.md` — modelos Madre + comandos
- `docs/herramientas/github-ecosystem.md` — estado herramientas GitHub
- `docs/infra/acer/setup-bluetooth-chromium.md` — setup Acer día 02
- `docs/infra/madre/auditoria-compose.md` — divergencias Docker Madre
- `inbox/procesado/` — 30 stubs de ficheros migrados

### Changed
- `CONTEXT.md` — estado exacto al cierre
- `MASTER-PENDIENTES.md` — items completados ✅

---

## [2026-07-02] — Fase 0 GitHub: 4 pilares implementados

### Added
- `.github/CODEOWNERS`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/` (4 forms)
- `.github/workflows/` (3 actions: context-reminder, lint-commits, inbox-health)
- `docs/operativa/` (6 docs)
- `scripts/migrar-inbox.sh`

---

## [2026-07-01] — Fase 1 Tailscale ✅ + SSH hardening + hallazgo FTP

### Added
- Tailscale en Madre y Acer — red privada activa
- SSH hardening parcial
- Hallazgo FTP puerto 21 (P0-crítico)
- Modelos Ollama descargados

---

## [2026-06-28/30] — Estructura base del repo

### Added
- README, CONVENCIONES, ECOSISTEMA, PLAN-SEGURIDAD-Y-DESPLIEGUE
- Estructura inicial docs/, templates/, scripts/
