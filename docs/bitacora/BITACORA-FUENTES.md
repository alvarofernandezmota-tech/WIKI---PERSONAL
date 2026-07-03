# BITÁCORA DE FUENTES — ECOSISTEMA YGGDRASIL

> Registro de dónde hemos consultado cada decisión técnica.  
> Regla: **siempre se puede volver al origen.**

---

## Formato de entrada

```
### [FECHA] — [TEMA]
- URL o referencia
- Por qué lo consultamos
- Qué decidimos basándonos en eso
- Enlace al doc donde se aplicó
```

---

## 2026-07-03 — Arquitectura GitHub Action vs Bot

**Pregunta investigada:** ¿GitHub Action prepara artifact y bot lo consume? ¿O bot hace todo?

### Fuentes consultadas

| Fuente | URL | Qué aportó |
|---|---|---|
| GitHub Actions workflow ecosystem paper | https://arxiv.org/pdf/2305.04772.pdf | Patrón de separación CI/CD vs bots de chat |
| GitHub Agentic Workflows glossary | https://github.github.com/gh-aw/reference/glossary/ | Terminología oficial de workflows agénticos |
| File-edit + auto-merge bot pattern | https://gist.github.com/blanchardjeremy/07dbc9bd271bb9c8077c8c906307aaec | Patrón cron→script→artifact→PR usado en producción |
| Telegram bot-to-bot communication (Bot API 10.0) | https://github.com/openclaw/openclaw/issues/85754 | Protocolo "secretary bot" para delegación de tareas |
| Telegram como front-door de AI agents | https://pub.towardsai.net/telegram-is-quietly-becoming-the-default-front-door-for-ai-agents-e0ba57a5b681 | Arquitectura 3 capas async workflows |
| aiogram 3 clean architecture | https://github.com/barahouei/clean-architecture-telegram-bot | Separación handlers/dominio/infra en bots |
| Guidelines for Developing Bots for GitHub | https://arxiv.org/pdf/2211.13063.pdf | Cuándo un bot se vuelve disruptivo vs útil |

### Decisión tomada

**GitHub Action = productor de artifacts. Bot = consumidor/presentador.**  
Aplicado en: `docs/arquitectura/github-action-vs-bot-patron.md`

---

## 2026-07-03 — Regla SINE y scripts de sesión

### Fuentes consultadas
- Sesión anterior (2026-07-02) — COMPORTAMIENTO-SESION.md
- CONVENCIONES.md del repo — reglas propias del ecosistema

### Decisión tomada
Una terminal nueva por tarea. Docker en background. Scripts en `scripts/maintenance/`.

---

## 2026-07-02 — Arquitectura bots Telegram (3 bots separados)

### Fuentes consultadas
- `inbox/2026-07-02-arquitectura-bots-telegram.md` (sesión noche)
- Decisión propia: separar dominios ahora, unificar después con ROUTER-BOT

### Decisión tomada
TOKI-Guardian (:8000) + TOKI-DEW (:8001) + TOKI-Personal (:8002 futuro).  
Aplicado en: `docs/PLAN-MAESTRO-ECOSISTEMA.md`

---

## PLANTILLA PARA PRÓXIMAS ENTRADAS

```markdown
## YYYY-MM-DD — [TEMA]

### Pregunta investigada
[qué queríamos saber]

### Fuentes consultadas
| Fuente | URL | Qué aportó |
|---|---|---|

### Decisión tomada
[qué decidimos y por qué]

### Aplicado en
[ruta al doc donde se aplicó]
```

---

_Primera entrada: 2026-07-03 — Perplexity vía MCP_
