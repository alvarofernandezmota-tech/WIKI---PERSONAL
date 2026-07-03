# 🤖 Arquitectura de Bots del Ecosistema

> Documento maestro. Define qué bot existe, para qué, cómo se llama y cómo se diferencia de los demás.
> Última actualización: 03-Jul-2026

---

## Los 3 bots del ecosistema

```
Ecosistema Yggdrasil
│
├── 🧑 thdora-personal   → tu interfaz humana, vida y proyectos personales
├── ⚙️  ygg-bot           → interfaz del ecosistema técnico, GitHub, workflows
└── 🧠 agente-autonomo   → trabaja solo, sin intervención humana, avanza el plan
```

---

## 🧑 thdora-personal (antes: thdora)

**Repo:** `github.com/alvarofernandezmota-tech/thdora` → renombrar a `thdora-personal`
**Para quién:** Álvaro (uso 100% personal)
**Token:** El token personal de Telegram

### Qué hace
- Comandos de vida personal: agenda, recordatorios, notas rápidas
- Consultas a ollama local (preguntas, resúmenes, análisis)
- Notificaciones de estado del sistema personal (madre, Tailscale, backups)
- Puerta de entrada al ecosistema desde el móvil
- `/estado`, `/roadmap`, `/pendientes`, `/islas`, `/pregunta`, `/resumir`

### Lo que NO hace
- No gestiona PRs ni código
- No audita repos
- No tiene acceso de escritura a GitHub

---

## ⚙️ ygg-bot (nuevo)

**Repo:** `github.com/alvarofernandezmota-tech/ygg-bot` (crear)
**Para quién:** El ecosistema técnico, puede ser usado por colaboradores
**Token:** Token de bot técnico separado

### Qué hace
- Notificaciones de GitHub: nuevo issue, PR mergeado, health check
- Disparar workflows via API de GitHub (`/lanzar-health`, `/audit`, `/deploy`)
- Comentar en PRs (mensajes de contexto del ecosistema)
- Daily report técnico a las 08:00: commits, islas tocadas, issues abiertos
- Webhook receptor: GitHub → Telegram

### Lo que NO hace
- No responde preguntas personales
- No accede a ollama
- No maneja datos personales

---

## 🧠 agente-autonomo (el que trabaja solo)

**Repo:** `github.com/alvarofernandezmota-tech/agente-ygg` (crear)
**Para quién:** El ecosistema — trabaja sin intervención humana
**Cómo funciona:** Tiene acceso a `ROADMAP-MASTER.md`, `MASTER-PENDIENTES.md` y `MAPA-ISLAS.md`. Lee el plan, elige la siguiente tarea pendiente, la ejecuta y hace commit.

### Qué puede hacer solo
| Tarea | Cómo lo hace |
|---|---|
| Completar documentación faltante | Lee template + contexto, genera README.md, hace commit |
| Crear issues de deuda técnica | Detecta TODOs, crea issues en GitHub |
| Actualizar ESTADO.md de cada isla | Lee últimos commits, actualiza el fichero |
| Ejecutar workflows de auditoría | Dispara `repo-audit.yml`, `ecosystem-guardian.yml` |
| Sincronizar MAPA-ISLAS.md | Lee carpetas reales del repo, actualiza la tabla |
| Investigar y documentar | Busca información, escribe en `docs/investigacion/` |

### Lo que SIEMPRE necesita humano
- Merge de PRs críticos (código de producción)
- Decisiones de arquitectura (separar isla, cambiar nombre)
- Secrets y credenciales nuevas
- Borrar cosas (solo puede proponer, no ejecutar)

### Cómo sabe qué hacer
```
Agente lee ROADMAP-MASTER.md
  ↓
Busca primeras tareas con estado [ ] (pendiente)
  ↓
Comprueba si tiene contexto suficiente (MAPA-ISLAS.md, docs/)
  ↓
Ejecuta → commit → actualiza estado en ROADMAP-MASTER.md
  ↓
Notifica via ygg-bot → Telegram
```

---

## ❌ Por qué NO microbots/microagentes (ahora)

Un microbot se justifica cuando:
1. Necesita ejecutarse en paralelo con ciclo de vida propio
2. Tiene más de 2000 líneas de código específico
3. Lo usan otros proyectos como dependencia

Nada en el ecosistema actual cumple esos criterios. Los microbots fragmentan el contexto y aumentan la deuda técnica sin beneficio real. **Toda la funcionalidad cabe en estos 3 bots.**

---

## 🔄 Cómo se comunican los 3

```
thdora-personal
  └── llama API → ygg-bot (para disparar workflows)
  └── llama → ollama (para IA local)

ygg-bot
  └── recibe webhook ← GitHub Actions
  └── dispara workflows → GitHub API
  └── notifica → Telegram (canal técnico)

agente-autonomo
  └── lee ← ROADMAP-MASTER.md, MAPA-ISLAS.md
  └── escribe ← docs/, README.md de cada isla
  └── notifica → ygg-bot → Telegram
  └── crea issues → GitHub API
```

---

## 📋 Estado de implementación

| Bot | Repo existe | Funciona | Documentado |
|---|---|---|---|
| thdora-personal | ✅ (renombrar desde thdora) | ⚠️ Deuda técnica #12 #10 | ✅ |
| ygg-bot | ❌ Crear | ❌ | ✅ Este doc |
| agente-autonomo | ❌ Crear | ❌ | ✅ Este doc |

---

## 🚀 Orden de implementación

1. **F1** — Resolver deuda thdora (#12, #10) + renombrar a thdora-personal
2. **F2** — Crear ygg-bot (webhook GitHub → Telegram)
3. **F3** — Crear agente-autonomo básico (documentación automática)
4. **F4** — Agente con capacidad de avanzar el ROADMAP solo

---

*Ver `ROADMAP-MASTER.md` para el plan completo.*
*Ver `thdora/THDORA-BOT-FUNCIONES.md` para comandos específicos.*
