# Herramientas Swarm Intelligence — Investigación Profunda

> Documentado: 2026-07-03 04:45 CEST
> Contexto: ecosistema 100% local, GTX 1060 6GB, filosofia privacidad total

---

## 1. Motores de Inferencia y Enrutamiento

### Tabby — Copilot Local
- **Repo:** https://github.com/TabbyML/tabby
- **Caso de uso Yggdrasil:** Autocompletado de código en background sin consumir la VRAM de los agentes
- **Modelos recomendados:** Qwen2.5-Coder:3B Q4_K_M, DeepSeek-Coder:1.3B
- **Puerto:** 8080 (añadir a docker-compose.yml de Madre)
- **Integración:** Plugin Neovim/Helix en Theodora via Tailscale → 100.91.112.32:8080

### RouteLLM — Router Inteligente de Prompts
- **Repo:** https://github.com/lm-sys/routellm
- **Caso de uso Yggdrasil:** El "peaje" entre el input y Ollama
  - Tarea simple → modelo 3B local (rápido, 0 VRAM extra)
  - Tarea compleja → modelo 7B en Ollama
  - Sustituye el router_llm.json estático por enrutamiento dinámico
- **Integración con Auditor:** el Auditor podría escribir umbrales en el config de RouteLLM

---

## 2. Frameworks de Orquestación Multi-Agente

### LangGraph — Grafos Cíclicos para Bucles
- **Repo:** https://github.com/langchain-ai/langgraph
- **Ventaja clave:** Permite **ciclos** (otros frameworks son lineales)
- **Aplicación directa:**
  ```
  Explorador → Sysadmin → Tester → Auditor
                    ↑                    ↓ (fallo)
                    └──── retry con Q5_K_M ────┘
  ```
- **Migrar desde:** `core/lab/laboratorio_agentes.py` (refactor como grafo)

### CrewAI — Roles YAML Legibles
- **Repo:** https://github.com/crewAIInc/crewAI
- **Ventaja:** Define agentes como roles (como un equipo real)
- **Archivo destino:** `core/crew/crew_config.yaml`
- **Plantilla:**
  ```yaml
  agents:
    - name: Explorador
      role: Model Scout
      goal: Encuentra modelos ≤8B compatibles con GTX 1060
      tools: [huggingface_search, hardware_filter]
    - name: Auditor
      role: Production Judge
      goal: Valida benchmarks y actualiza router_llm.json
  ```

---

## 3. Second Brain + Automatización

### Khoj — IA sobre Obsidian 100% Local
- **Repo:** https://github.com/khoj-ai/khoj
- **Caso de uso CRITICO:** Reemplaza FTS5 básico por **búsqueda semántica vectorial**
  - FTS5 encuentra "Tailscale" si está escrito
  - Khoj entiende "red segura privada" y conecta con notas de Tailscale
- **Deploy:** `docker run -p 42110:42110 ghcr.io/khoj-ai/khoj:latest`
- **Integración:** Plugin Obsidian + API local para agentes
- **Datos:** 100% en disco local, cero llamadas externas

### n8n Self-Hosted — Orquestador Visual
- **Repo:** https://github.com/n8n-io/n8n
- **Caso de uso:** Trigger visual para la colmena
  - Nota nueva en `inbox/` → dispara `laboratorio_agentes.py`
  - Mensaje Telegram privado → ejecuta script en Madre
  - Reporte Auditor → issue GitHub automático
- **Puerto:** 5678
- **Nodo MCP nativo disponible** (conecta directamente con tus servidores MCP)

---

## 4. Servidores MCP Comunitarios Clave

| Servidor MCP | Función | Prioridad |
|---|---|---|
| `mcp-server-sqlite` | Agentes leen/escriben bitacoras.db | ALTA |
| `mcp-server-git` | IA hace commits y ramas autónomamente | ALTA |
| `mcp-server-filesystem` | Agentes navegan ~/yggdrasil-dew | ALTA |
| `mcp-server-obsidian` | Acceso directo al vault .md | MEDIA |
| `mcp-server-docker` | Sysadmin controla contenedores | MEDIA |

---

## 5. Arquitectura Militar Aplicada al Homelab

### Principio: Sin nube, sin internet, sin fallo total

Los enjambres militares operan en condiciones donde la red cae.
Tu homelab: Tailscale puede caer. Madre puede reiniciarse.
Solución: **cada agente debe poder operar en modo degradado**.

### RudraX / CLI-First Agents
- Agentes que viven en terminal, con repo-awareness total
- Leen fallos de compilación, iteran solos
- Sin interfaz web = menos superficie de ataque = más privacidad

---

## 6. Quality Gates — Las 3 Contramedidas Críticas

### 6.1 Filtros de Validación Inter-Agente
```python
from pydantic import BaseModel, validator

class ModeloCandidato(BaseModel):
    name: str
    params: float
    quant: str

    @validator('params')
    def check_vram(cls, v):
        if v > 8.0:
            raise ValueError(f'Modelo {v}B excede VRAM GTX 1060')
        return v

    @validator('quant')
    def check_quant(cls, v):
        validas = ['q4_K_M', 'q5_K_M', 'q4_0']
        if v not in validas:
            raise ValueError(f'Cuantización {v} no validada')
        return v
```
Cada dato que pase entre agentes atraviesa este validador. Si falla, se loguea y se descarta. No se propaga.

### 6.2 Circuit Breaker — Anti-Bucle Infinito
```python
MAX_ITERATIONS = 5
MAX_RETRIES_PER_MODEL = 3

class CircuitBreaker:
    def __init__(self, max_iter=MAX_ITERATIONS):
        self.count = 0
        self.max = max_iter

    def tick(self, label=''):
        self.count += 1
        if self.count >= self.max:
            raise RuntimeError(f'Circuit breaker activado en: {label} ({self.count} iter)')
```

### 6.3 Compresor de Contexto (Anti-VRAM overflow)
```python
def comprimir_contexto(historial: list, max_tokens=1500) -> str:
    """
    Cada 10 minutos o cuando el historial supera max_tokens,
    resume el estado de la misión para liberar VRAM.
    """
    if sum(len(m) for m in historial) < max_tokens:
        return "\n".join(historial)
    # Llamar a modelo pequeño local para resumir
    resumen_prompt = "Resume en 3 puntos el estado actual: " + "\n".join(historial[-5:])
    return resumen_prompt  # TODO: llamar a Ollama con modelo 3B
```

---

## Roadmap de Integración Recomendado

```
Semana 1 (cuando despiertes)
  └─ Khoj en Docker → indexar vault Obsidian
  └─ n8n en Docker → workflow: inbox trigger → laboratorio_agentes.py
  └─ Quality gates (Pydantic) en laboratorio_agentes.py

Semana 2
  └─ Refactor laboratorio_agentes.py → LangGraph (ciclos)
  └─ Tabby en Docker → autocompletado en Theodora
  └─ mcp-server-git + mcp-server-sqlite

Semana 3
  └─ RouteLLM como capa de enrutamiento
  └─ CrewAI config YAML para los 4 agentes
  └─ Circuit breakers en todos los bucles
```

_Perplexity MCP — 03-jul-2026 04:45 CEST_
