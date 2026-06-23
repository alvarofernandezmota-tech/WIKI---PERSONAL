# LangChain + Ollama Local — Optimización Real
**Fecha:** 2026-06-24  
**Fuente:** LinkedIn threading tips, GitHub discussions, sitepoint LLMs 2026  
**Objetivo:** Máximo rendimiento en i5-8400 sin GPU

---

## El problema principal

Por defecto LangChain + Ollama usa **1 thread y 1 contexto**. Con un i5-8400 de 6 cores, estás desperdiciando el 83% de tu CPU.

---

## Variables de entorno Ollama (systemd)

```bash
sudo systemctl edit ollama.service
```

```ini
[Service]
Environment="OLLAMA_NUM_PARALLEL=3"
Environment="OLLAMA_MAX_LOADED_MODELS=2"
Environment="OLLAMA_KEEP_ALIVE=-1"
Environment="OLLAMA_NUM_THREAD=6"
```

```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

---

## LangChain — configuración óptima CPU

```python
from langchain_community.llms import Ollama
from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler

llm = Ollama(
    model="qwen2.5:3b",
    num_thread=6,          # todos los cores del i5-8400
    num_ctx=2048,           # contexto reducido = más rápido
    num_predict=512,        # limitar respuesta máxima
    temperature=0.7,
    keep_alive=-1,          # modelo siempre en memoria
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
)
```

---

## Threading para procesar documentos (RAG masivo)

```python
from concurrent.futures import ThreadPoolExecutor
from langchain_community.llms import Ollama

def procesar_doc(doc):
    # Cada thread crea su propia instancia
    llm = Ollama(model="qwen2.5:3b", num_thread=2)
    return llm.invoke(f"Resume esto: {doc}")

documentos = [...]  # lista de textos

# 3 workers paralelos (6 cores / 2 threads cada uno)
with ThreadPoolExecutor(max_workers=3) as executor:
    resultados = list(executor.map(procesar_doc, documentos))
```

**Resultado real**: 100 docs en 50min → 8min

---

## Pipeline RAG completo optimizado

```python
from langchain_community.llms import Ollama
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.vectorstores import Qdrant
from langchain.chains import RetrievalQA
from langchain.text_splitter import RecursiveCharacterTextSplitter

# Embeddings con bge-m3 (mejor modelo embedding local)
embeddings = OllamaEmbeddings(
    model="bge-m3",
    num_thread=6
)

# Vector store Qdrant (ya tenemos en Docker)
qdrant = Qdrant.from_existing_collection(
    embeddings=embeddings,
    url="http://localhost:6333",
    collection_name="cerebro"
)

# LLM optimizado
llm = Ollama(
    model="qwen2.5:7b",
    num_thread=6,
    num_ctx=4096,
    keep_alive=-1
)

# Chain RAG
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=qdrant.as_retriever(search_kwargs={"k": 5}),
    return_source_documents=True
)

# Usar
respuesta = qa_chain.invoke({"query": "¿Qué proyectos tengo activos?"})
print(respuesta["result"])
```

---

## Modelos recomendados por tarea (CPU only)

| Tarea | Modelo | RAM | Velocidad |
|---|---|---|---|
| Chat rápido | qwen2.5:3b | 3GB | ~20 t/s |
| RAG / análisis | qwen2.5:7b | 6GB | ~10 t/s |
| Código | qwen2.5-coder:7b | 6GB | ~10 t/s |
| Embeddings | bge-m3 | 1.5GB | rápido |
| Agente complejo | llama3.2:3b | 3GB | ~18 t/s |

---

## Agente LangChain con herramientas

```python
from langchain.agents import AgentType, initialize_agent
from langchain.tools import Tool
from langchain_community.llms import Ollama

llm = Ollama(model="qwen2.5:7b", num_thread=6, keep_alive=-1)

# Herramientas del agente
tools = [
    Tool(
        name="BuscarCerebro",
        func=qa_chain.run,
        description="Busca en el cerebro/vault personal"
    ),
    Tool(
        name="EjecutarComando",
        func=lambda cmd: __import__('subprocess').getoutput(cmd),
        description="Ejecuta comandos del sistema (SOLO comandos seguros)"
    )
]

agente = initialize_agent(
    tools=tools,
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    max_iterations=5
)

agente.run("¿Cuáles son mis tareas pendientes en el cerebro?")
```

---

## Estructura proyecto Python recomendada

```
batcueva-ai/
├── agents/
│   ├── erika.py          # agente Erika con memoria
│   └── toki.py           # agente TOKI telegram
├── rag/
│   ├── ingest.py         # ingestar vault Obsidian
│   └── query.py          # consultar RAG
├── tools/
│   └── system_tools.py   # herramientas sistema
├── config.py             # OLLAMA_URL, QDRANT_URL, modelos
└── main.py
```

---

## Próximos pasos

- [ ] Crear `batcueva-ai/` en Gitea local
- [ ] Script de ingesta del vault Obsidian → Qdrant
- [ ] Agente Erika con herramientas + memoria Qdrant
- [ ] API FastAPI para exponer agentes via n8n
