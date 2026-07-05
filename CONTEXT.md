# CONTEXT.md — Estado actual del ecosistema
#context #estado #navegacion

**Última actualización:** 2026-07-05 20:50 CEST  
**Próxima revisión obligatoria:** 2026-07-10 (Milestone Fase 0 cierre)

---

## 🔴 PRIORIDAD MÁXIMA

> **Desactivar FTP puerto 21 en router Digi** → `http://192.168.1.1`  
> Ver: `docs/seguridad/hallazgos/ftp-puerto21.md`

---

## Estado del sistema

### Madre (torre Madrid)
- **Online:** ✅
- **SSH:** ✅ hardening parcial — falta `PasswordAuthentication no`
- **Tailscale:** ✅ activo · IP `100.91.112.32`
- **Docker:** ✅ Portainer, Grafana, Ollama activos
- **FTP puerto 21:** 🔴 EXPUESTO — p0-crítico

### Acer (Toledo)
- **Online:** cuando está encendido
- **Tailscale:** ✅ activo · IP `100.86.119.102`
- **Cursor:** ✅ instalado
- **MCP Cursor:** ❌ pendiente (token `repo` full + `~/.cursor/mcp.json`)

### iPhone 11
- **Perplexity MCP GitHub:** ✅ ACTIVO — gestión repo completa
- **a-Shell:** ⏳ pendiente instalar (App Store)
- **Tailscale iOS:** ⏳ pendiente instalar (App Store)

### Red
- **Tailscale:** ✅ Madre + Acer conectados
- **Router Digi:** 🔴 FTP puerto 21 expuesto
- **UFW Madre:** ✅ activo

---

## Estado de la wiki — 2026-07-05

### ✅ COMPLETADO HOY
- Estructura `wiki/` creada con islas, infra, operaciones, agentes
- `wiki/00-mapa.md` — mapa maestro del ecosistema actualizado
- `wiki/mapa-islas.md` — tabla de islas y repos
- `HOME.md` — dashboard de navegación completo
- `docs/CONVENCIONES.md` — convenciones reales escritas desde cero
- `docs/MAPA-REPO.md` — mapa real del repo (no de yggdrasil-dew)
- `AGENT.md` — actualizado con todos los repos y estado de fases
- `CONTEXT.md` — este fichero actualizado
- `README.md` — actualizado con estructura real
- Raíz del repo limpia — documentos maestros en MAYÚSCULAS

### ⚠️ PENDIENTE — Wiki
- Fichas de islas en `wiki/islas/` — páginas por rellenar con contenido real
- `docs/diarios/` — consolidar con `diarios/` raíz
- Stubs vacíos en `docs/` — eliminar (SHA `3ee0e19...`)
- Archivos sueltos en `docs/` — migrar a carpetas correctas
- `diarios/` raíz — migrar a `docs/diarios/` cuando haya terminal

---

## Fase actual — Fase 0

### ✅ COMPLETADO
- Fase 1 — Tailscale: ✅ 100%
- Fase 0 — Repo + wiki estructurada: 95%

### ⏳ EN PROGRESO
- Fase 0 cierre: labels (22), milestones, branch protection
- Fase 2 — SSH Hardening: `PasswordAuthentication no` pendiente
- Fase 3 — Wazuh SIEM: en progreso

### 🕑 SIGUIENTE
- iPhone terminal (a-Shell + Tailscale iOS)
- Cursor + MCP Acer (Fase 6)
- Rellenar fichas de islas en `wiki/islas/`
- Fase 3 — Docker hardening

---

## Herramientas GitHub

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
| Gemini CLI | Madre | ⏳ config pendiente | — |
| Cursor | Acer | ⏳ token full pendiente | Issue #15 |
| Ollama | Madre local | — | ✅ activo |

---

## Referencias rápidas

- Mapa del ecosistema: [`wiki/00-mapa.md`](wiki/00-mapa.md)
- Mapa de islas: [`wiki/mapa-islas.md`](wiki/mapa-islas.md)
- Convenciones: [`docs/CONVENCIONES.md`](docs/CONVENCIONES.md)
- Mapa del repo: [`docs/MAPA-REPO.md`](docs/MAPA-REPO.md)
- Seguridad FTP: [`docs/seguridad/hallazgos/ftp-puerto21.md`](docs/seguridad/hallazgos/ftp-puerto21.md)
- Filosofía: [`docs/filosofia/`](docs/filosofia/)
