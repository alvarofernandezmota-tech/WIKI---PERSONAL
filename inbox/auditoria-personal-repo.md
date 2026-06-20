---
tags: [auditoria, personal, migracion, pendiente]
fecha: 2026-06-20
destino: se cierra cuando personal esté archivado
---

# 📋 Auditoría repo `personal` — Qué migrar y qué archivar

## Lo que ya está migrado hoy

| Origen en `personal` | Destino en ygg | Estado |
|---|---|---|
| `00_sistema/equipos.md` | `setup/varopc.md` + `setup/madre.md` + `setup/hp-touchsmart.md` | ✅ migrado |
| Hardware Madre | `setup/madre.md` | ✅ migrado |
| Hardware varopc | `setup/varopc.md` | ✅ migrado |
| Hardware HP | `setup/hp-touchsmart.md` | ✅ migrado |
| `02_formacion/02_python/` | `formacion/python.md` (apunta) | ✅ SE QUEDA en personal |

## Pendiente de migrar

### 🔴 Alta prioridad
| Carpeta | Contenido | Destino |
|---|---|---|
| `01_traking_diario/` | Diarios históricos | `diarios/` en ygg |
| `00_sistema/sistema-filosofia.md` | Filosofía técnica | `filosofia.md` en ygg |
| `00_sistema/CONTEXT.md` | Contexto anterior | Revisar vs `CONTEXT.md` ygg |

### 🟡 Media prioridad
| Carpeta | Contenido | Destino |
|---|---|---|
| `02_formacion/07_linux/` | Aprendizaje Linux | `formacion/linux.md` |
| `02_formacion/05_sql/` | Aprendizaje SQL | `formacion/sql.md` |
| `02_formacion/03_so2-kernel/` | SO / kernel | Revisar — puede archivar |
| `04_curiosidad/` | Notas curiosidades | `inbox/` lo útil |
| `00_yo/` | Perfil personal | `yo/` en ygg |
| `00_sistema/PROMPTS-DICCIONARIO.md` | Prompts útiles | `agentes/prompts.md` |
| `00_sistema/nuevo-dia.sh` | Script nuevo día | `setup/varopc.md` |

### 🟢 Baja prioridad / revisar si borrar
| Carpeta | Contenido | Decisión |
|---|---|---|
| `03_proyectos/` + `05_proyectos/` | Proyectos anteriores (duplicado) | Revisar y limpiar |
| `05_contenido/` | Contenido creado | Revisar |
| `02_formacion/04_lenguaje-c/` | C | Archivar (no activo) |
| `02_formacion/06_cursos-externos/` | Cursos externos | Revisar |
| `00_sistema/openclaw/` | ? | Leer antes de decidir |

## Lo que SE QUEDA en `personal` (intocable)

- `02_formacion/02_python/` — curso completo, se acaba ahí
- Historial de diarios antiguos — archivo histórico

## Cuando esté todo migrado

- [ ] `personal/README.md` → marcar como "Archivado — migrado a yggdrasil-dew"
- [ ] Mantener el repo público como histórico
- [ ] Eliminar del vault local si ocupa demasiado

---

_Esta nota se cierra cuando personal esté archivado · 20 jun 2026_
