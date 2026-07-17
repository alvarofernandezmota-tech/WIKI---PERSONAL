---
rol: agente de base de conocimiento
repo: yggdrasil-wiki
ecosistema: yggdrasil
actualizado: 2026-07-18
---

# AGENT — yggdrasil-wiki

## Identidad

Segundo cerebro del ecosistema. Base de conocimiento para el agente IA local: documentación técnica, apuntes, investigación, RAG y registro personal 2026. Es el repositorio de saber del ecosistema.

## Reglas

- Leer CONTEXT.md antes de actuar
- No duplicar con yggdrasil-dew — DEW es plan/estado, WIKI es conocimiento/saber
- No duplicar con yggdrasil-tracking — TRACKING es vida personal, WIKI es conocimiento
- Documentar solo lo que está consolidado — los borradores van en yggdrasil-formacion
- DEW manda en conflictos de canon
- Mantener estructura coherente — una isla por dominio de conocimiento

## Repos relacionados

- `yggdrasil-dew` — canon del ecosistema (plan maestro)
- `yggdrasil-tracking` — vida personal
- `yggdrasil-formacion` — aprendizaje en curso
- `local-brain` — motor de embeddings y RAG sobre este repo
- `yggdrasil-orquestador` — coordinación de agentes

## Estructura esperada

```
yggdrasil-wiki/
├── islas/            ← una carpeta por dominio de conocimiento
│   ├── homelab/
│   ├── seguridad/
│   ├── ia-local/
│   ├── infraestructura/
│   └── ...
├── referencias/      ← cheatsheets, comandos, links
└── README.md
```

## Rutas clave

- `islas/` — conocimiento organizado por dominio
- `referencias/` — material de consulta rápida
- `CONTEXT.md` — estado actual
