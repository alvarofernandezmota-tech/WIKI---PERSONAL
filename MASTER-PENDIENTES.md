---
tags: [pendientes, ssot, organizacion]
fecha-actualizacion: 2026-07-03T06:45
---

# MASTER-PENDIENTES.md

**Última actualización:** 2026-07-03 06:45 CEST

> Fuente única de verdad para pendientes. Los issues de GitHub son el tracker operativo; este fichero es el mapa estratégico.

---

## ✅ COMPLETADO — historial

### Sesión 2026-07-03
- [x] Issue #10 thdora — Fix `/config` timeout ✅
- [x] Issue #12 thdora — Código zombie eliminado ✅
- [x] `pytest` añadido a requirements-dev.txt ✅
- [x] `ai_audit.py` v2 creado ✅
- [x] `scripts/SCRIPTS.md` índice maestro creado ✅
- [x] `docs/AUDIT-SCRIPTS-2026-07-03.md` auditoria completa ✅
- [x] `scripts/maintenance/close-session.sh` creado ✅
- [x] `scripts/maintenance/night-cron.sh` creado ✅
- [x] `scripts/thdora/bot-session-report.sh` creado ✅
- [x] `scripts/infra/docker-health-check.sh` creado ✅
- [x] ROADMAP.md actualizado con estado real fases ✅
- [x] ESTADO-SISTEMA.md actualizado ✅
- [x] Regla SINE documentada en CONVENCIONES.md ✅

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

- [ ] **Docker thdora confirmar arriba** — `docker ps` en Madre
  - Desbloquea: smoke test `/start` Telegram
  - needs-terminal: SÍ

- [ ] **Smoke test** `/start` en Telegram via thdora
  - Requiere: Docker arriba
  - needs-terminal: NO (desde iPhone)

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

## 🟡 P2-NORMAL — Fase 6 Thdora (foco actual)

- [ ] **Handler `/estado`** en thdora — responde con estado Docker + sistema
  - Requiere: Docker arriba
  - needs-terminal: NO (vía MCP thdora)

- [ ] **Handler `/inbox`** en thdora — lista inbox de yggdrasil-dew
  - needs-terminal: NO

- [ ] **Handler `/pendientes`** en thdora — lista P0+P1 de este fichero
  - needs-terminal: NO

- [ ] Eliminar zombies scripts:
  - `scripts/inbox-cleanup-jun2024.sh`
  - `scripts/bc`
  - `scripts/inicio-sesion.sh`
  - mobile-ok: SÍ (vía MCP)

- [ ] Registrar cron nocturno en Madre:
  ```bash
  crontab -e
  # 0 2 * * * bash ~/yggdrasil-dew/scripts/maintenance/night-cron.sh >> /tmp/night-cron.log 2>&1
  ```
  - needs-terminal: SÍ

---

## 🔵 P3-BACKLOG

### Scripts — reorganización
- [ ] Mover scripts sueltos a subdirectorios correctos (ver AUDIT-SCRIPTS-2026-07-03.md)
- [ ] Unificar numeración 01-10 con ROADMAP fases reales
- [ ] Labels 22 personalizados (GitHub web)
- [ ] Milestones: Fase 0 (jul-10) + Fase 2 (jul-15)
- [ ] Branch protection main
- [ ] Limpiar carpeta `diarios/` raíz (duplica `docs/diarios/`)

### Decisión pendiente
- [ ] **Batcueva/IA stack** — ¿repo aparte o carpeta `infra/batcueva/` en yggdrasil-dew?
  - Candidatos: Ollama config, n8n flows, Wazuh config, Qdrant config
  - Ema: integrar como módulo en thdora (NO repo aparte) — decidido

### Fase 7 — Ollama + RAG
- [ ] `llama3.1:8b` pull
- [ ] `bge-m3` pull (embeddings)
- [ ] Qdrant desplegado en Madre
- [ ] RAG funcional sobre docs/

### Fase 9 — Mobile
- [ ] Termius iPhone configurado
- [ ] SSH funcional iPhone → Madre
- [ ] Tailscale Redmi A5

---

_Actualizado: 2026-07-03 06:45 CEST — cierre sesión Perplexity MCP_
