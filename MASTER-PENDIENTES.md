---
tags: [maestro, pendientes, estado]
fecha-actualizacion: 2026-07-02T20:30
---

# 📋 MASTER-PENDIENTES — Estado 02-jul-2026 20:30

> SSOT de tareas. Una sola lista, sin duplicados.
> Sincronizado con CONTEXT.md e Issues GitHub.
> Última actualización: 02-jul-2026 20:30 — Perplexity vía MCP

---

## 📱 MOBILE-OK — Perplexity puede hacer esto ahora

| Tarea | Estado | Bloquea |
|---|---|---|
| Crear repo `alvarofernandezmota-tech` (Profile README) | ❌ PENDIENTE | Fase 0 |
| Crear 20+ labels personalizados en yggdrasil-dew | ❌ PENDIENTE | Fase 0 |
| Crear milestones Fase 0 y Fase 2 | ❌ PENDIENTE | Fase 0 |
| Crear `.github/CODEOWNERS` | ❌ PENDIENTE | Fase 0 |
| Crear `.github/PULL_REQUEST_TEMPLATE.md` | ❌ PENDIENTE | Fase 0 |
| Actualizar `CHANGELOG.md` — formato Keep a Changelog | ❌ PENDIENTE | Fase 0 |
| O usar mega-prompt Gemini para hacer todo lo anterior | ❌ PENDIENTE | — |

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

### Herramientas
| Tarea | Estado |
|---|---|
| Instalar Cursor en Thdora | ❌ |
| Configurar MCP GitHub (token) en Cursor | ❌ |
| Desplegar 5 workflows GitHub Actions | ❌ |
| Configurar branch protection en Settings | ❌ |
| Procesar inbox (26 ficheros → mover a docs/) | ❌ |

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
| Milestones por fase | ❌ | — |
| CODEOWNERS | ❌ | — |
| CHANGELOG.md formato KaC | ❌ | — |
| Pinear repos en perfil | ❌ | #9 |

---

## 🔴 FASE 3 — Governance repo

| Tarea | Estado |
|---|---|
| CONVENCIONES.md auditado | ✅ 02-jul |
| HOME.md árbol visual real | ❌ |
| ECOSISTEMA.md referencias cruzadas | ❌ |
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

## 🟡 FASE 5 — GitHub Actions (bots repo)

| Tarea | Estado |
|---|---|
| `lint-commits.yml` | ✅ draftado en inbox |
| `update-diario-index.yml` | ✅ draftado en inbox |
| `context-reminder.yml` | ✅ draftado en inbox |
| `repo-health-check.yml` | ✅ draftado en inbox |
| `update-perplexity-docs.yml` | ✅ draftado en inbox |
| Desplegar todos (needs-terminal) | ❌ |

---

## 🟡 FASE 6 — TOKI + n8n

| Tarea | Estado |
|---|---|
| TOKI FastAPI base | ✅ corriendo |
| TOKI handlers: /estado, /inbox, /pendientes | ❌ |
| n8n hardening (0.0.0.0 → Tailscale) | ❌ |
| n8n flow: commit → Telegram | ❌ |
| n8n flow: Docker caído → alerta | ❌ |
| httpx==0.27.0 fix en requirements.txt | ❌ |

---

## 🟡 FASE 7 — Ollama + RAG

| Tarea | Estado |
|---|---|
| qwen2.5:7b | ✅ descargado |
| qwen2.5:3b | ✅ descargado |
| llama3.1:8b | ❌ pendiente pull |
| bge-m3 | ❌ pendiente pull |
| nomic-embed-text | ❌ pendiente pull |
| RAG con Qdrant | ❌ no iniciado |
| Agente autónomo v1 | ❌ no iniciado |

---

## 🟡 FASE 8 — Mobile completo

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

## Issues GitHub abiertos

| # | Título | Fase |
|---|---|---|
| #11 | Automatizar actualización docs | Fase 5 |
| #10 | Governance — reglas, naming, estructura | Fase 2/3 |
| #9 | Stack Wazuh + Suricata + Pihole + SearXNG | Fase 4 |
| #8 | Terminal iPhone → Madre via Termius + Tailscale | Fase 8 |
| #5 | AP WiFi hostapd varpc | Fase 4 |
| #3 | Setup varpc (Madre) | Fase 1 |
| #2 | ROADMAP ecosistema | Referencia |

---
_Actualizado: 02-jul-2026 20:30 CEST — Perplexity vía MCP_
