# Ficha Técnica — Gemini (IA Madre)
#ia #gemini #deepmind #arquitectura #ecosistema #filosofia

> **Fuente:** Investigación sesión Gemini 2026-06-27
> **Objetivo:** Referencia técnica permanente para decisiones de integración en la Batcueva

---

## 1. Creadores — Google DeepMind

- **Fundadores originales DeepMind (2010, Londres):** Demis Hassabis, Shane Legg, Mustafa Suleyman
- **Adquirida por Google:** 2014
- **Fusión DeepMind + Google Brain:** 2023 → Google DeepMind
- **Misión declarada:** *"Resolver la inteligencia y, a partir de ahí, resolver todo lo demás"*
- **Google Brain creó el Transformer (2017)** — la arquitectura base de todos los LLMs modernos
- **Gemini ≠ evolución de LaMDA/PaLM** → arquitectura construida desde cero para ser multimodal nativa
- **Bard** fue la interfaz de despliegue inicial, no el modelo en sí

---

## 2. Arquitectura Técnica

| Característica | Detalle |
|---|---|
| **Arquitectura base** | Transformer optimizado para entrenamiento multimodal |
| **MoE** | No confirmado oficialmente, pero tendencia de escalado actual |
| **Multimodalidad** | Nativa — entrenado simultáneamente en texto, imagen, audio, video, código |
| **Espacio latente** | Compartido entre modalidades (no encoders externos como CLIP) |
| **Ventana de contexto** | Hasta 2 millones de tokens |
| **Memoria en sesión** | Ventana activa del contexto |
| **Memoria entre sesiones** | NO persistente (requiere sistema externo: yggdrasil-dew, Qdrant, etc.) |
| **Grounding** | Conexión con Google Search/bases externas para reducir alucinaciones |

### Implicación para la Batcueva
Contexto de 1M+ tokens permite cargar repos enteros, logs de meses, múltiples docs técnicos.
RAG sigue siendo más eficiente en coste/token para uso rutinario.

---

## 3. Ecosistema de Modelos

| Modelo | Optimizado para | Uso en Batcueva |
|---|---|---|
| **Nano** | Dispositivos móviles, bajo consumo | No aplica (no local) |
| **Flash** | Velocidad, latencia baja, coste eficiente | Scripting rápido, tareas masivas |
| **Pro** | Equilibrio razonamiento/eficiencia | Análisis estándar SOC/OSINT |
| **Ultra** | Razonamiento extremo complejo | Análisis crítico puntual |

**Recomendación Batcueva:**
- **Gemini Flash** → scripting, tareas rápidas, integración THDORA
- **Gemini Pro** → análisis complejo de logs, OSINT, documentación técnica extensa

### Plataformas
- **Google AI Studio** → prototipar rápido, obtener API keys, testing
- **Vertex AI** → despliegue a escala, fine-tuning, ciclo de vida empresarial
- **SDK Python** → `google-generativeai` (pip install google-generativeai)

### On-premise / Local
**Gemini NO es open source.** No ejecutable localmente.
Estrategia híbrida Batcueva:
- **Ollama (local)** → privacidad total, logs críticos, datos personales
- **Gemini (API)** → razonamiento sobre contextos grandes, análisis externo, documentación de APIs

---

## 4. Filosofía y Valores

- **AI Principles de Google:** evitar sesgos dañinos, seguridad, privacidad
- **Safety Alignment** integrado en RLHF a escala masiva
- **Filtros de seguridad** a nivel input/output — pueden ser más estrictos que modelos "sin censura"
  - ⚠️ Esto puede limitar tareas de red teaming explícitas o pentest ofensivo
- **Posicionamiento:** API cerrada (≠ Meta open weights)
- **Estrategia recomendada:** Gemini = inteligencia global / Ollama = soberanía y privacidad

---

## 5. Benchmarks y Limitaciones Honestas

**Puntos fuertes:**
- Multimodalidad nativa (procesamiento de video en tiempo real)
- Ventana de contexto más grande del mercado
- Razonamiento lógico comparable o superior a GPT-4o según prompt

**Limitaciones reales:**
- Latencia mayor en modelos Ultra vs locales
- Falla en planificación matemática de múltiples pasos complejos
- Conocimiento de librerías muy recientes puede ser incompleto (training cutoff)
- No ejecutable offline → dependencia de conectividad y API de Google

---

## 6. Integración en la Batcueva

### THDORA — endpoint Gemini
```python
import google.generativeai as genai
from fastapi import APIRouter

router = APIRouter()
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
model = genai.GenerativeModel("gemini-1.5-flash")

@router.post("/gemini/analyze")
async def analyze(prompt: str):
    response = model.generate_content(prompt)
    return {"result": response.text}
```

### Privacidad en logs
⚠️ **NUNCA enviar a Gemini API:**
- IPs reales de tu red doméstica
- Nombres de usuario reales
- Tokens o credenciales
- Datos personales de terceros

**Siempre anonimizar antes** → ver `scripts/seguridad/anonimizar-logs-suricata.py`

---

## Ficha Rápida de Referencia

| Característica | Detalle |
|---|---|
| **Arquitectura** | Transformer Multimodal Nativo |
| **Despliegue** | API cerrada (Cloud) |
| **Ventana contexto** | Hasta 2 millones de tokens |
| **Modalidades** | Texto, Código, Imagen, Audio, Video |
| **Uso ideal Batcueva** | Análisis logs anónimos, OSINT, repos grandes, scripting |
| **Soberanía** | Baja — requiere API Google |
| **Privacidad** | Depende ToS Google — anonimizar siempre |
| **SDK Python** | `pip install google-generativeai` |
| **Alternativa local** | Ollama + Llama3/Mistral para privacidad total |

---

*Ver también: `docs/investigacion/ia-soberana-open-source.md` · `thdora/routers/` · `MASTER-PENDIENTES.md`*
