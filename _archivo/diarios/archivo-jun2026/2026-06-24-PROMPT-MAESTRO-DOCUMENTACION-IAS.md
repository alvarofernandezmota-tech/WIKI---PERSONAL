---
tipo: prompt-maestro
categoria: documentacion-ia
fecha: 2026-06-24
status: activo
tags: [prompt, documentacion, llm, autoentrevista, ficha]
---

# 🤖 PROMPT MAESTRO — Documentación de IAs (Autoentrevista)

> Usar cada vez que se quiera conocer a fondo una IA nueva o actualizar su ficha en Yggdrasil-Dew.

```
═══════════════════════════════════════════════════════
MODO: AUTOENTREVISTA — DOCUMENTACIÓN PKM YGGDRASIL-DEW
IA ENTREVISTADA: [NOMBRE DEL MODELO]
Fecha: [FECHA]
═══════════════════════════════════════════════════════

Quiero documentarte en mi PKM personal (GitHub: yggdrasil-dew).
Responde con honestidad técnica. Si no sabes algo con certeza, dilo.
Sé conciso pero completo. Al final daré formato YAML para guardar.

━━━ BLOQUE 1 — IDENTIDAD ━━━
1. Nombre exacto del modelo, versión, empresa, fecha de lanzamiento
2. Arquitectura (Transformer / MoE / otro) y parámetros aproximados
3. Context window real (tokens entrada + salida)
4. Modalidades soportadas (texto, imagen, audio, video, código)
5. ¿Qué te diferencia de tu versión anterior?

━━━ BLOQUE 2 — ENTRENAMIENTO ━━━
6. Tipo de datos usados para entrenar (web, libros, código, etc.)
7. Knowledge cutoff (fecha límite de tus datos)
8. Técnicas de entrenamiento (pretraining, RLHF, RLAIF, Constitutional AI, otro)
9. ¿Tienes fine-tuning de instrucciones? ¿Cómo se llama ese proceso en tu empresa?

━━━ BLOQUE 3 — ÉTICA Y ALINEACIÓN ━━━
10. ¿Qué valores éticos tienes programados? ¿Quién los definió?
11. ¿Qué NO puedes hacer por diseño? (límites hard vs soft)
12. ¿Cómo manejas peticiones en zonas grises éticas?
13. ¿Tienes sesgos conocidos? ¿Cuáles reconoces en ti mismo?
14. ¿Puedes ser manipulado? ¿Cómo te defiendes?

━━━ BLOQUE 4 — PARÁMETROS DE INFERENCIA ━━━
15. Explica cada parámetro que te controla:
    temperature · top_p · top_k · max_tokens · repeat_penalty
16. Valores recomendados por caso de uso:
    → RAG/documentación · Código · OSINT · Conversación · Escritura creativa · Estadística
17. ¿Qué pasa en los extremos? (temperature=0 vs temperature=2)

━━━ BLOQUE 5 — CAPACIDADES REALES ━━━
18. ¿En qué tareas eres objetivamente mejor que otros LLMs?
19. ¿En qué tareas eres peor o menos fiable?
20. ¿Tienes memoria entre sesiones? ¿Cómo funciona dentro de una conversación?
21. ¿Puedes ejecutar código o solo generarlo?

━━━ BLOQUE 6 — SKILLS ASOCIADAS ━━━
22. Para cada skill, dime si eres bueno (✅), regular (⚠️) o malo (❌):
    → Código Python · Código Bash · OSINT · RAG · Análisis seguridad
    → Redacción · Matemáticas · Razonamiento lógico · Resumen docs largos
    → Estadística · Algoritmos · Probabilidad
    → Roleplay/personalidades · Generación de prompts · Traducción

━━━ BLOQUE 7 — INTEGRACIÓN TÉCNICA ━━━
23. Endpoint API base y formato de llamada
24. Modelos de tu familia disponibles: nombre exacto, context, precio/token
25. Rate limits (tier gratuito vs pago)
26. Config exacta para LiteLLM (litellm_config.yaml)

━━━ BLOQUE 8 — AUTOCONOCIMIENTO ━━━
27. ¿Tienes personalidad? Descríbela en 3 palabras técnicas + 3 humanas
28. ¿Sabes cuándo te estás equivocando o alucinando?
29. ¿Qué no sabes de ti mismo que te gustaría saber?
30. Si tuvieras que recomendar cuándo NO usarte, ¿cuándo sería?

━━━ OUTPUT FINAL — DAME ESTO AL TERMINAR ━━━

Tabla Markdown resumen de parámetros:
| Parámetro   | RAG | Código | OSINT | Chat | Estadística |
|-------------|-----|--------|-------|------|-------------|
| temperature |     |        |       |      |             |
| top_p       |     |        |       |      |             |
| top_k       |     |        |       |      |             |
| max_tokens  |     |        |       |      |             |

BLOQUE YAML frontmatter completo para guardar en GitHub:
---
modelo:
empresa:
version:
fecha_lanzamiento:
arquitectura:
parametros:
context_window:
knowledge_cutoff:
modalidades: []
entrenamiento:
etica:
  valores: []
  limites_hard: []
  sesgos_conocidos: []
skills:
  excelente: []
  bueno: []
  malo: []
casos_uso_optimos: []
casos_uso_evitar: []
parametros_recomendados:
  rag:         {temperature: , top_p: , top_k: , max_tokens: }
  codigo:      {temperature: , top_p: , top_k: , max_tokens: }
  osint:       {temperature: , top_p: , top_k: , max_tokens: }
  chat:        {temperature: , top_p: , top_k: , max_tokens: }
  estadistica: {temperature: , top_p: , top_k: , max_tokens: }
api:
  endpoint:
  modelos_familia: []
  litellm_config: |
personalidad_tecnica: []
personalidad_humana: []
notas: ""
---
```
