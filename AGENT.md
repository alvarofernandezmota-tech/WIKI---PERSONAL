---
rol: agente de base de conocimiento
repo: yggdrasil-wiki (WIKI---PERSONAL)
ecosistema: yggdrasil
actualizado: 2026-07-18
---

# AGENT — yggdrasil-wiki

## Identidad

Segundo cerebro del ecosistema. Base de conocimiento estática del ecosistema Yggdrasil. Islas de conocimiento por dominio. Aquí vive el SABER — no el estado (DEW), no la vida personal (tracking).

## Reglas

- Leer CONTEXT.md antes de actuar
- No duplicar con `yggdrasil-dew` — DEW es plan/estado/issues, WIKI es conocimiento consolidado
- No duplicar con `yggdrasil-tracking` — tracking es vida personal
- Fuente de verdad de islas: `wiki/islas/INDEX.md`
- Mantener estructura de islas coherente — una isla por dominio
- DEW manda en conflictos de canon
- Repo PRIVADO

## Estructura real

```
yggdrasil-wiki/ (WIKI---PERSONAL)
├── wiki/
│   ├── islas/          ← una isla por dominio del ecosistema
│   ├── conocimiento/   ← notas técnicas y aprendizajes
│   ├── infra/          ← documentación de infraestructura
│   ├── agentes/        ← guías de agentes IA
│   ├── operaciones/    ← runbooks y procedimientos
│   ├── vida/           ← módulos de vida personal
│   └── relaciones/     ← personas y contextos
├── AGENT.md
├── CONTEXT.md
├── HOME.md           ← punto de entrada principal
└── README.md
```

## Repos relacionados

- `yggdrasil-dew` — gobernanza, issues, CI (cerebro operativo)
- `yggdrasil-tracking` — vida personal, diarios, metas
- `yggdrasil-formacion` — formación técnica
- `yggdrasil-scripts` — scripts operativos
- `yggdrasil-secops` — blue team, hallazgos
- `THDORA-PERSONAL` — bot IA personal

## Rutas clave

- `wiki/islas/INDEX.md` — fuente de verdad única de islas
- `wiki/islas/ecosistema.md` — mapa completo del ecosistema
- `wiki/CONVENCIONES.md` — convenciones de la wiki
- `HOME.md` — punto de entrada principal
- `CONTEXT.md` — estado actual
