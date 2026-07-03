# 🗺️ Plan: Estructura de Islas en ygg

**Creado:** 03-Jul-2026  
**Estado:** 🟠 En proceso  
**Prioridad:** Alta — bloquea automatizaciones

---

## 🔍 Diagnóstico: qué hay ahora en ygg

### Carpetas raíz detectadas (37 total)

```
Carpetas de SISTEMA (no mover):
  .github/        → Actions y config GitHub
  .obsidian/      → config Obsidian vault
  templates/      → plantillas del ecosistema
  scripts/        → scripts de mantenimiento y sesión
  docs/           → documentación general
  sesiones/       → resumen de cada sesión
  inbox/          → entrada de ideas, procesar y mover
  assets/         → imágenes y recursos estáticos

Carpetas de ISLAS (cada una = una isla del ecosistema):
  thdora/         → 🟡 isla thdora (bot principal)
  osint-stack/    → ⚪ SIN DEFINIR — duplicado de osint/
  osint/          → ⚪ SIN DEFINIR — duplicado de osint-stack/
  ollama/         → 🟡 isla local-brain (modelos locales)
  docker/         → parte de batcueva / madre
  infra/          → parte de batcueva / madre
  hardware/       → parte de theodora

Carpetas de CONOCIMIENTO (Obsidian PKM):
  diarios/        → ✅ diary entries (bien estructurado)
  mocs/           → Maps of Content Obsidian
  formacion/      → cursos, aprendizaje
  proyectos/      → proyectos activos
  yo/             → perfil personal
  core/           → conceptos base
  agentes/        → documentación de agentes IA

Carpetas AMBIGUAS (a resolver):
  tools/          → solapado con cli-tools/
  cli-tools/      → solapado con tools/
  setup/          → ¿parte de batcueva o de theodora?
  alvarofernandezmota-tech/ → ⚠️ carpeta con nombre de usuario — WTF?
```

---

## 🚨 Problemas críticos detectados

### Problema 1: Duplicados (bloquean Actions)

| Duplicado A | Duplicado B | Decisión |
|---|---|---|
| `osint/` | `osint-stack/` | Fusionar en `osint/` — borrar `osint-stack/` |
| `tools/` | `cli-tools/` | Fusionar en `tools/` — borrar `cli-tools/` |

### Problema 2: Carpeta con nombre de usuario
```
alvarofernandezmota-tech/  ← esto no deberia existir como carpeta
```
Posible artefacto de un `git clone` mal hecho. **Revisar y borrar.**

### Problema 3: Islas sin `README.md` propio
Cada isla debe tener su propio `README.md` con la plantilla estándar.
Islas detectadas SIN README propio:
- `osint/` — sin README
- `osint-stack/` — sin README
- `ollama/` — sin README
- `docker/` — sin README
- `infra/` — sin README
- `hardware/` — sin README

---

## 🏛️ La plantilla de isla (cómo debe ser cada una)

Cada isla en ygg debe tener EXACTAMENTE esta estructura:

```
isla-nombre/
├── README.md              ← plantilla estándar (ver abajo)
├── ESTADO.md              ← estado actual de la isla
├── HERRAMIENTAS.md        ← tools propias de esta isla
├── docs/                  ← documentación específica
└── scripts/               ← scripts propios (opcional)
```

### README.md plantilla para cada isla:
```markdown
# 🏝️ [NOMBRE-ISLA]

**Tipo:** [bot | infra | pkm | osint | backup | hardware]
**Estado:** [🟢 Activa | 🟡 Gaps | 🔜 No existe | ⚪ Sin definir]
**Repo propio:** [URL o N/A]
**Parte de:** [descripción del rol en el ecosistema]

## Qué hace
[1-3 frases]

## Herramientas propias
- herramienta 1 — descripción
- herramienta 2 — descripción

## Dependencias
- Depende de: [islas o servicios que necesita]
- Es usado por: [qué usa esta isla]

## GitHub Actions relacionadas
- [action.yml] — qué hace, cuándo se dispara

## Estado actual
| Componente | Estado | Notas |
|---|---|---|
| core | ✅/⚠️/❌ | |

## Pendientes
- [ ] tarea pendiente

## Última actualización
`YYYY-MM-DD` — descripción del cambio
```

---

## 📊 Qué tienen los diarios (diary) y qué les falta

### Lo que hay:
- Carpeta `diarios/` existe ✅
- Formato Obsidian Daily Note presumiblemente activo

### Lo que falta:
- **Action que verifique** que el diario del día existe
- **Plantilla de diario** en `templates/diario-daily.md`
- **Enlace automático** entre diario del día y sesiones del día
- **Índice mensual** generado automáticamente

### Plantilla diario propuesta:
```markdown
# 🗓️ [[YYYY-MM-DD]]

## 🌅 Inicio del día
- Sesión: [[sesiones/SYYYYMMDD-RESUMEN]]
- Foco: 

## 📝 Trabajo
### Completado
- 
### En curso
- 

## 🛠️ Técnico
- 

## 💡 Ideas / Inbox
- 

## 🌙 Cierre
- Mañana: 
```

---

## 📅 Plan de acción ordenado

```
S21 — HOY:
  [ ] 1. Fix SSH madre → GitHub
  [ ] 2. gh auth login
  [ ] 3. Revisar alvarofernandezmota-tech/ (borrar si es artefacto)
  [ ] 4. Fusionar osint/ + osint-stack/ → osint/
  [ ] 5. Fusionar tools/ + cli-tools/ → tools/
  [ ] 6. Crear plantilla diario en templates/

S22:
  [ ] 7. Añadir README.md a cada isla (ollama, docker, infra, hardware)
  [ ] 8. Crear thdora/README.md con plantilla estándar
  [ ] 9. Action: verifica que cada isla tiene README.md
  [ ] 10. Action: verifica que el diario del día existe

S23:
  [ ] 11. batcueva repo + docker-compose
  [ ] 12. GROQ_API_KEY en secrets
  [ ] 13. Automatización daily-report Telegram
```

---

## 🤖 Sobre el monitoring de Actions

Cada isla necesita que **alguien la monitorice**. El sistema actual:

```
ACTUAL (ygg):
  ecosystem-guardian.yml → audita ygg cada noche
  islas-health.yml       → verifica ficheros maestros
  mapa-islas-sync.yml    → actualiza timestamps

FALTA:
  — Action que verifique que CADA ISLA tiene su README.md
  — Action que compruebe que thdora está viva (ping al bot)
  — Action que alerte si batcueva lleva >7 días sin backup
  — Dashboard unificado del estado de todas las islas
```

El dashboard puede ser un simple `ESTADO-ISLAS.md` autogenerado por una Action.

---

*Mover a `docs/` cuando esté ejecutado al 100%*
