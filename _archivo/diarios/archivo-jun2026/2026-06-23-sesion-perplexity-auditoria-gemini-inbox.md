---
tipo: investigacion
fuente: perplexity
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
  - raw
---

# Sesión Perplexity: auditoría, vaciado y estructuración de inbox con Gemini

## Contexto
Sesión de investigación para definir el protocolo de auditoría y vaciado de `inbox/` en `yggdrasil-dew`, usando Gemini como motor de clasificación y Obsidian como fuente de verdad.

## Objetivo general
- Vaciar la inbox sin romper dependencias.
- Preservar archivos permanentes.
- Clasificar archivos en MOVIBLE y NO_MOVIBLE.
- Documentar el proceso en Obsidian.
- Preparar scripts reutilizables para Gemini.
- Preparar un mapeo funcional de la repo cuando haga falta.

## Permanentes blindados
- `README.md`
- `MASTER-PENDIENTES.md`
- `inbox-clasificado.md`

## Matriz de decisión binaria

### MOVIBLE
Solo si cumple todo esto:
- tiene destino exacto en la estructura viva;
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
- `RAW`: fuente original sin procesar.
- `OCR`: texto extraído de imagen o escaneo.
- `RAW_OCR`: mixto con ambos componentes.

## Flujo de ejecución
1. mover
2. verificar
3. archivar
4. borrar

## Criterios de seguridad
- No borrar nada dudoso.
- No inventar rutas ni carpetas destino.
- Mantener coherencia entre series, sesiones y documentos relacionados.
- Si el archivo no tiene destino claro → NO_MOVIBLE.

## Script maestro para Gemini (versión completa)

```text
Actúa como arquitecto de información y auditor de repositorios.

Contexto:
Voy a revisar la carpeta `inbox/` de un repositorio Obsidian/GitHub.
Tu tarea es auditar cada archivo y separarlo en dos grupos:
- MOVIBLE: solo si tiene un destino exacto en la estructura viva y cero ambigüedad.
- NO_MOVIBLE: permanentes, duplicados, obsoletos o notas que requieren revisión humana.

Además, rastrea el tipo de material cuando aplique:
- RAW
- OCR
- RAW_OCR

Reglas obligatorias:
1. No tocar nunca estos permanentes:
   - README.md
   - MASTER-PENDIENTES.md
   - inbox-clasificado.md

2. Un archivo es MOVIBLE solo si:
   - tiene destino exacto;
   - pertenece a la estructura viva del repositorio;
   - no es duplicado, obsoleto ni dudoso.

3. Un archivo es NO_MOVIBLE si:
   - es permanente;
   - no tiene destino claro;
   - está duplicado;
   - ya quedó obsoleto;
   - requiere revisión humana.

4. No inventes carpetas destino.
5. No borres nada dudoso.
6. Mantén coherencia entre series, sesiones y documentos relacionados.
7. Si un archivo contiene trabajo derivado de imagen o escaneo, clasifícalo como OCR o RAW_OCR.

Formato de salida obligatorio:
Tabla con columnas:
archivo | movible | tipo | destino | motivo | prioridad

Después añade:
- permanentes confirmados
- movibles
- no movibles
- dudosos
- orden recomendado de ejecución

Criterio de ejecución:
1. Mover solo lo que tenga destino claro.
2. Verificar que el destino sea correcto.
3. Archivar lo histórico útil.
4. Borrar solo lo claramente obsoleto.
5. Nunca tocar los permanentes.

Archivo de entrada:
[Pegar aquí el listado completo de archivos de `inbox/`]
```

## Script para actualización de inbox y clasificación de repo

```text
Actúa como arquitecto de información y auditor de repositorios.

Objetivos:
1. Actualizar el estado de `inbox/` con lo ya documentado.
2. Clasificar la repo en términos de contenido vivo, documentación, trabajo pendiente y material obsoleto.
3. Mantener trazabilidad en Obsidian y en la repo.
4. No inventar rutas ni borrar nada dudoso.

Reglas:
- Permanentes: README.md, MASTER-PENDIENTES.md, inbox-clasificado.md.
- MOVIBLE solo con destino exacto.
- NO_MOVIBLE para permanentes, dudosos, duplicados, obsoletos.
- Tipos: RAW, OCR, RAW_OCR.
- Flujo: mover -> verificar -> archivar -> borrar.

Salida obligatoria:
1. Tabla: archivo | movible | tipo | destino | motivo | prioridad
2. Permanentes confirmados.
3. Movibles.
4. No movibles.
5. Dudosos.
6. Estado actualizado de inbox.
7. Clasificación funcional de la repo.
8. Orden recomendado de ejecución.

Criterios de clasificación funcional de la repo:
- documentación viva
- tracking y diarios
- proyectos activos
- infraestructura
- formación
- agentes IA
- deuda técnica
- material pendiente de migración
- material consolidado

Archivo de entrada:
[Pegar aquí el listado completo de archivos de `inbox/`]
```

## Inventario real de inbox al 2026-06-23

### Permanentes (no tocar)
- `README.md`
- `MASTER-PENDIENTES.md`
- `.gitkeep`

### Archivos de trabajo del 2026-06-23
- `2026-06-23-actualizacion-claude-gemini.md`
- `2026-06-23-adr-docs-as-code-repos-cerebro.md`
- `2026-06-23-adr-ollama-en-agentes.md`
- `2026-06-23-auditoria-diarios.md`
- `2026-06-23-auditoria-docs.md`
- `2026-06-23-auditoria-formacion.md`
- `2026-06-23-auditoria-ollama.md`
- `2026-06-23-auditoria-osint.md`
- `2026-06-23-auditoria-setup.md`
- `2026-06-23-auditoria-tools-inbox-dashboard.md`
- `2026-06-23-auditoria-tools.md`
- `2026-06-23-auditoria-yo.md`
- `2026-06-23-dashboard-readme.md`
- `2026-06-23-decision-arquitectura-proyectos.md`
- `2026-06-23-decision-homelab-vs-proyectos.md`
- `2026-06-23-estado-auditoria-repo.md`
- `2026-06-23-estado-descargas-madre.md`
- `2026-06-23-inbox-clasificado.md`
- `2026-06-23-inbox-processor-implementacion.md`
- `2026-06-23-local-brain-setup.md`
- `2026-06-23-ollama-bge-m3.md`
- `2026-06-23-ollama-guia-seleccion.md`
- `2026-06-23-ollama-qwen2.5-3b.md`
- `2026-06-23-ollama-qwen2.5-7b.md`
- `2026-06-23-ollama-rag-investigacion.md`
- `2026-06-23-osint-rag-mover.md`
- `2026-06-23-prompt-claude-ecosistema-docker.md`
- `2026-06-23-prompt-claude-refactor-repo.md`
- `2026-06-23-prompt-gemini-auditoria-inbox.md`
- `2026-06-23-proyecto-chatbot-control.md`
- `2026-06-23-proyecto-local-brain.md`
- `2026-06-23-proyecto-terminal-ia.md`
- `2026-06-23-proyecto-thdora.md`
- `2026-06-23-pull-stack-madre.md`
- `2026-06-23-sesion-completa.md`
- `2026-06-23-sesion-gemini-auditoria.md`
- `2026-06-23-systemd-plan.md`
- `2026-06-23-tools-pendientes.md`
- `2026-06-23-v4-pendiente-ollama.md`
- `2026-06-23-yggdrasil-v4-diario-maestro.md`

## Criterio de ingeniería
Solo se mueve lo que tiene contrato de destino. Lo demás se conserva como contexto hasta que haya evidencia suficiente.

## Próximos pasos
- Pegar el inventario de `inbox/` en Gemini.
- Ejecutar la clasificación binaria.
- Mover a Claude para ejecutar el plan.
- Sincronizar con Obsidian tras el git pull.
- Vincular desde `MASTER-PENDIENTES.md`.

## Estado final de la sesión
Protocolo de auditoría y vaciado de inbox definido y documentado. Scripts reutilizables para Gemini generados. Inventario real de la inbox registrado. Listo para ejecutar con Claude.