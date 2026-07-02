# MASTER-PENDIENTES.md
#pendientes #organizacion #navegacion

**Última actualización:** 2026-07-03 01:00 CEST

> Fuente única de verdad para pendientes. Los issues de GitHub son el tracker operativo; este fichero es el mapa estratégico.

---

## ✅ COMPLETADO — historial

### Fase 1 — Tailscale [✅ COMPLETADO 2026-07-01]
- [x] Tailscale instalado en Madre
- [x] Tailscale instalado en Acer
- [x] Red privada funcional Madre ↔ Acer
- [x] SSH por Tailscale verificado
- [x] IPs documentadas

### Fase 0 — GitHub (parcial) [✅ 90% 2026-07-03]
- [x] Estructura docs/ y convenciones
- [x] CONTEXT.md, CHANGELOG.md, ECOSISTEMA.md, PLAN
- [x] CODEOWNERS, PR template, Issue forms (4)
- [x] 3 GitHub Actions workflows activos
- [x] docs/operativa/ completa (6 docs)
- [x] Inbox limpia — 30 ficheros procesados
- [x] scripts/migrar-inbox.sh
- [x] Diarios 2026-06-27 al 2026-07-03 iniciados
- [x] docs/arquitectura/gemini-fase1-investigacion.md
- [x] scripts/maintenance/health-check.sh
- [x] docs/filosofia/FILOSOFIA.md (movida desde raíz)
- [x] Limpieza raíz: `ly`, `tailscale-full.apk`, `filosofia.md` borrados

### Seguridad — SSH (parcial) [✅ parcial 2026-07-01]
- [x] `PermitRootLogin no`
- [x] `MaxAuthTries 3`
- [x] `AllowUsers alvaro`
- [x] Fail2ban instalado y activo

### Acer [✅ 2026-07-02]
- [x] Bluetooth resuelto
- [x] Chromium como app para Perplexity
- [x] Tailscale activo

---

## 🔴 P0-CRÍTICO

- [ ] **Puerto 21 FTP** — desactivar en panel router Digi `http://192.168.1.1`
  - Ruta: Configuración avanzada → Servicios → FTP → Desactivar
  - Requiere: acceso físico a Madrid o acceso remoto al panel del router
  - Doc: `docs/seguridad/hallazgos/ftp-puerto21.md`

---

## ⚠️ P1-URGENTE

- [ ] `PasswordAuthentication no` en Madre
  - Requiere: 2 terminales SSH simultáneas + test previo
  - mobile-ok: NO — needs-terminal

- [ ] Token GitHub `repo` full (nuevo, no compartir en chat)
  - Desbloquea: labels, milestones, branch protection desde IA
  - Meter en Acer `~/.cursor/mcp.json` — nunca en el chat
  - mobile-ok: SÍ

- [ ] Instalar **a-Shell** en iPhone
  - App Store → "a-Shell" (Nicolas Holzschuch) — gratis
  - Doc: `docs/operativa/iphone-terminal.md`
  - mobile-ok: SÍ

- [ ] Instalar **Tailscale iOS** en iPhone
  - App Store → "Tailscale"
  - mobile-ok: SÍ

---

## 🟡 P2-NORMAL — Fase 0 cierre

- [ ] Labels 22 personalizados
  - Requiere: token `repo` full (Acer) o GitHub web (iPhone ahora)
  - Doc: `docs/operativa/pendientes-labels-milestones.md`
  - mobile-ok: SÍ (GitHub web desde iPhone)

- [ ] Milestones: Fase 0 (jul-10) + Fase 2 (jul-15)
  - mobile-ok: SÍ (GitHub web)

- [ ] Branch protection main
  - mobile-ok: SÍ (GitHub web)

- [ ] Limpiar carpeta `diarios/` raíz (duplica `docs/diarios/`)
  - needs-terminal: SÍ (o Cursor)

---

## 🔄 EN PROCESO

- [ ] MCP Cursor en Acer (token full + `~/.cursor/mcp.json`)
  - Bloquea: automatización local, labels desde IA
  - Issue #15

- [ ] a-Shell + SSH Madre desde iPhone
  - Desbloqueado por: a-Shell + Tailscale iOS instalados
  - Doc: `docs/operativa/iphone-terminal.md`

- [ ] Gemini CLI en Madre
  - Configurar con API key
  - Doc: `docs/arquitectura/gemini-fase1-investigacion.md`

---

## 🕑 FUTURO — fases siguientes

### Fase 2 — SSH Hardening completo
- [ ] `PasswordAuthentication no` (ver P1)
- [ ] Cambiar puerto SSH (22 → otro)
- [ ] Fail2ban tuning
- [ ] Auditoría UFW puertos

### Fase 3 — Docker hardening
- [ ] Auditar puertos expuestos contenedores
- [ ] Docker network isolation
- [ ] Secrets en `.env` — no en compose

### Fase 4 — Monitoring
- [ ] Grafana dashboards Madre
- [ ] Alertas Telegram (TOKI-GUARDIAN)
- [ ] Uptime Kuma o Prometheus

### Fase 5 — GitHub Actions avanzado
- [ ] Auto-cierre inbox workflow
- [ ] Deploy script Madre
- [ ] Backup automatizado repo

### Fase 6 — Cursor + MCP Acer
- [ ] Instalar cursor-bin (AUR)
- [ ] Configurar ~/.cursor/mcp.json
- [ ] Test MCP completo desde Acer

### Fase 7 — Bots Telegram
- [ ] TOKI-GUARDIAN: `/estado` `/docker` `/alertas`
- [ ] TOKI-DEW básico: consultas repo
- [ ] Webhook Grafana → Telegram

### Fase 8 — IA local
- [ ] RAG sobre repo con nomic-embed-text
- [ ] Open WebUI accesible por Tailscale
- [ ] TOKI-DEW + Ollama integrado
