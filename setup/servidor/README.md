---
tags: [setup, servidor, madre, index]
fecha: 2026-06-24
maquina: madre
---

# Setup Servidor Madre

Configuración completa del servidor principal (Madre) con stack de IA local.

## Hardware
- CPU: Intel i5-8400 (6 cores)
- RAM: 16GB DDR4
- OS: Arch Linux
- Red: Tailscale (100.91.112.32)

## Stack

| Servicio | Puerto | Estado |
|---|---|---|
| Ollama | 11434 | ✅ CPU optimizado |
| Open WebUI | 3001 | ✅ RAG configurado |
| Qdrant | 6333 | ✅ Vector store |

## Documentos

- [[docker-compose.yml]] — compose final con healthchecks
- [[ollama-cpu-setup.md]] — optimización CPU i5-8400
- [[tailscale-autoarranque.md]] — Tailscale permanente
- [[ufw-seguridad.md]] — firewall mínimo

## Orden de ejecución inicial

1. `docker compose up -d`
2. `ollama pull qwen2.5:3b && ollama pull nomic-embed-text`
3. Crear Modelfile CPU
4. Configurar RAG en Open WebUI
5. Activar UFW
6. Verificar Tailscale autoarranque
