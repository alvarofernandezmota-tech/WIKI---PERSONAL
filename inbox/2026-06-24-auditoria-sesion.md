---
tags: [inbox, auditoria, sesion, commit, cierre]
fecha: 2026-06-24
tipo: auditoria-sesion
---

# Auditoria Sesion — 24 Jun 2026

## Commits

| SHA | Mensaje | Archivos |
|---|---|---|
| 6d7f0a9 | feat: setup completo Madre | 6 en setup/servidor/ |
| (este) | docs: diario + auditoria + plan | 3 en diarios/ + inbox/ |

## Archivos creados hoy

```
setup/servidor/docker-compose.yml
setup/servidor/ollama-cpu-setup.md
setup/servidor/tailscale-autoarranque.md
setup/servidor/ufw-seguridad.md
setup/servidor/README.md
inbox/MASTER-PENDIENTES.md (actualizado)
inbox/2026-06-24-plan-madre-ejecucion.md
inbox/2026-06-24-auditoria-sesion.md
diarios/2026-06-24-diario.md
```

## Decisiones tecnicas tomadas

| Tema | Decision | Motivo |
|---|---|---|
| OLLAMA_NUM_THREADS | 6 | cores fisicos i5-8400 |
| OLLAMA_NUM_PARALLEL | 1 | CPU-only, mas = swap |
| OLLAMA_MAX_LOADED_MODELS | 2 | qwen3b + embeddings en 16GB |
| OLLAMA_KEEP_ALIVE | 24h | modelos en memoria entre chats |
| Modelo principal | qwen2.5:3b | espanol + RAG + ligero |
| Embeddings | nomic-embed-text | mejor ratio calidad/CPU |
| Vector DB | Qdrant | ya en stack, sin codigo extra |
| Firewall | UFW deny-all + LAN + Tailscale | minimo seguro |
| Tailscale | systemctl enable + authkey reusable | permanente sin intervencion |

## Estado stack al cerrar sesion

| Componente | Estado | Accion pendiente |
|---|---|---|
| Docker compose | documentado y optimizado | ejecutar en Madre |
| Ollama CPU vars | configurados en compose | aplicar al levantar |
| Modelos | sin descargar | ollama pull al llegar |
| Open WebUI RAG | sin configurar | paso 5 del plan |
| Tailscale autoarranque | pendiente | authkey en admin.tailscale.com |
| UFW | pendiente | ejecutar 7 reglas |

## Proxima sesion

Ejecutar [[inbox/2026-06-24-plan-madre-ejecucion.md]] paso a paso.
Exito = docker compose ps 3 healthy + RAG test OK + Tailscale sobrevive reboot.

---
_Sesion cerrada: 24 jun 2026 01:11 | Perplexity + Gemini + Grok + MCP GitHub_
