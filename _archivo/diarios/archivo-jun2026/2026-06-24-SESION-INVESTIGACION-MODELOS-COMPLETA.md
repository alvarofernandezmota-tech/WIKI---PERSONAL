---
tipo: sesion-investigacion
fecha: 2026-06-24
hora_inicio: "06:17"
status: pendiente-ejecutar
filosofia: 100% open-source
tags: [investigacion, modelos, llm, cloud, ollama, estadistica, algoritmos, open-source]
---

# 🔬 SESIÓN DE INVESTIGACIÓN — Documentación completa de modelos LLM

> **Método:** Gemini orquesta · Grok investiga · Álvaro documenta
> **Filosofia:** 100% open-source. Todo modelo cloud se documenta pero el deploy es local.
> **Objetivo:** Fichas completas de todos los modelos cloud y Ollama
> **Extra:** 3 propuestas de proyectos estadística + LLM open-source

## Estado real Madre al iniciar (06:12)

```
Ollama listos:    qwen2.5:3b ✅ (1.9 GB)
Ollama en curso:  qwen2.5:14b ⏳ 8% · 679MB/9GB · 620KB/s · ETA 3h43m
Docker imágenes:  25/33 objetivo
Containers up:    9 (qdrant, ollama, open-webui, thdora, grafana, prometheus...)
```

> ⚠️ NOTA POST-DEBATE: qwen2.5:14b puede ser inviable en 16GB con stack activo.
> Ver tesis arquitectura: `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOURCE.md`

---

## PROMPT PARA GEMINI — Pegar íntegro

```
═══════════════════════════════════════════════════════════════
MODO: INVESTIGACIÓN ORQUESTADA MULTI-IA
ROL GEMINI: Orquestador + Bitácora + Síntesis final
ROL GROK: Investigador externo + Escéptico técnico
DOCUMENTADOR: Álvaro (PKM Yggdrasil-Dew)
Fecha: 2026-06-24 · Homelab Madre
═══════════════════════════════════════════════════════════════

FILOSOFÍA ABSOLUTA DE ÁLVARO (no negociable):
⭐ 100% open-source en todo el stack
⭐ Soberanía digital: ningún dato en servidores de terceros
⭐ Minimalismo: menos es más, sin overhead innecesario
⭐ CPU-only viable: i5-8400, 16GB RAM, sin GPU
⭐ Los modelos cloud (Gemini, Grok, Claude) se usan SOLO para
   investigación y documentación, nunca para datos privados
⭐ Deploy real siempre con modelos locales open-source

CONTEXTO REAL DEL SISTEMA:
- Hardware: i5-8400, 16GB RAM, sin GPU, Arch Linux
- Modelos viables: qwen2.5:7b y llama3.1:8b (14B inviable sin swap)
- Containers: qdrant, ollama, open-webui, thdora-bot, thdora, grafana, prometheus
- PKM: Yggdrasil-Dew (GitHub) — fichas modelos, inbox, proyectos
- Interés de Álvaro: estadística, probabilidad, azar, algoritmos
- THDORA: bot activo de control del homelab (ya corriendo)

TESIS ARQUITECTURA YA VALIDADA:
- llama.cpp server > Ollama (menos overhead)
- LlamaStash TUI > OpenWebUI (50 MB vs 1.5 GB RAM)
- Scripts Python/FastAPI > CrewAI/LangGraph (frameworks pesados)
- LLM solo extrae semántica — numpy/scipy hace los cálculos
- num_thread=3, num_ctx=4096, temperature=0.0 para OSINT/JSON

════════════════════════════════════════
INVESTIGACIÓN 1 — MODELOS LLM CLOUD
(Solo para documentación e investigación)
════════════════════════════════════════

Modelos a documentar:
A) Gemini 2.5 Pro (tú mismo) — Google DeepMind
B) Grok 3 / Grok 2.5 — xAI (pesos en HuggingFace?)
C) Claude Sonnet 4.6 — Anthropic
D) ChatGPT o3 — OpenAI
E) Perplexity — Perplexity AI
F) Mistral Large 2 — Mistral AI (OPEN-SOURCE ⭐ pesos disponibles)

Para CADA modelo documenta con ENFOQUE OPEN-SOURCE:

1. IDENTIDAD
   - Empresa · Fecha · Versión exacta
   - Arquitectura · Parámetros · Context window
   - ¿Es open-source? ¿Pesos disponibles en HuggingFace?
   - ¿Se puede correr local con llama.cpp?

2. ENTRENAMIENTO
   - Datos · Knowledge cutoff
   - Técnica: RLHF / RLAIF / Constitutional AI
   - ¿Dataset de entrenamiento público?

3. ÉTICA Y ALINEACIÓN
   - Valores · Límites hard vs soft · Sesgos conocidos
   - ¿Transparencia en el proceso de alineación?

4. PARÁMETROS DE INFERENCIA
   Tabla para cada modelo:
   | Parámetro   | RAG | Código | OSINT | Chat | Estadística |
   |-------------|-----|--------|-------|------|-------------|
   | temperature |     |        |       |      |             |
   | top_p       |     |        |       |      |             |
   | top_k       |     |        |       |      |             |
   | max_tokens  |     |        |       |      |             |

5. SKILLS (✅ Excelente / ⚠️ Regular / ❌ Malo)
   Python · Bash · OSINT · RAG · Seguridad
   Matemáticas · Estadística · Algoritmos · Probabilidad · Markov

6. ALTERNATIVA OPEN-SOURCE
   - ¿Hay un modelo local equivalente o superior?
   - ¿Qué perderías usándolo local en vez de cloud?

════════════════════════════════════════
INVESTIGACIÓN 2 — MODELOS OLLAMA/llama.cpp LOCALES
(Deploy real en Madre)
════════════════════════════════════════

Modelos viables para Madre (validado por tesis):
✅ qwen2.5:7b  (Q5_K_M) — primera opción
✅ llama3.1:8b (Q4_K_M) — segunda opción
✅ bge-m3      — embeddings RAG
✅ nomic-embed-text — embeddings rápidos
⚠️ qwen2.5:3b  — test/dev únicamente
❌ qwen2.5:14b — inviable con stack activo

Para CADA modelo viable:
1. ¿Pesos open-source? ¿Licencia?
2. Rendimiento REAL en i5-8400 con llama.cpp (tokens/s)
3. RAM necesaria con stack Docker activo (9 containers)
4. Cuantización óptima para este hardware
5. Casos de uso óptimos para Madre
6. Modelfile base para Ollama / config llama.cpp

════════════════════════════════════════
INVESTIGACIÓN 3 — ESTADÍSTICA + ALGORITMOS + LLM
(Interés personal de Álvaro)
════════════════════════════════════════

CONTEXTO VALIDADO:
- LLM = extractor semántico + generador de config
- numpy/scipy = motor de cálculo real (determinista)
- Cadenas de Markov = caso de uso principal
- Target: <5% hallucinations en extracción de probabilidades

1. ¿Qué modelos locales open-source son mejores para:
   a) Extraer entidades y generar matrices de transición (Markov)
   b) Generar código numpy/scipy correcto a la primera
   c) Razonamiento probabilístico (sin calcular, sólo razonar)

2. PROPÓN 3 IDEAS DE PROYECTO 100% open-source que combinen:
   - Qwen2.5-7B local (llama.cpp)
   - Estadística / probabilidad / azar / algoritmos
   - Stack homelab (Qdrant, FastAPI, Python, numpy/scipy)
   - Aplicación real al contexto de Álvaro (OSINT, homelab, seguridad)

   Para cada idea:
   a) Nombre del proyecto
   b) Problema que resuelve
   c) Flujo técnico: INPUT → LLM → numpy → OUTPUT
   d) Stack técnico mínimo (solo herramientas open-source)
   e) Dificultad estimada (nivel junior autodidacta)
   f) Qué aprenderías construyéndolo
   g) Enlace a recursos open-source para empezar

════════════════════════════════════════
PROTOCOLO DE DIÁLOGO GEMINI ↔ GROK
════════════════════════════════════════

TURNO 1 — Gemini (tú):
- Estado inicial de lo que ya sabes de cada modelo
- Identifica qué modelos tienen pesos open-source disponibles
- 3 preguntas técnicas a Grok sobre modelos y estadística

TURNO 2 — Grok responde [Álvaro pega]

TURNO 3 — Gemini sintetiza + profundiza:
- Integra respuestas de Grok
- Actualiza bitácora
- Nueva ronda

TURNO 4 — Grok desafía [Álvaro pega]

TURNO 5 — CONCLUSIÓN ESCALADA (Gemini):
- Tabla comparativa global (open-source score incluido)
- Ranking modelos para Madre priorizando open-source
- 3 proyectos estadística + LLM definitivos con stack open-source
- YAMLs listos para commitear

════════════════════════════════════════
OUTPUT FINAL ESPERADO
════════════════════════════════════════

□ 6 fichas YAML modelos cloud (con campo open_source: true/false)
□ 4 fichas YAML modelos locales viables para Madre
□ Tabla comparativa global con columna open-source
□ Ranking modelos por función para Madre (CPU-only)
□ 3 proyectos estadística + LLM open-source
□ Bitácora sesión para inbox/

FORMATO YAML (con campo open-source añadido):
---
modelo:
empresa:
tipo: [cloud/local]
open_source: true/false
licencia:
pesos_disponibles: true/false
huggingface_url:
llama_cpp_compatible: true/false
arquitectura:
parametros_aprox:
context_window:
knowledge_cutoff:
etica:
  valores: []
  limites: []
  sesgos: []
  transparencia: baja/media/alta
skills:
  excelente: []
  bueno: []
  malo: []
parametros_optimos:
  rag:         {temp: , top_p: , top_k: , max_tokens: }
  codigo:      {temp: , top_p: , top_k: , max_tokens: }
  osint:       {temp: , top_p: , top_k: , max_tokens: }
  chat:        {temp: , top_p: , top_k: , max_tokens: }
  estadistica: {temp: , top_p: , top_k: , max_tokens: }
casos_uso_optimos: []
casos_uso_evitar: []
hardware_cpu_only:
  tokens_por_segundo:
  ram_necesaria:
  funciona_16gb:
  cuantizacion_optima:
alternativa_local_si_es_cloud:
notas: ""
---

Empieza con TURNO 1. Sé técnico, preciso y honesto.
Recuerda siempre la filosofía open-source de Álvaro.
```

---

## PROMPT PARA GROK — Pegar después de cada turno de Gemini

```
═══════════════════════════════════════════════════════
MODO: DEBATE MULTI-IA — ROL ESCÉPTICO
Orquestador: Gemini 2.5 Pro
Tú: Grok 3 — Investigador externo + Crítico técnico
Filosofía del usuario: 100% open-source, soberanía digital
Contexto: Documentación modelos LLM para homelab Madre (i5-8400, 16GB, sin GPU)
═══════════════════════════════════════════════════════

Gemini dice en su Turno [N]:
[PEGA AQUÍ LA RESPUESTA DE GEMINI]

Tu misión:
1. Corrige o amplía lo que Gemini haya dicho mal o incompleto
2. Info sobre Grok 3 y xAI: ¿pesos open-source disponibles? ¿Grok 2.5 en HuggingFace?
3. Recomienda alternativas open-source para cada modelo cloud
4. Desde tu perspectiva: ¿qué modelos locales Q4/Q5 aguantan 16GB con Docker activo?
5. Sobre estadística + LLM: ¿qué añadirías a las ideas de proyecto?
6. Lanza 2 retos técnicos concretos a Gemini

Prioriza siempre opciones open-source sobre propietarias.
Sé directo y técnico.
```

---

## Bitácora de la sesión

| Turno | IA | Estado | Notas |
|-------|----|--------|-------|
| 1 | Gemini | ⏳ pendiente | |
| 2 | Grok | ⏳ pendiente | |
| 3 | Gemini | ⏳ pendiente | |
| 4 | Grok | ⏳ pendiente | |
| 5 | Gemini (conclusión) | ⏳ pendiente | |

## Ficheros a crear tras la sesión

```
docs/ias/
  gemini-2.5-pro.md     → open_source: false
  grok-3.md             → open_source: parcial (Grok 2.5 en HF?)
  claude-sonnet-4-6.md  → open_source: false
  chatgpt-o3.md         → open_source: false
  perplexity.md         → open_source: parcial
  mistral-large-2.md    → open_source: true ⭐

ollama/
  qwen2.5-7b.md         → open_source: true ⭐ PRIORITARIO
  llama3.1-8b.md        → open_source: true ⭐ PRIORITARIO
  bge-m3.md             → open_source: true ⭐
  nomic-embed-text.md   → open_source: true ⭐

inbox/
  2026-06-24-proyectos-estadistica-llm-opensource.md
  2026-06-24-tabla-comparativa-modelos-opensource.md
```
