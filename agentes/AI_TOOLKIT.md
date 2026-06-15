# AI Toolkit — Cómo usar cada IA con nuestras herramientas

> Última actualización: 2026-06-15

---

## Resumen rápido

| IA | Para qué | Limitación clave |
|---|---|---|
| **Claude via Perplexity** | Operar GitHub directo desde chat (MCP) | Sin memoria entre sesiones |
| **Claude Code** | Codificar bloques enteros en local | Necesita terminal abierta |
| **Gemini 1.5 Pro** | Documentación masiva (1M tokens) | No lee GitHub con URL directa |
| **Groq API** | NLP tiempo real en THDORA bot | No accede a herramientas externas |
| **ChatGPT** | Diseño, arquitectura, brainstorming | Sin acceso repo directo |
| **Ollama local** | Modelos offline, datos privados | Menos potente que cloud |

---

## Claude via Perplexity (MCP Tools)

**Qué puede hacer:**
- Leer archivos del repo con URLs raw automáticamente
- Crear/actualizar archivos directamente en GitHub (push_files)
- Crear issues, PRs, branches
- Listar commits, archivos, estado del repo
- Escribir diarios de sesión directamente en `.github/diarios/`

**Cómo usarlo:**
```
Chat normal → accede GitHub con MCP tools automáticamente
No hace falta abrir VS Code ni terminal
Ejemplo: "Crea CONTRIBUTING.md en thdora con este contenido"
```

**Limitación real:** No tiene memoria entre sesiones. Hay que darle contexto cada vez.

---

## Claude Code (Terminal local)

**Qué puede hacer:**
- Leer todos los archivos del proyecto local
- Implementar bloques enteros de código autónomamente
- Ejecutar bash, tests, linting
- Refactors grandes sin perder contexto

**Cómo usarlo:**
```bash
cd thdora
claude
# Prompt: "Implementa Block 3 FastAPI completo"
```

**Limitación real:** Solo local. Para subir al repo necesita git normal.

---

## Gemini 1.5 Pro

**Qué puede hacer:**
- 1M tokens de contexto → documentación masiva de una sola vez
- Importar repo entero manualmente y analizarlo
- Generar 8+ archivos de documentación en un prompt

**Cómo usarlo:**
```
1. gemini.google.com
2. Click "+" → Import repo (necesita Gemini Advanced $20/mes)
   ó pegar URLs raw manualmente
3. Pegar prompt largo con deliverables
4. Copiar output → subir con MCP o Claude Code
```

**Limitación real:** NO puede hacer push al repo automáticamente. Solo genera contenido en el chat.

---

## Groq API (en THDORA)

**Qué puede hacer:**
- NLP ultra-rápido (<1s) para el bot de Telegram
- Tool calling con JSON schemas (create_appointment, mark_habit_done)
- Integración directa Python

**Cómo usarlo:**
```python
# En thdora/src/ai/nlp.py
client = Groq()
response = client.chat.completions.create(
    model="llama-3.3-70b-versatile",
    messages=[...],
    tools=tools,
    tool_choice="auto",
    timeout=90
)
```

**Limitación real:** Solo para producción en código. No sirve para operar repos.

---

## Decision tree — ¿Qué IA usar?

```
¿Necesito tocar GitHub (crear archivos, issues, PRs)?
  └─ SÍ → Claude via Perplexity (MCP)
  └─ NO →
      ¿Necesito codificar mucho en local?
        └─ SÍ → Claude Code (terminal)
        └─ NO →
            ¿Es documentación larga de una sola vez?
              └─ SÍ → Gemini 1.5 Pro
              └─ NO →
                  ¿Es NLP en producción (bot)?
                    └─ SÍ → Groq API
                    └─ NO → Claude via Perplexity / ChatGPT
```
