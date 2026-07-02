# MASTER-PENDIENTES.md
#pendientes #organizacion #navegacion

**Última actualización:** 2026-07-03 00:25 CEST

> Fuente única de verdad para pendientes. Los issues de GitHub son el tracker operativo; este fichero es el mapa estratégico.

---

## ✅ COMPLETADO — historial

### Fase 1 — Tailscale [✅ COMPLETADO 2026-07-01]
- [x] Tailscale instalado en Madre
- [x] Tailscale instalado en Acer
- [x] Red privada funcional Madre ↔ Acer
- [x] SSH por Tailscale verificado
- [x] IPs documentadas

### Fase 0 — GitHub (parcial) [✅ 85% 2026-07-02/03]
- [x] Estructura docs/ y convenciones
- [x] CONTEXT.md, CHANGELOG.md, ECOSISTEMA.md, PLAN
- [x] CODEOWNERS, PR template, Issue forms (4)
- [x] 3 GitHub Actions workflows activos
- [x] docs/operativa/ completa (6 docs)
- [x] Inbox limpia — 30 ficheros procesados
- [x] scripts/migrar-inbox.sh
- [x] Diarios 2026-06-27 al 2026-07-02 iniciados

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

## 🔴 P0-CRÍTICO — hacer antes de dormir / primera cosa del día

- [ ] **Puerto 21 FTP** — desactivar en panel router Digi `http://192.168.1.1`
  - Ruta: Configuración avanzada → Servicios → FTP → Desactivar
  - Doc: `docs/seguridad/hallazgos/ftp-puerto21.md`
  - Requiere: acceso físico a Madrid o acceso remoto al panel del router

---

## ⚠️ P1-URGENTE

- [ ] `PasswordAuthentication no` en Madre
  - Requiere: 2 terminales SSH abiertas simultáneamente + test previo
  - Doc: `docs/seguridad/ssh-hardening.md`
  - mobile-ok: NO — needs-terminal

- [ ] Token GitHub `repo` full
  - Desbloquea: labels, milestones, branch protection desde IA
  - Dónde: GitHub.com → Settings → Developer settings → Tokens
  - mobile-ok: SÍ — hacerlo desde iPhone

- [ ] Instalar a-Shell en iPhone
  - App Store → "a-Shell" (Nicolas Holzschuch)
  - Doc: `docs/operativa/iphone-terminal.md`
  - mobile-ok: SÍ

- [ ] Instalar Tailscale iOS en iPhone
  - App Store → "Tailscale"
  - mobile-ok: SÍ

---

## 🟡 P2-NORMAL — Fase 0 cierre

- [ ] Labels 22 personalizados
  - Requiere: token `repo` full o GitHub web
  - Doc: `docs/operativa/pendientes-labels-milestones.md`
  - mobile-ok: SÍ (GitHub web desde iPhone)

- [ ] Milestones: Fase 0 (jul-10) + Fase 2 (jul-15)
  - mobile-ok: SÍ (GitHub web)

- [ ] Branch protection main
  - mobile-ok: SÍ (GitHub web)

---

## 🟢 P3-LIMPIEZA — cuando haya tiempo

- [ ] Borrar `ly` de raíz (fichero vacío)
  - mobile-ok: SÍ (GitHub web → editar → borrar)

- [ ] Borrar `tailscale-full.apk` de raíz (fichero vacío)
  - mobile-ok: SÍ (GitHub web)

- [ ] Mover `filosofia.md` raíz → `docs/filosofia.md`
  - mobile-ok: SÍ (GitHub web)

- [ ] Limpiar carpeta `diarios/` raíz (duplica `docs/diarios/`)
  - Primero: verificar si tiene contenido diferente al de `docs/diarios/`
  - needs-terminal: SÍ (o Cursor)

---

## 🔄 EN PROCESO

- [ ] MCP Cursor (token full + config en Acer)
  - Bloquea: automatización local, labels desde IA
  - Desbloqueado por: token `repo` full (P1)

- [ ] a-Shell + SSH Madre desde iPhone
  - Desbloqueado por: a-Shell instalado + Tailscale iOS
  - Doc: `docs/operativa/iphone-terminal.md`

- [ ] Gemini CLI en Madre
  - Configurar con API key
  - Habilita: automatización local gratuita

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

### Fase 6 — Bots Telegram
- [ ] TOKI-GUARDIAN: `/estado` `/docker` `/alertas`
- [ ] TOKI-DEW básico: consultas repo
- [ ] Webhook Grafana → Telegram

### Fase 7 — IA local
- [ ] RAG sobre repo con nomic-embed-text
- [ ] Open WebUI accesible por Tailscale
- [ ] TOKI-DEW + Ollama integrado
