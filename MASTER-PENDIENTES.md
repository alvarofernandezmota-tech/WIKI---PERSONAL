---
tags: [maestro, pendientes, estado]
fecha-actualizacion: 2026-07-02T21:01
---

# 📋 MASTER-PENDIENTES — Estado 02-jul-2026 21:01

> SSOT de tareas. Una sola lista, sin duplicados.
> Sincronizado con CONTEXT.md e Issues GitHub.
> Última actualización: 02-jul-2026 21:01 — Perplexity vía MCP

---

## 📱 MOBILE-OK — Perplexity puede hacer esto ahora

| Tarea | Estado | Bloquea |
|---|---|---|
| Crear repo `alvarofernandezmota-tech` (Profile README) | ❌ PENDIENTE | Fase 0 |
| Crear 20+ labels personalizados en yggdrasil-dew | ❌ PENDIENTE | Fase 0 |
| Crear milestones Fase 0 a Fase 9 | ❌ PENDIENTE | Fase 0 |
| Crear `.github/CODEOWNERS` | ❌ PENDIENTE | Fase 0 |
| Crear `.github/PULL_REQUEST_TEMPLATE.md` | ❌ PENDIENTE | Fase 0 |
| Actualizar `CHANGELOG.md` — formato Keep a Changelog | ❌ PENDIENTE | Fase 0 |
| Crear issues #13-#16 (Fases 6d, 7, 8MCP, 9) | ❌ PENDIENTE | — |
| Actualizar issue #12 naming TOKI → Thdora Dev | ❌ PENDIENTE | — |

---

## 🖥️ NEEDS-TERMINAL — Thdora (siguiente sesión)

### Limpieza git
| Tarea | Estado |
|---|---|
| `git rm --cached tailscale-full.apk ly` | ❌ |
| `git rm -r --cached .obsidian/` | ❌ |

### Migraciones estructura
| Tarea | Estado |
|---|---|
| `git mv diarios/ docs/diarios/` | ❌ |
| `git mv osint-stack/* osint/` | ❌ |
| `git mv cli-tools/* scripts/` | ❌ |
| `git mv mocs/ docs/mocs/` | ❌ |
| `git mv setup/* scripts/setup/` | ❌ |
| `git mv thdora/* infra/thdora/` | ❌ |
| `git rm filosofia.md` (raíz — ya en docs/) | ❌ |

### Inbox — migración (32 ficheros pendientes)

> Ver plan detallado: `inbox/2026-07-02-auditoria-inbox-migracion.md`

| Fichero | Destino | Prioridad |
|---|---|---|
| `2026-06-25-auditoria-infraestructura-engineering-excellence.md` | `docs/arquitectura/` | Media |
| `2026-06-25-sesion-tarde-procesado.md` | `docs/diarios/2026-06-25.md` | Media |
| `2026-06-27-madre-ap-wifi-debug.md` | `docs/infra/madre/ap-wifi.md` | Alta |
| `2026-06-27-monitoring-pentest-research.md` | `docs/seguridad/pentest/` | Alta |
| `2026-06-27-prompt-gemini-sesion-completa.md` | `docs/diarios/2026-06-27.md` | Media |
| `2026-06-28-auditoria-sesion-completa.md` | `docs/diarios/2026-06-28.md` | Media |
| `2026-06-30-cierre-sesion.md` | `docs/diarios/2026-06-30.md` | Media |
| `2026-06-30-ollama-modelos-pull.md` | `docs/herramientas/ollama.md` | Alta |
| `2026-06-30-thdora-auditoria-estado.md` | `docs/herramientas/thdora.md` | Alta |
| `2026-07-01-auditoria-compose-divergencia.md` | `docs/infra/docker/` | Alta |
| `2026-07-01-fase1-completada.md` | `docs/diarios/2026-07-01.md` | Alta |
| `2026-07-01-gemini-auditoria-capas-pentest.md` | `docs/seguridad/pentest/` | Alta |
| `2026-07-01-gemini-bots-secops-arquitectura.md` | `docs/arquitectura/bots.md` | Alta |
| `2026-07-01-hallazgo-ftp-puerto21.md` | `docs/seguridad/hallazgos/` | 🔴 Urgente |
| `2026-07-01-modelos-ollama-completos.md` | `docs/herramientas/ollama.md` | Alta |
| `2026-07-01-redmi-adb-bloqueos.md` | `docs/dispositivos/redmi.md` | Media |
| `2026-07-01-sesion-madrugada-docker-pentest.md` | `docs/diarios/2026-07-01.md` | Alta |
| `2026-07-01-sesion-pentest-completa.md` | `docs/seguridad/pentest/` | Alta |
| `2026-07-01-sesion-tarde-docker-stack.md` | `docs/diarios/2026-07-01.md` | Alta |
| `2026-07-01-ssh-hardening-completo.md` | `docs/infra/seguridad/ssh.md` | 🔴 Urgente |
| `2026-07-02-*` (12 ficheros) | `docs/diarios/2026-07-02.md` + destinos | Esta sesión |
| `GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md` | Renombrar + `docs/seguridad/pentest/` | 🔴 Naming roto |
| `PROCEDIMIENTO-MADRE-HOY.md` | Renombrar + `docs/infra/madre/` | 🔴 Naming roto |

### Herramientas
| Tarea | Estado |
|---|---|
| Instalar Cursor en Thdora | ❌ |
| Configurar MCP GitHub (token) en Cursor | ❌ |
| Desplegar 5 workflows GitHub Actions | ❌ |
| Configurar branch protection en Settings | ❌ |

---

## 🔴 FASE 1 — Seguridad base Madre — 90%

| Tarea | Estado | Issue |
|---|---|---|
| UFW activo | ✅ | #3 |
| fail2ban jail sshd | ✅ | #6 |
| Tailscale autoarranque | ✅ | — |
| SSH hardening (clave pública + deshabilitar password) | ❌ PENDIENTE | #3 |

---

## 🔴 FASE 2 — GitHub profesional

| Tarea | Estado | Issue |
|---|---|---|
| CONVENCIONES.md nivel senior | ✅ 02-jul | — |
| AGENT.md actualizado | ✅ 02-jul | — |
| CONTRIBUTING.md creado | ✅ 02-jul | — |
| Issue templates | ✅ 02-jul | #10 |
| PR template | ❌ pendiente crear | #10 |
| Labels personalizados | ❌ pendiente crear | #10 |
| Profile README repo | ❌ pendiente crear | — |
| Milestones por fase (0–9) | ❌ | — |
| CODEOWNERS | ❌ | — |
| CHANGELOG.md formato KaC | ❌ | — |
| Pinear repos en perfil | ❌ | #9 |

---

## 🔴 FASE 3 — Governance repo

| Tarea | Estado |
|---|---|
| CONVENCIONES.md auditado | ✅ 02-jul |
| HOME.md árbol visual real | ❌ |
| ECOSISTEMA.md referencias cruzadas + naming Thdora | ❌ |
| ESTADO-SISTEMA.md real | ❌ |
| ROADMAP.md SSOT | ❌ |
| Frontmatter en todos los .md | ❌ (needs-terminal) |

---

## 🔴 FASE 4 — Stack técnico Madre

| Tarea | Estado | Issue |
|---|---|---|
| Hardening batcueva (0.0.0.0 → Tailscale) | ❌ | — |
| Wazuh prereq vm.max_map_count | ❌ | #9 |
| Suricata IDS activo | ❌ | #9 |
| Kali KasmWeb operativo | ❌ | — |
| Pihole DNS | ❌ | — |
| SearXNG instancia privada | ❌ | — |
| start-batcueva.sh ejecutado | ❌ | — |

---

## 🟡 FASE 5 — GitHub Actions (automatización repo)

| Tarea | Estado | Issue |
|---|---|---|
| `lint-commits.yml` | ✅ draftado en inbox | #11 |
| `update-diario-index.yml` | ✅ draftado en inbox | #11 |
| `context-reminder.yml` | ✅ draftado en inbox | #11 |
| `repo-health-check.yml` | ✅ draftado en inbox | #11 |
| `update-perplexity-docs.yml` | ✅ draftado en inbox | #11 |
| Desplegar todos (needs-terminal) | ❌ | #11 |

---

## 🟡 FASE 6 — Thdora Guardián + n8n

> ⚠️ Naming actualizado: TOKI-Guardian → **Thdora Guardián** | TOKI-DEW → **Thdora Dev**

| Tarea | Estado | Issue |
|---|---|---|
| Thdora FastAPI base | ✅ corriendo | — |
| Thdora handlers: /estado, /inbox, /pendientes | ❌ | #12 |
| n8n hardening (0.0.0.0 → Tailscale) | ❌ | — |
| n8n flow: commit → Telegram | ❌ | — |
| n8n flow: Docker caído → alerta | ❌ | — |
| httpx==0.27.0 fix en requirements.txt | ❌ | — |
| Thdora Dev bot (repo GitHub) | ❌ | #12 |

---

## 🟡 FASE 6d — Multi-IA vía n8n (Gemini, DeepSeek)

> Nuevo bloque documentado 02-jul-2026

| Tarea | Estado | Issue |
|---|---|---|
| Flujo n8n: Gemini → webhook → GitHub API | ❌ | #13 (pendiente crear) |
| Flujo n8n: DeepSeek → webhook → GitHub API | ❌ | #13 (pendiente crear) |
| Token PAT GitHub en n8n secrets | ❌ | — |
| Prueba: crear issue desde Gemini | ❌ | — |

---

## 🟡 FASE 7 — Ollama + RAG

| Tarea | Estado | Issue |
|---|---|---|
| qwen2.5:7b | ✅ descargado | — |
| qwen2.5:3b | ✅ descargado | — |
| llama3.1:8b | ❌ pendiente pull | #14 (pendiente crear) |
| bge-m3 | ❌ pendiente pull | — |
| nomic-embed-text | ❌ pendiente pull | — |
| RAG con Qdrant | ❌ no iniciado | — |
| Agente autónomo v1 | ❌ no iniciado | — |

---

## 🟡 FASE 8 — MCP server propio en Madre

> Objetivo: cualquier IA llama al servidor MCP de Madre → acceso completo al ecosistema

| Tarea | Estado | Issue |
|---|---|---|
| Instalar Node.js o Python en Madre | ❌ | #15 (pendiente crear) |
| Crear servidor MCP custom (github/github-mcp-server o propio) | ❌ | — |
| Conectar Claude Desktop → MCP Madre | ❌ | — |
| Conectar Cursor → MCP Madre | ❌ | — |
| Prueba end-to-end: Claude crea issue en yggdrasil-dew | ❌ | — |

---

## 🟡 FASE 9 — Mobile completo

| Tarea | Estado | Issue |
|---|---|---|
| Tailscale iPhone activo | ✅ | #8 |
| Termius iPhone configurado | ❌ | #8 |
| SSH desde iPhone a Madre | ❌ | #8 |
| Tailscale Redmi A5 | ❌ | — |

---

## ✅ Chromium / Perplexity conectores

| Tarea | Estado |
|---|---|
| Problema documentado | ✅ 02-jul |
| Probar Firefox/Brave | ❌ |
| Probar Comet | ❌ |

---

## Issues GitHub — estado real

| # | Título | Fase | Estado |
|---|---|---|---|
| #12 | Thdora Dev bot repo (naming actualizar) | Fase 6 | 🔄 Abierto |
| #11 | Automatizar actualización docs | Fase 5 | 🔄 Abierto |
| #10 | Governance — reglas, naming, estructura | Fase 2/3 | 🔄 Abierto |
| #9 | Stack Wazuh + Suricata + Pihole + SearXNG | Fase 4 | 🔄 Abierto |
| #8 | Terminal iPhone → Madre via Termius + Tailscale | Fase 9 | 🔄 Abierto |
| #6 | DIARY 28-06-2026 | Diary | 🔄 Abierto |
| #5 | AP WiFi hostapd varpc | Fase 4 | 🔄 Abierto |
| #3 | Setup varpc (Madre) | Fase 1 | 🔄 Abierto |
| #2 | ROADMAP ecosistema | Referencia | 🔄 Abierto |
| #13 | (pendiente) Fase 6d — Multi-IA n8n | Fase 6d | ❌ Sin crear |
| #14 | (pendiente) Fase 7 — Ollama RAG completo | Fase 7 | ❌ Sin crear |
| #15 | (pendiente) Fase 8 — MCP server propio Madre | Fase 8 | ❌ Sin crear |

---

## Naming bots — SSOT

> Decisión tomada 02-jul-2026. Referencia: `inbox/2026-07-02-session-cierre-tarde.md`

| Bot | Nombre correcto | Función |
|---|---|---|
| Thdora | Thdora | Bot personal — diario, notas, tareas, Obsidian |
| Thdora Guardián | Thdora Guardián | Servidor Madre — Docker, Wazuh, Suricata, alertas |
| Thdora Dev | Thdora Dev | GitHub repo — commits, issues, inbox, audit, MCP |

---

_Actualizado: 02-jul-2026 21:01 CEST — Perplexity vía MCP_
