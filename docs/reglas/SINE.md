---
fecha_creacion: "2026-07-03"
tags: ["regla", "documentacion", "ecosistema", "flujo"]
version: "1.0"
---

# Regla SINE — Simultáneo, Inmediato, Natural, Etiquetado

> "Todo lo que ocurre en el ecosistema se documenta simultáneamente en todos los sitios donde corresponda.
> Cuando el archivo sea subido a la repo o al local, se le busca el hueco y se le etiqueta."

## Definición

SINE es la regla de documentación del ecosistema yggdrasil. No es una regla adicional — **es la forma natural de operar**.

| Letra | Significado | Qué implica |
|---|---|---|
| **S** | Simultáneo | Se documenta en todos los sitios a la vez, no después |
| **I** | Inmediato | En el momento en que ocurre, no al final del día |
| **N** | Natural | Es el flujo normal, no un extra de trabajo |
| **E** | Etiquetado | Todo archivo recibe sus tags/labels al subirse |

## Los 4 destinos simultáneos

Cualquier cosa que ocurra en el ecosistema va a **los 4 sitios a la vez**:

```
┌─────────────────────────────────────────────────┐
│              ALGO OCURRE                        │
│  (decisión, hallazgo, fix, idea, error, regla)  │
└──────────────┬──────────────────────────────────┘
               │
       ┌───────┴────────┐
       ▼                ▼
  📥 inbox/         📖 diario del día
  captura rápida    contexto + notas
       │                │
       ▼                ▼
  📁 docs/          🏷️ GitHub Issue
  hueco permanente  seguimiento + label
```

## Flujo detallado

1. **Captura** → `inbox/YYYY-MM-DD-nombre.md` (30 segundos, sin pensar)
2. **Diario** → añadir línea en `docs/diarios/YYYY-MM-DD.md` en la sección correspondiente
3. **Permanente** → mover/crear en `docs/[categoria]/` con tags frontmatter
4. **Issue** → crear o actualizar en la repo correspondiente con label correcto

## Etiquetado obligatorio

Todo archivo en docs/ lleva frontmatter mínimo:
```yaml
---
fecha: "YYYY-MM-DD"
tags: ["categoria", "subcategoria"]
estado: "activo|archivado|pendiente"
---
```

Todo issue en GitHub lleva al menos:
- Label de fase (`fase-0` ... `fase-8`)
- Label de tipo (`bug`, `enhancement`, `documentacion`, `seguridad`...)
- Label de prioridad (`prioridad-critica`, `prioridad-alta`, `prioridad-normal`)

## Regla de simetría de issues

**Todo issue en una repo del ecosistema tiene su espejo maestro en yggdrasil-dew.**

```
thdora#12 (deuda técnica)  →  yggdrasil-dew: [ECOSISTEMA] thdora deuda técnica
thdora#10 (bug /config)    →  yggdrasil-dew: [ECOSISTEMA] thdora deuda técnica
thdora-bots (nuevo)        →  yggdrasil-dew: [ECOSISTEMA] bots arquitectura
```

El issue maestro en dew es el **punto de navegación** — no duplica información, apunta a los issues reales.

## Cuándo se aplica

- Al tomar una decisión técnica ✅
- Al detectar un bug ✅
- Al crear un script ✅
- Al abrir una sesión de trabajo ✅
- Al cerrar una sesión de trabajo ✅
- Al definir una regla (como esta misma) ✅
- Al capturar una idea en el móvil ✅

## Herramientas de soporte

| Herramienta | Función SINE |
|---|---|
| `new-session.sh` | Abre diario + muestra aplazados |
| `session-close.sh` | Cierra diario + commit + push |
| `migrate-inbox.sh` | Mueve inbox → docs/ con tags |
| `audit-full.sh` | Verifica que todo está documentado |

## Origen

Definida el 2026-07-03 en sesión de madrugada. Surge de la necesidad de que el ecosistema sea auditable y el agente IA futuro pueda navegar el estado real sin preguntar.
