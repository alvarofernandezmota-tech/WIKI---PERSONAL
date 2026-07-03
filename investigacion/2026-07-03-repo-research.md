---
type: report
date: 2026-07-03
source: manual
priority: medium
status: pending
title: Investigación mejora repo
processed_by: pending
---

# Investigación de mejora del repo — 2026-07-03

## 1. Scripts sueltos en scripts/ (sin subdirectorio de isla)

- `scripts/01-fix-driver-rtl8188ftu.sh`
- `scripts/02-git-pull-rebase.sh`
- `scripts/03-fase1-seguridad.sh`
- `scripts/04-fase2-start-batcueva.sh`
- `scripts/05-fase7-ollama-pull.sh`
- `scripts/06-verificacion-post-reboot.sh`
- `scripts/07-fase3-restic-backup.sh`
- `scripts/08-fase6-thdora-handlers.sh`
- `scripts/09-fase8-seguridad-acer.sh`
- `scripts/10-fase9-osint-stack.sh`
- `scripts/audit-and-migrate.sh`
- `scripts/batcueva-control.sh`
- `scripts/cierre-sesion.sh`
- `scripts/create-issues.sh`
- `scripts/fix-permisos.sh`
- `scripts/hardening-ufw.sh`
- `scripts/inbox-cleanup-jun2026.sh`
- `scripts/inbox-migrate.sh`
- `scripts/inicio-sesion.sh`
- `scripts/procesar-inbox-masivo.sh`
- `scripts/repo-research.sh`
- `scripts/setup-labels.sh`
- `scripts/thdora-handlers.py`
- `scripts/uptime-kuma-webhook.py`
- `scripts/watchdog_adb.sh`

## 2. Subdirectorios de scripts/ sin README.md

- `scripts/archive/` — falta README
- `scripts/backup/` — falta README
- `scripts/ci/` — falta README
- `scripts/infra/` — falta README
- `scripts/maintenance/` — falta README
- `scripts/osint/` — falta README
- `scripts/seguridad/` — falta README
- `scripts/setup/` — falta README
- `scripts/tests/` — falta README
- `scripts/thdora/` — falta README

## 3. Posibles duplicados / solapamientos detectados

- `osint/` y `osint-stack/` — candidatos a fusionar
- `tools/` y `cli-tools/` — revisar separación
- `docker/` y `infra/` — revisar separación

## 4. Inventario de directorios (ficheros totales)

| Directorio | Ficheros |
|---|---|
| `.` | 1226 |
| `./agentes` | 62 |
| `./alvarofernandezmota-tech` | 1 |
| `./assets` | 1 |
| `./cli-tools` | 2 |
| `./core` | 2 |
| `./diarios` | 174 |
| `./docker` | 24 |
| `./docs` | 226 |
| `./formacion` | 197 |
| `./.git` | 66 |
| `./.github` | 33 |
| `./hardware` | 8 |
| `./inbox` | 56 |
| `./infra` | 7 |
| `./logs` | 1 |
| `./mocs` | 4 |
| `./.obsidian` | 5 |
| `./ollama` | 17 |
| `./osint` | 10 |
| `./osint-stack` | 1 |
| `./proyectos` | 56 |
| `./scripts` | 71 |
| `./sesiones` | 6 |
| `./setup` | 134 |
| `./templates` | 13 |
| `./thdora` | 2 |
| `./tools` | 18 |
| `./yo` | 11 |

## 5. Issues GitHub abiertos

- #29 🗂️ NUEVA SESIÓN — Backlog priorizado limpio 03-jul-2026\n- #28 formacion: retomar Python — biblioteca de scripts + módulos del ecosistema\n- #27 chore(madre): añadir cron semanal clean-root-artifacts en thdora\n- #26 [ECOSISTEMA] thdora — deuda técnica crítica (espejo maestro)\n- #25 ⏰ Verificar modelos Ollama descargados — revisar al despertar\n- #21 🔧 [AI] Fase 8 — Servidor MCP propio en Madre — Ollama + yggdrasil-dew\n- #20 🧠 [AI] Fase 7 — Ollama en Madre — IA local GTX 1060 6GB\n- #19 🤖 [AI] Fase 6d — Gemini + DeepSeek vía n8n → GitHub\n- #18 🤖 Profile README GitHub — alvarofernandezmota-tech\n- #17 📦 [REPO] Migrar inbox/ completo a docs/ — 32 ficheros pendientes\n- #16 🧹 [REPO] Limpieza git — rm basura + mv estructura definitiva\n- #15 💻 [DEV] Instalar Cursor + configurar MCP GitHub en Acer\n- #14 🔥 [SEGURIDAD] Cerrar puerto 21 FTP en router — hallazgo crítico\n- #12 feat(fase6c): crear TOKI-DEW — bot Telegram para yggdrasil-dew repo\n- #11 docs: automatizar actualización repo GitHub con GitHub Actions\n- #10 📐 [GOVERNANCE] Auditar reglas, naming y estructura de la repo\n- #9 🐳 [INFRA] Levantar stack completo: Wazuh + Suricata + Pihole + SearXNG\n- #8 📱 [MOBILE] Terminal iPhone → madre via Termius + Tailscale\n- #6 📓 DIARY — Sesión 28-06-2026 | Netdata Acer + fail2ban jails + puerto 53317 + AP documentado\n- #5 📡 varpc — Access Point WiFi (hostapd) — Setup y estado\n
## 6. Propuestas de mejora

- [ ] Mover scripts sueltos de `scripts/` raíz a su subdirectorio de isla
- [ ] Crear `scripts/sesion/` con `inicio-sesion.sh` y `cierre-sesion.sh`
- [ ] Añadir README.md a cada subdirectorio de scripts/
- [ ] Estandarizar nombres: eliminar prefijos numéricos (01-, 02-) → nombre descriptivo
- [ ] Publicar REGISTRO-ISLAS.md con todas las islas y su estado
- [ ] Revisar `backup/` dentro de scripts/ — ¿muerto o activo?
- [ ] Mover `gemini-brief.md` a `docs/` o `inbox/` — no pertenece a scripts/
- [ ] Crear `scripts/agents/` para los scripts de agentes que vienen

