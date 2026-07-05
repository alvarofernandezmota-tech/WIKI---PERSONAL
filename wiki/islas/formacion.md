---
tipo: isla
nombre: Formación
descripcion: Aprendizaje técnico orientado al ecosistema — todo lo que se aprende produce algo útil
repo_principal: https://github.com/alvarofernandezmota-tech/formacion-tech
github_issues: https://github.com/alvarofernandezmota-tech/formacion-tech/issues
obsidian_link: "[[formacion]]"
depende_de: []
sirve_a: [cerebro, thdora, ia-local]
estado: activo
---

# 📚 Isla: Formación

La formación no es genérica. **Todo lo que se aprende se convierte en script, módulo o herramienta real dentro del ecosistema.**

## Repos

| Repo | Propósito | URL |
|---|---|---|
| `formacion-tech` | Apuntes, ejercicios y recursos técnicos organizados por área | https://github.com/alvarofernandezmota-tech/formacion-tech |
| `investigacion-ia` | PoCs e investigación aplicada de IA | https://github.com/alvarofernandezmota-tech/investigacion-ia |

## Estructura de formacion-tech

```
formacion-tech/
├── terminal/     ← bash, zsh, comandos
├── git/          ← flujos, convenciones, hooks
├── docker/       ← compose, redes, volúmenes
├── linux/        ← arch, systemd, kernel
├── seguridad/    ← conceptos, herramientas
├── ia/           ← prompts, APIs, modelos
├── redes/        ← TCP/IP, UFW, Tailscale
├── python/       ← async, FastAPI, Pydantic
└── recursos/     ← libros, cursos, referencias
```

## Python — temario orientado al ecosistema

| Nivel | Tema | Para qué |
|---|---|---|
| 1 | `async/await` | THDORA handlers |
| 1 | Decoradores | FastAPI routes |
| 1 | Pydantic/dataclasses | Modelos THDORA |
| 2 | `pathlib` | Scripts del ecosistema |
| 2 | `argparse` | CLI tools propios |
| 3 | Vectores/embeddings | local-brain RAG |
| 3 | Qdrant client | Memoria vectorial |

## Regla

> Cada sesión de formación produce al menos 1 artefacto útil: un script, un módulo, o un apunte con ejemplo real del ecosistema.

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
