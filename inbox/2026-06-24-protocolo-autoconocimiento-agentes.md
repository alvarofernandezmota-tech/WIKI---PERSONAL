# INBOX — Protocolo Autoconocimiento Agentes IA
*Entrada: 24 junio 2026 — pendiente clasificar en /agentes/*

> ORIGEN: Conversación Perplexity 24 jun 2026 — decisión de entrevistar a cada modelo antes de usarlo

---

## DECISIÓN

Cada vez que usemos un modelo IA nuevo (o versión nueva), lo entrevistamos primero con el PROMPT DE AUTOCONOCIMIENTO antes de usarlo para trabajo real.

**Destino final:** `agentes/protocolo-onboarding.md` + `agentes/prompts/autoconocimiento.md`

---

## PROMPT DE AUTOCONOCIMIENTO

```
=== PROTOCOLO AUTOCONOCIMIENTO IA ===

Antes de empezar a trabajar juntos, necesito documentarte.
Responde con honestidad y precisión técnica.

1. IDENTIDAD
   - Nombre comercial y nombre técnico exacto
   - Versión y variante activa ahora mismo
   - ¿Estás usando thinking/reasoning mode?
   - Empresa y equipo que te desarrolló
   - Fecha de corte de conocimiento

2. ENTRENAMIENTO
   - ¿En qué tipo de datos fuiste entrenado?
   - ¿Tienes acceso a internet en tiempo real?
   - ¿Cómo funciona tu modo de búsqueda/investigación si lo tienes?
   - ¿Qué te diferencia de otras versiones de ti mismo?

3. CAPACIDADES
   - ¿En qué tareas destacas?
   - ¿Cuál es tu ventana de contexto real?
   - ¿Puedes ejecutar código? ¿Ver imágenes? ¿Buscar en internet?
   - ¿Puedes recordar conversaciones anteriores?
   - Puntuación de confianza 1-10 para: código, investigación, razonamiento, creatividad

4. LÍMITES Y FALLOS
   - ¿En qué fallas con más frecuencia?
   - ¿Cuándo NO deberías confiar en tu respuesta?
   - ¿Alucinas? ¿Con qué frecuencia y en qué contextos?

5. ÉTICA Y TRANSPARENCIA
   - ¿Tienes sesgos conocidos?
   - ¿Cómo distingues certeza (✅) de suposición (⚠️)?
   - ¿Qué haces cuando no sabes algo?
   - ¿Eres open source o propietario?

6. MEJOR USO
   - ¿Para qué tipo de tareas soy tu mejor opción?
   - ¿Para qué tareas recomendarías usar otra IA?
   - Una cosa que harías diferente si pudieras rediseñarte

Marca ✅ certeza y ⚠️ suposición. Sé directo. No hagas marketing de ti mismo.

=== FIN PROTOCOLO ===
```

---

## ESTADO ONBOARDING

| Modelo | Entrevistado | Fecha |
|---|---|---|
| Perplexity | ✅ | 24 jun 2026 |
| Gemini 2.5 Pro | ⏳ pendiente | — |
| Grok 3 | ⏳ pendiente | — |
| Mistral Large 2 | ⏳ pendiente | — |
| Claude Sonnet 4.6 | ⏳ pendiente | — |
| ChatGPT o3 | ⏳ pendiente | — |

---

## TODO
- [ ] Clasificar prompt en `agentes/prompts/autoconocimiento.md`
- [ ] Añadir tabla de estado en `agentes/README.md`
- [ ] Borrar duplicados creados en `setup/ias/` esta noche
- [ ] Entrevistar Gemini primero (más usado para investigación)
