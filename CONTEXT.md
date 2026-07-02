---
tags: [contexto, ssot, referencia]
fecha-actualizacion: 2026-07-02T21:05
---

# 🧪 CONTEXT.md — Contexto activo del ecosistema

> Fichero de arranque para cualquier IA. Lee esto primero.
> Actualizado: 02-jul-2026 21:05 CEST — Perplexity vía MCP

---

## El proyecto

**yggdrasil-dew** es el repositorio central de Álvaro Fernández Mota.
Documenta y controla el ecosistema tecnológico personal: infraestructura, seguridad, IA, automatización y formación.

---

## Máquinas del ecosistema

| Nombre | Rol | OS | Estado |
|---|---|---|---|
| **Madre** | Servidor principal home lab | Arch Linux | ✅ Operativa |
| **Thdora** (varpc) | Workstation / terminal diario | Arch Linux | ✅ Operativa |
| **MacBook** | Secundario / creatividad | macOS | ✅ Operativo |
| **iPhone** | Móvil principal | iOS | ✅ Activo |
| **Redmi A5** | Android secundario | Android 14 | ⚠️ Tailscale pendiente |
| **Acer** | Portatil auxiliar | Linux | ⚠️ Bluetooth/Chromium issues |

---

## Bots del ecosistema — Naming SSOT

> Decisión definitiva 02-jul-2026. No usar nombres anteriores (TOKI-*).

| Bot | Nombre | Función | Estado |
|---|---|---|---|
| Bot personal | **Thdora** | Diario, notas, tareas, Obsidian | ✅ Corriendo |
| Bot infra | **Thdora Guardián** | Docker, Wazuh, Suricata, alertas Madre | ❌ En desarrollo |
| Bot repo | **Thdora Dev** | GitHub commits, issues, inbox, audit, MCP | ❌ En desarrollo |

---

## Stack tecnológico activo

### Seguridad (Madre)
- UFW ✅ activo
- fail2ban ✅ jail sshd activo
- Tailscale ✅ autoarranque
- SSH hardening ❌ pendiente (clave pública, deshabilitar password)
- Wazuh ❌ pendiente (vm.max_map_count bloqueante)
- Suricata IDS ❌ pendiente

### Docker / Servicios (Madre)
- n8n ⚠️ corriendo pero escuchando 0.0.0.0 (hardening pendiente)
- Thdora (FastAPI) ✅ corriendo base
- Batcueva ❌ sin levantar (hardening pendiente)
- Pihole ❌ pendiente
- SearXNG ❌ pendiente
- Kali KasmWeb ❌ pendiente

### IA Local (Madre)
- Ollama ✅ instalado
- qwen2.5:7b ✅ descargado
- qwen2.5:3b ✅ descargado
- llama3.1:8b ❌ pendiente pull
- bge-m3 ❌ pendiente pull
- nomic-embed-text ❌ pendiente pull
- RAG + Qdrant ❌ no iniciado

### GitHub / Herramientas
- MCP GitHub activo vía Perplexity Space ✅
- Issues #2 al #12 abiertos ✅
- CONVENCIONES.md nivel senior ✅
- AGENT.md actualizado ✅
- CONTRIBUTING.md ✅
- Issue templates ✅
- GitHub Actions (5 workflows) ❌ draftados, sin desplegar
- Cursor + MCP local ❌ pendiente instalar

---

## Fases del proyecto

| Fase | Nombre | Estado | Issue |
|---|---|---|---|
| 1 | Seguridad base Madre | 🔴 90% | #3 |
| 2 | GitHub profesional | 🔴 70% | #10 |
| 3 | Governance repo | 🔴 50% | #10 |
| 4 | Stack técnico Madre | 🔴 10% | #9 |
| 5 | GitHub Actions automatización | 🟡 30% | #11 |
| 6 | Thdora Guardián + n8n | 🟡 20% | #12 |
| 6d | Multi-IA vía n8n (Gemini, DeepSeek) | ❌ 0% | #13 |
| 7 | Ollama + RAG + agente autónomo | 🟡 20% | #14 |
| 8 | MCP server propio en Madre | ❌ 0% | #15 |
| 9 | Mobile completo | 🟡 30% | #8 |

---

## Archivos SSOT del repo

| Archivo | Qué es |
|---|---|
| `MASTER-PENDIENTES.md` | Lista única de tareas pendientes |
| `CONTEXT.md` | Este fichero. Contexto de arranque |
| `ROADMAP.md` | Fases y objetivos |
| `ECOSISTEMA.md` | Mapa completo del ecosistema |
| `ESTADO-SISTEMA.md` | Estado real de servicios ahora mismo |
| `AGENT.md` | Instrucciones para IAs |
| `CONVENCIONES.md` | Reglas de naming, commits, estructura |
| `CHANGELOG.md` | Registro de cambios |

---

## Reglas para IAs

1. Leer AGENT.md antes de actuar
2. Nunca hacer push directo a main sin contexto
3. Los commits siguen Conventional Commits (ver CONVENCIONES.md)
4. Inbox = zona de trabajo temporal, no archivo permanente
5. Naming bots: Thdora / Thdora Guardián / Thdora Dev (nunca TOKI-*)
6. MASTER-PENDIENTES es el SSOT de tareas

---

_Actualizado: 02-jul-2026 21:05 CEST — Perplexity vía MCP_
