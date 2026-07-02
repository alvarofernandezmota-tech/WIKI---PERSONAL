---
tags: [maestro, pendientes, estado]
fecha-actualizacion: 2026-07-02T19:52
---

# 📋 MASTER-PENDIENTES — Estado 02-jul-2026

> SSOT de tareas pendientes. Sincronizado con Issues GitHub.
> Última actualización: 02-jul-2026 19:52 CEST — Perplexity vía MCP

---

## 🔴 FASE 1 — Seguridad base Madre — 90% ✅

| Tarea | Estado | Issue |
|---|---|---|
| UFW activo y limpio | ✅ | #3 |
| fail2ban jail sshd | ✅ | #6 |
| Tailscale autoarranque | ✅ | — |
| Suspensión desactivada | ✅ | — |
| **SSH hardening (clave pública + deshabilitar password)** | **❌ PENDIENTE** | #3 |

Ver: `docs/infra/fase1-seguridad.md`

---

## 🔴 FASE 2 — GitHub profesional — EN PROCESO 🟡

| Tarea | Estado | Issue |
|---|---|---|
| Issue templates (bug, task, security) | ✅ 02-jul | #10 |
| PR template | ✅ 02-jul | #10 |
| Labels doc + script gh | ✅ 02-jul | #10 |
| **Crear labels en GitHub UI o via gh CLI** | **❌ PENDIENTE** | #10 |
| Profile README profesional | ❌ PENDIENTE | — |
| Pinear repos correctos | ❌ PENDIENTE | #9 |

---

## 🔴 FASE 3 — Governance y estructura repo — #10

| Tarea | Estado |
|---|---|
| CONVENCIONES.md auditado | ✅ 02-jul |
| HOME.md árbol visual real | ❌ PENDIENTE |
| ECOSISTEMA.md referencias cruzadas actualizadas | ❌ PENDIENTE |
| ESTADO-SISTEMA.md estado real madre | ❌ PENDIENTE |
| ROADMAP.md SSOT planificado | ❌ PENDIENTE |
| Verificar frontmatter en todos los .md | ❌ PENDIENTE |

---

## 🔴 FASE 4 — Stack técnico Madre — #9

| Tarea | Estado |
|---|---|
| Wazuh prereq (vm.max_map_count) | ❌ PENDIENTE |
| Suricata IDS activo | ❌ PENDIENTE |
| Suricata → Wazuh → THDORA → Telegram | ❌ PENDIENTE |
| Kali KasmWeb operativo | ❌ PENDIENTE |
| Pihole DNS | ❌ PENDIENTE |
| SearXNG instancia privada | ❌ PENDIENTE |
| start-batcueva.sh ejecutado | ❌ PENDIENTE |

Ver: `docs/infra/procedimiento-madre.md`

---

## 🟡 FASE 5 — Mobile + acceso remoto — #8

| Tarea | Estado |
|---|---|
| Tailscale en iPhone | ❌ PENDIENTE |
| Termius configurado | ❌ PENDIENTE |
| SSH desde iPhone verificado | ❌ PENDIENTE |

---

## 🟡 FASE 6 — THDORA fix + observabilidad

| Tarea | Estado |
|---|---|
| httpx==0.27.0 en requirements.txt | ❌ PENDIENTE |
| Uptime Kuma → THDORA → alertas Telegram | ❌ PENDIENTE |
| Dashboard CPU temp + latencia Ollama | ❌ PENDIENTE |

---

## 🟡 FASE 7 — Automatización docs (GitHub Actions) — #11

| Tarea | Estado |
|---|---|
| Workflow update-perplexity-docs.yml | ❌ PENDIENTE |
| Script scripts/update_perplexity_docs.py | ❌ PENDIENTE |
| Probar con workflow_dispatch | ❌ PENDIENTE |

---

## ✅ Chromium / Perplexity conectores

| Tarea | Estado |
|---|---|
| Problema detectado y documentado | ✅ 02-jul |
| Probar Firefox | ❌ PENDIENTE |
| Probar Comet | ❌ PENDIENTE |

Ver: `docs/herramientas/chromium-perplexity.md`

---

## Issues GitHub abiertos

| # | Título | Fase |
|---|---|---|
| #11 | Automatizar actualización docs (GitHub Actions) | Fase 7 |
| #10 | Governance — auditar reglas, naming, estructura | Fase 3 |
| #9 | Stack completo: Wazuh + Suricata + Pihole + SearXNG | Fase 4 |
| #8 | Terminal iPhone → madre via Termius + Tailscale | Fase 5 |
| #6 | DIARY sesión 28-06-2026 | Archivo |
| #5 | AP WiFi hostapd varpc | Fase 4 |
| #4 | DIARY sesión 22-06-2026 | Archivo |
| #3 | Setup varpc (Madre) | Fase 1 |
| #2 | ROADMAP ecosistema | Referencia |

---
_Actualizado: 02-jul-2026 19:52 CEST — Perplexity vía MCP_
