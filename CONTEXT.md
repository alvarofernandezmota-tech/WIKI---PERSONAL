# CONTEXT.md — Estado actual del ecosistema
#context #estado #navegacion

**Última actualización:** 2026-07-16 16:55 CEST  
**Próxima revisión obligatoria:** inicio de próxima sesión

---

## 🔴 PRIORIDAD MÁXIMA

> **Desactivar FTP puerto 21 en router Digi** → `http://192.168.1.1`  
> Ver: `docs/seguridad/hallazgos/ftp-puerto21.md`

> **THDORA caída** — HAL-007 (`.env` malformado) + HAL-008 (token Telegram revocado)  
> Ver: [DEW #44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) · [DEW #45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45)

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
- **Tailscale iOS:** ⏳ pendiente instalar

### Red
- **Tailscale:** ✅ Madre + Acer conectados
- **Router Digi:** 🔴 FTP puerto 21 expuesto

---

## Estado de la wiki — 2026-07-16

### ✅ COMPLETADO HOY (2026-07-16)
- **Purga wiki completada** — 3 archivos deprecados borrados (`VIDAPERSONAL.md`, `cerebro.md`, `labs.md`)
- **Repos alineados** en `AGENT.md`, `CONTEXT.md`, `00-mapa.md`, `mapa-islas.md`, `INDEX.md`
- **Nombre repo corregido** — `WIKI---PERSONAL` → `yggdrasil-wiki` en todos los ficheros
- **Repos corregidos** — `thdora-personal` → `THDORA-PERSONAL`, `formacion-tech` → `yggdrasil-formacion`, `vidapersonal` → `yggdrasil-tracking`
- **Fase 0 cerrada al 100%**
- `wiki/islas/INDEX.md` — 26 → 23 islas, conteos actualizados

### 🟡 PENDIENTE — Wiki
- Solapamiento `conocimiento.md` ↔ `formacion.md` — revisar y decidir
- `thea.md` — decisión arquitectural pendiente (A: archivar / B: fusionar / C: librería)
- `impresion3d.md` + `formacion.md` — stubs que necesitan input de Álvaro
- Subdirectorios `wiki/agentes/`, `wiki/conocimiento/`, `wiki/infra/`, `wiki/operaciones/`, `wiki/relaciones/`, `wiki/vida/` — auditar si están vacíos
- Labels (22) · Milestones · Branch protection — pendientes desde Fase 0

---

## Fase actual — Fase 1 (post cierre Fase 0)

### ✅ COMPLETADO
- Fase 0 — Repo + wiki estructurada: ✅ 100% (2026-07-16)
- Fase 1 — Tailscale: ✅ 100%

### ⏳ EN PROGRESO
- Fase 2 — SSH Hardening: `PasswordAuthentication no` pendiente
- Fase 3 — Wazuh SIEM: en progreso
- Fase 4 — Suricata IDS: en progreso

### 🕑 SIGUIENTE
- Protocolos de sesión — primer test ahora que wiki está limpia
- Cursor + MCP Acer (Fase 6)
- Decisión arquitectural `thea-ia` (ver DEW #49)
- Reactivar THDORA (HAL-007 + HAL-008)
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
- Índice canónico de islas: [`wiki/islas/INDEX.md`](wiki/islas/INDEX.md)
- Convenciones: [`wiki/CONVENCIONES.md`](wiki/CONVENCIONES.md)
- Seguridad FTP: [`docs/seguridad/hallazgos/ftp-puerto21.md`](docs/seguridad/hallazgos/ftp-puerto21.md)
- Filosofía: [`wiki/islas/filosofia.md`](wiki/islas/filosofia.md)

---

_Actualizado: 2026-07-16 16:55 CEST · Purga wiki · Fase 0 cerrada · Perplexity-MCP_
