---
tags: [changelog]
fecha-actualizacion: 2026-07-02T21:05
---

# Changelog

Todos los cambios relevantes del proyecto. Formato: [Keep a Changelog](https://keepachangelog.com/es/1.0.0/).
Versionado: [SemVer](https://semver.org/lang/es/).

---

## [Unreleased]

### Por hacer
- Milestones por fase en GitHub
- Labels personalizados (20+)
- PR template
- CODEOWNERS
- Branch protection
- Desplegar 5 GitHub Actions
- Instalar Cursor + MCP en Thdora
- Migración inbox → docs/ (script listo)
- Crear issues #13, #14, #15
- SSH hardening completo Madre
- Cerrar puerto FTP 21
- Fix n8n binding 0.0.0.0 → Tailscale

---

## [0.4.0] — 2026-07-02

### Añadido
- `CONTRIBUTING.md` creado con estándares de contribución
- Issue templates en `.github/ISSUE_TEMPLATE/` (bug, feature, diary, security)
- Issues #8 al #12 creados con documentación técnica completa
- Fases 6d, 7, 8MCP identificadas y documentadas
- Volcado de sesión completa en `inbox/`
- Script de migración `inbox/2026-07-02-auditoria-inbox-migracion.md`
- Arquitectura MCP multi-IA documentada

### Cambiado
- `CONVENCIONES.md` elevado a nivel senior
- `AGENT.md` actualizado con naming Thdora y nuevas reglas
- `MASTER-PENDIENTES.md` reestructurado con todas las fases y SSOT naming
- `CONTEXT.md` actualizado con estado real del ecosistema
- `ROADMAP.md` expandido con fases 6d, 7, 8MCP, 9
- `ESTADO-SISTEMA.md` actualizado con hallazgos reales
- Naming bots: TOKI-* → Thdora / Thdora Guardián / Thdora Dev

### Deprecado
- Naming `TOKI-Guardian`, `TOKI-DEW` — reemplazado por Thdora Guardián / Thdora Dev

---

## [0.3.0] — 2026-07-01

### Añadido
- Documentación completa hardening SSH
- Hallazgo FTP puerto 21 documentado
- Auditoría Docker Compose divergencias
- Sesión pentest completa documentada
- Modelos Ollama completos (qwen2.5:7b, qwen2.5:3b)
- Arquitectura bots SecOps documentada

### Cambiado
- Fase 1 elevada a 90% completada
- Stack Ollama operativo en Madre

---

## [0.2.0] — 2026-06-30

### Añadido
- Thdora FastAPI base corriendo
- Modelos Ollama: primer pull y configuración
- Cierre de sesión documentado

### Cambiado
- Estado Thdora: activa con base funcional

---

## [0.1.0] — 2026-06-27

### Añadido
- Repo iniciado y estructurado
- UFW + fail2ban + Tailscale configurados en Madre
- Primeras sesiones documentadas
- Estructura base de carpetas

---

_Actualizado: 02-jul-2026 21:05 CEST — Perplexity vía MCP_
