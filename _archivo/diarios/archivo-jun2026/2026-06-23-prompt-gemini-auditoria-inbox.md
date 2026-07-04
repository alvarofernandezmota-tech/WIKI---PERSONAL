---
tags: [prompt, gemini, deep-research, auditoria, inbox, estado-repo]
fecha: 2026-06-23
estado: listo-para-ejecutar
tipo: prompt-agente
agente: gemini-deep-research
prioridad: ALTA
ruta-obsidian: inbox/2026-06-23-prompt-gemini-auditoria-inbox.md
---

# Prompt Gemini Deep Research — Auditoría inbox + estado real repo

> Usar con Gemini con Deep Research + acceso a GitHub
> Objetivo: saber exactamente qué hay en inbox, qué está hecho y qué no

---

## RAW PROMPT — COPIAR COMPLETO

```
Eres un ingeniero de software senior especializado en gestión del conocimiento y documentación técnica.
Tienes acceso a mi repo GitHub `alvarofernandezmota-tech/yggdrasil-dew`.
Este repo es mi cerebro digital como ingeniero de software.

## CONTEXTO DEL SISTEMA

Arquitectura: docs-as-code + inbox-first + wikilinks Obsidian
Filosofía: ver `filosofia.md` en la raíz del repo (v3.0)
Referencia de calidad: carpeta `agentes/` — así debe ser todo el repo

Las 3 leyes del sistema:
1. Nunca duplicar — siempre enlazar con wikilinks [[archivo]]
2. Todo nuevo entra por inbox/ primero
3. Infraestructura != Producto

Decisiones ADR tomadas (NO cambiar):
- agentes/ = IAs externas con API únicamente (Claude, Gemini, GPT, Grok, Perplexity)
- ollama/ = todo local (modelos, RAG, Qdrant, Open WebUI)
- setup/servidor/ = homelab Batcueva (Docker stack, Madre, scripts)
- proyectos/ = productos con repo GitHub propia
- osint/ = conocimiento + repo osint-stack futura
- Todo Docker → repo GitHub propia + doc en proyectos/ + conocimiento en carpeta temática

## SITUACIÓN HOY 2026-06-23

Se ha hecho una sesión completa de arquitectura y auditoría.
El inbox ahora tiene ~30 archivos de esta sesión.
Hay una mezcla de:
- ADRs (decisiones de arquitectura)
- Planes de auditoría por carpeta
- Prompts para agentes
- Estado de instalaciones
- Fichas de conocimiento
- Diario maestro
- Documentos que ya fueron procesados

El problema: no hay claridad de qué está realmente ejecutado vs qué es solo un plan.

## TU TAREA

### PASO 1 — Lee TODO el inbox

Lee cada archivo de `inbox/` y clasifícalo en:

| Estado | Significado |
|---|---|
| ✅ EJECUTADO | La tarea/decisión ya está implementada en el repo |
| ⏳ EN CURSO | Se está ejecutando ahora (ej: descargas Docker) |
| 📋 PLAN | Es un plan/prompt pendiente de ejecutar |
| 📚 CONOCIMIENTO | Es conocimiento puro — mover a su carpeta definitiva |
| 🔄 PROCESAR | Necesita decisión: ¿dónde va definitivamente? |
| 🗑️ OBSOLETO | Ya no aplica o fue superado por otra decisión |

### PASO 2 — Audita el estado REAL de cada carpeta

Para cada carpeta del repo lee su contenido real y determina:
- ¿Tiene README.md?
- ¿Tiene frontmatter YAML en sus archivos?
- ¿Está al nivel de `agentes/`?
- ¿Qué le falta exactamente?

Carpetas a auditar: `diarios/` `ollama/` `osint/` `formacion/` `tools/` `cli-tools/` `docs/` `yo/` `setup/` `proyectos/` `templates/`

Archivos raíz a auditar: `HOME.md` `ECOSISTEMA.md` `CONTEXT.md` `AGENT.md` `CHANGELOG.md`

### PASO 3 — Verifica qué existe vs qué falta

Cruza los planes de auditoría del inbox con la realidad del repo:
- ¿El plan de `auditoria-diarios.md` ya se ejecutó?
- ¿El plan de `auditoria-ollama.md` ya se ejecutó?
- ¿Existe `.obsidian/` workspace?
- ¿Existe `setup/servidor/`?
- ¿Existe `proyectos/ollama-stack/`?
- ¿Existe `docs/CONVENCIONES.md`?
- ¿Los diarios están en `diarios/2026/06/` o en la raíz?

### PASO 4 — Genera el output

Crea estos archivos directamente en el repo:

**A) `inbox/2026-06-23-estado-real-repo.md`**
Doc maestro con:
- Tabla de estado real de cada carpeta (existe/bien/mejorable/vacía)
- Lista exacta de qué planes del inbox ya se ejecutaron
- Lista de qué planes del inbox son aún pendientes
- Lo que existe en el repo pero no está documentado en el inbox

**B) `inbox/2026-06-23-inbox-clasificado.md`**
Tabla completa de todos los archivos del inbox con:
- Nombre del archivo
- Clasificación (EJECUTADO / EN CURSO / PLAN / CONOCIMIENTO / PROCESAR / OBSOLETO)
- Dónde va definitivamente cuando se procese
- Prioridad (AHORA / SEMANA / FUTURO)

**C) Actualiza `inbox/MASTER-PENDIENTES.md`**
Con el estado real verificado — marca como ✅ lo que ya está hecho de verdad.

**D) Mueve conocimiento puro a su carpeta definitiva**
Si hay fichas de conocimiento en inbox que claramente pertenecen a `ollama/`, `agentes/`, `osint/`
muévelas a su carpeta correcta con commit descriptivo.

## RESTRICCIONES

- NO mover archivos sin verificar el contenido real primero
- NO marcar como ejecutado algo que solo tiene el plan pero no la implementación
- Commits descriptivos por cada grupo de cambios
- Frontmatter YAML en todos los docs que crees
- Wikilinks [[]] nunca URLs relativas
- Respetar las 3 leyes de filosofia.md
- NO tocar agentes/ — es la referencia perfecta

## REPOS DEL ECOSISTEMA

| Repo | Estado |
|---|---|
| alvarofernandezmota-tech/yggdrasil-dew | ✅ activo — este repo |
| alvarofernandezmota-tech/thdora | ✅ activo — bot Telegram |
| alvarofernandezmota-tech/ai-toolkit | ✅ activo |
| alvarofernandezmota-tech/ollama-stack | 🔴 pendiente crear |
| alvarofernandezmota-tech/osint-stack | 🔴 pendiente crear |

## OUTPUT ESPERADO AL FINAL

1. Claridad 100% de qué hay en inbox y su estado
2. Estado real verificado de cada carpeta del repo
3. MASTER-PENDIENTES con solo lo realmente pendiente
4. Conocimiento puro movido a sus carpetas definitivas
5. Repo más cercano al nivel de ingeniero de software organizado

Empieza por PASO 1 — lee todo el inbox y confírmame la clasificación antes de ejecutar cambios.
```

---

## CÓMO USAR ESTE PROMPT

1. Abrir Gemini con Deep Research activado
2. Dar acceso al repo `alvarofernandezmota-tech/yggdrasil-dew`
3. Pegar el bloque raw completo
4. Confirmar clasificación del PASO 1 antes de dejar ejecutar
5. Revisar output antes de hacer merge

## QUÉ APORTA GEMINI AQUÍ vs CLAUDE

- Deep Research → lee TODO el repo de golpe sin límite de contexto
- Puede cruzar 30 archivos del inbox con el estado real de 15 carpetas simultáneamente
- Mejor para auditorías de consistencia y detección de duplicados
- Claude mejor para ejecutar cambios concretos uno a uno

---
_Generado Perplexity · 2026-06-23 · usar con Gemini Deep Research + acceso GitHub_
