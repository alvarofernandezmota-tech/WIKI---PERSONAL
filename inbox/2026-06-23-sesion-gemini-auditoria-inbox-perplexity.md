---
tipo: investigacion
fuente: gemini
estado: documentado
tema: auditoria-y-vaciado-inbox
tags:
  - inbox
  - obsidian
  - gemini
  - auditoria
  - repo
  - clasificacion
  - documentacion
  - perplexity
  - sesion
---

# Conversación completa: auditoría, vaciado y estructuración de inbox

## Contexto
Sesión de trabajo con Perplexity enfocada en revisar, documentar y estructurar el flujo de auditoría de `inbox/` dentro del repositorio `yggdrasil-dew`, usando Obsidian como fuente de verdad y la repo como destino final del conocimiento consolidado.

## Objetivo general
- Vaciar la inbox sin romper dependencias.
- Preservar archivos permanentes.
- Clasificar archivos movibles y no movibles.
- Documentar todo el proceso en Obsidian.
- Preparar un mapeo funcional de la repo cuando haga falta.

## Permanentes blindados
- `README.md`
- `MASTER-PENDIENTES.md`
- `inbox-clasificado.md`

## Matriz de decisión

### MOVIBLE
Solo si cumple todo esto:
- tiene destino exacto;
- pertenece a la estructura viva;
- no hay ambigüedad;
- no es duplicado ni obsoleto.

### NO_MOVIBLE
Si cumple cualquiera de estos:
- es permanente;
- no tiene destino claro;
- es duplicado;
- está obsoleto;
- requiere revisión humana.

## Tipos de material
- `RAW`
- `OCR`
- `RAW_OCR`

## Flujo de ejecución
1. mover
2. verificar
3. archivar
4. borrar

## Criterios de seguridad
- No borrar nada dudoso.
- No inventar rutas.
- Mantener coherencia entre series, sesiones y documentos relacionados.
- Si el archivo no tiene destino claro, queda como `NO_MOVIBLE`.

## Clasificación real de la inbox (2026-06-23)

| archivo | movible | tipo | destino | motivo | prioridad |
|---|---|---|---|---|---|
| README.md | NO | — | permanente | control inbox | — |
| MASTER-PENDIENTES.md | NO | — | permanente | control inbox | — |
| 2026-06-23-inbox-clasificado.md | NO | RAW | permanente | snapshot de clasificación | — |
| 2026-06-23-actualizacion-claude-gemini.md | SÍ | RAW | agentes/ | documentación de roles de modelos | alta |
| 2026-06-23-adr-docs-as-code-repos-cerebro.md | SÍ | RAW | docs/ | ADR listo para docs vivos | alta |
| 2026-06-23-adr-ollama-en-agentes.md | SÍ | RAW | docs/ | ADR listo para docs vivos | alta |
| 2026-06-23-auditoria-diarios.md | SÍ | RAW | diarios/ | auditoría de diarios lista | media |
| 2026-06-23-auditoria-docs.md | SÍ | RAW | docs/ | auditoría de docs lista | media |
| 2026-06-23-auditoria-formacion.md | SÍ | RAW | formacion/ | auditoría de formación lista | media |
| 2026-06-23-auditoria-ollama.md | SÍ | RAW | agentes/ | auditoría ollama lista | alta |
| 2026-06-23-auditoria-osint.md | SÍ | RAW | proyectos/ | auditoría OSINT lista | media |
| 2026-06-23-auditoria-setup.md | SÍ | RAW | setup/ | auditoría setup lista | alta |
| 2026-06-23-auditoria-tools-inbox-dashboard.md | SÍ | RAW | docs/ | auditoría herramientas lista | media |
| 2026-06-23-auditoria-tools.md | SÍ | RAW | docs/ | auditoría tools lista | media |
| 2026-06-23-auditoria-yo.md | SÍ | RAW | yo/ | auditoría personal lista | baja |
| 2026-06-23-dashboard-readme.md | SÍ | RAW | docs/ | README dashboard listo | media |
| 2026-06-23-decision-arquitectura-proyectos.md | SÍ | RAW | docs/ | decisión arquitectónica lista | alta |
| 2026-06-23-decision-homelab-vs-proyectos.md | SÍ | RAW | docs/ | decisión arquitectónica lista | alta |
| 2026-06-23-estado-auditoria-repo.md | SÍ | RAW | docs/ | estado real del repo documentado | alta |
| 2026-06-23-estado-descargas-madre.md | SÍ | RAW | setup/ | estado máquina madre documentado | media |
| 2026-06-23-inbox-processor-implementacion.md | SÍ | RAW | docs/ | implementación de inbox processor | alta |
| 2026-06-23-local-brain-setup.md | SÍ | RAW | setup/ | setup local brain | alta |
| 2026-06-23-ollama-bge-m3.md | SÍ | RAW | agentes/ | modelo RAG documentado | alta |
| 2026-06-23-ollama-guia-seleccion.md | SÍ | RAW | agentes/ | guía selección modelos ollama | alta |
| 2026-06-23-ollama-qwen2.5-3b.md | SÍ | RAW | agentes/ | modelo documentado | media |
| 2026-06-23-ollama-qwen2.5-7b.md | SÍ | RAW | agentes/ | modelo documentado | media |
| 2026-06-23-ollama-rag-investigacion.md | SÍ | RAW | agentes/ | investigación RAG completa | alta |
| 2026-06-23-osint-rag-mover.md | SÍ | RAW | proyectos/ | OSINT RAG listo para mover | alta |
| 2026-06-23-prompt-claude-ecosistema-docker.md | SÍ | RAW | agentes/ | prompt reutilizable Claude | alta |
| 2026-06-23-prompt-claude-refactor-repo.md | SÍ | RAW | agentes/ | prompt reutilizable Claude | alta |
| 2026-06-23-prompt-gemini-auditoria-inbox.md | SÍ | RAW | agentes/ | prompt reutilizable Gemini | alta |
| 2026-06-23-proyecto-chatbot-control.md | SÍ | RAW | proyectos/ | proyecto activo | alta |
| 2026-06-23-proyecto-local-brain.md | SÍ | RAW | proyectos/ | proyecto activo | alta |
| 2026-06-23-proyecto-terminal-ia.md | SÍ | RAW | proyectos/ | proyecto activo | media |
| 2026-06-23-proyecto-thdora.md | SÍ | RAW | proyectos/ | proyecto activo | alta |
| 2026-06-23-pull-stack-madre.md | SÍ | RAW | setup/ | configuración madre | media |
| 2026-06-23-sesion-completa.md | SÍ | RAW | diarios/ | sesión completa del día | alta |
| 2026-06-23-sesion-gemini-auditoria.md | NO | RAW | — | posible duplicado de esta nota | dudoso |
| 2026-06-23-systemd-plan.md | SÍ | RAW | setup/ | plan systemd listo | media |
| 2026-06-23-tools-pendientes.md | SÍ | RAW | docs/ | tools pendientes documentadas | media |
| 2026-06-23-v4-pendiente-ollama.md | SÍ | RAW | agentes/ | pendiente ollama v4 | alta |
| 2026-06-23-yggdrasil-v4-diario-maestro.md | SÍ | RAW | diarios/ | diario maestro v4 del día | alta |

## Bloques funcionales detectados en la repo

| bloque | estado | archivos representativos |
|---|---|---|
| agentes IA | activo | ollama, bge-m3, prompts claude/gemini |
| setup / infraestructura | activo | madre, local-brain, systemd, descargas |
| proyectos activos | activo | thdora, chatbot, terminal-ia, local-brain |
| documentación viva | activo | ADRs, decisiones, auditorías |
| diarios | activo | sesión completa, diario maestro v4 |
| formación | pendiente | auditoria-formacion |
| yo / perfil | pendiente | auditoria-yo |
| deuda técnica | dudoso | sesion-gemini-auditoria (revisar duplicado) |

## Permanentes confirmados
- `README.md`
- `MASTER-PENDIENTES.md`
- `inbox/2026-06-23-inbox-clasificado.md`

## Dudosos
- `2026-06-23-sesion-gemini-auditoria.md` — posible duplicado de esta nota, revisar antes de borrar.

## Orden recomendado de ejecución
1. Mover archivos de alta prioridad a su destino exacto.
2. Verificar que el destino existe y el contenido es correcto.
3. Archivar los históricos útiles que ya no son operativos.
4. Revisar dudosos manualmente.
5. Borrar solo lo claramente obsoleto.
6. Nunca tocar los permanentes.

## Script maestro para Gemini
Ver: [[inbox/2026-06-23-prompt-gemini-auditoria-inbox]]

## Próximos pasos
- Ejecutar la migración por bloques: agentes/ primero, luego setup/, proyectos/, docs/, diarios/.
- Actualizar CONTEXT.md al final de cada bloque.
- Vincular esta nota desde MASTER-PENDIENTES.md.
- Revisar duplicado `sesion-gemini-auditoria.md` antes de borrar.
