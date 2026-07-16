---
tipo: agent
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
ruta: AGENT.md
tags: [agent, protocolo, wiki]
status: vigente
version: 1
---

# AGENT.md — WIKI---PERSONAL

> Instrucciones para agentes IA que trabajen en este repo.  
> Leer este archivo **antes de ejecutar cualquier acción**.

---

## Identidad del repo

| Campo | Valor |
|---|---|
| **Nombre** | `WIKI---PERSONAL` |
| **Propósito** | Conocimiento estático del ecosistema: mapas, islas, convenciones |
| **Tipo** | Wiki — mapa del ecosistema, no decisión ni tracking |
| **Isla wiki** | Este repo ES la wiki |
| **ADR principal** | ADR-003 (fundación de la wiki) |

---

## Protocolo de inicio (obligatorio)

Antes de cualquier acción, leer en este orden:

1. `yggdrasil-dew/docs/sesiones/PROXIMA-SESION.md` — estado y bloques pendientes
2. `CONTEXT.md` — contexto del ecosistema completo
3. `wiki/islas/INDEX.md` — estado actual de todas las islas
4. Issues abiertos en DEW con label relevante para la sesión

---

## Reglas de este repo

### ✅ Hacer siempre
- Toda isla nueva sigue `yggdrasil-dew/docs/canon/NORMA-ENTRADA-NUEVA-ISLA.md`
- Toda isla nueva se añade a `wiki/islas/INDEX.md` y `wiki/mapa-islas.md`
- Nombres de repos siempre los canónicos exactos (ver `CONTEXT.md`)
- Frontmatter completo en todos los archivos `.md`
- Commit message: `tipo(scope): descripción — closes #N`

### ❌ Nunca hacer
- Usar nombres de repos aliases o viejos (ej: `yggdrasil-wiki`, `vidapersonal`)
- Crear archivos sin frontmatter
- Borrar islas sin issue aprobado y sin comprobar que no hay referencias
- Editar `INDEX.md` sin actualizar `mapa-islas.md` en el mismo commit

---

## Estructura del repo

```
WIKI---PERSONAL/
└── wiki/
    ├── 00-mapa.md         ← punto de entrada del ecosistema
    ├── mapa-islas.md      ← vista de todas las islas
    ├── CONVENCIONES.md    ← normas de escritura
    ├── MODELO-MENTAL.md   ← filosofía del ecosistema
    └── islas/
        ├── INDEX.md           ← índice canónico de todas las islas
        └── [nombre].md        ← ficha de cada isla
```

---

## Conexiones con el ecosistema

| Repo relacionado | Relación |
|---|---|
| `yggdrasil-dew` | Canon: decisiones, protocolos, issues — siempre |
| `yggdrasil-tracking` | Isla `tracking.md` referencia este repo |
| Todos los repos | Cada repo tiene isla en `wiki/islas/` |

---

## Protocolo de cierre (obligatorio)

1. `wiki/islas/INDEX.md` actualizado si se tocó alguna isla
2. `wiki/mapa-islas.md` sincronizado con INDEX.md
3. `git push` limpio
4. Seguir `yggdrasil-dew/docs/canon/PROTOCOLO-CIERRE-SESION.md`

---

_Instanciado desde: `yggdrasil-dew/docs/canon/AGENT-template.md`_  
_Última actualización: 2026-07-16_
