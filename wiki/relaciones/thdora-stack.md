---
tipo: relacion
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05 21:18 CEST
ruta: wiki/relaciones/thdora-stack.md
tags: [relacion, thdora, bot, telegram, dew, madre, secops]
status: vigente
islas: [thdora, ia-local, infra, seguridad]
---

# 🦾 THDORA Stack — Relaciones del ecosistema

> Cómo THDORA se relaciona con Dew, WIKI, Madre y SecOps.
> Esta relación es la capa de interfaz conversacional del ecosistema.

---

## Qué es THDORA en el ecosistema

THDORA es el **bot Telegram** que sirve como interfaz conversacional entre el usuario y el ecosistema. Es el único punto de contacto móvil con Madre cuando no hay acceso SSH directo.

---

## Mapa de relaciones

| Componente | Capa | Relación con THDORA |
|---|---|---|
| `yggdrasil-dew` | Cerebro | Dew documenta la arquitectura y deuda de THDORA |
| `WIKI` (esta wiki) | Conceptual | Isla [[thdora]] = mapa conceptual del bot |
| `madre-config` | Infra | Madre ejecuta THDORA vía Docker (puerto 8000) |
| `yggdrasil-secops` | Seguridad | SecOps audita el bot (credenciales, tokens, exposición) |
| `ollama-stack` | IA Local | THDORA llama a Ollama como backend de IA |
| `formacion-tech` | Formación | Python async, FastAPI → aplicado en handlers THDORA |

---

## Qué es conceptual (vive en WIKI)

- La visión de THDORA como interfaz conversacional del ecosistema
- El mapa de qué puede hacer el bot en cada fase
- Las relaciones entre THDORA y las otras islas

## Qué es técnico (vive en Dew)

- Arquitectura del bot (handlers, agentes, LLM)
- Deuda técnica activa (issues #10, #12, #17)
- Roadmap de migración Groq → Ollama local
- Decisiones de diseño

## Qué es operativo (vive en Madre / madre-config)

- Docker compose del bot
- Variables de entorno y secrets
- Scripts de deploy y restart
- Logs de ejecución

## Qué es de seguridad (vive en SecOps)

- Auditoría de tokens Telegram expuestos
- Auditoría de puertos del bot
- Plan de rotación de credenciales

---

## Deuda técnica activa (resumen conceptual)

> Detalle completo → issues [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues)

| Issue | Problema | Bloquea |
|---|---|---|
| [#12](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/12) | Duplicación agentes + 3 LLM zombie | Todo lo demás |
| [#10](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/10) | Timeout `/config` asyncio 5s | Estabilidad |
| [#17](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/17) | Falta `scripts/deploy.sh` | Operaciones |

> ⚠️ **Regla activa:** No se crea repo nuevo ni bot nuevo hasta que #12, #10 y #17 estén cerrados.

---

## Conexiones

- → [[thdora]] (isla principal del bot)
- → [[ia-local]] (backend de IA que usa THDORA)
- → [[infra]] (Madre donde corre el bot)
- → [[seguridad]] (SecOps audita tokens y exposición)

---
_Actualizado: 2026-07-05 21:18 CEST · Perplexity-MCP_
