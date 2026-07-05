---
tipo: conocimiento
tags: [estructura, repos, convenciones, ecosistema]
estado: activo
created: 2026-07-03
actualizado: 2026-07-05
---

# 🏗️ ESTRUCTURA DEL ECOSISTEMA

> Migrado desde raíz — 2026-07-05
> Normas completas: [yggdrasil-dew/CONVENCIONES.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/CONVENCIONES.md)

---

## Principio de separación

| Repo | Contiene | No contiene |
|---|---|---|
| yggdrasil-dew | Gobierno, diarios, arquitectura | Código operativo |
| thdora | Bot FastAPI, scripts propios | Docs de otras islas |
| madre-config | Config Madre, Docker, scripts infra | Docs de thdora |
| WIKI---PERSONAL | Conocimiento, notas Obsidian | Issues técnicos |
| formacion-tech | Cursos, prácticas, apuntes | Config infra |

## Estructura mínima repo hija

```
repo-hija/
├── README.md
├── docs/
│   ├── CONVENCIONES-LOCAL.md
│   └── ROADMAP.md
├── scripts/
└── .github/workflows/
    ├── ci.yml
    ├── ecosystem-guardian.yml
    └── lint-commits.yml
```

_Migrado desde raíz — 2026-07-05 · Perplexity-MCP_
