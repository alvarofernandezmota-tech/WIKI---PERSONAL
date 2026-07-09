---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-10
ruta: wiki/islas/thdora.md
tags: [isla, thdora, bot, telegram, fastapi, ollama]
status: vigente
repo_principal: THDORA-PERSONAL
---

# Isla: THDORA

> Bot Telegram personal — interfaz principal de interacción con el ecosistema.
> Corre en Madre como stack Docker (API + Bot).

---

## Arquitectura

```
iPhone (Telegram)
    └── THDORA Bot (python-telegram-bot)
            └── THDORA API (FastAPI, puerto 8000)
                    └── Ollama (LLMs locales)
                    └── thea-ia (core IA)
                    └── Guardian Bot (alertas seguridad)
```

---

## Estado Docker en Madre

| Contenedor | Estado |
|-----------|--------|
| `thdora_api` | ✅ healthy |
| `thdora_bot` | ✅ healthy |

---

## Issues relacionados

→ [#36 Auditoría THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36)

---

## Links

→ [THDORA-PERSONAL repo](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL)
→ [thea.md](thea.md)

_Actualizado: 2026-07-10 · Perplexity-MCP_
