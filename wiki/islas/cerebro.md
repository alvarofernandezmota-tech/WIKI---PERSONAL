---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/cerebro.md
tags: [isla, cerebro, wiki, conocimiento, segundo-cerebro, dew, vidapersonal]
status: auditada
---

# Isla: Cerebro (Segundo cerebro digital)

> Sistema de gestión del conocimiento personal del ecosistema.
> El triángulo que lo forma: **DEW** (operativo) + **Wiki** (conocimiento) + **VIDAPERSONAL** (vida).

---

## El triángulo del cerebro

```
        DEW
       (plan, issues, canon, ADRs)
      /         \
     /           \
  Wiki ———— VIDAPERSONAL
(fichas,       (diarios, hábitos,
 islas,         proyectos vida)
historial)
```

| Repo | Qué guarda | Actualización |
|------|-----------|---------------|
| [`yggdrasil-dew`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Plan maestro, issues, canon, ADRs | Continua (cada sesión) |
| [`yggdrasil-wiki`](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki) | Fichas de islas, convenciones, historial | Continua (cada cambio de estado) |
| [`VIDAPERSONAL`](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL) | Diarios, hábitos, metas, proyectos vida | Semanal (cada domingo) |

---

## Regla de alineación DEW ↔ Wiki

> **Cada cambio de estado en una isla → actualizar su ficha en Wiki.**
> **Cada tarea pendiente → issue en DEW, nunca en un chat.**
> **Nunca duplicar información.** Si está en Wiki, DEW referencia Wiki. No repite.

---

## Agentes que alimentan el cerebro

| Agente | Rol |
|--------|-----|
| Perplexity (MCP) | Gestiona repos, crea issues, actualiza Wiki y DEW |
| Claude | Auditorías profundas, análisis de estructura |
| THDORA | Interfaz Telegram — consultas rápidas al ecosistema |

---

## Estado real — 2026-07-13

✅ **DEW y Wiki activos y en alineación continua.**
🟡 **VIDAPERSONAL**: migrada a estructura canónica el 2026-07-10, pendiente limpieza final (DEW #48).

---

## Issues DEW relacionados

- [DEW #48 — AUDIT-006 VIDAPERSONAL](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/48)
- [DEW #50 — GOB-001 Filosofía](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/50)

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
