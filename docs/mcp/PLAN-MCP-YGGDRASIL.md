# Plan MCP Yggdrasil — Servidor Propio para Perplexity y Gemini

> **Objetivo**: Crear un servidor MCP central que conecte Perplexity y Gemini a todas nuestras repos, documentación, ChromaDB y herramientas de infra, sin necesidad de usar `@GitHub` ni conectores manuales.

---

## ¿Por qué un servidor MCP propio?

El `@GitHub` que aparece en Perplexity es un conector externo que hay que invocar manualmente. Con un servidor MCP propio:

- Las IAs acceden **automáticamente** a nuestras herramientas sin escribir `@nada`
- Controlamos qué exponer: repos, ChromaDB, scripts, logs, hardware
- Funciona igual en **Perplexity y Gemini** con la misma configuración
- Soberanía total: los datos no salen de nuestra infra (expuesto vía Tailscale)
- Linux/Arch compatible: MCP remoto funciona en web sin depender de Comet

---

## Arquitectura objetivo

```
┌──────────────────────────────────────────┐
│         yggdrasil-mcp (FastMCP)          │
│   Expuesto via Tailscale HTTPS :8080     │
│                                          │
│  🔧 Herramientas disponibles:            │
│  - leer_repo     → GitHub API            │
│  - buscar_docs   → ChromaDB / RAG        │
│  - estado_nodos  → Docker API            │
│  - run_script    → scripts/ locales      │
│  - leer_archivo  → filesystem yggdrasil  │
└──────────────┬───────────────────────────┘
               │
        ┌──────┴──────┐
        ▼             ▼
   Perplexity      Gemini
  (Settings →   (mcp.json →
  Connectors)   httpUrl)
```

---

## Estado actual (02/07/2026)

| Componente | Estado |
|---|---|
| Docker activo en servidor | ✅ Confirmado |
| Tailscale APK descargado | ⚠️ Pendiente configurar |
| Ollama desplegado | 🔄 En progreso |
| Open WebUI + ChromaDB | ❌ Pendiente |
| yggdrasil-dew cargado en RAG | ❌ Pendiente (depende de ChromaDB) |
| Servidor MCP creado | ❌ Pendiente |
| Conectado a Perplexity | ❌ Pendiente |
| Conectado a Gemini | ❌ Pendiente |

---

## Fases de implementación

### Fase 0 — Prerrequisitos (esta semana)

- [ ] Configurar Tailscale en el servidor y verificar conectividad
- [ ] Levantar Open WebUI + ChromaDB con `docker compose` (ver `docker/`)
- [ ] Cargar yggdrasil-dew en ChromaDB como fuente RAG
- [ ] Verificar que Ollama responde en `http://localhost:11434`

### Fase 1 — Servidor MCP mínimo

- [ ] Crear `infra/mcp/server.py` con FastMCP
- [ ] Implementar herramienta `buscar_docs` (consulta ChromaDB)
- [ ] Implementar herramienta `leer_repo` (consulta GitHub API)
- [ ] Dockerizar: `infra/mcp/Dockerfile` + añadir al `docker-compose.yml`
- [ ] Exponer puerto 8080 en Tailscale

### Fase 2 — Conexión a IAs

- [ ] **Perplexity**: Settings → Connectors → Add custom remote connector → URL Tailscale → API key
- [ ] **Gemini AI Studio**: crear `mcp.json` con `httpUrl` del servidor
- [ ] Verificar que ambas IAs ven las herramientas sin `@` ni conectores manuales

### Fase 3 — Ampliar herramientas

- [ ] `estado_nodos` — estado Docker en nodos Madre y Acer
- [ ] `run_script` — ejecutar scripts de `scripts/` de forma controlada
- [ ] `leer_archivo` — acceso directo a cualquier fichero de la repo
- [ ] `osint_query` — integración con stack OSINT propio

---

## Estructura de ficheros a crear

```
infra/
└── mcp/
    ├── server.py          # Servidor FastMCP principal
    ├── tools/
    │   ├── github.py      # Herramientas de repos
    │   ├── chromadb.py    # Herramientas RAG/docs
    │   └── sistema.py     # Estado de nodos y scripts
    ├── Dockerfile
    └── requirements.txt
```

---

## Esqueleto del servidor (Python + FastMCP)

```python
# infra/mcp/server.py
from fastmcp import FastMCP
import os

mcp = FastMCP("yggdrasil-mcp")

@mcp.tool()
def buscar_docs(query: str) -> str:
    """Busca en la base de conocimiento RAG de yggdrasil-dew"""
    # Conecta a ChromaDB en localhost:8000
    ...

@mcp.tool()
def leer_repo(repo: str, path: str = "/") -> str:
    """Lee un archivo o directorio de cualquiera de nuestras repos de GitHub"""
    # Usa GITHUB_TOKEN de .env
    ...

@mcp.tool()
def estado_nodos() -> str:
    """Devuelve el estado de los contenedores Docker activos"""
    # Llama a Docker API local
    ...

if __name__ == "__main__":
    mcp.run(transport="streamable-http", host="0.0.0.0", port=8080)
```

---

## Cómo conectar a Perplexity

1. Ir a [perplexity.ai](https://perplexity.ai) → Settings → Connectors
2. Click en "Add custom remote connector"
3. Pegar la URL de Tailscale: `https://<nodo-tailscale>:8080/mcp`
4. Elegir autenticación por API key (definida en `.env`)
5. Resultado: Perplexity usa las herramientas automáticamente en cada conversación

## Cómo conectar a Gemini

1. En Google AI Studio → crear fichero `mcp.json`:
```json
{
  "mcpServers": {
    "yggdrasil": {
      "httpUrl": "https://<nodo-tailscale>:8080/mcp",
      "headers": {
        "Authorization": "Bearer <API_KEY>"
      }
    }
  }
}
```
2. Guardar y recargar AI Studio — Gemini verá las herramientas disponibles

---

## Notas de seguridad

- Nunca exponer el servidor MCP sin Tailscale o sin autenticación
- La API key va en `.env` (que está en `.gitignore`)
- Usar `.env.template` para documentar las variables necesarias sin valores reales
- Tailscale garantiza que solo dispositivos en nuestra red pueden alcanzar el servidor

---

## Pendientes de hoy (02/07/2026)

1. ✅ Decisión tomada: servidor MCP propio en lugar de depender de `@GitHub`
2. ✅ Arquitectura documentada en este fichero
3. ⏳ Configurar Tailscale en el servidor
4. ⏳ Levantar ChromaDB + Open WebUI
5. ⏳ Crear esqueleto `infra/mcp/server.py`
6. ⏳ Primera herramienta funcional: `buscar_docs`

---

*Documento creado automáticamente por sesión de trabajo 02/07/2026*
