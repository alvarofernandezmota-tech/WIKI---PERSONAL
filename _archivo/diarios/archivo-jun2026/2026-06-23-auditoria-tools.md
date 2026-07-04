---
tags: [auditoria, tools, cli-tools, estructura, homelab]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: inbox/2026-06-23-auditoria-tools.md
---

# Auditoría `tools/` + `cli-tools/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Decisión arquitectura (ADR 2026-06-23)

Las tools se clasifican en dos tipos:

| Tipo | Dónde va | Ejemplo |
|---|---|---|
| **Infra/homelab** | `setup/scripts/` | pull-stack.sh, systemd units |
| **CLI conocimiento** | `tools/` o `cli-tools/` | ripgrep, fzf, bat, eza |
| **Agente IA** | `agentes/AI_TOOLKIT.md` | opencode, ai-toolkit |

## Estructura objetivo

```
tools/
  README.md                    ← índice herramientas
  GUIA-SELECCION.md            ← cuándo usar cada tool
  cli/
    ripgrep.md
    fzf.md
    bat.md
    eza.md
    tmux.md
    zsh.md
  dev/
    git.md
    gh.md                      ← GitHub CLI
    docker.md
    python.md
  monitoring/
    htop.md
    nvtop.md
    netdata.md

setup/scripts/                 ← scripts de infra (NO en tools/)
  pull-stack.sh
  systemd/
```

## Frontmatter YAML estándar

```yaml
---
tags: [tool, cli|dev|monitoring]
nombre: ripgrep
tipo: busqueda-texto
install: apt|brew|cargo
caso-uso: "Buscar en código más rápido que grep"
estado: activo
---
```

## Pasos a ejecutar

- [ ] Listar contenido actual `tools/` y `cli-tools/`
- [ ] Reclasificar: scripts infra → `setup/scripts/`
- [ ] Crear subcarpetas `cli/`, `dev/`, `monitoring/`
- [ ] Ficha por herramienta al nivel de `agentes/`
- [ ] Fusionar `tools/` y `cli-tools/` si hay duplicidad
