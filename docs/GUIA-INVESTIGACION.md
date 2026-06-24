# Guía Maestra de Investigación
**Última actualización:** 2026-06-24  
**Propósito:** Dónde buscar cada tipo de información, qué IA usar para qué, cómo contrastar

---

## Filosofía de investigación

> No toda IA sirve para todo. No toda fuente es igual de buena.
> El cerebro investiga con sistema, no al azar.

Regla de oro: **Buscar → Contrastar → Documentar en inbox → Procesar después**

---

## Por tipo de pregunta — qué herramienta usar

### 🔍 Investigación técnica (código, docker, linux, arquitectura)

| Fuente | Para qué sirve | Cómo acceder |
|---|---|---|
| **Perplexity** | Investigación rápida con fuentes reales y actuales | perplexity.ai o esta sesión |
| **GitHub Search** | Encontrar repos de referencia, ver código real | github.com/search o MCP tool |
| **ArchWiki** | Todo sobre Arch Linux, configuraciones, sysctl | wiki.archlinux.org |
| **Docker Hub** | Imágenes oficiales, tags, documentación | hub.docker.com |
| **dev.to / medium** | Tutoriales prácticos con experiencia real | buscar en Perplexity |

**Flujo recomendado:**
```
1. Perplexity: "[tema] 2026 docker self-hosted" → contexto rápido
2. GitHub: buscar repos con el stack → ver cómo lo hacen otros
3. Documentación oficial del tool → casos edge
4. Contrastar con segunda IA si hay duda
```

---

### 🤖 Investigación sobre IA / LLMs / agentes

| Fuente | Para qué sirve |
|---|---|
| **Perplexity** | Estado del arte, comparativas de modelos actuales |
| **Ollama Library** | ollama.com/library — todos los modelos disponibles, RAM necesaria |
| **Hugging Face** | huggingface.co — modelos GGUF, benchmarks, papers |
| **LangChain docs** | python.langchain.com — código oficial de chains y agentes |
| **OpenRouter** | openrouter.ai — comparativa precios/velocidad APIs externas |
| **LMSys Chatbot Arena** | chat.lmsys.org — ranking real de modelos por humanos |

**Preguntas clave al investigar un modelo:**
```
- ¿Cuánta VRAM/RAM necesita?
- ¿Cuántos tokens/segundo en CPU i5-8400?
- ¿Tiene buena instrucción following en español?
- ¿Hay Modelfile público ya hecho?
```

---

### 🕵️ Investigación OSINT

| Fuente | Para qué sirve |
|---|---|
| **Perplexity** | Técnicas actuales, herramientas nuevas 2026 |
| **OSINT Framework** | osintframework.com — mapa visual de todas las herramientas |
| **Bellingcat** | bellingcat.com — investigaciones reales, técnicas avanzadas |
| **IntelTechniques** | inteltechniques.com — Michael Bazzell, biblia del OSINT |
| **GitHub: jivoi/awesome-osint** | Lista curada de tools OSINT open source |
| **Sector035** | sector035.nl — OSINT weekly, novedades |

**Para investigar una persona:**
```
Nivel 1 (público, siempre legal):
  Google, LinkedIn, RRSS públicas
Nivel 2 (técnico, legal con precaución):
  Sherlock, Maigret, SpiderFoot
Nivel 3 (avanzado, solo con permiso):
  IVRE, Shodan, reconocimiento facial
```

---

### 🛡️ Investigación seguridad / hacking

| Fuente | Para qué sirve |
|---|---|
| **HackTricks** | book.hacktricks.xyz — la biblia del pentesting |
| **TryHackMe** | tryhackme.com — aprender con labs prácticos |
| **HackTheBox** | hackthebox.com — CTFs y máquinas reales |
| **CVE Details** | cvedetails.com — vulnerabilidades actuales |
| **Exploit-DB** | exploit-db.com — exploits públicos |
| **ArchWiki Security** | wiki.archlinux.org/title/Security |

---

### 📚 Formación y aprendizaje

| Fuente | Para qué sirve |
|---|---|
| **roadmap.sh** | Roadmaps visuales por tecnología |
| **Real Python** | realpython.com — Python práctico nivel intermedio/avanzado |
| **FastAPI docs** | fastapi.tiangolo.com — documentación oficial |
| **Awesome-listas GitHub** | awesome-[tema] — listas curadas de recursos |
| **YouTube: NetworkChuck** | Homelab, redes, hacking para principiantes |
| **YouTube: TechnoTim** | Self-hosted, Docker, Kubernetes práctico |

---

## Por tipo de IA — cuándo usar cada una

| IA | Mejor para | Peor para |
|---|---|---|
| **Perplexity (esta)** | Investigación con fuentes, GitHub MCP, documentar en repo | Generar código largo complejo |
| **Claude (Sonnet)** | Código complejo, refactoring, razonamiento largo | Búsqueda de información actual |
| **Gemini (Flash/Pro)** | Procesar documentos largos, PDFs, contexto enorme | Precisión técnica de nicho |
| **ChatGPT (GPT-4o)** | Tareas generales, Canvas para escribir | Información muy reciente |
| **Erika (Ollama local)** | Consultas privadas, RAG sobre cerebro, offline | Modelos grandes, contexto >8k |
| **Grok** | Información de Twitter/X, noticias muy recientes | Tareas técnicas profundas |

### Flujo de contraste (cómo verificar)
```
Paso 1: Perplexity → investigación inicial con fuentes
Paso 2: Si hay duda técnica → contrastar con Claude
Paso 3: Si es tema muy reciente → Grok o Gemini
Paso 4: Documentar resultado en inbox con fuentes
Paso 5: Procesar a la carpeta correcta del cerebro
```

---

## Queries de búsqueda — plantillas que funcionan

### GitHub (repos de referencia)
```
[tool1] [tool2] docker self-hosted stars:>50
homelab [tecnologia] 2026 docker compose
awesome [tema] (busca listas curadas)
[problema] language:shell OR language:python
```

### Perplexity (investigación técnica)
```
[herramienta] vs [herramienta] 2026 comparison self-hosted
how to [hacer X] docker compose [tecnologia]
[herramienta] performance optimization [hardware]
best [tipo de tool] open source 2026
```

### Perplexity (OSINT)
```
[herramienta OSINT] tutorial 2026
OSINT [tipo de objetivo] techniques open source
[herramienta] docker setup guide
```

---

## Estructura inbox — cómo documentar investigaciones

Convención de nombres:
```
AAAO-MM-DD-[tipo]-[tema].md

Tipos:
  investigacion-  → investigación nueva
  guia-           → guía de uso
  script-         → script listo para ejecutar
  sesion-         → resumen de sesión
  adr-            → Architecture Decision Record
  auditoria-      → revisión del estado
  debate-         → comparativa / decisión pendiente
```

Plantilla mínima para investigación:
```markdown
# Título — Tema
**Fecha:** AAAA-MM-DD
**Fuente:** (URLs o IAs usadas)
**Objetivo:** (para qué sirve esto)

## Hallazgo principal
...

## Código / comandos
...

## Próximos pasos
- [ ] ...
```

---

## Recursos favoritos rápido — bookmark mental

```
GitHub MCP     → buscar repos y código real desde Perplexity
OSINT Framework → osintframework.com
Ollama models  → ollama.com/library
Arch Linux     → wiki.archlinux.org
HackTricks     → book.hacktricks.xyz
Roadmaps       → roadmap.sh
LangChain      → python.langchain.com
OpenRouter     → openrouter.ai (precios APIs)
Hugging Face   → huggingface.co/models
```
