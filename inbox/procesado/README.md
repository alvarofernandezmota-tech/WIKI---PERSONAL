---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 23:55 CEST
actualizado: 2026-07-03 23:55 CEST
ruta: inbox/README.md
tags: [inbox, estados, tracker, normas]
status: vigente
---

# 📥 INBOX — Sistema de entrada y estados

El inbox es el **punto de entrada único** de todos los artefactos del ecosistema.
Ningún archivo va directamente a `docs/` sin pasar primero por aquí.

## Estructura

```
inbox/
├── README.md          ← este archivo (normas)
├── .tracker/          ← estados de artefactos (no commitear .tracker/*.json)
├── terminal-log/      ← logs de terminal (terminal-logger.sh)
├── mejorador/         ← reports de agente-mejorador (JSON)
├── deuda/             ← deuda técnica detectada (JSON + ranking MD)
└── (otros artefactos directos)
```

## Estados de artefactos

| Emoji | Estado | Significado | Acción siguiente |
|---|---|---|---|
| 🔴 | `por-hacer` | Detectado, sin acción | Asignar, planificar |
| 🟡 | `en-proceso` | Trabajo activo en curso | Completar |
| 🟢 | `completado` | Terminado y validado | Archivar a docs/ |
| ⚪ | `archivado` | Movido a destino final | — |
| 🔵 | `bloqueado` | Necesita algo externo | Resolver bloqueo |

## Cómo marcar estados

```bash
# Marcar como en-proceso
bash scripts/agentes/agente-estado-tracker.sh --mark en-proceso inbox/mi-artefacto.md

# Marcar como completado
bash scripts/agentes/agente-estado-tracker.sh --mark completado inbox/mi-artefacto.md

# Ver reporte de todos los estados
bash scripts/agentes/agente-estado-tracker.sh --report
```

## Reglas

- **Todo** lo que produce un agente va a una subcarpeta de `inbox/`
- **Todo** lo que se ejecuta en terminal relevante va a `inbox/terminal-log/`
- Los artefactos `completados` se mueven a `docs/` en el cierre de sesión
- `.tracker/` no se commitea (está en .gitignore)
- Nunca dejar artefactos en estado `por-hacer` más de 48h sin avanzar

_Actualizado: 2026-07-03 23:55 CEST · Perplexity-MCP_
