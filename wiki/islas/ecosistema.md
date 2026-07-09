---
tipo: isla
author: Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
creado: 2026-07-09
actualizado: 2026-07-09 23:07 CEST
ruta: wiki/islas/ecosistema.md
tags: [isla, ecosistema, repos, gobernanza, yggdrasil]
status: vigente
---

# Isla: Ecosistema Yggdrasil

> Mapa conceptual del ecosistema. Los detalles técnicos viven en Dew.
> Esta isla responde a: ¿Qué es el ecosistema y cómo se organiza?

---

## Qué es Yggdrasil

Ecosistema personal de infraestructura, seguridad y automatización.
Todo gira alrededor de **Madre** (servidor principal) con acceso remoto via Tailscale.

---

## Repos del ecosistema

| Repo | Para qué sirve | Visibilidad |
|---|---|---|
| `yggdrasil-dew` | Documentación técnica, ADRs, diarios, canon | Público |
| `yggdrasil-secops` | Bots de seguridad, Docker, scripts operativos | 🔒 Privado |
| `thdora-personal` | Bot Telegram personal (Thdora) | 🔒 Privado |
| `WIKI---PERSONAL` | Mapas conceptuales, modelo mental, conocimiento | 🔒 Privado |

---

## Cómo se documenta

| Capa | Dónde vive | Qué contiene |
|---|---|---|
| Canon (reglas) | `yggdrasil-dew/docs/canon/` | Convenciones, ADRs, runbooks |
| Operativa (qué pasó) | `yggdrasil-dew/docs/diarios/` | Diarios de sesión |
| Infraestructura | `yggdrasil-dew/docs/infra/` | Madre, Docker, red |
| Auditorías | `yggdrasil-dew/docs/auditorias/` | Fichas por repo |
| Mapas mentales | `WIKI---PERSONAL/wiki/` | Islas conceptuales |

---

## Estado a 2026-07-09

- Todos los repos privados salvo `yggdrasil-dew` ✅
- WIKI limpiada: solo `wiki/` con islas conceptuales ✅
- `inbox/` y `docs/` WIKI borradas completamente ✅
- 15 issues abiertas en Dew — priorizadas
- HAL-006 (.env expuesto) pendiente 🔴
- HDD Madre 28k+ horas — pendiente smartctl 🔴

---

## Links a Dew (fuente de verdad)

→ [DASHBOARD.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/DASHBOARD.md)
→ [PLAN-MAESTRO-2026-07.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/PLAN-MAESTRO-2026-07.md)

---

_Actualizado: 2026-07-09 23:07 CEST · Perplexity-MCP_
