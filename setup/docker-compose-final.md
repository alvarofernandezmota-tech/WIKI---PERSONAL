# 🐳 Docker Compose Final — Stack Completo

> Migrado: 2026-06-25
> Origen: `inbox/2026-06-24-docker-compose-final-completo.md`

## Stack completo del ecosistema

### Servicios incluidos

```yaml
# Estructura del compose:
services:
  ollama:          # LLM engine local
  litellm:         # Proxy unificado de modelos (Fase 4)
  open-webui:      # UI para Ollama
  n8n:             # Automatización workflows
  perplexica:      # Búsqueda con IA local
  spiderfoot:      # OSINT framework
  vault:           # Secrets management (SOPS)
  nginx-proxy:     # Reverse proxy
```

### Fases de despliegue

| Fase | Servicios | Estado |
|------|-----------|--------|
| 1 | Ollama + Open-WebUI | ✅ Funcional |
| 2 | + Perplexica | ✅ Planificada |
| 3 | + n8n | ✅ Documentada |
| 4 | + LiteLLM + SOPS/Vault | 🔴 Pendiente |

### Referencia de archivos
- `inbox/2026-06-24-fase1-revisada-con-litellm.md`
- `inbox/2026-06-24-fase3-completa.md`
- `inbox/2026-06-24-fase4-litellm-sops-plan.md`
- `inbox/2026-06-24-n8n-litellm-integracion.md`
- `inbox/2026-06-24-nginx-proxy-manager.md`

## ⚠️ Próximo paso
Aplicar fase 4: LiteLLM como proxy central + SOPS para gestión de secretos
```bash
# En la Madre:
cd ~/docker/yggdrasil-stack
docker compose -f docker-compose-fase4.yml up -d
```
