# Pendientes cierre sesión — 2026-07-03
#pendientes #sesion #fase0

**Sesión:** 2026-07-02 23:00 → 2026-07-03 00:18 CEST  
**Completado esta sesión:** 4 pilares GitHub (CODEOWNERS, templates, Actions, operativa)

---

## ✅ Completado esta sesión

- [x] `.github/CODEOWNERS`
- [x] `.github/PULL_REQUEST_TEMPLATE.md`
- [x] `.github/ISSUE_TEMPLATE/` — bug, tarea, seguridad, config
- [x] `.github/workflows/` — context-reminder, lint-commits, inbox-health
- [x] `docs/operativa/workflow-inbox.md`
- [x] `docs/operativa/migraciones-inbox.md`
- [x] `docs/operativa/github-actions.md`
- [x] `docs/operativa/github-pillars.md`
- [x] `scripts/migrar-inbox.sh`
- [x] `docs/operativa/mcp-setup-multi-ia.md` (esta sesión)
- [x] `docs/operativa/pendientes-labels-milestones.md` (esta sesión)

---

## 🔴 Pendiente — mobile-ok (GitHub web, 5 min)

- [ ] Crear 22 labels personalizados → [labels](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/labels)
- [ ] Crear milestone `Fase 0 — Repo limpio` (due 2026-07-10)
- [ ] Crear milestone `Fase 2 — SSH Hardening` (due 2026-07-15)
- [ ] Branch protection en main → Settings → Branches
- [ ] Crear repo `alvarofernandezmota-tech` con Profile README
- [ ] Pinear repos en perfil

---

## 🔴 Pendiente — needs-terminal (Acer mañana)

- [ ] **Puerto 21 FTP** — panel router Digi → desactivar FTP server
- [ ] **SSH `PasswordAuthentication no`** en Madre — ver `docs/seguridad/ssh-hardening.md`
- [ ] **Probar SSH Acer→Madre** desde Toledo
- [ ] **Token GitHub `repo` completo** → `github.com/settings/tokens/new`
- [ ] **Configurar MCP Cursor** con token full → `~/.cursor/mcp.json`
- [ ] **Instalar Gemini CLI** en Acer/Madre → `npm install -g @google/gemini-cli`
- [ ] **TOKI-Guardian** — handlers `/estado` `/docker` `/alertas`

---

## 📋 Orden de prioridad mañana

1. Puerto 21 FTP (seguridad — p1-urgente)
2. SSH PasswordAuthentication no (seguridad — p1-urgente)
3. Token GitHub + MCP Cursor (desbloquea labels y control total)
4. Labels + milestones (si no hecho desde móvil)
5. TOKI-Guardian handlers

> Ver plan completo: `PLAN-FASES.md` y `MASTER-PENDIENTES.md`
