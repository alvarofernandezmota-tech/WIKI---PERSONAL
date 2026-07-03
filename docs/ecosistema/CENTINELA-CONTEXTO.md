# CONTEXTO PARA EL CENTINELA — Puesta al día

> Este documento existe para que cualquier IA/agente/bot que se una al ecosistema
> tenga el contexto mínimo necesario para no estar perdido.  
> Actualizar al inicio de cada semana o tras cambios estructurales grandes.

---

## ¿Qué es este ecosistema?

Ecosistema personal de infraestructura, automatización y conocimiento.
Construido sobre **Arch Linux** (Madre = PC principal) + **GitHub** como cerebro.

**Repos principales:**
- `yggdrasil-dew` — segundo cerebro, documentación, gestión del ecosistema
- `thdora` — bot Telegram principal (FastAPI + aiogram)
- `yggdrasil-secops` — seguridad y monitorización

---

## Estado al 2026-07-03

### Infraestructura activa
- **Madre (varopc):** Arch Linux, GTX 1060, Docker corriendo
- **thdora:** Docker compose UP (en proceso de estabilización)
- **Ollama:** Descargando modelos (~15GB, llama3.1 + mistral + codellama)
- **Tailscale:** Red privada Madre ↔ Acer ↔ iPhone activa
- **Wazuh:** Monitorización de seguridad activa

### Deuda técnica crítica (bloquea avance)
1. `thdora#12` — código zombie en `src/bot/agents/` — **eliminar**
2. `thdora#10` — `/config` timeout → `asyncio.wait_for` 5s — **3 líneas de fix**

### Fase actual: Fase 5 → 6a
No se avanza a Fase 6a hasta cerrar thdora#12 y #10.

---

## Reglas del ecosistema (resumen)

1. **Una terminal nueva por tarea** — no ocupar la terminal principal
2. **Regla SINE** — Script → Issue → Nota → Ejecutar (en ese orden)
3. **Un solo punto de entrada** — todo conectado, nada disperso
4. **GitHub Action = produce artifacts. Bot = consume artifacts. Script = ejecuta en Madre.**
5. **No se abre repo nueva hasta cerrar deuda técnica activa**
6. **Todo pendiente tiene destino:** MASTER-PENDIENTES / Issue / inbox / p0-critico

---

## Arquitectura de bots

| Bot | Puerto | Dominio | Estado |
|---|---|---|---|
| TOKI-Guardian | :8000 | Infra Madre | En construcción |
| TOKI-DEW | :8001 | Repo yggdrasil-dew | Pendiente |
| TOKI-Personal | :8002 | Productividad | Futuro |

Futuro: ROUTER-BOT como único punto de entrada que delega a los tres.

---

## Dónde está todo

| Qué necesitas | Dónde mirarlo |
|---|---|
| Estado de fases | `docs/PLAN-MAESTRO-ECOSISTEMA.md` |
| Issues activos | GitHub Issues (yggdrasil-dew + thdora) |
| Pendientes del día | `MASTER-PENDIENTES.md` (raíz) |
| Reglas del ecosistema | `docs/NORMAS-ECOSISTEMA.md` |
| Scripts disponibles | `scripts/SCRIPTS.md` |
| Arquitectura decisiones | `docs/arquitectura/` |
| Fuentes investigadas | `docs/bitacora/BITACORA-FUENTES.md` |
| Diario de sesiones | `docs/diarios/` |

---

## Lo que NO debes hacer sin preguntar

- Crear repos nuevas (deuda técnica activa)
- Mezclar dominios de bots (cada bot = un dominio)
- Hacer commits directos a main sin issue relacionado
- Eliminar archivos sin verificar si tienen referencias cruzadas

---

_Actualizado: 2026-07-03 — Perplexity vía MCP_  
_Próxima actualización: al completar thdora#12 + #10_
