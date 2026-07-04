---
tipo: bitacora-debate
fecha: 2026-06-24
hora: "07:03"
fuente: grok-3
status: documentado
tags: [perplexica, ollama, llama.cpp, fases, docker, open-source, grok]
priority: ALTA
nota-critica: "Grok sugiere modelos 3B como ideal ahora. Contrasta con tesis anterior que dice 7B es el techo practico. Ver nota al final."
---

# 🥊 BITÁCORA GROK — Perplexica + Estrategia de Fases

> Turno final del debate. Grok introduce Perplexica y ajusta la estrategia.

---

## Estrategia general

- **Eres novato** → prioridad: facilidad al principio
- Hardware limitado → modelos pequeños + control estricto de recursos
- Filosofía: 100% open-source, 0 euros
- **Empezar fácil con Ollama → migrar después a llama.cpp**

---

## Comparativa herramientas

| Herramienta | RAM | Facilidad | Personalizable | Recomendado |
|-------------|-----|-----------|----------------|-------------|
| Ollama | Medio-Alto | ✅ Muy Alta | Media | **Fase 1 (ahora)** |
| llama.cpp | Bajo | Media | ✅ Muy Alta | **Fase 2 (3-6 sem)** |
| Perplexica | Medio | Media | Media | Sí (con Ollama) |
| vLLM | Alto | Baja | Alta | ❌ Necesita GPU |

---

## Perplexica (novedad de este turno)

- Búsquedas inteligentes locales open-source
- Funciona con Ollama (fácil) y con llama.cpp (más eficiente)
- Usa SearxNG internamente para búsqueda web
- También conocido como **Vane** en su repo principal
- Imagen Docker: `itzcrazykns/perplexica:latest`
- 100% gratis, sin APIs externas

---

## Fases temporales (Grok)

| Fase | Cuándo | Stack |
|------|--------|-------|
| **Fase 1** | Ahora | Ollama + Perplexica + modelo 3B |
| **Fase 2** | 3-6 semanas | Migrar a llama.cpp server |
| **Futuro** | Nueva máquina 32GB+ | Modelos grandes (14B, 32B) allá, i5-8400 como servidor ligero |

---

## docker-compose.yml (Fase 1 — Ollama + Perplexica)

```yaml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    restart: unless-stopped
    ports: ["11434:11434"]
    volumes: ["./ollama_data:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=1
    deploy:
      resources:
        limits: { cpus: '3.0', memory: 6g }

  perplexica:
    image: itzcrazykns/perplexica:latest
    restart: unless-stopped
    ports: ["3000:8080"]
    environment:
      - CHAT_MODEL=qwen2.5:3b
      - CHAT_MODEL_PROVIDER=ollama
      - OLLAMA_HOST=http://ollama:11434
    depends_on:
      - ollama
    deploy:
      resources:
        limits: { cpus: '1.5', memory: 2g }
```

### Arrancar

```bash
docker compose up -d
docker exec -it ollama ollama pull qwen2.5:3b
# Abrir: http://localhost:3000
```

---

## Modelos sugeridos por Grok para Fase 1

- `qwen2.5:3b` — ideal para empezar
- `phi4:mini` — muy bueno en razonamiento
- `llama3.2:3b` — fallback

---

## ⚠️ NOTA CRÍTICA — Contraste con tesis anterior

Grok en este turno recomienda **3B como ideal ahora**.
La tesis anterior (turno 1) dice que el techo práctico es **7B-8B** y que 3B es solo para test/dev.

**¿Cuál es correcto?** Probablemente ambos según contexto:

| Caso | Modelo |
|------|--------|
| THDORA en producción (calidad respuesta) | 7B (Q5_K_M) |
| Perplexica / experimentación rápida | 3B |
| Stack muy cargado (fase 3 Docker activa) | 3B como fallback |
| Embeddings RAG (bge-m3) | pequeñísimo, siempre |

**Pendiente:** Benchmark real cuando qwen2.5:7b esté descargado.
Comparar calidad de respuesta 3B vs 7B en tareas reales de THDORA.

---

## Sobre Perplexica: ¿va en Madre?

**Pendiente decidir:**
- [ ] ¿Añadir Perplexica al stack de Madre?
- [ ] ¿En qué fase? (no está en el ROADMAP actual)
- [ ] Puerto 3000 ya ocupado por Grafana → habría que reasignar
- [ ] Ver si encaja con filosofía minimalista o es otro servicio más
