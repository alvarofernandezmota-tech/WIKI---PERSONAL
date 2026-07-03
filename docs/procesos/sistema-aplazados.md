---
titulo: "Sistema de Aplazados — Inbox con Urgencia Automática"
estado: "activo"
fecha_creacion: "2026-07-03"
tags: ["inbox", "proceso", "automatizacion"]
---

# Sistema de Aplazados

## Concepto

Cuando una tarea no puede procesarse inmediatamente, **no se elimina del inbox** — se convierte en un archivo `APLAZADO-*.md` con frontmatter estructurado.

Cada mañana, `morning-check.sh` calcula automáticamente cuántos días lleva aplazado y asigna urgencia.

## Escala de urgencia automática

| Días aplazado | Urgencia | Acción recomendada |
|---|---|---|
| 0-1 | 🟢 baja | Normal |
| 2-3 | 🟡 media | Planificar esta semana |
| 4-6 | 🟠 alta | Hacer hoy o mañana |
| 7+ | 🔴 crítica | Bloqueo — resolver YA |

La urgencia manual en frontmatter (`urgencia_manual`) sobreescribe el cálculo automático.

## Estados

- `no_empezado` — capturado, sin tocar
- `en_progreso` — se está trabajando
- `completado` — listo para mover a `docs/` con `migrate-inbox.sh`

## Flujo completo

```
Captura rápida (iPhone/Blink)
    ↓
inbox/APLAZADO-descripcion.md   ← copia del template, rellenar frontmatter
    ↓ (días pasan)
morning-check.sh muestra urgencia automática
    ↓ (cuando se resuelve)
cambiar estado: completado
    ↓
bash scripts/maintenance/migrate-inbox.sh
    ↓
docs/[destino]/   ← conocimiento permanente
```

## Archivos del sistema

- `inbox/APLAZADO-template.md` — plantilla base
- `scripts/maintenance/morning-check.sh` — muestra aplazados con urgencia
- `scripts/maintenance/migrate-inbox.sh` — mueve completados a docs/

## Regla de oro

> El inbox nunca acumula días sin que se sepa. Cada archivo aplazado lleva su contador visible. Si hay 🔴 críticas al despertar, van primero.
