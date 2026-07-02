# CONTEXT.md — Estado actual del ecosistema
#context #estado #navegacion

**Última actualización:** 2026-07-03 00:20 CEST  
**Próxima revisión:** 2026-07-10 (Milestone Fase 0)

---

## Estado del sistema

### Madre (torre Madrid)
- **Online:** ✅
- **SSH:** ✅ hardening parcial (falta `PasswordAuthentication no`)
- **Tailscale:** ✅ activo
- **Docker:** ✅ Portainer, Grafana, Ollama activos
- **FTP puerto 21:** 🔴 EXPUESTO — pendiente desactivar en router Digi

### Acer (Toledo)
- **Online:** ✅ (cuando está encendido)
- **Tailscale:** ✅ activo
- **Cursor:** ✅ instalado
- **Bluetooth:** ✅ resuelto
- **MCP Cursor:** ❌ pendiente configurar token full

### Red
- **Tailscale:** ✅ Madre + Acer en red privada
- **Router Digi:** FTP puerto 21 🔴 expuesto
- **UFW Madre:** ✅ activo

---

## Fase actual

**Fase 0 — Repo limpio:** 85% completada
- ✅ Estructura docs, convenciones, CONTEXT, CHANGELOG
- ✅ CODEOWNERS, PR template, Issue forms
- ✅ 3 GitHub Actions workflows activos
- ✅ Operativa inbox documentada
- ⏳ Labels, milestones, branch protection pendientes

**Próxima fase:** Fase 2 — SSH Hardening (Fase 1 Tailscale ✅ completada)

---

## Próximo paso más importante

🔴 **Puerto 21 FTP** — desactivar en panel router Digi (`192.168.1.1`)

Luego:
1. `PasswordAuthentication no` en Madre (con segunda terminal SSH abierta)
2. Token GitHub `repo` full + MCP Cursor → desbloquea labels desde IA
3. Labels + milestones → cierre Fase 0

---

## Herramientas IA activas

| IA | Uso | MCP | Estado |
|---|---|---|---|
| Perplexity | Gestión repo, docs, research | GitHub MCP ✅ | Principal |
| Gemini CLI | Terminal, automatización | Pendiente config | En Acer |
| Cursor | Código, filesystem local | Pendiente config | En Acer |
| Ollama | IA local offline | — | En Madre |

---

## Inbox

**Estado:** ✅ LIMPIA — todos los ficheros migrados (2026-07-03 00:20)

---

## Referencias rápidas

- Plan completo: `PLAN-SEGURIDAD-Y-DESPLIEGUE.md`
- Pendientes: `MASTER-PENDIENTES.md`
- Cierre sesión: `docs/operativa/pendientes-sesion-2026-07-03.md`
- MCP setup: `docs/operativa/mcp-setup-multi-ia.md`
- Diario hoy: `docs/diarios/2026-07-02.md`
