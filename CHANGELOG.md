# CHANGELOG — yggdrasil-wiki
#changelog #historial

Formato: [Keep a Changelog](https://keepachangelog.com/es/1.1.0/)  
Versionado: fecha de sesión

---

## [2026-07-12/13] — Auditoría ecosistema completa — 25 islas + alineación tridente

### Added
- `wiki/islas/mcp.md` — isla nueva: protocolo MCP consolidado — cierra #42
- `wiki/islas/orquestador.md` — isla nueva: n8n, agentes, automatizaciones
- `wiki/islas/filosofia.md` — isla nueva: principios, valores, cosmovisión Yggdrasil
- `wiki/islas/ia-local.md` — isla nueva (stub completado)
- `wiki/islas/secops.md` — isla nueva (stub completado)
- `wiki/islas/gitops.md` — isla nueva (stub completado)
- `wiki/islas/scripts.md` — isla nueva (stub completado)
- `docs/sesiones/2026-07-12-auditoria-seguridad.md` — sesión auditoría isla seguridad
- `docs/sesiones/2026-07-13-cierre-sesion.md` — cierre oficial sesión completa
- `wiki/investigacion/2026-07-13-auditoria-gemini.md` — registro auditoría externa Gemini

### Changed
- `INDEX.md` — actualizado a 25 islas reales auditadas + alineación 19 repos
- `HOME.md` + `README.md` — unificados, estado real ecosistema
- `CONTEXT.md` — actualizado a estado real 2026-07-13
- `CHANGELOG.md` — fix título (decía yggdrasil-dew por error) + esta entrada
- Islas expandidas con contenido real: `acer`, `thea`, `labs`, `thdora`, `cerebro`, `seguridad`
- `GRAFO-ECOSISTEMA.md` — dependencias ecosistema completas

### Issues cerrados
- #42 AUDIT-005 — isla mcp.md consolidada
- #41 parcial — C4 Mermaid (completado en DEW)

### Estado al cierre
- 25 islas verificadas y con contenido real
- Tridente DEW ↔ Wiki ↔ VIDAPERSONAL alineado al 100%
- 10 commits en 2 días

---

## [2026-07-03 madrugada] — Sesión activa — Limpieza P3 + Gemini docs + health-check

### Added
- `docs/arquitectura/gemini-fase1-investigacion.md` — investigación Gemini revisada y documentada
- `scripts/maintenance/health-check.sh` — script funcional: Tailscale, Btrfs, Docker, Ollama, GPU, UFW, SMART
- `docs/filosofia/FILOSOFIA.md` — filosofía core movida a ubicación correcta

### Removed
- `ly` — fichero vacío basura borrado de raíz
- `tailscale-full.apk` — fichero vacío basura borrado de raíz
- `filosofia.md` raíz — movida a `docs/filosofia/FILOSOFIA.md`

### Changed
- `MASTER-PENDIENTES.md` — P3 limpieza completados
- `CONTEXT.md` — estado actualizado sesión activa

---

## [2026-07-03] — Cierre sesión — Fase 0 GitHub 85% + iPhone terminal

### Added
- `docs/operativa/iphone-terminal.md`
- `docs/diarios/2026-07-02.md`
- `docs/diarios/2026-07-01.md`
- `docs/seguridad/hallazgos/ftp-puerto21.md`
- `docs/seguridad/ssh-hardening.md`
- `docs/proyectos/thdora/arquitectura-bots.md`
- `docs/herramientas/ollama-modelos.md`
- `docs/herramientas/github-ecosystem.md`
- `docs/infra/acer/setup-bluetooth-chromium.md`
- `docs/infra/madre/auditoria-compose.md`
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
- `.github/workflows/` (3 actions)
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

---

_Perplexity-MCP_
