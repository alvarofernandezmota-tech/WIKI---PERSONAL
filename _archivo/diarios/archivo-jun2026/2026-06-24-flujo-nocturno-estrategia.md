---
tags: [estrategia, flujo, nocturno, modelfiles, especializacion, ram, ollama]
fecha: 2026-06-24
estado: pendiente-investigar
ruta-obsidian: inbox/2026-06-24-flujo-nocturno-estrategia.md
---

# Flujo nocturno — estrategia del ecosistema

> Idea clave surgida 24 jun 2026 05:41 CEST
> Investigación profunda encargada a Gemini — ver script adjunto

---

## La idea central

**Por la noche:** descargas, auditorías, documentación, commits, reorganización repos
**Por el día:** configurar, probar, construir — con todo ya listo y documentado

Ventajas:
- No perdemos tiempo del día ordenando
- Cada mañana arrancamos con contexto completo
- Los modelos pesados descargan sin interrumpir el trabajo
- Las IAs pueden auditar repos enteros mientras dormimos

---

## Problema identificado: RAM + modelos grandes

Madre es CPU-only. Los modelos 14B+ consumen:
- `qwen2.5:14b` — ~10GB RAM en inferencia
- `llama3.1:8b` — ~6GB RAM
- Tener 2 modelos cargados = RAM agotada

**Solución propuesta: Modelfiles especializados**

En lugar de un modelo grande general → varios modelos pequeños especializados:

```
qwen2.5:3b + Modelfile TOKI    → experto en responder al usuario (bot Telegram)
qwen2.5:3b + Modelfile CODIGO  → experto en Python/bash/Docker
qwen2.5:3b + Modelfile OSINT   → experto en análisis OSINT
qwen2.5:3b + Modelfile DIARIO  → experto en procesar notas personales
```

Beneficios:
- Mismo modelo base (3B) → carga rápida, poco RAM
- System prompt especializado → igual de eficiente en su tarea
- Podemos tener 3-4 "expertos" corriendo en paralelo
- No necesitamos GPU para esto

---

## Niveles de especialización (de menor a mayor coste)

### Nivel 1 — Modelfile (ya podemos hacerlo)
```
FROM qwen2.5:3b
SYSTEM "Eres TOKI, asistente personal de Álvaro..."
PARAMETER temperature 0.7
PARAMETER num_ctx 4096
```
Coste: 0. Solo un fichero de texto.

### Nivel 2 — RAG (local-brain ya lo tiene)
Inyectar documentos del repo como contexto.
Coste: Qdrant ya corriendo. Solo subir los docs.

### Nivel 3 — Fine-tuning LoRA (futuro)
Entrenar adaptadores sobre el modelo base con datos propios.
Coste: necesita GPU o tiempo en Colab/AI Studio.
Herramienta: `ai-toolkit` (ya tienes el repo).

### Nivel 4 — Entrenamiento completo (muy futuro)
Cambiar pesos del modelo. Necesita cluster o RTX 3090+.

---

## Plan de acción (basado en investigación Gemini)

- [ ] Investigación Gemini completa — ver `inbox/2026-06-24-investigacion-modelfiles-gemini.md`
- [ ] Crear `ollama/Modelfile.toki` — bot Telegram especializado
- [ ] Crear `ollama/Modelfile.codigo` — asistente Python/bash
- [ ] Crear `ollama/Modelfile.osint` — analista OSINT
- [ ] Subir docs ygg a Open WebUI RAG
- [ ] Probar inferencia con 2 modelos en paralelo en Madre
- [ ] Documentar consumo RAM real por modelo

---

_Generado: 24 jun 2026 05:41 CEST_
_Investigación encargada a Gemini — prompt en `inbox/2026-06-24-prompt-gemini-modelfiles.md`_
