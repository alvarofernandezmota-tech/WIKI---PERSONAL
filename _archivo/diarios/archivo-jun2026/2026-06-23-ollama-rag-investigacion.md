---
tags: [inbox, ollama, rag, investigacion, chromadb, bm25, embeddings, llm-local]
fecha: 2026-06-23
estado: pendiente-migrar
destino: ollama/
fuentes: [claude-sonnet-4.6, gemini-2.5-pro]
relacionado-anterior: [[inbox/2026-06-23-tools-pendientes]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-ollama-rag-investigacion.md
---

# Investigación RAG Ollama — Síntesis Claude + Gemini

> Hardware: GTX 1060 6GB · Arch Linux · ~500 notas .md
> Investigado con Claude Sonnet 4.6 y Gemini 2.5 Pro simultáneamente.

---

## 1. LLM — llama3.2:3b → qwen2.5:3b

**Claude y Gemini coinciden al 100%: cambiar a qwen2.5:3b.**

| Modelo | VRAM Q4 | Velocidad | Español | RAG |
|---|---|---|---|---|
| llama3.2:3b (actual) | ~2.0 GB | ~30 tok/s | ❌ Malo | Suficiente |
| **qwen2.5:3b** (recomendado) | ~2.0 GB | ~30 tok/s | ✅ Bueno | Mejor |
| gemma3:4b | ~3.0 GB | ~22 tok/s | ✅ Bueno | Bueno |
| phi4-mini:3.8b | ~2.5 GB | ~25 tok/s | Medio | Bueno |

**Acción:**
```bash
ollama pull qwen2.5:3b
# Actualizar LLM_MODEL=qwen2.5:3b en .env
```

---

## 2. Embeddings — nomic-embed-text vs bge-m3

**Claude y Gemini DIFIEREN aquí:**

| | Claude | Gemini |
|---|---|---|
| Recomendación | **bge-m3** | **Quedarse con nomic** |
| Razón | Mejor multilingüe, híbrido nativo | bge-m3 consume +1.2GB VRAM extra |

**Síntesis:** Gemini tiene razón en el trade-off de VRAM.
- GTX 1060 6GB con qwen2.5:3b (~2GB) + bge-m3 (~570MB) = ~2.6GB → cabe bien
- Si notas que la búsqueda falla en español → migrar a bge-m3
- **Decisión: nomic-embed-text:v1.5 primero (upgrade seguro), bge-m3 si hace falta**

```bash
ollama pull nomic-embed-text  # ya lo tienes
# Si falla en español:
ollama pull bge-m3
```

---

## 3. ChromaDB — quedarse

**Claude: quedarse. Gemini: migrar a LanceDB.**

- A 500 notas / ~2000 chunks → ChromaDB no tiene problema
- LanceDB sería mejor a largo plazo (Rust, más ligero, Arrow)
- **Decisión: ChromaDB ahora, evaluar LanceDB cuando escale**

---

## 4. Chunking — CAMBIO IMPORTANTE

**Claude y Gemini coinciden: 1200 chars es demasiado grande.**

### Estrategia correcta

```python
import re
import yaml

def parse_frontmatter(content: str):
    """Extrae frontmatter como metadata, no lo mete en el chunk."""
    fm_match = re.match(r'^---\n(.*?)\n---\n', content, re.DOTALL)
    metadata = {}
    if fm_match:
        metadata = yaml.safe_load(fm_match.group(1))
        content = content[fm_match.end():]
    return content, metadata

def chunk_markdown_v2(content: str, filename: str, metadata: dict,
                      max_chars: int = 500, overlap: int = 100) -> list:
    """Split por headers primero, luego por párrafo si > max_chars."""
    # 1. Split por headers H1/H2/H3
    sections = re.split(r'\n(#{1,3} .+)\n', content)
    chunks = []
    current = ""
    for section in sections:
        if len(current) + len(section) < max_chars:
            current += section + "\n"
        else:
            if current.strip():
                # Inyectar contexto de metadata en el chunk
                prefix = f"Nota: {filename} | Tags: {metadata.get('tags', [])}"
                chunks.append(f"{prefix}\n{current.strip()}")
            current = section + "\n"
    if current.strip():
        prefix = f"Nota: {filename} | Tags: {metadata.get('tags', [])}"
        chunks.append(f"{prefix}\n{current.strip()}")
    return chunks
```

**Cambios clave:**
- Chunk size: 1200 → **400-600 chars**
- Overlap: 0 → **100-150 chars**
- Frontmatter: dentro del chunk → **metadata de ChromaDB**
- Split: párrafo → **header primero, párrafo si es largo**

---

## 5. BM25 — Persistencia con pickle

**Claude identifica bug crítico: BM25 no persiste entre reinicios.**

```python
import pickle, os

INDEX_PATH = "./bm25_index.pkl"

def load_or_build_bm25(corpus: list):
    if os.path.exists(INDEX_PATH):
        with open(INDEX_PATH, "rb") as f:
            return pickle.load(f)
    bm25 = BM25Okapi([doc.lower().split() for doc in corpus])
    with open(INDEX_PATH, "wb") as f:
        pickle.dump(bm25, f)
    return bm25
```

**Además: usar RRF para fusión de scores** (ambos coinciden)

```python
def reciprocal_rank_fusion(vec_results: list, bm25_results: list, k: int = 60):
    """RRF — fusiona rankings de vector search y BM25 correctamente."""
    scores = {}
    for rank, doc in enumerate(vec_results):
        scores[doc] = scores.get(doc, 0) + 1 / (k + rank + 1)
    for rank, doc in enumerate(bm25_results):
        scores[doc] = scores.get(doc, 0) + 1 / (k + rank + 1)
    return sorted(scores.keys(), key=lambda d: scores[d], reverse=True)
```

---

## 6. LLM Potente (modo conectado)

**Claude recomienda Groq API. Gemini recomienda qwen2.5:14b con offloading.**

| Opción | Velocidad | Calidad | Coste | Red |
|---|---|---|---|---|
| qwen2.5:7b local | ~5 tok/s (offload) | ⭐⭐⭐⭐ | Gratis | ❌ |
| Groq llama-3.3-70b | ~300 tok/s | ⭐⭐⭐⭐⭐ | Free tier | ✅ |
| claude-sonnet-4.6 | ~100 tok/s | ⭐⭐⭐⭐⭐ | API key | ✅ |

**Decisión: Groq API como modo potente con conexión (ya tienes key en thdora)**

---

## Resumen de cambios al main.py por prioridad

| Cambio | Impacto | Urgencia |
|---|---|---|
| llama3.2:3b → qwen2.5:3b | Alto — mejor español | ✅ Ahora |
| Chunking 1200 → 400-600 chars | Alto — mejor recuperación | ✅ Ahora |
| Frontmatter a metadata ChromaDB | Alto — menos ruido | ✅ Ahora |
| BM25 pickle persistencia | Medio — arranque más rápido | ✅ Ahora |
| RRF en lugar de extend() | Medio — mejor fusión | ✅ Ahora |
| nomic → bge-m3 | Bajo-medio — evaluar | ⏳ Después |
| ChromaDB → LanceDB | Bajo — escala futura | ⏳ Futuro |

---

## Pendiente

- [ ] Actualizar main.py con todos estos cambios
- [ ] Actualizar deploy_brain.sh con qwen2.5:3b
- [ ] Testear cuando Ollama termine de descargar
- [ ] Migrar esta nota a `ollama/rag-investigacion.md`
