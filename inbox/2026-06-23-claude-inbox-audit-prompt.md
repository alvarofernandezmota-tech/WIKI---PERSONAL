---
tags: [agentes, claude, inbox, auditoria, prompt]
fecha: 2026-06-23
estado: pendiente-ejecutar
ruta-obsidian: inbox/2026-06-23-claude-inbox-audit-prompt.md
---

# Prompt Claude — Auditoría Inbox Completa

> Claude está ejecutando este prompt ahora mismo (23/06/2026 ~16:35 CEST)
> Cuando devuelva el output → pegarlo a Perplexity para ejecutar vía MCP GitHub

## Objetivo

Auditar los 35 archivos del inbox/, determinar destino definitivo de cada uno,
escribir frontmatter correcto con tags y ruta-obsidian, detectar duplicados,
e identificar qué va también a repos externos.

## Prompt completo

```
Eres un experto en organización de conocimiento tipo Obsidian / Zettelkasten / second brain.

CONTEXTO DEL PROYECTO:
- Repo GitHub: alvarofernandezmota-tech/yggdrasil-dew
- Este repo ES el segundo cerebro (vault Obsidian sincronizado con GitHub)
- Cualquier doc/conocimiento vive AQUÍ. El código vive en su repo propio.

ESTRUCTURA DE DESTINOS EN EL REPO:
  diarios/              ← diarios de sesión (nombre: YYYY-MM-DD.md)
  setup/servidor/       ← docker-compose YML, scripts bash, configs sistema
  setup/varopc/         ← configs Hyprland, wayland, entorno escritorio
  osint/                ← investigación OSINT, herramientas, técnicas
  proyectos/thdora/     ← bot TOKI, FastAPI, Telegram
  proyectos/batcueva/   ← servidor Madre, hardware, batcueva Docker
  agentes/              ← fichas de LLMs y agentes IA
  formacion/            ← módulos Python, cursos, recursos aprendizaje
  tools/                ← scripts Python propios del ecosistema
  yo/                   ← perfil personal, filosofía, objetivos vitales
  docs/                 ← documentación técnica, guías de referencia

REGLA CRÍTICA — repos externos:
  Si un archivo contiene código o config que pertenece a un repo externo
  (ej: thdora, spiderfoot, batcueva como repo propio):
  → La DOCUMENTACIÓN va en yggdrasil-dew en proyectos/ o setup/
  → El CÓDIGO/CONFIG va en el repo externo correspondiente
  → Indica: repo-externo: nombre-del-repo y ruta-repo: path/en/ese/repo

FORMATO FRONTMATTER obligatorio para cada archivo procesado:
---
tags: [tag1, tag2, tag3]
fecha: YYYY-MM-DD
estado: procesado | referencia | pendiente-ejecutar
ruta-obsidian: carpeta/destino/nombre-final.md
repo-externo: nombre-repo  (solo si aplica)
ruta-repo: path/en/repo    (solo si repo-externo aplica)
---

INVENTARIO COMPLETO DEL INBOX (35 archivos):

GRUPO A — Diarios/sesiones:
inbox/2026-06-20-tarde.md
inbox/2026-06-20-tarde2.md
inbox/2026-06-20-tarde3-bateria.md
inbox/2026-06-20-tarde4-optimizacion.md
inbox/2026-06-20-tarde5-cierre-acer-inicio-madre.md
inbox/2026-06-20-tarde6-hyprlock-dashboard.md
inbox/2026-06-20-tarde7-madre-estado-red.md
inbox/2026-06-20-tarde8-madre-ia-local.md
inbox/2026-06-20-tarde9-monitores-volumen.md
inbox/2026-06-20-tarde10-madre-ufw-ssh.md
inbox/2026-06-20-tarde11-volumen-hyprland.md
inbox/2026-06-22-plan-dia.md
inbox/2026-06-22-tarde-netdata-agentes-llm.md
inbox/2026-06-23-diary.md

GRUPO B — Decisiones / auditorías:
inbox/decisiones-sesion-2026-06-20.md
inbox/auditoria-ecosistema-2026-06-20.md
inbox/auditoria-ai-toolkit.md
inbox/auditoria-personal-repo.md
inbox/segundo-cerebro-fix-gordo.md
inbox/PENDIENTE-git-pull-y-obsidian.md

GRUPO C — Proyectos:
inbox/proyecto-thdora-mvp.md
inbox/proyecto-dashboard-ecosistema.md
inbox/proyecto-llm-python-necesidad.md
inbox/proyecto-tools-ecosistema.md
inbox/thdora-estado-stack.md
inbox/madre-servidor-pendientes.md
inbox/2026-06-23-batcueva-osint-stack.md
inbox/2026-06-23-batcueva-stack-definitivo.md

GRUPO D — Scripts e investigación IA/OSINT:
inbox/grok-2026-06-20-investigacion-completa.md
inbox/grok-2026-06-20-segundo-cerebro-pro.md
inbox/2026-06-23-grok-script-maestro-batcueva.md
inbox/2026-06-23-gemini-fase2-corregido.md
inbox/2026-06-23-gemini-osint-expansion.md
inbox/2026-06-23-gemini-script-maestro-final.md
inbox/modelos-ollama-hardware-madre.md

GRUPO E — Formación / config:
inbox/formacion-python-osint.md
inbox/obsidian-configuracion.md

NO MOVER:
inbox/README.md
inbox/MASTER-PENDIENTES.md

TAREA:
1. Lee cada archivo en GitHub (URL base:
   https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/)
2. Determina destino definitivo correcto
3. Propón nombre final en kebab-case
4. Escribe frontmatter YAML correcto
5. Detecta duplicados → indica cuál conservar y cuál borrar
6. Si hay código que va a repo externo → indícalo explícitamente
7. Los 11 fragmentos del 20-jun consolídalos en un solo diarios/2026-06-20.md

OUTPUT — dos secciones:
SECCIÓN 1: Tabla resumen
| archivo-origen | destino-final | nombre-final.md | estado | repo-externo |

SECCIÓN 2: Frontmatter para cada archivo (solo el bloque YAML)

Cuando termines, el output se pasa a Perplexity (MCP GitHub)
para ejecutar todos los movimientos en un solo commit.
```

## Estado

- [ ] Claude procesando (~16:35 CEST)
- [ ] Output recibido
- [ ] Perplexity ejecuta movimientos vía MCP
- [ ] inbox/ limpio
