---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/thea.md
tags: [isla, thea, ia, agente, python, thdora]
status: auditada
repo_principal: thea-ia
---

# Isla: Thea IA (core Python)

> Core de inteligencia artificial personal del ecosistema.
> `thea-ia` es la librería Python base. `THDORA-PERSONAL` es la interfaz Telegram + API que la consume.

---

## Arquitectura

```
thea-ia (core IA — Python)
    └── THDORA-PERSONAL (bot Telegram + FastAPI)
            └── Madre (Docker — thdora-bot + thdora-api)
                    └── Telegram (canal de comunicación)
```

| Repo | Rol | Estado |
|------|-----|--------|
| [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) | Core Python IA | 🔴 Sin actividad desde feb 2026 |
| [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot + API | 🔴 Caído (HAL-007 + HAL-008) |

---

## Decisión arquitectural pendiente

> **¿Qué es thea-ia hoy?** Hay tres opciones abiertas:

| Opción | Descripción | Consecuencia |
|--------|-------------|---------------|
| A. Archivar | thea-ia queda obsoleto | THDORA funciona sin core separado |
| B. Fusionar | Código de thea-ia → dentro de THDORA-PERSONAL | Un solo repo |
| C. Librería | thea-ia se convierte en paquete que importa THDORA | Arquitectura limpia |

⚠️ **Esta decisión debe tomarse antes de reactivar THDORA** (ver [DEW #49](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49)).

---

## Estado real — 2026-07-13

- `thea-ia`: sin commits desde febrero 2026, decisión pendiente
- `THDORA-PERSONAL`: bot y API caídos por `.env` malformado (HAL-007) y token Telegram revocado (HAL-008)
- Ollama corre en Madre y puede ser el motor LLM una vez THDORA vuelva

---

## Issues DEW relacionados

- [DEW #44 — HAL-007 .env malformado](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) 🔴 BLOQUEANTE
- [DEW #45 — HAL-008 rotar token Telegram](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) 🔴 BLOQUEANTE
- [DEW #49 — AUDIT-007 Orquestador](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49)

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
