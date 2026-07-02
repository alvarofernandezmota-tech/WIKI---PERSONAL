---
tags: [contexto, estado, ssot]
fecha-actualizacion: 2026-07-02T20:36
agente: Perplexity MCP + Gemini
dispositivo: iPhone 11
---

# 🧠 CONTEXT.md — Estado real del sistema

> SSOT de estado. Leer siempre antes de actuar.
> Última actualización: 02-jul-2026 20:36 CEST
> Sesión: iPhone 11 · Perplexity MCP + Gemini

---

## 🖥️ Infraestructura

| Máquina | Rol | Estado |
|---|---|---|
| **Madre** | Torre Docker — servidor principal | ✅ Encendida |
| **Thdora** | Portátil Arch — terminal de trabajo | ⚠️ Offline esta sesión |
| **iPhone 11** | Mobile — agentes IA + SSH | ✅ Activo (sesión actual) |

---

## 📦 Stack Docker activo en Madre

| Servicio | Puerto | Estado |
|---|---|---|
| Ollama | 11434 | ✅ Corriendo |
| n8n | 5678 (0.0.0.0) | ⚠️ Hardening pendiente |
| TOKI FastAPI | 8000 | ✅ Base lista, handlers pendientes |
| Wazuh | — | ❌ Prereq pendiente |
| Suricata | — | ❌ No iniciado |
| Pihole | — | ❌ No iniciado |
| SearXNG | — | ❌ No iniciado |
| KasmWeb Kali | — | ❌ No iniciado |

---

## 🤖 Modelos Ollama descargados

- ✅ qwen2.5:7b
- ✅ qwen2.5:3b
- ❌ llama3.1:8b — pendiente pull
- ❌ bge-m3 — pendiente pull
- ❌ nomic-embed-text — pendiente pull

---

## 📊 Estado de fases

| Fase | Descripción | Estado |
|---|---|---|
| **Fase 0** | Repo limpio y documentado | 🟡 95% — labels/milestones pendientes UI |
| **Fase 1** | Seguridad base Madre | 🟡 90% — SSH hardening pendiente |
| **Fase 2** | GitHub profesional | 🟡 80% — Profile README pendiente |
| **Fase 3** | Governance repo | 🟡 60% — archivos docs pendientes |
| **Fase 4** | Stack técnico Madre | 🔴 10% — hardening batcueva urgente |
| **Fase 5** | GitHub Actions | 🟡 70% — workflows draftados, desplegar en Thdora |
| **Fase 6** | TOKI + n8n | 🔴 20% — base lista, handlers pendientes |
| **Fase 7** | Ollama + RAG | 🔴 15% — modelos parciales |
| **Fase 8** | Mobile completo | 🟡 50% — Tailscale OK, Termius pendiente |

---

## ✅ Lo completado HOY (02-jul-2026)

### Mañana — Thdora
- Problema Chromium/Perplexity documentado
- `docs/herramientas/chromium-perplexity.md` creado

### Tarde/Noche — iPhone + Perplexity MCP + Gemini
- CONVENCIONES.md reescrito nivel senior
- AGENT.md actualizado (fases, stack, iPhone)
- CONTRIBUTING.md creado
- Auditoría herramientas GitHub completada
- `.github/CODEOWNERS` creado ✅
- `.github/PULL_REQUEST_TEMPLATE.md` creado ✅
- `CHANGELOG.md` formato Keep a Changelog ✅
- `scripts/maintenance/audit-repo.sh` creado ✅
- `.github/workflows/repo-health-check.yml` desplegado ✅
- MASTER-PENDIENTES.md con 8 fases completas ✅
- Análisis productividad sesión documentado
- Roadmap bots y scripts documentado

### Pendiente de UI (no automatizable por MCP)
- Labels 20+ → crear en github.com/yggdrasil-dew/labels
- Milestones → crear en github.com/yggdrasil-dew/milestones
- Profile README repo → crear repo público `alvarofernandezmota-tech`
- Pinear repos en perfil

---

## 🔴 Urgente próxima sesión Thdora

1. `git rm --cached tailscale-full.apk ly .obsidian/` — limpiar archivos sensibles
2. Hardening batcueva — n8n puerto 0.0.0.0 → solo Tailscale
3. Desplegar workflows Actions restantes (lint-commits, context-reminder, update-diario-index)
4. Instalar Cursor + MCP GitHub en Thdora
5. Procesar inbox (27+ ficheros → mover a docs/)

---

## 🤖 División de trabajo agentes IA

| Agente | Rol | Cuándo |
|---|---|---|
| **Perplexity** | Documenta, MCP GitHub, commits | Siempre / iPhone |
| **Gemini** | Auditorías masivas, tareas bulk | Sesiones planificadas |
| **Claude** | Código complejo, terminal, debug | Thdora con Cursor |

---

## 📱 Herramientas Perplexity

- **@GitHub**: ✅ funciona en web (Chrome/Firefox/Brave/Edge/Safari/Arc)
- **Comet**: ⚠️ sin soporte oficial Linux — usar web en Thdora
- **Chromium Arch**: ⚠️ problema conector detectado — usar Firefox/Brave

---
_Actualizado: 02-jul-2026 20:36 CEST — Perplexity MCP + Gemini Fase 0 completada_
