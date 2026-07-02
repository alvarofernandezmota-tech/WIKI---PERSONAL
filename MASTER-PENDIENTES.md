---
tags: [master, pendientes, tareas, issues]
fecha-actualizacion: 2026-07-02
---

# 📋 MASTER-PENDIENTES

> Fuente única de verdad de TODO lo pendiente.
> Sincronizado con Issues GitHub.
> Última actualización: **02-jul-2026 19:45 CEST**

---

## 🔥 CRÍTICO — hacer pronto

- [ ] **SEC-001** — Cerrar FTP puerto 21 router Digi (`79.116.247.44`) → secops #1
- [ ] Fix crash-loops: `log_guardian_bot` + `tailscale_monitor` → secops #2
- [ ] Fix `local_tripwire`: configurar `WATCH_PATHS` → secops #2
- [ ] Login Tailscale en Redmi A5 (tocar pantalla físicamente)
- [ ] Instalar **Blink Shell** en iPhone + configurar SSH a madre → Issue dew #8

---

## 🟡 ALTA prioridad

### GitHub / Repos (Fase 1 + 2)
- [ ] Borrar `ly` y `tailscale-full.apk` de raíz yggdrasil-dew (git rm local)
- [ ] Borrar/mover `thdora/` y `osint-stack/` de raíz yggdrasil-dew
- [ ] Crear labels GitHub: `security`, `bug`, `infra`, `docs`, `pentest`, `bot`
- [ ] Profile README GitHub profesional (Fase 2)
- [ ] Pinear repos: yggdrasil-dew, thdora, yggdrasil-secops, osint-stack, ai-toolkit → Issue dew #9
- [ ] **Automatizar actualización docs con GitHub Actions** → Issue dew #11

### Configuración móvil (Issue dew #8)
- [ ] Instalar Blink Shell (App Store o compilar Xcode)
- [ ] Generar llave ed25519 en Secure Enclave desde Blink
- [ ] Añadir llave pública a madre `authorized_keys`
- [ ] Verificar conexión Tailscale iPhone activa antes de SSH

### Seguridad infra
- [ ] Auditar Ollama `:11434` — confirmar solo accesible vía Tailscale
- [ ] Auditar Qdrant `:6333` — sin auth público
- [ ] Desactivar ADB Redmi cuando no se use

---

## 🟢 NORMAL

### Infra / Docker (Fase 5)
- [ ] Levantar wazuh + suricata (IDS)
- [ ] Levantar pihole (DNS blocker)
- [ ] Levantar searxng (búsqueda privada)
- [ ] Sync divergencia composes repos vs disco madre
- [ ] Configurar `OLLAMA_HOST=127.0.0.1` o bind solo Tailscale
- [ ] Repo `batcueva` — crear (infra ejecutable)
- [ ] AlertManager → Telegram (cadena alertas Fase 5)
- [ ] Loki + Promtail (logs → Grafana)

### THDORA (handlers pendientes)
- [ ] Implementar handlers thdora-bot
- [ ] Testing pipeline FastAPI + Ollama

### Pentest
- [ ] Esperar imagen Kali KasmWeb 3.7GB
- [ ] Acceder a `http://100.91.112.32:6901` y verificar
- [ ] Instalar herramientas en Kali
- [ ] Definir scope primer pentest

---

## 🔜 ROADMAP largo plazo (Fase 4 + 5)

- [ ] Auditoría gobernanza completa repos → Issue dew #10
- [ ] CrowdSec — complementar fail2ban
- [ ] BloodHound — mapeado AD si aplica
- [ ] Ntfy — notificaciones push ligeras

---

## ✅ COMPLETADO (referencias)

| Tarea | Fecha | Issue/PR |
|---|---|---|
| SSH hardening madre | 2026-07-01 | — |
| AP WiFi MadreAP debug | 2026-06-27 | — |
| Tailscale iOS instalado vía ADB | 2026-07-01 | — |
| Modelos Ollama inventariados | 2026-07-01 | — |
| Issue templates GitHub | 2026-07-02 | PR — |
| ECOSISTEMA.md auditado | 2026-07-02 | — |
| Inbox vaciado (22 ficheros) | 2026-07-02 | — |
| Blink Shell — decisión tomada | 2026-07-02 | Issue dew #8 |
| Investigación GitHub Actions docs | 2026-07-02 | Issue dew #11 |

---
_Actualizado: 02-jul-2026 19:45 CEST — Perplexity vía MCP_
