---
tipo: contexto-sesion
fecha: 2026-06-24
hora: "17:59"
status: listo
tags: [contexto, migracion, inbox, sesion, auditoria]
priority: CRITICA
---

# 🧠 CONTEXTO MAESTRO — Sesión Migración Inbox

> Leer esto al inicio de la nueva conversación para tener contexto completo.
> SHA de este commit: ver git log

---

## 🎯 Objetivo de esta sesión

**Vaciar el inbox completamente.** Hay ~85 archivos acumulados en 2 días (23-24 junio).
Cada archivo debe ir a su destino definitivo en el repo o archivarse.

---

## 📊 Estado actual del inbox

### Archivos por categoría

| Categoría | Nº archivos | Destino |
|-----------|-------------|---------|
| Ollama / Modelos locales | ~15 | `docs/ias/ollama/` |
| Docker / Stack Madre | ~12 | repo `batcueva` o `homelab-stack` |
| Arquitectura / ADRs | ~8 | `docs/adr/` |
| Seguridad / Hardening | ~6 | `docs/setup/seguridad/` |
| Proyectos activos | ~7 | `proyectos/` |
| Setup / Arch / Batcueva | ~7 | `docs/setup/` |
| Fases / Plan trabajo | ~8 | procesar + archivar |
| Sesiones / Cierres | ~15 | `diarios/2026-06-24/` |
| Prompts maestros | ~5 | `agentes/prompts/` |

---

## ✅ Decisiones ya tomadas (NO re-debatir)

- **Ollama > llama.cpp** — veredicto final con debate Grok + multi-IA
- **Stack Madre levantado** con: n8n, LiteLLM, Vaultwarden, Nginx Proxy Manager, Watchtower, Open WebUI
- **Arquitectura minimalista open-source** — tesis central del ecosistema
- **Modelo embedding**: bge-m3 (Ollama)
- **Modelo chat ligero**: qwen2.5:3b (Ollama)
- **Modelo chat principal**: qwen2.5:7b (Ollama)
- **Thdora**: agente terminal local, handlers definidos, modelfile Erika creado
- **Local Brain**: proyecto activo con RAG sobre yggdrasil-dew
- **Docs-as-code**: repos son la fuente de verdad, no Notion ni Obsidian

---

## 🗂️ Estructura de carpetas a crear (si no existen)

```
yggdrasil-dew/
├── docs/
│   ├── adr/              ← ADRs formales
│   ├── ias/
│   │   ├── ollama/       ← docs modelos, guías, benchmarks
│   │   ├── debates/      ← debates multi-IA ya resueltos
│   │   └── prompts/      ← prompts maestros reutilizables
│   ├── setup/
│   │   ├── seguridad/    ← SSH, sysctl, hardening
│   │   └── arch/         ← Arch Linux, Hyprland
│   └── arquitectura/     ← tesis, decisiones grandes
├── proyectos/
│   ├── thdora/
│   ├── local-brain/
│   ├── chatbot-control/
│   └── terminal-ia/
├── diarios/
│   └── 2026-06-24/       ← cierres de sesión archivados
└── agentes/
    └── prompts/          ← prompts maestros
```

---

## 📋 Tabla de migración — archivo x archivo

### 🔴 PRIORIDAD ALTA — mover primero

| Archivo inbox | Destino | Acción |
|---------------|---------|--------|
| `2026-06-23-adr-docs-as-code-repos-cerebro.md` | `docs/adr/` | MOVER |
| `2026-06-23-adr-ollama-en-agentes.md` | `docs/adr/` | MOVER |
| `2026-06-24-docker-compose-final-completo.md` | repo batcueva/stack | MOVER |
| `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-proyectos-fichas.md` | `proyectos/` | MOVER |
| `2026-06-24-fase4-litellm-sops-plan.md` | `docs/arquitectura/` | MOVER |

### 🟡 PRIORIDAD MEDIA — investigaciones y docs técnicos

| Archivo inbox | Destino | Acción |
|---------------|---------|--------|
| `2026-06-23-ollama-rag-investigacion.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-23-ollama-ecosistema-prep.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-23-ollama-guia-seleccion.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-23-ollama-bge-m3.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-23-ollama-qwen2.5-3b.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-23-ollama-qwen2.5-7b.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-24-ollama-modelfile-erika.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-24-langchain-ollama-optimizacion.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md` | `docs/ias/ollama/` | MOVER |
| `2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md` | `docs/ias/debates/` | MOVER |
| `2026-06-24-DEBATE-GROK-OLLAMA-VS-LLAMACPP.md` | `docs/ias/debates/` | MOVER |
| `2026-06-24-BITACORA-GEMINI-TURNO3-LLAMACPP-MARKOV.md` | `docs/ias/debates/` | MOVER |
| `2026-06-23-debate-multiia-escalar-docker.md` | `docs/ias/debates/` | MOVER |
| `2026-06-24-ssh-hardening.md` | `docs/setup/seguridad/` | MOVER |
| `2026-06-24-kernel-sysctl-hardening.md` | `docs/setup/seguridad/` | MOVER |
| `2026-06-24-vaultwarden-docker.md` | `docs/setup/seguridad/` | MOVER |
| `2026-06-24-nginx-proxy-manager.md` | `docs/setup/seguridad/` | MOVER |
| `2026-06-24-watchtower-backups.md` | `docs/setup/seguridad/` | MOVER |
| `2026-06-24-arch-linux-optimizacion-completa.md` | `docs/setup/arch/` | MOVER |
| `2026-06-24-hypridle-desactivado.md` | `docs/setup/arch/` | MOVER |
| `2026-06-24-osint-visual-personas-camaras.md` | `docs/ias/osint/` | MOVER |
| `2026-06-23-auditoria-osint.md` | `docs/ias/osint/` | MOVER |
| `2026-06-23-osint-rag-mover.md` | `docs/ias/osint/` | MOVER |
| `2026-06-24-n8n-litellm-integracion.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-fase1-revisada-con-litellm.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-fase3-completa.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-mapa-maestro-ecosistema.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-mapa-completo-repo-real.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-ecosistema-comparativa-repos.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md` | `docs/arquitectura/` | MOVER |
| `2026-06-24-protocolo-autoconocimiento-agentes.md` | `agentes/` | MOVER |

### 🟢 PROYECTOS — fichas a su carpeta

| Archivo inbox | Destino | Acción |
|---------------|---------|--------|
| `2026-06-23-proyecto-thdora.md` | `proyectos/thdora/` | MOVER |
| `2026-06-24-script-thdora-handlers.md` | `proyectos/thdora/` | MOVER |
| `2026-06-23-proyecto-local-brain.md` | `proyectos/local-brain/` | MOVER |
| `2026-06-24-descubrimiento-tools-local-brain.md` | `proyectos/local-brain/` | MOVER |
| `2026-06-23-local-brain-setup.md` | `proyectos/local-brain/` | MOVER |
| `2026-06-23-proyecto-chatbot-control.md` | `proyectos/chatbot-control/` | MOVER |
| `2026-06-23-proyecto-terminal-ia.md` | `proyectos/terminal-ia/` | MOVER |
| `2026-06-24-batcueva-fase2-plan.md` | `proyectos/batcueva/` | MOVER |
| `2026-06-24-script-batcueva-fase2.md` | `proyectos/batcueva/` | MOVER |
| `2026-06-24-formacion-python-roadmap.md` | `proyectos/formacion/` | MOVER |

### 🔵 PROMPTS MAESTROS

| Archivo inbox | Destino | Acción |
|---------------|---------|--------|
| `2026-06-24-PROMPT-MAESTRO-DEBATE-MULTI-IA.md` | `agentes/prompts/` | MOVER |
| `2026-06-24-PROMPT-MAESTRO-DOCUMENTACION-IAS.md` | `agentes/prompts/` | MOVER |
| `2026-06-24-PROMPT-GEMINI-ECOSISTEMA-FINAL.md` | `agentes/prompts/` | MOVER |
| `2026-06-23-prompt-claude-ecosistema-docker.md` | `agentes/prompts/` | MOVER |
| `2026-06-23-prompt-claude-refactor-repo.md` | `agentes/prompts/` | MOVER |
| `2026-06-23-prompt-gemini-auditoria-inbox.md` | `agentes/prompts/` | MOVER |
| `2026-06-24-prompt-gemini-modelfiles.md` | `agentes/prompts/` | MOVER |

### ⚫ ARCHIVAR — sesiones y cierres (no migrar, solo mover a diarios)

```
2026-06-24-SESION-COMPLETA-RESUMEN.md
2026-06-24-SESION-COMPLETA.md
2026-06-24-vaciado-sesion-completa-madrugada.md
2026-06-24-CIERRE-DEFINITIVO-06h00.md
2026-06-24-CIERRE-SESION.md
2026-06-24-ESTADO-CIERRE-NOCHE.md
2026-06-24-ESTADO-MADRE-CIERRE.md
2026-06-24-cierre-sesion-madrugada.md
2026-06-24-auditoria-sesion.md
2026-06-24-AUDITORIA-MAÑANA.md
2026-06-23-sesion-completa.md
2026-06-23-VACIADO-MAESTRO-GEMINI.md
2026-06-23-sesion-gemini-auditoria.md
2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md
2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md
2026-06-23-sesion-noche-pendientes.md
2026-06-23-yggdrasil-v4-diario-maestro.md
2026-06-23-actualizacion-claude-gemini.md
2026-06-23-inbox-clasificado.md
```
Todos → `diarios/2026-06-24/`

### 🗑️ ELIMINAR o ignorar (info ya integrada en otros docs)

```
2026-06-23-estado-auditoria-repo.md   (duplicado de otros)
2026-06-23-dashboard-readme.md        (ya integrado)
2026-06-24-SCRIPT-DESCARGA-GLOBAL.md  (ejecutado, ya no útil)
2026-06-24-descargas-progreso-03h28.md (log temporal)
2026-06-24-DESCARGAS-COMPLETAS-06h10.md (log temporal)
2026-06-23-script-vivo-debate-docker.md (ya archivado como debate)
2026-06-24-plan-mientras-descarga.md   (ya ejecutado)
2026-06-24-BITACORA-GROK-PERPLEXICA-FASES.md (exploración)
```

---

## 🔧 Estado técnico actual (verificar al inicio de sesión)

```bash
# Verificar modelos Ollama descargados
ollama list

# Verificar stack madre
cd ~/batcueva && docker compose ps

# Verificar Vaultwarden
curl http://localhost:8888/alive

# Ver estructura actual del repo
tree yggdrasil-dew/ -L 2
```

---

## 📌 Prompt de inicio para la nueva conversación

Copia y pega esto al inicio:

---

**"Hola. Estamos en sesión de migración del inbox de yggdrasil-dew. Lee el archivo `inbox/2026-06-24-CONTEXTO-NUEVA-SESION-MIGRACION.md` del repo alvarofernandezmota-tech/yggdrasil-dew. Ese archivo tiene todo el contexto: ~85 archivos a migrar con su destino exacto ya calculado. El objetivo es vaciar el inbox completamente moviendo cada archivo a su carpeta definitiva en el repo. Empezamos."**

---

## 💡 Nota sobre documentación automática de sesiones

Cuando el ecosistema esté completo, el flujo será:
1. Escribes notas en `inbox/` durante el trabajo
2. Al cerrar sesión: `cierre-sesion.sh` → git log del día → diario automático
3. Script IA lee frontmatter `tipo:` → mueve cada archivo a su destino
4. Commit automático → inbox = 0

El `tipo:` en el frontmatter es la clave. Ya tenemos la tabla tipo→destino definida en `PLAN-PROXIMA-SESION.md`.
