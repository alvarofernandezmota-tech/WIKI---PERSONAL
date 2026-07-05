---
tipo: isla
nombre: THDORA
descripcion: Bot Telegram del ecosistema — interfaz conversacional con todo el sistema
repo_principal: https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL
github_issues: https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues
obsidian_link: "[[thdora]]"
depende_de: [infra, ia-local]
sirve_a: [cerebro]
estado: activo-con-deuda
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
---

# 🦾 Isla: THDORA

THDORA es el **bot Telegram** del ecosistema. Es la interfaz conversacional que permite interactuar con Madre, con los modelos de IA local y con el ecosistema desde cualquier dispositivo.

> ⚡ Código y deuda técnica → [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL)

---

## Stack técnico (mapa)

- **Lenguaje:** Python
- **Framework:** python-telegram-bot + FastAPI
- **IA:** Groq API + Ollama local (en migración)
- **Corre en:** Madre vía Docker · Puerto 8000

---

## Deuda técnica activa

| Issue | Problema | Prioridad |
|---|---|---|
| [thdora#12](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/12) | Duplicación `src/bot/agents/` + 3 LLM zombie | 🔴 Crítica |
| [thdora#10](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/10) | `/config` timeout `asyncio.wait_for` 5s | 🔴 Crítica |
| [thdora#17](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/17) | Crear `scripts/deploy.sh` | 🟠 Alta |

## Regla de deuda

> No se crea repo nuevo ni bot nuevo hasta que `thdora#12`, `thdora#10` y `thdora#17` estén cerrados.

---

## Conexiones

- ← [[infra]] (corre en Madre vía Docker)
- ← [[ia-local]] (usa modelos Ollama de Madre)
- → [[cerebro]] (reporta estado al ecosistema)

---
_Actualizado: 2026-07-05 21:00 CEST · Perplexity-MCP_
