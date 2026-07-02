# Master Pendientes — Yggdrasil

> Actualizado: 2026-07-02 17:20 CEST
> Sincronizado con GitHub Issues — ver [yggdrasil-dew/issues](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues) y [yggdrasil-secops/issues](https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues)

---

## 🔴 CRÍTICO — Acción inmediata

- [ ] **[SEC-001]** Cerrar puerto 21 FTP en router Digi (`79.116.247.44`) → secops #1
- [ ] **[INFRA]** Fijar crash-loop `log_guardian_bot` → secops #2
- [ ] **[INFRA]** Fijar crash-loop `tailscale_monitor` → secops #2
- [ ] **[REPO]** Borrar ficheros basura raíz: `ly`, `tailscale-full.apk` → dew #3
- [ ] **[REPO]** Mover `thdora/` raíz → ya existe en `proyectos/thdora/` → dew #3
- [ ] **[REPO]** Mover `osint-stack/docker-compose.kali.yml` → `docker/` → dew #3

---

## 🟡 PRIORITARIO — Esta semana

### Infra / Docker
- [ ] Levantar Wazuh Manager + Dashboard → dew #4
- [ ] Levantar Suricata IDS (pasivo wlan0) → dew #4
- [ ] Levantar Pihole + SearXNG → dew #4
- [ ] Verificar Kali KasmWeb operativo
- [ ] Auditar APIs sin auth: Ollama `:11434`, Qdrant `:6333` → dew #5

### SecOps / Bots
- [ ] Configurar `WATCH_PATHS` en `local_tripwire` (rutas: `/etc`, docker configs, repos) → secops #6
- [ ] Documentar causa + fix crash-loops en `docs/bots/`

### Integración alertas
- [ ] Conectar Suricata → Wazuh → AlertManager → Telegram (thdora-bot)
- [ ] Configurar Grafana con fuente Wazuh/Loki
- [ ] Wazuh: configurar agentes en theodora e iPhone

### Mobile / Acceso
- [ ] Instalar Termius en iPhone → dew #7
- [ ] Configurar SSH madre via Tailscale desde iPhone
- [ ] Tailscale login en Redmi A5

---

## 🟢 PRÓXIMAS 2 SEMANAS

- [ ] GitHub Project kanban unificado (dew + secops) → dew #8
- [ ] Labels profesionales en ambas repos
- [ ] Script backup automático de configs
- [ ] Documentar arquitectura red completa en `docs/infra/red-local.md`
- [ ] Pihole: configurar listas de bloqueo
- [ ] SearXNG: configurar instancia privada
- [ ] Wazuh dashboard: primeras alertas
- [ ] Añadir Loki + Promtail al stack

---

## 📋 BACKLOG

- [ ] CI/CD básico GitHub Actions para las repos
- [ ] Migrate theodora configs to repo
- [ ] AddAlertManager (9093) al stack
- [ ] Evaluar CrowdSec vs fail2ban
- [ ] DefectDojo para gestión de hallazgos
- [ ] Ntfy como sistema notificaciones push
- [ ] `port_scanner_bot` — desarrollar código real
- [ ] `threat_intel_bot` — OSINT automatizado
- [ ] `vuln_tracker_bot` — CVE tracking
- [ ] Fase 2 pentest router Digi (post SEC-001)
- [ ] Añadir yggdrasil-secops como git submodule en yggdrasil-dew

---

## ✅ COMPLETADO

- [x] SSH Hardening madre (ed25519, passphrase, no root, no password)
- [x] Ollama instalado y modelos descargados (qwen2.5, llama3.1, bge-m3, nomic-embed)
- [x] Pentest inicial red local — Fase 1 completada (nmap, nikto, hydra)
- [x] MadreAP hostapd + dnsmasq operativo
- [x] Suspensión sistema maskeada en madre
- [x] Docker stack principal levantado (thdora, grafana, prometheus, qdrant, n8n, gitea, spiderfoot…)
- [x] ADB Redmi A5: optimización hotspot
- [x] Bots de monitorización activos (7 bots, guardian_bot estable)
- [x] ECOSISTEMA.md completo con todas las repos y nodos
- [x] Análisis logs bots — issues detectados y documentados
- [x] **02-jul** — Inbox vaciada (22 ficheros → `inbox/procesado/`)
- [x] **02-jul** — 16 ficheros cristalizados en árbol de conocimiento
- [x] **02-jul** — Diarios 25-jun→02-jul completos
- [x] **02-jul** — Issues #1 y #2 abiertos en yggdrasil-secops
- [x] **02-jul** — yggdrasil-secops: diarios + arquitectura bots + SEC-001 ref
