---
tags: [prompt, claude, docker, ecosistema, ollama, qdrant, webui, paso-a-paso]
fecha: 2026-06-23
estado: listo-para-ejecutar
tipo: prompt-agente
agente: claude-sonnet
prioridad: INMEDIATA
ruta-obsidian: inbox/2026-06-23-prompt-claude-ecosistema-docker.md
---

# Prompt Claude — Ecosistema Docker paso a paso

> 📌 Prioridad máxima — las 3 imágenes están descargando AHORA en Madre
> Usar con Claude + acceso MCP a repos

---

## RAW PROMPT — COPIAR COMPLETO

```
Eres un ingeniero de software senior con experiencia en homelab, Docker y sistemas de IA local.
Tienes acceso MCP completo a mis repos de GitHub. Trabaja directamente sobre ellos.

## MI ECOSISTEMA

Servidor: "Madre" — Linux, GPU NVIDIA, corriendo en casa
Cerebro: repo `alvarofernandezmota-tech/yggdrasil-dew` — second brain en Markdown
Philosophy: docs-as-code, separation of concerns, inbox-first, nunca duplicar siempre enlazar

## SITUACIÓN ACTUAL — HOY 2026-06-23

Están descargando AHORA en Madre estas 3 imágenes Docker:
1. Ollama — servidor de modelos locales (puerto 11434)
2. Open WebUI — interfaz web para Ollama (puerto 3000)
3. Qdrant — vector database para RAG (puerto 6333)

Cuando terminen de descargar necesito el ecosistema funcionando al 100%.

## REPOS DEL ECOSISTEMA

- `alvarofernandezmota-tech/yggdrasil-dew` — cerebro (existe)
- `alvarofernandezmota-tech/thdora` — bot Telegram activo (existe)
- `alvarofernandezmota-tech/ai-toolkit` — toolkit IA (existe)
- `alvarofernandezmota-tech/ollama-stack` — CREAR AHORA

## ARQUITECTURA DECIDIDA

- agentes/ = IAs externas con API (Claude, Gemini, GPT, Grok, Perplexity)
- ollama/ = todo local (modelos, RAG, Qdrant, Open WebUI)
- setup/servidor/ = homelab Batcueva
- proyectos/ = productos con repo GitHub propia
- Ley: infraestructura != producto
- Ley: nunca duplicar, siempre wikilinks
- Ley: todo nuevo entra por inbox/

## TAREA 1 — CREAR REPO `ollama-stack` (HACER YA)

Crea el repo `alvarofernandezmota-tech/ollama-stack` con:

1. `docker-compose.yml` completo con:
   - Ollama (nvidia GPU passthrough, puerto 11434, volumen persistente)
   - Open WebUI (depende de Ollama, puerto 3000, volumen persistente)
   - Qdrant (puerto 6333 + 6334 gRPC, volumen persistente)
   - Red interna compartida
   - Variables de entorno en .env
   - Restart policy: unless-stopped
   - Health checks

2. `.env.example` con todas las variables necesarias

3. `README.md` profesional con:
   - Requisitos (NVIDIA Docker, CUDA)
   - Instalación en 3 comandos
   - Cómo añadir modelos
   - URLs de acceso
   - Troubleshooting básico

4. `Makefile` con targets:
   - make up, make down, make logs, make pull-models, make status

5. `scripts/pull-models.sh` — descarga modelos base recomendados

6. `.gitignore` correcto (ignorar .env, datos, modelos)

## TAREA 2 — DOCUMENTAR EN CEREBRO

En el repo `yggdrasil-dew` actualiza/crea:

1. `ollama/README.md` — añade enlace [[ollama-stack]] y estado actual
2. `setup/servidor/docker-stack.md` — tabla con los 3 servicios, puertos, estado
3. `proyectos/ollama-stack/README.md` — ficha del proyecto con wikilinks

Frontmatter YAML obligatorio en todos los docs:
```yaml
---
tags: [ollama, docker, homelab, IA-local]
fecha: 2026-06-23
estado: instalando|activo|pendiente
repo: alvarofernandezmota-tech/ollama-stack
---
```

## TAREA 3 — PLAN POST-INSTALACIÓN

Cuando Ollama+WebUI+Qdrant estén corriendo, el siguiente paso es:

1. Pull modelos prioritarios:
   - qwen2.5:7b — uso general
   - qwen2.5:3b — tareas rápidas
   - bge-m3 — embeddings para RAG
   - nomic-embed-text — embeddings alternativos

2. Configurar Open WebUI:
   - Conectar con Ollama
   - Crear workspace personal
   - Configurar modelos por defecto

3. Configurar Qdrant:
   - Crear colección para RAG del cerebro
   - Conectar con Open WebUI

4. Test end-to-end:
   - Pregunta al cerebro via RAG
   - Verificar que indexa yggdrasil-dew

Crea `inbox/2026-06-23-post-instalacion-ollama.md` con este plan detallado
y los comandos exactos.

## RESTRICCIONES

- Commits descriptivos en cada cambio
- Nunca duplicar contenido entre repos
- Todo nuevo en cerebro pasa por inbox/ primero
- Wikilinks [[]] nunca URLs relativas en el cerebro
- NO tocar `agentes/` en yggdrasil-dew
- El docker-compose debe funcionar con `docker compose up -d` sin modificación

## OUTPUT ESPERADO

Al terminar quiero:
1. Repo `ollama-stack` listo en GitHub con docker-compose funcional
2. Docs actualizados en `yggdrasil-dew` con estado real
3. Plan post-instalación con comandos exactos
4. Todo enlazado con wikilinks

Empieza por TAREA 1. Confírmame cada paso antes de pasar al siguiente.
```

---

## NOTAS DE USO

- Usar con Claude que tenga acceso MCP a GitHub
- Ejecutar TAREA 1 mientras las imágenes siguen descargando
- TAREA 2 se puede ejecutar en paralelo
- TAREA 3 solo cuando los servicios estén levantados

## ORDEN DE EJECUCIÓN

```
AHORA (descargas en curso):
  → Claude crea repo ollama-stack
  → Claude documenta en cerebro

CUANDO TERMINEN DESCARGAS:
  → docker compose up -d
  → pull modelos
  → configurar WebUI + Qdrant
  → test RAG

SIGUIENTE FASE:
  → osint-stack (SpiderFoot + IVRE + Kismet)
  → local-brain
  → chatbot-control
```

---
_Generado Perplexity · 2026-06-23 · usar con Claude MCP_
