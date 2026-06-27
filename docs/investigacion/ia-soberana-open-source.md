# Arquitectura de IA Soberana y Open Source — Batcueva
#ia #llm #rag #ollama #open-webui #crewai #arquitectura

---

## 1. Análisis: IA gubernamental vs. open source

| Componente | Función gubernamental | Equivalente open source |
|---|---|---|
| Modelo de Lenguaje (LLM) | Razonamiento, extracción de entidades | **Ollama** (llama3, phi3, mistral...) |
| Base de Datos Vectorial | Memoria largo plazo, indexado de logs/docs | **Qdrant** / ChromaDB |
| Framework Multi-Agente | Flujos complejos, orquestación | **CrewAI** / LangChain |
| Infraestructura ETL | Normalización datos (PDFs, logs, capturas de red) | **n8n** / scripts Python |

---

## 2. Arquitectura Batcueva — capas

### Capa de Cómputo — Motor IA
**Ollama** corre los modelos localmente y expone una API local en `http://localhost:11434`.  
Permite que THDORA, Open WebUI y scripts Python se conecten sin latencia externa.

### Capa de Conocimiento — RAG
**Open WebUI + Qdrant** → cargar archivos, repos Git y documentos para consultas RAG.  
Todo almacenado en Qdrant local; ningún dato sale de los nodos.

### Capa de Automatización — Agentes
**CrewAI** → definir roles ("Analista de Red", "Redactor de Informes") y orquestar tareas  
que combinen herramientas OSINT locales con razonamiento del LLM.

### Capa de Conectividad y Seguridad
**Tailscale + Docker** → VPN malla WireGuard privada. Docker encapsula cada servicio.  
Portabilidad entre Madre y Acer sin exposición a Internet.

---

## 3. Plan de implementación

1. **Preparación de nodos:** Madre (i5-8400, 6 núcleos) optimizada para Docker sin sobrecarga.
2. **Orquestación:** Desplegar Ollama primero y probar inferencia básica.
3. **Integración RAG:** Cargar `yggdrasil-dew` en Open WebUI para que la IA tenga contexto completo.
4. **Agentes:** Primer agente de monitorización de logs de red con SpiderFoot + LLM local.

---

## 4. Ejemplo docker-compose base

```yaml
services:
  ollama:
    image: ollama/ollama
    volumes:
      - ./ollama:/root/.ollama
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    depends_on:
      - ollama
```

---

*Ver también: `docs/infra/suricata-af-packet-wazuh.md` · `MASTER-PENDIENTES.md` (sección IA local)*
