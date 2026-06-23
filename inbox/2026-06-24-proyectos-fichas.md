---
tags: [inbox, proyectos, fichas, pendiente-mover]
fecha: 2026-06-24
destino: proyectos/*/README.md
estado: borrador
---

# Fichas Proyectos — Trabajo Adelantado

> Crear estas fichas en proyectos/ cuando toque refactor.

---

## proyectos/thdora/README.md

```markdown
# thdora — Bot TOKI (Telegram)

Bot personal en Telegram conectado a Madre.
Permite controlar el ecosistema desde el movil.

## Handlers pendientes
- /start — verificar conexion
- /diario <texto> — escribe en diarios/
- /inbox <texto> — crea nota en inbox/
- /tarea <texto> — anade tarea al diario
- /estado — muestra docker ps en Madre

## Stack
- Python + python-telegram-bot
- SSH a Madre para /estado
- git commit+push para /diario y /inbox

## Docs
- docs/DEPLOY.md — pendiente
- docs/SERVIDOR_MADRE.md — pendiente
- docs/TROUBLESHOOTING.md — pendiente
```

---

## proyectos/local-brain/README.md

```markdown
# local-brain — Cerebro IA Local

RAG sobre yggdrasil-dew via Ollama + Qdrant.
Pregunta al cerebro desde el terminal o Open WebUI.

## Stack
- Ollama (qwen2.5:3b-cpu) — LLM
- nomic-embed-text — embeddings
- Qdrant — vector store
- Open WebUI — interfaz

## Estado
- [ ] Coleccion RAG creada en Qdrant
- [ ] yggdrasil-dew indexado
- [ ] Test end-to-end OK
```

---

## proyectos/terminal-ia/README.md

```markdown
# terminal-ia — Terminal con IA

Integracion de Ollama en el terminal.
Query rapida desde CLI sin abrir browser.

## Opciones
- shell-gpt apuntando a Ollama local
- script Python custom: query + respuesta en terminal
- alias: `ai "pregunta"` -> ollama run erika

## Pendiente
- [ ] Instalar/configurar shell-gpt con Ollama backend
- [ ] O script Python minimalista
- [ ] Alias en .zshrc / .bashrc
```

---

## proyectos/chatbot-control/README.md

```markdown
# chatbot-control — Control Personal

Chatbot con acceso al ecosistema completo.
Evolucion de thdora hacia control total.

## Vision
- Consultar MASTER-PENDIENTES desde chat
- Crear notas inbox por voz/texto
- Ver estado servicios Docker
- Ejecutar scripts en Madre

## Stack objetivo
- Telegram bot (thdora) + Ollama (Erika) + RAG (cerebro)
- n8n para automatizacion workflows
```

---
_Mover a proyectos/*/README.md cuando toque refactor_
