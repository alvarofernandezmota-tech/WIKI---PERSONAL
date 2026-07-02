# CONTEXT.md — Estado actual del ecosistema
#context #estado #navegacion

**Última actualización:** 2026-07-03 01:00 CEST  
**Próxima revisión obligatoria:** 2026-07-10 (Milestone Fase 0)

---

## 🔴 PRIORIDAD MÁXIMA AHORA

> Antes de cualquier otra cosa:
> **Desactivar FTP puerto 21 en router Digi** → `http://192.168.1.1`
> Ver: `docs/seguridad/hallazgos/ftp-puerto21.md`

---

## Estado del sistema

### Madre (torre Madrid)
- **Online:** ✅
- **SSH:** ✅ hardening parcial — falta `PasswordAuthentication no`
- **Tailscale:** ✅ activo
- **Docker:** ✅ Portainer, Grafana, Ollama activos
- **FTP puerto 21:** 🔴 EXPUESTO — p0-critico

### Acer (Toledo)
- **Online:** cuando está encendido
- **Tailscale:** ✅ activo
- **Cursor:** ✅ instalado
- **MCP Cursor:** ❌ pendiente (token `repo` full + `~/.cursor/mcp.json`)
- **Perplexity web:** ⚠️ sin MCP — usar Cursor en su lugar

### iPhone
- **Perplexity MCP GitHub:** ✅ ACTIVO — gestión repo completa
- **a-Shell:** ⏳ pendiente instalar (App Store)
- **Tailscale iOS:** ⏳ pendiente instalar (App Store)

### Red
- **Tailscale:** ✅ Madre + Acer conectados
- **Router Digi:** 🔴 FTP puerto 21 expuesto
- **UFW Madre:** ✅ activo

---

## Fase actual

### ✅ COMPLETADO
- **Fase 1 — Tailscale:** ✅ 100%
- **Fase 0 — Repo:** 90% — 4 pilares GitHub, inbox limpia, docs completa, limpieza raíz hecha

### ⏳ EN PROGRESO
- **Fase 0 — Pendiente cierre:** Labels (22), milestones, branch protection
- **Fase 2 — SSH Hardening:** iniciado, falta `PasswordAuthentication no`

### 🕑 SIGUIENTE
- iPhone terminal (a-Shell + Tailscale iOS)
- Cursor + MCP Acer (Fase 6)
- Fase 3 — Docker hardening

---

## Herramientas GitHub activas ✅

| Herramienta | Estado |
|---|---|
| CODEOWNERS | ✅ activo |
| PR template | ✅ activo |
| Issue forms (4 tipos) | ✅ activos |
| Actions: context-reminder | ✅ activo |
| Actions: lint-commits | ✅ activo |
| Actions: inbox-health | ✅ activo |
| Labels personalizados (22) | ❌ pendiente |
| Milestones | ❌ pendiente |
| Branch protection | ❌ pendiente |

---

## Herramientas IA activas

| IA | Acceso | MCP GitHub | Estado |
|---|---|---|---|
| **Perplexity** | iPhone app | ✅ ACTIVO | Principal |
| Gemini CLI | Madre | ⏳ config pendiente | Doc: `docs/arquitectura/gemini-fase1-investigacion.md` |
| Cursor | Acer | ⏳ token full pendiente | Issue #15 |
| Ollama | Madre local | — | ✅ activo |

---

## Raíz del repo — estado

**✅ LIMPIA** (2026-07-03 01:00)
- `ly` — borrado ✅
- `tailscale-full.apk` — borrado ✅  
- `filosofia.md` — movida a `docs/filosofia/FILOSOFIA.md` ✅
- `diarios/` raíz — pendiente migrar contenido + borrar (needs-terminal)

---

## Inbox

**Estado:** ✅ LIMPIA — todos los ficheros procesados (2026-07-03 00:25)

---

## Referencias rápidas

- Diario hoy: [`docs/diarios/2026-07-03.md`](docs/diarios/2026-07-03.md)
- Pendientes: [`MASTER-PENDIENTES.md`](MASTER-PENDIENTES.md)
- Plan: [`PLAN-SEGURIDAD-Y-DESPLIEGUE.md`](PLAN-SEGURIDAD-Y-DESPLIEGUE.md)
- iPhone terminal: [`docs/operativa/iphone-terminal.md`](docs/operativa/iphone-terminal.md)
- Filosofía: [`docs/filosofia/FILOSOFIA.md`](docs/filosofia/FILOSOFIA.md)
- Gemini investigación: [`docs/arquitectura/gemini-fase1-investigacion.md`](docs/arquitectura/gemini-fase1-investigacion.md)
- Health-check script: [`scripts/maintenance/health-check.sh`](scripts/maintenance/health-check.sh)
