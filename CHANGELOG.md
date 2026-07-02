# CHANGELOG — yggdrasil-dew
#changelog #historial

Formato: [Keep a Changelog](https://keepachangelog.com/es/1.1.0/)  
Versionado: fecha de sesión

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
- `CONTEXT.md` — estado exacto al cierre, iPhone añadido, ficheros basura documentados
- `MASTER-PENDIENTES.md` — items completados marcados ✅, p0/p1/p2/p3 actualizados
- `CHANGELOG.md` — este mismo

### Deprecated
- `diarios/` raíz — duplica `docs/diarios/`, pendiente migrar contenido y borrar

### Pending (needs-terminal o GitHub web)
- Borrar `ly`, `tailscale-full.apk`, mover `filosofia.md`
- Labels, milestones, branch protection
- `PasswordAuthentication no` SSH

---

## [2026-07-02] — Fase 0 GitHub: 4 pilares implementados

### Added
- `.github/CODEOWNERS`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/` (4 forms)
- `.github/workflows/` (3 actions: context-reminder, lint-commits, inbox-health)
- `docs/operativa/` (6 docs: workflow-inbox, migraciones, github-actions, github-pillars, mcp-setup, pendientes-labels)
- `scripts/migrar-inbox.sh`

### Changed
- `CONTEXT.md`, `CHANGELOG.md` actualizados

---

## [2026-07-01] — Fase 1 Tailscale ✅ + SSH hardening + hallazgo FTP

### Added
- Tailscale en Madre y Acer — red privada activa
- SSH hardening parcial (PermitRootLogin, MaxAuthTries, AllowUsers, Fail2ban)
- Hallazgo FTP puerto 21 (p0-critico)
- Modelos Ollama descargados

---

## [2026-06-28/30] — Estructura base del repo

### Added
- README, CONVENCIONES, ECOSISTEMA, PLAN-SEGURIDAD-Y-DESPLIEGUE
- Estructura inicial docs/, templates/, scripts/
- Primeras sesiones documentadas en inbox
