# Google Colab + AI Studio — Laboratorio cloud

> Última actualización: 13 junio 2026
> Complemento a Ollama local — para lo que la GTX 1060 no aguante

---

## Regla de uso

> **Ollama local primero.** Colab y AI Studio para experimentos que necesiten
> más GPU, datasets grandes o APIs que no existen en local.

---

## Google Colab

| Aspecto | Detalle |
|---|---|
| URL | [colab.research.google.com](https://colab.research.google.com) |
| GPU gratuita | T4 (16GB VRAM) — mucho más que GTX 1060 |
| Uso principal | Experimentar modelos, fine-tuning, datasets |
| Integración | Conectar a Google Drive, clonar repos GitHub |

```python
# Clonar personal-v2 en Colab
!git clone https://github.com/alvarofernandezmota-tech/personal-v2.git
%cd personal-v2
```

---

## Google AI Studio (Gemini API)

| Aspecto | Detalle |
|---|---|
| URL | [aistudio.google.com](https://aistudio.google.com) |
| Uso principal | Prototipar con Gemini, embeddings, multimodal |
| API key | Gratis hasta límite generoso |
| Integración THDORA | Añadir como backend alternativo a Ollama |

```python
# Usar Gemini API en THDORA
import google.generativeai as genai

genai.configure(api_key="TU_API_KEY")
model = genai.GenerativeModel('gemini-1.5-flash')
response = model.generate_content("Hola")
```

---

## Cuándo usar cada uno

| Escenario | Herramienta |
|---|---|
| Chat diario, tareas ligeras | Ollama local (llama3.2:3b) |
| Código complejo | Ollama local (codellama:7b) |
| Modelo > 6GB VRAM | Google Colab |
| Multimodal (imagen+texto) | AI Studio (Gemini) |
| Fine-tuning propio | Google Colab |
| THDORA en producción cloud | AI Studio API |

---

_Ver también: [ollama.md](ollama.md)_
_Volver al índice: [README.md](README.md)_
