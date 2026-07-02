# 📐 Convenciones del repositorio

> Este fichero define las reglas de estructura, nombrado y estilo del repo.
> Fuente de verdad para contribuciones propias y agentes IA.

---

## Estructura de carpetas

```
yggdrasil-dew/
├── README.md               ← entrada pública
├── CHANGELOG.md
├── ROADMAP.md
├── CONVENCIONES.md         ← este fichero
├── .env.template
├── .gitignore
├── .github/                ← workflows y templates
├── infra/                  ← configs Madre, Ansible
├── docker/                 ← stacks docker-compose
├── scripts/                ← todos los scripts (bash, python)
├── setup/                  ← instalación inicial de máquinas
├── ollama/                 ← modelos y config IA local
├── osint/                  ← herramientas y notas OSINT
├── agentes/                ← agentes IA y prompts
├── thdora/                 ← config específica Acer Thdora
├── proyectos/              ← proyectos activos
├── formacion/              ← apuntes y cursos
├── hardware/               ← inventario y specs
├── yo/                     ← perfil, contexto personal
└── docs/                   ← toda la documentación narrativa
    ├── herramientas/
    ├── infra/
    ├── diarios/
    ├── mocs/
    └── filosofia.md
```

## Nombrado de ficheros

- Siempre `kebab-case` en lowercase: `setup-madre.sh`, `docker-compose.yml`
- Documentos de referencia raíz en MAYUSCULAS: `README.md`, `ROADMAP.md`
- Fechas en diarios: `YYYY-MM-DD-descripcion.md`
- Scripts con prefijo de acción: `start-`, `stop-`, `install-`, `check-`

## Commits

Seguir Conventional Commits:
```
feat:     nueva funcionalidad
fix:      corrección de bug
docs:     solo documentación
chore:    mantenimiento, limpieza
infra:    cambios de infraestructura
security: cambios de seguridad
refactor: reestructuración sin cambio funcional
```

## Reglas generales

- Nunca commitear `.env`, secrets, APKs, binarios
- `.obsidian/` siempre en `.gitignore`
- Documentación narrativa va en `docs/`, no en la raíz
- Un script = una responsabilidad
- Todo script debe tener cabecera con descripción y uso

---
_Actualizado: 02-jul-2026_
