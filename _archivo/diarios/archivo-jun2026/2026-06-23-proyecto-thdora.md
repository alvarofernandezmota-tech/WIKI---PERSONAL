---
tags: [inbox, proyecto, thdora, telegram, bot, python, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: proyectos/thdora.md
relacionado-anterior: [[inbox/2026-06-23-decision-arquitectura-proyectos]]
ruta-obsidian: inbox/2026-06-23-proyecto-thdora.md
---

# Proyecto THDORA — Bot Telegram

## Qué es

Bot de Telegram personal. Interfaz conversacional para el ecosistema de Álvaro.

## Estado actual

- Proyecto activo en repositorio separado
- En proceso de reestructuración

## Responsabilidad única

Interfaz conversacional vía Telegram. Nada más.

## Lo que NO hace (por diseño)

- No contiene lógica RAG interna
- No contiene base vectorial
- No gestiona el vault de Obsidian

## Integraciones previstas

- `/vault <pregunta>` → HTTP a LOCAL BRAIN :8001
- Groq API como LLM cloud cuando no hay conexión a Madre

## Tecnología

- Python + aiogram
- Groq API (llama-3.3-70b-versatile)
- Arch Linux / VPS

## Ver también

- [[proyectos/local-brain]] — backend RAG que consumirá
- [[inbox/2026-06-23-decision-arquitectura-proyectos]]
