# 🧠 Agente Autónomo — Cómo trabaja solo

> El agente no necesita intervención humana para avanzar el plan.
> Lee el ROADMAP, elige la siguiente tarea, la ejecuta, hace commit, notifica.

---

## El principio

El ecosistema tiene un plan en `ROADMAP-MASTER.md`. Cada tarea pendiente tiene un `[ ]`. El agente:
1. Lee el ROADMAP
2. Coge la primera tarea `[ ]` que puede resolver solo
3. La ejecuta
4. Cambia `[ ]` → `[x]` y hace commit
5. Notifica via ygg-bot

Sin intervención humana. Sin preguntar. Si no puede resolver algo, lo deja y pasa al siguiente.

---

## Qué puede resolver solo

### Documentación
- Islas sin README.md → genera uno con el template `templates/isla-README.md`
- Islas sin ESTADO.md → genera uno leyendo últimos commits
- `MAPA-ISLAS.md` desactualizado → sincroniza leyendo carpetas del repo
- TODOs sin issue → crea el issue en GitHub

### Investigación
- Cuando hay una tarea marcada como `[investigar]` → busca, sintetiza, escribe en `docs/investigacion/FECHA-TEMA.md`
- Actualiza `HERRAMIENTAS-ECOSISTEMA.md` con lo encontrado

### Auditoría
- Dispara `ecosystem-guardian.yml` y `auto-investigacion.yml` si no han corrido hoy
- Lee los issues creados por las Actions y los prioriza en `MASTER-PENDIENTES.md`

---

## Lo que NUNCA hace solo

```
❌ Merge de código de producción
❌ Borrar archivos o repos
❌ Cambiar secrets o credenciales
❌ Decisiones de arquitectura
❌ Escribir código funcional (sólo documentación y config)
❌ Tocar ramas de producción directamente
```

Para estas tareas: crea un issue, lo documenta y notifica a Álvaro.

---

## Cuándo se activa

| Trigger | Qué hace |
|---|---|
| Cada día a las 06:00 CEST | Revisa ROADMAP, ejecuta 1-3 tareas pendientes |
| Manualmente via `/avanzar` en thdora-personal | Ejecuta siguiente tarea ahora |
| Después de cada sesión de trabajo | Sincroniza lo hecho con el ROADMAP |

---

## Contexto que necesita para funcionar

El agente lee estos ficheros para entender dónde está:

```
ROADMAP-MASTER.md      → el plan
MAPER-ISLAS.md         → estado de cada isla
MASTER-PENDIENTES.md   → tareas en cola
ECOSISTEMA.md          → arquitectura completa
CONVENCIONES.md        → reglas del ecosistema
AGENT.md               → cómo comportarse
```

---

## Implementación técnica (F3)

El agente se implementará como GitHub Action (`agente-autonomo.yml`) que:
1. Corre en schedule (06:00 CEST) o `workflow_dispatch`
2. Usa `actions/github-script` + llamadas a API de GitHub
3. Para tareas de IA: llama a Groq API (cloud) o ollama (local via Tailscale)
4. Hace commits firmados con el usuario `github-actions[bot]`
5. Notifica resultados via webhook a ygg-bot → Telegram

---

*Este es el estado objetivo. Implementación en Fase F3.*
*Ver `docs/BOTS-ARQUITECTURA.md` para el contexto completo.*
