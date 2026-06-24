---
tipo: sesion-investigacion
fecha: 2026-06-24
hora_inicio: "06:17"
status: pendiente-ejecutar
tags: [investigacion, modelos, llm, cloud, ollama, estadistica, algoritmos]
---

# 🔬 SESIÓN DE INVESTIGACIÓN — Documentación completa de modelos LLM

> **Método:** Gemini orquesta · Grok investiga · Álvaro documenta  
> **Objetivo:** Fichas completas de todos los modelos cloud y Ollama  
> **Extra:** 3 propuestas de proyectos estadística + LLM

## Estado real Madre al iniciar (06:12)

```
Ollama listos:    qwen2.5:3b ✅ (1.9 GB)
Ollama en curso:  qwen2.5:14b ⏳ 8% · 679MB/9GB · 620KB/s · ETA 3h43m
Docker imágenes:  25/33 objetivo
Containers up:    9 (qdrant, ollama, open-webui, thdora, grafana, prometheus...)
```

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

CONTEXTO REAL DEL SISTEMA:
- Hardware: i5-8400, 16GB RAM, sin GPU, Arch Linux
- Ollama: qwen2.5:3b ✅ · qwen2.5:7b⏳ · qwen2.5:14b⏳ · llama3.1:8b⏳ · mistral:7b⏳ · bge-m3⏳ · nomic-embed-text⏳
- Containers: qdrant, ollama, open-webui, thdora-bot, thdora, grafana, prometheus
- PKM: Yggdrasil-Dew (GitHub) — fichas modelos, inbox, proyectos
- Interés de Álvaro: estadística, probabilidad, azar, algoritmos

════════════════════════════════════════
INVESTIGACIÓN 1 — MODELOS LLM CLOUD
════════════════════════════════════════

Modelos a documentar:
A) Gemini 2.5 Pro (tú mismo)
B) Grok 3
C) Claude Sonnet 4.6
D) ChatGPT o3
E) Perplexity
F) Mistral Large 2

Para CADA modelo documenta:

1. IDENTIDAD
   - Empresa · Fecha · Versión exacta
   - Arquitectura · Parámetros · Context window

2. ENTRENAMIENTO
   - Datos · Knowledge cutoff
   - Técnica: RLHF / RLAIF / Constitutional AI
   - Fine-tuning de instrucciones

3. ÉTICA Y ALINEACIÓN
   - Valores programados · Quién los definió
   - Límites hard vs soft · Sesgos conocidos

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
   Matemáticas · Estadística · Algoritmos · Probabilidad
   Razonamiento · Resumen largo · Generación prompts

6. CASOS DE USO ÓPTIMOS vs EVITAR

7. API + LITELLM CONFIG

════════════════════════════════════════
INVESTIGACIÓN 2 — MODELOS OLLAMA LOCALES
════════════════════════════════════════

Para CADA modelo local (CPU-only, 16GB RAM):

1. Arquitectura · Cuantización · Empresa base
2. Rendimiento en Madre:
   - Tokens/segundo estimados
   - RAM necesaria · ¿Cabe con Docker stack activo?
3. Casos de uso óptimos para este hardware
4. Parámetros Ollama recomendados + Modelfile base
5. Skills y especialización del modelo

════════════════════════════════════════
INVESTIGACIÓN 3 — ESTADÍSTICA + ALGORITMOS + LLM
════════════════════════════════════════

1. ¿Qué modelos (cloud y local) son mejores para razonamiento estadístico?
2. ¿Puede un LLM local ayudar a implementar algoritmos probabilísticos?
3. PROPÓN 3 IDEAS DE PROYECTO que combinen:
   - Modelos Ollama locales (CPU-only)
   - Estadística / probabilidad / azar / algoritmos
   - Stack homelab (Qdrant, n8n, Python)
   
   Para cada idea:
   - Nombre del proyecto
   - Problema que resuelve
   - Modelo que usaría y por qué
   - Stack técnico mínimo
   - Dificultad estimada (nivel junior)
   - Qué aprenderías construyéndolo

════════════════════════════════════════
PROTOCOLO DE DIÁLOGO GEMINI ↔ GROK
════════════════════════════════════════

TURNO 1 — Gemini (tú):
- Estado inicial de lo que ya sabes
- 3 gaps de información clave
- 3 preguntas técnicas a Grok

TURNO 2 — Grok responde [Álvaro pega]

TURNO 3 — Gemini sintetiza:
- Integra respuestas de Grok
- Actualiza bitácora
- Nueva ronda de preguntas

TURNO 4 — Grok desafía [Álvaro pega]

TURNO 5 — CONCLUSIÓN ESCALADA (Gemini):
- Tabla comparativa global todos los modelos
- Ranking por caso de uso para hardware de Álvaro
- 3 proyectos estadística + LLM definitivos
- YAMLs listos para commitear

════════════════════════════════════════
OUTPUT FINAL ESPERADO
════════════════════════════════════════

□ 6 fichas YAML modelos cloud
□ 7 fichas YAML modelos Ollama
□ Tabla comparativa global
□ Ranking modelos por función para Madre
□ 3 propuestas proyectos estadística + LLM
□ Bitácora sesión para inbox/

FORMATO YAML POR MODELO:
---
modelo:
empresa:
tipo: [cloud/local]
arquitectura:
parametros_aprox:
context_window:
knowledge_cutoff:
entrenamiento:
etica:
  valores: []
  limites: []
  sesgos: []
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
api_endpoint:
litellm_config: |
notas: ""
---

Empieza con TURNO 1. Sé técnico, preciso y honesto.
```

---

## PROMPT PARA GROK — Pegar después de cada turno de Gemini

```
═══════════════════════════════════════════════════════
MODO: DEBATE MULTI-IA — ROL ESCÉPTICO
Orquestador: Gemini 2.5 Pro
Tú: Grok 3 — Investigador externo + Crítico técnico
Contexto: Documentación modelos LLM para homelab Madre
═══════════════════════════════════════════════════════

Gemini dice en su Turno [N]:
[PEGA AQUÍ LA RESPUESTA DE GEMINI]

Tu misión:
1. Corrige o amplía lo que Gemini haya dicho mal o incompleto
2. Añade información que él no tiene (especialmente sobre Grok 3 y xAI)
3. Desde tu perspectiva: ¿qué modelo recomendarías para cada caso en hardware sin GPU?
4. Sobre las ideas de proyectos con estadística: ¿añadirías o cambiarías algo?
5. Lanza 2 retos técnicos concretos a Gemini para el próximo turno

Sé directo. No repitas lo que Gemini ya dijo bien.
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
  gemini-2.5-pro.md
  grok-3.md
  claude-sonnet-4-6.md
  chatgpt-o3.md
  perplexity.md
  mistral-large-2.md

ollama/
  qwen2.5-14b.md
  llama3.1-8b.md
  mistral-7b.md
  bge-m3.md
  nomic-embed-text.md

inbox/
  2026-06-24-proyectos-estadistica-llm.md
  2026-06-24-tabla-comparativa-modelos.md
```
