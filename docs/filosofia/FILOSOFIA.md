---
tipo: filosofia-core
fecha_creacion: 2026-06-23
ultima_actualizacion: 2026-07-03
status: vigente
tags: [filosofia, open-source, soberania, principios, homelab]
---

# 🌳 Filosofía de Yggdrasil-Dew

> El árbol del conocimiento crece desde las raíces propias, no de nubes ajenas.

## Principios Absolutos (no negociables)

### 1. ⭐ 100% Open-Source
Todo software, modelo, herramienta o infraestructura debe ser open-source.
Si no hay alternativa open-source viable, se documenta el propietario pero
el deploy real siempre espera a que exista la alternativa libre.

### 2. ⭐ Soberanía Digital
Ningún dato privado sale del homelab.
Los modelos cloud (Gemini, Grok, Claude) se usan **únicamente** para:
- Investigación y documentación
- Generación de prompts y templates
- Debate técnico y aprendizaje
Nunca para procesar datos personales, del homelab o de proyectos reales.

### 3. ⭐ Minimalismo Soberano
Menos es más. Cada componente debe justificar su RAM, su CPU y su complejidad.
Si una herramienta ligera hace el 80% de lo que hace una pesada, gana la ligera.
- llama.cpp > Ollama (cuando hay overhead justificado)
- Script Python > Framework agencial
- CLI/TUI > WebUI cuando sea posible

### 4. ⭐ CPU-Only Viable
El homelab Madre (i5-8400, 16GB RAM, sin GPU) es una plataforma de producción real.
Todo diseño debe funcionar en este hardware sin degradar servicios activos.
- Modelos viables: 7B-8B (Q4_K_M o Q5_K_M)
- num_thread ≤ 4 · num_ctx ≤ 4096
- 14B+: solo si se libera RAM suficiente o cambia hardware

### 5. ⭐ Conocimiento desde Primera Mano
Documentar todo: cada decisión, cada error, cada aprendizaje.
Las IAs se entrevistan, se debaten y sus respuestas se archivan.
El conocimiento no se da por supuesto: se verifica, se prueba, se mide.

### 6. ⭐ Aprendizaje Continuo
Autodidacta activo. El homelab es un laboratorio de aprendizaje permanente.
Cada proyecto enseña algo concreto: Python, estadística, algoritmos, redes, seguridad.
El error es datos. El fracaso es documentación.

---

## Stack Preferido (por filosofía)

| Categoría | Elección Open-Source | Alternativa Propietaria (solo investigación) |
|-----------|----------------------|----------------------------------------------|
| LLM local | llama.cpp + Qwen2.5-7B / Llama3.1-8B | Gemini, GPT-4, Claude |
| UI local | LlamaStash (TUI) / CLI | OpenWebUI |
| Vector DB | Qdrant | Pinecone, Weaviate Cloud |
| Orquestación | FastAPI + scripts Python | CrewAI, LangChain, LangGraph |
| Estadística | numpy + scipy | - |
| Monitor | Prometheus + Grafana | Datadog, New Relic |
| Git | Gitea (self-hosted) | GitHub (solo PKM público) |
| DNS | Pihole | Cloudflare |
| VPN | Wireguard + Headscale | Tailscale (propietario) |
| Secretos | Vaultwarden + SOPS | 1Password, HashiCorp Cloud |
| CI/CD | Gitea Actions | GitHub Actions |
| OS | Arch Linux | - |

---

## Sobre las IAs Cloud

Gemini, Grok, Claude, ChatGPT y Perplexity son **herramientas de investigación**, no de producción.
Se usan para:
- Documentar modelos desde primera mano (autoentrevista)
- Debates técnicos multi-IA
- Generar prompts, templates y artefactos
- Investigar arquitecturas y comparar opciones

El conocimiento extraído se archiva en Yggdrasil-Dew y se aplica con herramientas open-source.

---

## Proyectos e Interés Personal

Álvaro tiene interés especial en:
- **Estadística y probabilidad**: cadenas de Markov, distribuciones, simulaciones
- **Algoritmos**: diseño, análisis de complejidad, implementación desde cero
- **OSINT**: herramientas open-source, análisis de redes, tshark, Scapy
- **Seguridad**: pentest, ciberseguridad defensiva y ofensiva
- **IA aplicada**: LLM como extractor semántico + cálculo nativo

El patrón ideal de proyecto:
```
Dato real (red/archivo/texto)
    ↓
 LLM local (extrae semántica, genera estructura)
    ↓
numpy/scipy (cálculo determinista)
    ↓
Resultado útil + documentación en PKM
```
