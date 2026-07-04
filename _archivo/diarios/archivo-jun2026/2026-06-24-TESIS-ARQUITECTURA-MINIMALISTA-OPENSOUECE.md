---
tipo: tesis-arquitectura
fecha: 2026-06-24
hora: "06:35"
status: validado
fuente: debate-gemini-grok
tags: [arquitectura, open-source, llama.cpp, homelab, thdora, minimalista, cpu-only]
priority: CRITICA
---

# ✅ TESIS FINAL — Arquitectura Minimalista Soberana para Madre

> **Filosofia:** 100% open-source. Soberanía digital absoluta. Nada propietario.
> **Hardware:** i5-8400 · 6 cores/6 threads · 16 GB RAM · sin GPU
> **Veredicto:** Stack minimalista llama.cpp + herramientas nativas. Todo framework pesado: DESCARTADO.

---

## 1. Hardware y Límites Reales

- **i5-8400**: 6 cores / 6 threads reales (sin Hyper-Threading)
- Asignación segura: máximo **3-4 hilos** para inferencia LLM
- Techo práctico: modelos **7B-8B** (Q4_K_M o Q5_K_M)
- Rendimiento esperado (ctx 4096): **4-7 tokens/s** en generación
- **14B+**: inviable sin swap constante → congelamiento de servicios

## 2. Modelos Recomendados

| Prioridad | Modelo | Cuantización | Motivo |
|-----------|--------|--------------|--------|
| ⭐ Primera | Qwen2.5-7B-Instruct | Q5_K_M | Mejor equilibrio calidad/RAM |
| ⭐ Segunda | Llama 3.1-8B | Q4_K_M | Multilingüe, código |
| ☁️ Externo | Grok 3 | API | Validación externa única |
| ❌ Descartar | qwen2.5:14b | cualquiera | Inviable 16GB con stack activo |

> Grok 2.5 sí disponible en HuggingFace. Grok 3 pesos aún no liberados (2026-06-24).

## 3. Stack de Inferencia (Veredicto definitivo)

| Componente | Recomendado | Motivo | RAM aprox |
|------------|-------------|--------|-----------|
| Inferencia | **llama.cpp server** | Más rápido y ligero que Ollama | Bajo |
| UI/Cliente | **LlamaStash (Rust TUI) o CLI** | <50 MB vs 1.5 GB OpenWebUI | Mínimo |
| Orquestación | **Scripts Python/Go + FastAPI** | Evitar CrewAI/Autogen/LangGraph | <500 MB |
| Vector DB | **Qdrant** (límites estrictos) | Ligero y eficiente | 1-2 GB |

### ❌ DESCARTAR completamente:
- Ollama (overhead innecesario)
- OpenWebUI (1.5 GB RAM idle)
- CrewAI / Autogen / LangGraph
- Cualquier framework agencial Python pesado

## 4. Arquitectura THDORA Recomendada

```
tshark / hcxdumptool
        ↓
  parsing estructurado
        ↓
   Qdrant (RAG)
        ↓
 Qwen2.5-7B (llama.cpp)
  └─ SOLO extrae entidades
  └─ genera JSON / matriz
        ↓
  numpy / scipy
  └─ ejecución determinista
  └─ Markov, simulaciones, etc.
```

> **Regla de oro:** El LLM **nunca** realiza cálculos aritméticos directos.
> Los números siempre pasan por numpy/scipy.

## 5. Docker Compose y Control de Recursos

```yaml
# Parámetros críticos para llama.cpp en Madre
num_thread: 3        # máximo 4, dejar 2 hilos libres para OS+Docker
num_ctx: 4096        # context seguro sin swap
temperature: 0.0     # determinista para extracción OSINT/JSON
```

- Usar **cgroups estrictos** por contenedor
- Preferir **bare-metal o Podman** sobre Docker para mínimo overhead
- Nunca levantar 14B con stack Docker completo activo

## 6. Ciberseguridad + LLM Local

No existen herramientas "todo-en-uno" maduras open-source. Mejor enfoque:

```
Scapy + tshark → llama-cpp-python → numpy/scipy
```

- LLM = **traductor semántico** (prompt + few-shot)
- Target: <5% hallucinations en extracción de probabilidades
- Cálculo real: siempre delegado al runtime nativo

## 7. Pipelines Matemáticos / Probabilísticos

> **Script puro (numpy/scipy) siempre gana** en latencia, precisión y coste.

| Tarea | Herramienta | Motivo |
|-------|-------------|--------|
| Cadenas de Markov | scipy + numpy | Determinista, rápido |
| Estadística | numpy/scipy | Sin alucinaciones |
| Semántica / extracción | LLM (Qwen2.5-7B) | Lo que hace bien |
| Cálculo / aritmética | NUNCA el LLM | Alucinaciones garantizadas |

## 8. Próximos pasos concretos

- [ ] Dockerfile llama.cpp server optimizado para Madre
- [ ] Prompt System + few-shot definitivo para THDORA
- [ ] docker-compose.yml revisado con cgroups
- [ ] Script base THDORA (tshark → Qwen → numpy)
- [ ] Evaluar LlamaStash como reemplazo de OpenWebUI
- [ ] Benchmarks reales: llama.cpp vs Ollama en i5-8400

---

## Conclusión

La filosofía **escéptica, minimalista y 100% open-source** es correcta y necesaria.

Con el stack recomendado (llama.cpp + LlamaStash + scripts puros + Qwen2.5-7B) Madre será:
- ✅ Estable bajo 16 GB RAM
- ✅ Totalmente soberana y open-source
- ✅ Responsive para THDORA
- ✅ Eficiente en OSINT, análisis y simulaciones Markov

Cualquier intento de usar frameworks modernos o modelos 14B+ en este hardware generará frustración y degradación del sistema.
