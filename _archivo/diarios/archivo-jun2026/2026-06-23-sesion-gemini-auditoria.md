---
tags: [sesion, gemini, auditoria, inbox, plan-4-fases, aprendizaje, ollama, claude]
fecha: 2026-06-23
hora: 20:48
tipo: documentacion-sesion
agente: gemini-2.5-pro
estado: ejecutado-parcialmente
ruta-obsidian: inbox/2026-06-23-sesion-gemini-auditoria.md
---

# Sesión Gemini — Auditoría inbox 2026-06-23

> Documentación de la interacción con Gemini 2.5 Pro para auditar el inbox.
> Resultado: plan de 4 fases + fichas agentes actualizadas + plan migración ollama/

## Contexto dado a Gemini

Se le proporcionó vía texto:
- Inventario completo de los 37 archivos del inbox con clasificación
- Estado real de cada carpeta del repo
- Las 3 leyes del sistema
- ADRs tomados hoy
- Estado de lo ejecutado vs solo planificado

## Limitación detectada

> Gemini 2.5 Pro en chat NO tiene acceso directo a GitHub API.
> Necesita contexto serializado vía texto en el prompt.
> Claude con MCP es la herramienta correcta para ejecución directa.

## Output de Gemini — Plan de 4 fases

### Fase 1 — Clasificación e informes de control (inmutable)
- [ ] Generar `inbox/2026-06-23-inbox-clasificado.md`
- [ ] Generar `inbox/2026-06-23-estado-real-repo.md`

### Fase 2 — Purga inbox y migración conocimiento
- [ ] Mover fichas ollama/ → `ollama/modelos/`
- [ ] Mover prompts agentes → integrar en fichas `agentes/`
- [ ] Archivar archivos efímeros de sesión

### Fase 3 — Infraestructura de carpetas
- [ ] READMEs básicos en osint/, tools/, formacion/
- [ ] Crear `setup/servidor/` + esqueleto `docker-stack.md`
- [ ] Inicializar `.obsidian/` workspace básico

### Fase 4 — Sincronización raíz y cierre
- [ ] Reescribir `HOME.md`, `ECOSISTEMA.md`, `CONTEXT.md` con wikilinks
- [ ] Filtrar `MASTER-PENDIENTES.md` — solo lo realmente pendiente

## Plan migración ollama/ propuesto por Gemini

| Origen inbox/ | Destino | Tipo |
|---|---|---|
| ollama-guia-seleccion.md | ollama/guia-seleccion.md | Índice carpeta |
| ollama-bge-m3.md | ollama/modelos/bge-m3.md | Ficha modelo |
| ollama-qwen2.5-3b.md | ollama/modelos/qwen2.5-3b.md | Ficha modelo |
| ollama-qwen2.5-7b.md | ollama/modelos/qwen2.5-7b.md | Ficha modelo |
| ollama-rag-investigacion.md | ollama/arquitectura/rag-investigacion.md | Arquitectura RAG |
| v4-pendiente-ollama.md | ollama/pendientes.md | Pendientes |

## Aprendizaje clave de esta sesión

- Gemini es ideal para auditorías masivas de texto
- Claude es ideal para ejecución con MCP
- Perplexity documenta la sesión en tiempo real
- **Flujo óptimo:** Gemini analiza → Claude ejecuta → Perplexity guarda

## Wikilinks
- [[agentes/gemini-2.5-pro]]
- [[agentes/claude-sonnet-4.6]]
- [[inbox/2026-06-23-prompt-gemini-auditoria-inbox]]
- [[inbox/MASTER-PENDIENTES]]

---
_Sesión documentada por Perplexity · 2026-06-23 20:48_
