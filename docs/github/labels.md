---
tags: [github, labels, convenciones]
fecha-actualizacion: 2026-07-02
---

# 🏷️ Labels GitHub — yggdrasil-dew

> Crear manualmente en: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/labels

## Labels a crear

| Label | Color | Descripción |
|---|---|---|
| `bug` | `#d73a4a` | Algo no funciona |
| `security` | `#e4e669` | Hallazgo o tarea de seguridad |
| `infra` | `#0075ca` | Infraestructura, servidores, red |
| `docs` | `#cfd3d7` | Documentación |
| `pentest` | `#7057ff` | Investigación o testing de seguridad |
| `bot` | `#008672` | Automatización, bots, scripts |
| `hardware` | `#e99695` | Hardware físico, drivers |
| `docker` | `#0e8a16` | Contenedores y compose |
| `wontfix` | `#ffffff` | No se va a resolver |
| `blocked` | `#b60205` | Bloqueado por dependencia externa |

## Script para crear todos los labels via GitHub CLI

Si tienes `gh` instalado en Acer o Madre:

```bash
gh label create "security"  --color "e4e669" --description "Hallazgo o tarea de seguridad" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "infra"     --color "0075ca" --description "Infraestructura, servidores, red" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "pentest"   --color "7057ff" --description "Investigación o testing de seguridad" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "bot"       --color "008672" --description "Automatización, bots, scripts" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "hardware"  --color "e99695" --description "Hardware físico, drivers" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "docker"    --color "0e8a16" --description "Contenedores y compose" --repo alvarofernandezmota-tech/yggdrasil-dew
gh label create "blocked"   --color "b60205" --description "Bloqueado por dependencia externa" --repo alvarofernandezmota-tech/yggdrasil-dew
```

---
_Creado: 02-jul-2026 — Perplexity vía MCP_
