# CONTEXT.md — Estado actual del ecosistema
#context #estado #navegacion

**Última actualización:** 2026-07-03 00:25 CEST  
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
- **Cursor:** ✅ instalado, token `repo` full pendiente
- **Bluetooth:** ✅ resuelto
- **MCP Cursor:** ❌ pendiente (token full + config)

### iPhone
- **Perplexity MCP GitHub:** ✅ ACTIVO — gestión repo completa
- **a-Shell:** ⏳ pendiente instalar
- **Tailscale iOS:** ⏳ pendiente instalar

### Red
- **Tailscale:** ✅ Madre + Acer conectados
- **Router Digi:** 🔴 FTP puerto 21 expuesto
- **UFW Madre:** ✅ activo

---

## Fase actual

### ✅ COMPLETADO
- **Fase 1 — Tailscale:** ✅ 100% — Madre + Acer en red privada
- **Fase 0 — Repo limpio:** 85% — 4 pilares GitHub activos, inbox limpia

### ⏳ EN PROGRESO
- **Fase 0 — Pendiente:** Labels (22), milestones, branch protection
- **Fase 2 — SSH Hardening:** iniciado, falta `PasswordAuthentication no`

### 🕑 SIGUIENTE
- Fase 3 — Docker hardening
- Fase 4 — Monitoring (Grafana + alertas)

---

## Herramientas IA activas

| IA | Acceso | MCP GitHub | Estado |
|---|---|---|---|
| **Perplexity** | iPhone + Acer | ✅ ACTIVO | Principal |
| Gemini CLI | Acer / Madre | pendiente config | En setup |
| Cursor | Acer | token parcial | Token full pendiente |
| Ollama | Madre | — local | Activo |

---

## Operativa sin ordenador (iPhone)

- **Gestión repo:** Perplexity app + MCP ✅
- **Terminal SSH a Madre:** a-Shell (pendiente instalar)
- **VPN a red privada:** Tailscale iOS (pendiente instalar)

---

## Inbox

**Estado:** ✅ LIMPIA — todos los ficheros procesados (2026-07-03 00:25)

---

## Ficheros basura en raíz — pendiente limpiar

| Fichero | Tipo | Acción |
|---|---|---|
| `ly` | fichero vacío | borrar (GitHub web) |
| `tailscale-full.apk` | fichero vacío | borrar (GitHub web) |
| `diarios/` | carpeta duplicada de `docs/diarios/` | migrar contenido + borrar (needs-terminal) |
| `filosofia.md` | fichero en raíz | mover a `docs/filosofia.md` (GitHub web) |

---

## Referencias rápidas

- Diario hoy: [`docs/diarios/2026-07-02.md`](docs/diarios/2026-07-02.md)
- Pendientes: [`MASTER-PENDIENTES.md`](MASTER-PENDIENTES.md)
- Plan: [`PLAN-SEGURIDAD-Y-DESPLIEGUE.md`](PLAN-SEGURIDAD-Y-DESPLIEGUE.md)
- iPhone terminal: [`docs/operativa/iphone-terminal.md`](docs/operativa/iphone-terminal.md)
- MCP setup: [`docs/operativa/mcp-setup-multi-ia.md`](docs/operativa/mcp-setup-multi-ia.md)
