---
tags: [inbox, proyecto, chatbot, control, idea, pendiente-definir]
fecha: 2026-06-23
estado: idea
destino: proyectos/chatbot-control.md
relacionado-anterior: [[inbox/2026-06-23-decision-arquitectura-proyectos]]
ruta-obsidian: inbox/2026-06-23-proyecto-chatbot-control.md
---

# Idea — Chatbot de Control del Ecosistema

> Estado: IDEA — no implementar hasta que local-brain v4 esté validado.

## Concepto

Interfaz web (no Telegram) para controlar todo el ecosistema desde un chat.
Le dices "mueve esta nota al inbox" y lo ejecuta.

## Diferencia con THDORA

| | THDORA | Chatbot Control |
|---|---|---|
| Interfaz | Telegram | Web local |
| Propósito | Conversación personal | Control del ecosistema |
| Acceso | Móvil / remoto | Local (Madre) |
| Estado | Activo | Idea |

## Alternativas a evaluar

| Opción | Pros | Contras |
|---|---|---|
| **Open WebUI** | Conecta Ollama nativo, sin config | Solo chat, no ejecuta acciones |
| **Panel propio FastAPI+htmx** | Control total, ejecuta comandos | Hay que construirlo |
| **Perplexica** | RAG + web search local | Más complejo |

## Acciones que podría ejecutar

- Mover notas entre carpetas del vault
- Crear notas en inbox
- Consultar el RAG (:8001)
- Ver estado de servicios (systemd)
- Hacer commits al repo

## Prereqs antes de empezar

- [ ] local-brain v4 funcionando y validado
- [ ] Systemd services estables
- [ ] Decidir entre Open WebUI o panel propio
