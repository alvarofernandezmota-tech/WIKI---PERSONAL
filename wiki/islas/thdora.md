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
actualizado: 2026-07-06
tags: [thdora, telegram, bot, python, docker, ia-local]
---

# 🦷 Isla: THDORA

THDORA es el **bot Telegram personal** del ecosistema. Es la interfaz conversacional que permite interactuar con Madre, con los modelos de IA local y con el ecosistema completo desde cualquier dispositivo — especialmente desde el iPhone.

> **¿Por qué existe THDORA?**  
> Porque la mayor parte del tiempo no tengo un ordenador delante. THDORA convierte el móvil en el panel de control del ecosistema: puedo consultar el estado de los servicios, lanzar comandos, hablar con los modelos de IA local y recibir alertas — todo desde Telegram sin abrir ningún otro cliente.

> ⚡ Código, issues y deuda técnica → [`THDORA-PERSONAL`](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL)  
> ⚡ Decisión de arquitectura → [ADR-001](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ADR-001-platform-stack.md#-isla-thdora)

---

## Qué hace THDORA

| Función | Estado |
|---|---|
| Consultar estado de servicios Docker en Madre | ✅ activo |
| Conversar con modelos Ollama locales (Llama3, Mistral) | 🚧 en migración desde Groq |
| Recibir alertas del `guardian_bot` de seguridad | ✅ activo |
| Lanzar comandos en Madre vía Telegram | 🚧 parcial |
| Responder preguntas sobre el ecosistema (RAG local) | 🔴 pendiente — requiere ADR-003 implementado |

---

## Stack técnico

| Componente | Detalle |
|---|---|
| Lenguaje | Python 3.11 |
| Framework | `python-telegram-bot` + FastAPI |
| IA actual | Groq API (cloud) |
| IA objetivo | Ollama local en Madre (ADR-003) |
| Transporte | Docker en Madre · puerto 8000 |
| Acceso | Solo vía Tailscale + Telegram |

**Dos contenedores separados** (decisión en ADR-001):
- `thdora` — backend (API, lógica, conexión con Ollama)
- `thdora-bot` — interfaz Telegram (recibe mensajes, manda respuestas)

Separados para poder actualizar cada capa de forma independiente sin reiniciar el bot completo.

---

## Deuda técnica activa

| HAL / Issue | Problema | Prioridad | Link |
|---|---|---|---|
| HAL-001 | Token de Telegram en historial git — rotar urgente | 🔴 crítica | [secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) |
| HAL-003 | Segunda exposición de token en historial | 🔴 crítica | [secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) |
| thdora#12 | Duplicación en `src/bot/agents/` + 3 LLM zombie | 🔴 crítica | [issue](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/12) |
| thdora#10 | `/config` timeout `asyncio.wait_for` 5s | 🔴 crítica | [issue](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/10) |
| thdora#17 | Crear `scripts/deploy.sh` | 🟠 alta | [issue](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL/issues/17) |

### Regla de deuda

> **No se crea repo nuevo ni bot nuevo** hasta que thdora#12 y thdora#10 estén cerrados.  
> **No se hace push a repos públicos** hasta que HAL-001 y HAL-003 estén resueltos (token rotado).

---

## Ambigüedad `thdora` vs `THDORA-PERSONAL` — resuelta

| Nombre | Rol |
|---|---|
| `THDORA-PERSONAL` | Repo GitHub — código fuente, issues, historial |
| `thdora` | Contenedor Docker que corre en Madre |
| `thdora-bot` | Contenedor Docker de la interfaz Telegram |
| Isla Thdora | Este archivo — el mapa conceptual de la isla |

No son lo mismo. El repo contiene el código. Los contenedores son las instancias corriendo. La isla es el mapa.

---

## Conexiones

- ← [[infra]] (corre en Madre vía Docker, accesible por Tailscale)
- ← [[ia-local]] (usa modelos Ollama de Madre — en migración)
- → [[cerebro]] (reporta estado y alertas al ecosistema)
- ← [[seguridad]] (recibe alertas del guardian_bot)

---

_Actualizado: 2026-07-06 · Perplexity-MCP · Ampliado con tabla de funciones, stack detallado, ambigüedad thdora resuelta, HALs vinculados_
