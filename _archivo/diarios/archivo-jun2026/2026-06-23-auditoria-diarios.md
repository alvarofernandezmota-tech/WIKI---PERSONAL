---
tags: [auditoria, diarios, estructura, obsidian, refactor]
fecha: 2026-06-23
estado: pendiente-ejecutar
ruta-obsidian: inbox/2026-06-23-auditoria-diarios.md
---

# Auditoría `diarios/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Estado actual

### ✅ Lo que está bien
- `README.md` — existe
- `_plantilla.md`, `_dia.md`, `_mes.md`, `_semana.md` — plantillas completas
- Carpeta `diarios/2026/` — existe pero vacía

### 🔴 Problemas
- 12 diarios sueltos en raíz en lugar de dentro de `2026/`
- Sin subcarpetas por mes (`2026/06/`, `2026/05/`...)
- Diarios sin frontmatter YAML estandarizado
- README no tiene índice con wikilinks Obsidian

## Archivos a mover

| Archivo actual | Destino correcto |
|---|---|
| `diarios/2026-06-05.md` | `diarios/2026/06/2026-06-05.md` |
| `diarios/2026-06-12.md` | `diarios/2026/06/2026-06-12.md` |
| `diarios/2026-06-13.md` | `diarios/2026/06/2026-06-13.md` |
| `diarios/2026-06-14.md` | `diarios/2026/06/2026-06-14.md` |
| `diarios/2026-06-15.md` | `diarios/2026/06/2026-06-15.md` |
| `diarios/2026-06-15-redmi-a5-flash-errores.md` | `diarios/2026/06/2026-06-15-redmi-a5-flash-errores.md` |
| `diarios/2026-06-16.md` | `diarios/2026/06/2026-06-16.md` |
| `diarios/2026-06-17.md` | `diarios/2026/06/2026-06-17.md` |
| `diarios/2026-06-18.md` | `diarios/2026/06/2026-06-18.md` |
| `diarios/2026-06-20.md` | `diarios/2026/06/2026-06-20.md` |
| `diarios/2026-06-22.md` | `diarios/2026/06/2026-06-22.md` |
| `diarios/2026-06-23.md` | `diarios/2026/06/2026-06-23.md` |

## Estructura objetivo

```
diarios/
  README.md                    ← índice maestro con wikilinks
  _plantilla.md                ← plantilla diaria
  _dia.md                      ← referencia formato día
  _mes.md                      ← referencia formato mes
  _semana.md                   ← referencia formato semana
  2026/
    README.md                  ← índice año 2026
    06/
      README.md                ← índice junio 2026
      2026-06-23.md
      2026-06-22.md
      ...
    05/
      README.md                ← índice mayo (si hay entradas)
```

## Frontmatter YAML estándar para cada diario

```yaml
---
tags: [diario, YYYY-MM]
fecha: YYYY-MM-DD
tipo: diario-dia
resumen: "Una línea resumen del día"
proyectos: [proyecto1, proyecto2]
---
```

## Pasos a ejecutar

- [ ] Crear `diarios/2026/06/README.md` — índice junio
- [ ] Crear `diarios/2026/README.md` — índice año
- [ ] Mover los 12 diarios a `diarios/2026/06/`
- [ ] Añadir frontmatter YAML a los que no lo tengan
- [ ] Actualizar `diarios/README.md` con wikilinks a años/meses
- [ ] Repetir estructura para meses anteriores si existen

## Enlace Obsidian

Desde `HOME.md` añadir:
```
[[diarios/README]] — Diarios técnicos 2026
[[diarios/2026/06/2026-06-23]] — Hoy
```
