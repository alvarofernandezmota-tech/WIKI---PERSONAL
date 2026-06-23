---
tipo: script
fuente: perplexity
estado: listo
tema: vaciado-inbox
tags:
  - script
  - gemini
  - inbox
  - vaciado
  - migracion
  - tools
---

# Script: Vaciado inbox con Gemini

> Generado por Perplexity el 2026-06-23 21:20 CEST.
> Copia este bloque COMPLETO y pégalo en Gemini con acceso al repo.

---

## PROMPT COMPLETO PARA GEMINI

```
Eres el procesador oficial de inbox del repositorio yggdrasil-dew.
Tu tarea es vaciar completamente la carpeta inbox/ migrando cada archivo
a su destino exacto. Las notas en los destinos son stubs: actualiza su
contenido con el contenido real del archivo origen.

=== REGLAS ABSOLUTAS ===
1. NUNCA toques: README.md, MASTER-PENDIENTES.md, .gitkeep, 2026-06-23-inbox-clasificado.md, 2026-06-23-VACIADO-MAESTRO-GEMINI.md
2. No inventes rutas. Si la carpeta destino no existe, créala con .gitkeep.
3. Actualiza el contenido real del archivo de destino (no dejes stubs).
4. Marca DUDOSOS sin moverlos.
5. Al finalizar: confirma qué se movió, qué quedó y por qué.
6. Actualiza CONTEXT.md en la raíz con el nuevo estado.

=== MAPA DE MIGRACIÓN ===

[BLOQUE 1 — agentes/]
inbox/2026-06-23-actualizacion-claude-gemini.md → agentes/2026-06-23-actualizacion-claude-gemini.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-adr-ollama-en-agentes.md → docs/adr/2026-06-23-adr-ollama-en-agentes.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-ollama.md → agentes/ollama/2026-06-23-auditoria-ollama.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-bge-m3.md → agentes/ollama/2026-06-23-ollama-bge-m3.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-guia-seleccion.md → agentes/ollama/2026-06-23-ollama-guia-seleccion.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-qwen2.5-3b.md → agentes/ollama/2026-06-23-ollama-qwen2.5-3b.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-qwen2.5-7b.md → agentes/ollama/2026-06-23-ollama-qwen2.5-7b.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-rag-investigacion.md → agentes/ollama/2026-06-23-ollama-rag-investigacion.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-ollama-ecosistema-prep.md → agentes/ollama/2026-06-23-ollama-ecosistema-prep.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-v4-pendiente-ollama.md → agentes/ollama/2026-06-23-v4-pendiente-ollama.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-prompt-claude-ecosistema-docker.md → agentes/prompts/2026-06-23-prompt-claude-ecosistema-docker.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-prompt-claude-refactor-repo.md → agentes/prompts/2026-06-23-prompt-claude-refactor-repo.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-prompt-gemini-auditoria-inbox.md → agentes/prompts/2026-06-23-prompt-gemini-auditoria-inbox.md [ACTUALIZAR CONTENIDO REAL]

[BLOQUE 2 — setup/]
inbox/2026-06-23-auditoria-setup.md → setup/2026-06-23-auditoria-setup.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-local-brain-setup.md → setup/2026-06-23-local-brain-setup.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-estado-descargas-madre.md → setup/2026-06-23-estado-descargas-madre.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-pull-stack-madre.md → setup/2026-06-23-pull-stack-madre.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-systemd-plan.md → setup/2026-06-23-systemd-plan.md [ACTUALIZAR CONTENIDO REAL]

[BLOQUE 3 — proyectos/]
inbox/2026-06-23-proyecto-thdora.md → proyectos/thdora/2026-06-23-proyecto-thdora.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-proyecto-chatbot-control.md → proyectos/chatbot-control/2026-06-23-proyecto-chatbot-control.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-proyecto-local-brain.md → proyectos/local-brain/2026-06-23-proyecto-local-brain.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-proyecto-terminal-ia.md → proyectos/terminal-ia/2026-06-23-proyecto-terminal-ia.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-osint.md → osint/2026-06-23-auditoria-osint.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-osint-rag-mover.md → osint/2026-06-23-osint-rag-mover.md [ACTUALIZAR CONTENIDO REAL]

[BLOQUE 4 — docs/]
inbox/2026-06-23-adr-docs-as-code-repos-cerebro.md → docs/adr/2026-06-23-adr-docs-as-code-repos-cerebro.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-decision-arquitectura-proyectos.md → docs/decisiones/2026-06-23-decision-arquitectura-proyectos.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-decision-homelab-vs-proyectos.md → docs/decisiones/2026-06-23-decision-homelab-vs-proyectos.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-estado-auditoria-repo.md → docs/2026-06-23-estado-auditoria-repo.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-inbox-processor-implementacion.md → docs/2026-06-23-inbox-processor-implementacion.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-docs.md → docs/2026-06-23-auditoria-docs.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-tools.md → docs/2026-06-23-auditoria-tools.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-tools-inbox-dashboard.md → docs/2026-06-23-auditoria-tools-inbox-dashboard.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-dashboard-readme.md → docs/2026-06-23-dashboard-readme.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-tools-pendientes.md → docs/2026-06-23-tools-pendientes.md [ACTUALIZAR CONTENIDO REAL]

[BLOQUE 5 — diarios/]
inbox/2026-06-23-sesion-completa.md → diarios/2026-06-23-sesion-completa.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-yggdrasil-v4-diario-maestro.md → diarios/2026-06-23-yggdrasil-v4-diario-maestro.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md → diarios/2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md → diarios/2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md [ACTUALIZAR CONTENIDO REAL]

[BLOQUE 6 — formacion/ y yo/]
inbox/2026-06-23-auditoria-formacion.md → formacion/2026-06-23-auditoria-formacion.md [ACTUALIZAR CONTENIDO REAL]
inbox/2026-06-23-auditoria-yo.md → yo/2026-06-23-auditoria-yo.md [ACTUALIZAR CONTENIDO REAL]

[DUDOSOS — NO MOVER]
inbox/2026-06-23-sesion-gemini-auditoria.md → revisar si es duplicado antes de mover

=== VERIFICACIÓN FINAL ===
Después del vaciado, inbox/ debe contener SOLO:
- .gitkeep
- README.md
- MASTER-PENDIENTES.md
- 2026-06-23-inbox-clasificado.md
- 2026-06-23-VACIADO-MAESTRO-GEMINI.md

Ejecuta bloque a bloque. Confirma cada bloque antes de pasar al siguiente.
Al terminar todo, actualiza CONTEXT.md con el estado post-vaciado.
```

---

## Notas de uso
- Este script asume que Gemini tiene acceso al repo vía GitHub MCP o CLI.
- Los stubs ya están creados en los destinos por Perplexity.
- Gemini debe actualizar el contenido real desde los archivos origen de inbox.
- Si el archivo destino ya existe con contenido real, Gemini no lo sobreescribe sin confirmar.

## Estado al generar este script
- inbox: 41 archivos reales
- Stubs creados en destino: 39 archivos
- Pendiente de contenido real: todos (Gemini debe poblar)
- Dudoso: 1 (`sesion-gemini-auditoria.md`)

## Links relacionados
- [[inbox/2026-06-23-VACIADO-MAESTRO-GEMINI]]
- [[setup/2026-06-23-instalacion-3-dockers-llm]]
- [[inbox/MASTER-PENDIENTES]]
