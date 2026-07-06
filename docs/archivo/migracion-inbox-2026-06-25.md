# Mapa de Migración Inbox — 2026-06-25

Este documento registra qué archivos del inbox (sesiones 23-24-25 jun) se migraron a qué carpeta definitiva.

**Script de migración:** `scripts/migrar-inbox.sh`  
**Fecha ejecución:** 2026-06-25  

---

## Tabla de migración

| Archivo inbox (origen) | Destino definitivo | Categoría |
|------------------------|-------------------|-----------|
| `2026-06-23-ollama-bge-m3.md` | `ollama/modelos/bge-m3.md` | Ollama |
| `2026-06-23-ollama-qwen2.5-3b.md` | `ollama/modelos/qwen2.5-3b.md` | Ollama |
| `2026-06-23-ollama-qwen2.5-7b.md` | `ollama/modelos/qwen2.5-7b.md` | Ollama |
| `2026-06-23-ollama-guia-seleccion.md` | `ollama/guia-seleccion-modelos.md` | Ollama |
| `2026-06-23-ollama-rag-investigacion.md` | `ollama/rag-investigacion.md` | Ollama |
| `2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md` | `ollama/bitacora-ollama-vs-llamacpp.md` | Ollama |
| `2026-06-24-langchain-ollama-optimizacion.md` | `ollama/langchain-optimizacion.md` | Ollama |
| `2026-06-24-ollama-modelfile-erika.md` | `ollama/modelfile-erika.md` | Ollama |
| `2026-06-23-adr-docs-as-code-repos-cerebro.md` | `docs/adr/ADR-001-docs-as-code.md` | ADR |
| `2026-06-23-adr-ollama-en-agentes.md` | `docs/adr/ADR-002-ollama-en-agentes.md` | ADR |
| `2026-06-24-ADR-OBSIDIAN-PLUGINS-SSOT.md` | `docs/adr/ADR-003-obsidian-plugins-ssot.md` | ADR |
| `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md` | `docs/tesis-arquitectura-minimalista.md` | Docs |
| `2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md` | `docs/deep-research-alineacion-ssot.md` | Docs |
| `2026-06-24-mapa-completo-repo-real.md` | `docs/mapa-completo-repo.md` | Docs |
| `2026-06-24-mapa-maestro-ecosistema.md` | `docs/mapa-maestro-ecosistema.md` | Docs |
| `2026-06-23-proyecto-local-brain.md` | `proyectos/local-brain/README.md` | Proyectos |
| `2026-06-23-proyecto-chatbot-control.md` | `proyectos/chatbot-control/README.md` | Proyectos |
| `2026-06-23-proyecto-terminal-ia.md` | `proyectos/terminal-ia/README.md` | Proyectos |
| `2026-06-23-proyecto-thdora.md` | `proyectos/thdora/README.md` | Proyectos |
| `2026-06-24-batcueva-fase2-plan.md` | `proyectos/batcueva/fase2-plan.md` | Proyectos |
| `2026-06-23-auditoria-setup.md` | `setup/auditoria-2026-06-23.md` | Setup |
| `2026-06-24-arch-linux-optimizacion-completa.md` | `setup/arch-linux-optimizacion.md` | Setup |
| `2026-06-24-kernel-sysctl-hardening.md` | `setup/kernel-sysctl-hardening.md` | Setup |
| `2026-06-24-hypridle-desactivado.md` | `setup/hypridle-desactivado.md` | Setup |
| `2026-06-23-auditoria-tools.md` | `tools/auditoria-2026-06-23.md` | Tools |
| `2026-06-24-n8n-litellm-integracion.md` | `tools/n8n-litellm-integracion.md` | Tools |
| `2026-06-24-nginx-proxy-manager.md` | `tools/nginx-proxy-manager.md` | Tools |
| `2026-06-24-BITACORA-GROK-PERPLEXICA-FASES.md` | `tools/perplexica-fases.md` | Tools |
| `2026-06-23-auditoria-osint.md` | `osint/auditoria-2026-06-23.md` | OSINT |
| `2026-06-23-osint-rag-mover.md` | `osint/rag-mover.md` | OSINT |
| `2026-06-24-fase1-revisada-con-litellm.md` | `agentes/fase1-litellm.md` | Agentes |
| `2026-06-24-fase3-completa.md` | `agentes/fase3-completa.md` | Agentes |
| `2026-06-24-fase4-litellm-sops-plan.md` | `agentes/fase4-litellm-sops.md` | Agentes |
| `2026-06-23-auditoria-formacion.md` | `formacion/auditoria-2026-06-23.md` | Formación |
| `2026-06-24-formacion-python-roadmap.md` | `formacion/python-roadmap.md` | Formación |
| `2026-06-23-yggdrasil-v4-diario-maestro.md` | `diarios/2026-06-23.md` | Diarios |
| `2026-06-24-SESION-COMPLETA-RESUMEN.md` | `diarios/2026-06-24.md` | Diarios |

---

## Archivos eliminados (temporales / prompts / sesiones efímeras)

Estos archivos se borraron porque su contenido era temporal (cierres de sesión, prompts de IA, borradores) y ya está integrado en los documentos permanentes:

- Todos los `*-sesion-*.md`, `*-cierre-*.md`, `*-prompt-*.md`, `*-AUDITORIA-MAÑANA.md`, `*-PLANIFICACION-DIARIA.md`, `*-PLANTILLA-INBOX.md`, etc.
- Ver lista completa en `scripts/migrar-inbox.sh` (array `ARCHIVOS_TEMPORALES`)

---

## Cómo ejecutar

```bash
# Primero: dry-run para revisar
bash scripts/migrar-inbox.sh --dry-run

# Luego: migración real
bash scripts/migrar-inbox.sh

# Commit final
git add -A && git commit -m 'chore: vaciar inbox migracion 2026-06-25'
```

---

**Ver también:** `diarios/2026-06-25.md` | `ollama/descargas-estado.md`
