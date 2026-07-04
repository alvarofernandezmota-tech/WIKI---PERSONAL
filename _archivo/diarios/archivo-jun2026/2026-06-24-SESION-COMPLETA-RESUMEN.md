---
tipo: resumen-sesion
fecha: 2026-06-24
hora_inicio: "06:12"
hora_fin: "06:48"
status: documentado
tags: [sesion, resumen, thdora, ollama, llama.cpp, arquitectura, modelos, decisiones]
---

# 🗓️ SESIÓN COMPLETA — 24 junio 2026

> Todo lo pensado, debatido y decidido esta mañana. Leer en orden.

---

## Índice de ficheros generados hoy

| Orden | Fichero | Contenido |
|-------|---------|----------|
| 1 | `2026-06-24-PROMPT-MAESTRO-DOCUMENTACION-IAS.md` | Prompt autoentrevista para cualquier IA nueva |
| 2 | `2026-06-24-PROMPT-MAESTRO-DEBATE-MULTI-IA.md` | Protocolo debate Gemini ↔ Grok |
| 3 | `2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md` | Prompt listo para pegar en Gemini (con filosofía open-source) |
| 4 | `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md` | Tesis arquitectura stack inferencia (resultado debate) |
| 5 | `2026-06-24-DEBATE-GROK-OLLAMA-VS-LLAMACPP.md` | Grok matiza: Ollama domado vs llama.cpp nativo |
| 6 | `2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md` | **Veredicto final + config lista para aplicar** |
| 7 | `2026-06-24-SESION-COMPLETA-RESUMEN.md` | Este fichero |
| — | `docs/ias/TEMPLATE-FICHA-MODELO.md` | Template universal ficha modelo LLM |
| — | `filosofia.md` | Filosofía actualizada con 6 principios + stack preferido |

---

## Timeline de la sesión

### 06:12 — Estado inicial de Madre
```
✅ qwen2.5:3b listo (1.9 GB)
⏳ qwen2.5:14b descargando 8% · ETA 3h43m
Docker: 25/33 imágenes · 9 containers activos
```

### 06:17 — Idea: investigar y documentar todos los modelos LLM
Se decide usar **Gemini como orquestador** y **Grok como escéptico** para investigar:
- 6 modelos cloud (Gemini, Grok, Claude, GPT-4, Perplexity, Mistral)
- 7 modelos Ollama locales
- 3 proyectos estadística + LLM

### 06:23 — Se añade filosofía open-source a los prompts
Todo el stack cloud es solo para investigación. El deploy real siempre local.
Se añade campo `open_source: true/false` a cada YAML de modelo.

### 06:35 — Tesis arquitectura (resultado debate Gemini ↔ Grok turno 1)
**Veredicto inicial:** llama.cpp server > Ollama siempre.
Stack: llama.cpp + LlamaStash TUI + scripts Python + numpy/scipy.
Ollama, OpenWebUI, CrewAI, LangGraph: DESCARTADOS.

### 06:39 — Grok matiza la tesis (no tan radical)
**Dato clave:** Ollama = llama.cpp + envoltorio Go. Motor 95% idéntico.
El problema no es Ollama, es Ollama **sin dominar**.
**Ecosistema híbrido** (ambos simultáneos): OOM Killer garantizado en 16 GB.
Dos opciones reales: Ollama domado O llama.cpp nativo. Solo un rey.

### 06:41 — ¿Dos containers diferentes?
**Pregunta de Álvaro:** ¿y si los metemos en dos Docker diferentes?
**Respuesta:** La RAM es física, no lógica. Da igual el container.
Salvo una excepción válida:
```
ollama-chat:       qwen2.5:7b  (~6.5 GB) ← THDORA
ollama-embeddings: bge-m3      (~600 MB) ← Qdrant/RAG
Total: ~7.1 GB + ~4 GB stack = ~11 GB ✅
```

### 06:43 — Bitácora final consolidada (veredicto definitivo)
**FASE 1 (ahora):** Ollama domado + Qwen2.5-7B
**FASE 2 (2-4 semanas):** Migrar a llama.cpp server puro

Config lista:
```yaml
OLLAMA_NUM_PARALLEL=1
OLLAMA_MAX_LOADED_MODELS=1
OLLAMA_FLASH_ATTENTION=1
cpus: '3.5' · memory: 7g
```
Modelfile: num_ctx=4096, num_thread=3, temperature=0.0

### 06:46 — Funciones automáticas de THDORA
Se detecta que hay dos capas en THDORA:

**Capa admin (para Álvaro):** comandos de control del homelab sin IA
```
/status /ram /cpu /disco /containers /up /down /restart /logs
/ollama /ping /ip /git /alertas
Monitores: RAM > 85% → alerta · container caído → alerta
```

**Capa negocio (para clientes):** Ollama ES el motor, no una feature
```
Voz/Texto → Telegram → THDORA → Ollama NLP → acción de negocio
```

### 06:48 — Aclaración importante
**El código de THDORA NO va aquí.** Va en el repo propio de THDORA.
Yggdrasil-Dew = cerebro/documentación. THDORA repo = código.

---

## Decisiones tomadas hoy

| Decisión | Estado |
|----------|--------|
| Usar Gemini + Grok para documentar modelos | ✅ Prompt listo |
| Filosofía 100% open-source en todo | ✅ Documentada en `filosofia.md` |
| Ollama domado (Fase 1) | ✅ Config lista |
| Migrar a llama.cpp (Fase 2, 2-4 semanas) | ⏳ Pendiente |
| NO ecosistema hírido simultáneo | ✅ Descartado |
| Sí separación chat + embeddings (bge-m3) | ⏳ Pendiente implementar |
| Funciones admin THDORA sin IA | ⏳ Pendiente — van en repo THDORA |
| Fichas YAML de todos los modelos | ⏳ Pendiente — lanzar sesión Gemini+Grok |

---

## Pendientes concretos que salen de esta sesión

### En Yggdrasil-Dew (este repo)
- [ ] Lanzar sesión investigación modelos (prompt en inbox #3)
- [ ] Crear fichas en `docs/ias/` con YAMLs de cada modelo
- [ ] Crear fichas en `ollama/` para modelos locales viables
- [ ] Actualizar `ESTADO-SISTEMA.md` con modelos reales descargados
- [ ] Aplicar variables Ollama domado al docker-compose de Madre
- [ ] Documentar config final docker-compose cuando esté aplicada

### En repo THDORA (código)
- [ ] Implementar capa admin: /status /ram /cpu /containers /logs
- [ ] Implementar monitores: RAM > 85% + container caído
- [ ] Documentar aquí qué hace cada comando (referencia cruzada)
- [ ] Migrar NLP de Groq → Ollama local (Sprint 4)

### Hardware / Infraestructura
- [ ] Esperar descarga qwen2.5:7b (ETA ~3h desde 06:12)
- [ ] Probar Modelfile Qwen2.5-7B con parámetros del veredicto
- [ ] Benchmark real: tokens/s con num_thread=3 vs 4
- [ ] Evaluar LlamaStash como reemplazo de OpenWebUI (Fase 2)

---

## Contexto THDORA (para no perderse)

THDORA **no es** un bot de control del homelab.
THDORA **es** un asistente de negocio multi-sector (restaurantes, clínicas, coaches...).

```
Arquitectura real:
Voz/Texto del cliente
    ↓ Telegram
    ↓ THDORA core
    ↓ Groq NLP (ahora) → Ollama local (Sprint 4)
    ↓ function calling
    ↓ API / BD del negocio
    ↓ Respuesta al cliente
```

Ollama en THDORA = motor de lenguaje central, no comando opcional.
Los comandos admin (/status etc.) son una capa secundaria para que Álvaro gestione Madre.

---

## Próxima sesión recomendada

1. Lanzar el prompt de Gemini (inbox #3) — mientras descarga qwen2.5:7b
2. Recoger YAMLs → commitear fichas en `docs/ias/` y `ollama/`
3. Aplicar config Ollama domado en Madre
4. Probar Modelfile Qwen2.5-7B cuando esté listo
5. Abrir repo THDORA y empezar capa admin
