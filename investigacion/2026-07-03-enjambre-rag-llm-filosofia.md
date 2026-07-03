# 🧠 Análisis: Enjambre IA, RAG y Cuantización LLM para el Ecosistema Yggdrasil

**Fecha:** 2026-07-03  
**Estado:** INBOX — pendiente de revisión y acción  
**Tags:** `#filosofia-ia` `#enjambre` `#rag` `#llm` `#cuantizacion` `#ecosistema`  
**Relacionado con:** `2026-07-03-arquitectura-bots-ecosistema.md`

---

## 🎯 Pregunta central

> ¿Qué bots necesitamos? ¿Cómo los gestionamos para atacar, defender y monitorizar?  
> ¿Cómo construir un buen RAG? ¿Cómo hacer que los LLMs pesen menos sin perder fiabilidad?

---

## 1. Filosofía de IA — Orquestación de Enjambre (Swarm Intelligence)

### Qué es

La inteligencia de enjambre en IA replica comportamientos de la naturaleza (hormigas, abejas, bandadas). Cada agente es **simple y autónomo**; la inteligencia emerge de la **interacción colectiva**, no de un agente omnisciente central.

Principios fundamentales aplicados a bots:
- **Descentralización** — ningún bot es el único punto de fallo
- **Auto-organización** — los bots se coordinan sin orquestador rígido
- **Emergencia** — el sistema hace cosas que ningún bot haría solo
- **Especialización** — cada bot tiene UN rol, no muchos

### Paradigmas actuales (2026)

| Framework | Descripción | Uso ideal |
|---|---|---|
| **Society of HiveMind (SOHM)** | Orquesta múltiples LLMs imitando enjambres naturales con teorías evolutivas | Sistemas complejos multi-modelo |
| **Orchestrated Distributed Intelligence (ODI)** | Redes cohesionadas con capas de orquestación + loops de feedback humano | Producción con supervisión humana |
| **Conversational Swarm Intelligence (CSI)** | Grupos de cualquier tamaño en deliberaciones productivas en tiempo real | Toma de decisiones colectiva |
| **ClawTeam** | Un comando → equipo coordinado. Líder descompone tareas, workers ejecutan, tablero Kanban compartido. MIT | Workflows paralelos complejos |
| **OpenSwarm** | Desktop app MIT. Canvas 2D infinito, Human-in-the-loop, 4000+ integraciones MCP, git worktree isolation | Control de enjambre local |

### Aplicación al ecosistema Yggdrasil

```
                    ┌─────────────────┐
                    │   ORQUESTADOR   │  ← thdora (coordinadora)
                    │   (thdora)      │
                    └────────┬────────┘
                             │
           ┌─────────────────┼─────────────────┐
           │                 │                 │
    ┌──────▼──────┐  ┌───────▼──────┐  ┌──────▼──────┐
    │  GUARDIANA  │  │  THDORA-DEW  │  │     EMA     │
    │  (defensa)  │  │ (monitoring) │  │  (análisis) │
    └─────────────┘  └──────────────┘  └─────────────┘
           ↑                 ↑                 ↑
           └─────────────────┴─────────────────┘
                    Shared RAG Layer
                    (Vector Store)
```

---

## 2. Qué bots necesitamos — Flota propuesta

### Nivel 1 — Producción inmediata

| Bot | Rol | Estado | Tecnología |
|---|---|---|---|
| `thdora` | Interfaz Telegram + coordinadora | ✅ En producción | Python, aiogram |
| `guardiana` | Alertas, monitorización, defensa | 📋 Planificada Fase 8 | Python, cron, webhooks |
| `thdora-dew` | Diario de sesión, contexto, memoria | 🔧 Parcial en handlers | Python, Markdown |

### Nivel 2 — Con RAG maduro

| Bot | Rol | Trigger |
|---|---|---|
| `ema` | Auditoría IA, análisis código, detección zombie | Cuando ai_audit.py madure |
| `sentinel` | Vigilancia repos externos, alertas dependencias | Cuando guardiana esté estable |
| `biblia` | RAG del ecosistema — responde preguntas sobre el propio sistema | Cuando vector store esté configurado |

### Regla del enjambre para este ecosistema

> **Un bot = un verbo.** thdora COORDINA. guardiana ALERTA. ema ANALIZA. biblia RESPONDE.  
> Si un bot hace dos verbos, es que debería ser dos bots.

---

## 3. RAG — Recuperación Aumentada para Producción

### Por qué lo necesitamos

Sin RAG, thdora sólo "sabe" lo que está en su contexto de conversación. Con RAG, puede responder preguntas sobre:
- Estado del ecosistema en cualquier momento
- Historial de decisiones (inbox)
- Documentación técnica (SCRIPTS.md, ROADMAP.md)
- Código de los propios repos

### Arquitectura RAG 2026 (producción)

```
INGESTA                    RETRIEVAL                  GENERACIÓN
───────                    ─────────                  ──────────
Docs → Chunks           Híbrido: Dense              LLM con contexto
(200-500 tokens,      + BM25 → RRF fusion        aumentado + cita
 10-20% overlap)      → Reranker (top 5-10)       de fuentes
 + metadata           → Cross-encoder
```

**Stack recomendado para el ecosistema (bajo coste):**

| Componente | Opción recomendada | Alternativa |
|---|---|---|
| Vector store | **pgvector** (ya tienes Postgres probable) | ChromaDB (más simple) |
| Embeddings | `nomic-embed-text` (Ollama, gratis) | `text-embedding-3-small` (OpenAI) |
| Reranker | `ms-marco-MiniLM-L-6-v2` (local, ligero) | Cohere Rerank 3.5 |
| Retrieval | Hybrid BM25 + dense, RRF k=60 | Solo dense para empezar |
| Eval | RAGAS (Hit@k, faithfulness) | Manual spot-checks |

### Pipeline concreto para thdora

```python
# Flujo propuesto en src/rag/
1. ingest.py      → lee inbox/*.md, docs/, scripts/ → chunks → embeddings → pgvector
2. retrieve.py    → query → hybrid search → rerank → top-5 chunks
3. augment.py     → construye prompt con chunks + query original
4. thdora usa augment.py antes de responder preguntas sobre el ecosistema
```

### Reglas de higiene del conocimiento

- **Delta updates**: no re-indexar todo, solo lo nuevo desde el último run
- **Versionar el índice**: poder hacer rollback si una ingesta rompe calidad
- **Una colección por agente**: thdora no mezcla su memoria con la de ema
- **Chunking con metadatos**: cada chunk lleva `source`, `date`, `agent`, `type`

---

## 4. Cuantización LLM — Cómo hacerlos ligeros sin sacrificar fiabilidad

### Qué es la cuantización

Reducir la precisión de los pesos del modelo: de 16 bits (FP16) a 4-8 bits. Es como comprimir una imagen TIFF a JPEG — pierdes algo, pero si lo haces bien, casi no se nota.

### Tabla de decisión GGUF 2026

| Nivel | Tamaño (70B) | Calidad vs FP16 | Velocidad | Cuándo usar |
|---|---|---|---|---|
| **Q2_K** | 20GB | 87% | 2.4x | Nunca en producción |
| **Q3_K_M** | 30GB | 93% | 4.5x | Solo si no cabe nada más |
| **Q4_K_M** ⭐ | 40GB | 97.5% | 3.7x | **Sweet spot. Default.** |
| **Q5_K_M** ⭐ | 47GB | 98.5% | 3.0x | Si cabe, mejor calidad |
| **Q6_K** | 54GB | 99% | 1.6x | Alta calidad, poco gain |
| **Q8_0** | 70GB | 99.5% | 1.4x | Cuándo VRAM no importa |
| **FP16** | 140GB | 100% | 1x | Evaluación, no producción |

**Regla clave para agentes**: Nunca bajar de Q4 para tool-use. El razonamiento degrada más rápido que el lenguaje general en Q3 y Q2.

### Benchmark de razonamiento matemático (GSM8K)

| Nivel | Llama 4 8B | Qwen 3 32B | Degradación |
|---|---|---|---|
| FP16 | 78.2% | 89.1% | baseline |
| Q5_K_M | 77.4% | 88.6% | ~0.5% |
| Q4_K_M | 76.5% | 87.9% | ~1.5% |
| Q3_K_M | 72.1% | 84.8% | **~5%** ← notar |
| Q2_K | 61.4% | 76.5% | **~14%** ← inaceptable |

### ¿Cómo meterle tus skills/filosofía sin reentrenar?

El LLM no cambia — cambias el **contexto que le das**. Tres técnicas por coste:

```
GRATIS — System Prompt Engineering
├── CLAUDE.md / AGENTS.md definen la filosofía
├── El bot lo inyecta en cada conversación
└── Resultado: el LLM "actúa" según tus reglas sin reentrenamiento

ECONÓMICO — RAG
├── Vectorizas tu documentación (inbox, roadmap, código)
├── El bot recupera contexto relevante antes de responder
└── Resultado: el LLM "sabe" sobre tu ecosistema sin memorizar nada

AVANZADO — Fine-tuning / LoRA
├── Entrenas un adaptador ligero (LoRA, ~50-200MB)
├── El modelo base no cambia, solo se añade el adaptador
└── Resultado: comportamiento específico "horneado" en el modelo
```

Para el ecosistema actual: **System Prompt + RAG** es suficiente y es gratuito.

### Modelos ligeros recomendados (2026, local)

| Modelo | Tamaño Q4 | Especialidad | Uso en ecosistema |
|---|---|---|---|
| `qwen3:0.6b` | ~400MB | Chat rápido, respuestas cortas | thdora-light (respuestas inline) |
| `llama3.2:3b` | ~2GB | Generalista equilibrado | ema análisis rápido |
| `qwen3:8b` | ~5GB | Razonamiento, código | thdora análisis complejo |
| `qwen3:14b` | ~9GB | Multimodal, tool-use | Agente principal con RAG |
| `deepseek-coder:6.7b` | ~4GB | Código especializado | Auditoría zombie code |
| `nomic-embed-text` | ~270MB | Embeddings | RAG (no generación) |

---

## 5. Mejores skills/herramientas de comunidad (2026)

### Skills más usadas en producción

| Skill/Tool | Estrellas | Qué hace | Fit ecosistema |
|---|---|---|---|
| **OpenSwarm** | 650+ | Canvas multi-agente local, MIT, 4000 MCP tools | ⭐⭐⭐ Orquestación visual |
| **ClawTeam** | 3800+ | Enjambre un-comando, Kanban automático, MIT | ⭐⭐⭐ Automatización |
| **LangGraph** | N/A | Grafos de agentes con estado, producción estable | ⭐⭐⭐ Workflows complejos |
| **CrewAI** | N/A | Equipos de agentes con roles, fácil setup | ⭐⭐ Prototipado rápido |
| **Mastra** | N/A | TypeScript, multi-agente, integración moderna | ⭐⭐ Si se migra a TS |
| **awesome-agent-swarm** | Curated | Lista de recursos enjambre, actualizada | 📚 Referencia |

### Patrón que usan los mejores (aplicable a thdora)

```python
# Pattern: Líder-Worker con memoria compartida
class OrchestratorAgent:
    """thdora como líder: descompone, delega, agrega"""
    def run(self, goal):
        tasks = self.decompose(goal)          # LLM descompone
        results = [worker.run(t) for t in tasks]  # Workers ejecutan
        return self.aggregate(results)         # LLM agrega

class WorkerAgent:
    """ema, guardiana, etc. como workers especializados"""
    def run(self, task):
        context = rag.retrieve(task)          # RAG da contexto
        return llm.complete(task, context)    # LLM genera
```

---

## 6. Docker — Estado actual y fix del connError

El error `connError Socket is not connected` al final del build **no es un fallo del build**. Es un timeout de la sesión SSH/terminal después de los 1605s de build. El build terminó correctamente (exporting layers: 42.4s completado).

**Verificar:**
```bash
docker compose ps
docker compose logs --tail=20 thdora
curl http://localhost:8000/health  # si tienes healthcheck
```

**Si el build terminó pero el contenedor no está up:**
```bash
docker compose up -d  # arrancar sin rebuild
```

---

## 7. Acciones propuestas (pendiente revisión)

### Inmediato (esta sesión)
- [ ] Verificar Docker: `docker compose ps && docker compose logs thdora --tail=20`
- [ ] Cerrar issue #12 (zombie code) con `ai_audit.py` ya desplegado
- [ ] Crear `CLAUDE.md` en thdora con filosofía del ecosistema (System Prompt base)

### Próxima sesión
- [ ] Configurar ChromaDB o pgvector como vector store
- [ ] `src/rag/ingest.py` — indexar inbox/ + docs/ + scripts/
- [ ] Definir modelo local: `qwen3:8b` Q4_K_M como candidato principal

### Aplazado (Fase 8+)
- [ ] Fine-tuning LoRA con conversaciones del ecosistema
- [ ] OpenSwarm como panel de control del enjambre
- [ ] `biblia` bot — RAG puro sobre el ecosistema

---

## Referencias

- [Society of HiveMind (SOHM)](http://arxiv.org/pdf/2503.05473.pdf) — Multi-agent swarm framework
- [Orchestrated Distributed Intelligence](https://arxiv.org/pdf/2503.13754.pdf) — ODI paradigm
- [OpenSwarm](https://github.com/openswarm-ai/openswarm) — MIT, canvas multi-agente local
- [ClawTeam](https://www.opensourcedrop.com/tools/HKUDS/ClawTeam) — Swarm un-comando
- [awesome-agent-swarm](https://github.com/EvoMap/awesome-agent-swarm) — Lista curada enjambre
- [RAG Best Practices 2026](https://agentflare.org/research/rag-best-practices-for-2026.html) — AgentFlare
- [RAG Production Guide 2026](https://lushbinary.com/blog/rag-retrieval-augmented-generation-production-guide/) — LushBinary
- [GGUF Quantization Comparison 2026](https://bmdpat.com/tools/quant-compare) — 9 niveles comparados
- [Local LLM Quantization Benchmarks 2026](https://presenc.ai/research/local-llm-quantization-quality-benchmarks-2026) — Presenc AI
