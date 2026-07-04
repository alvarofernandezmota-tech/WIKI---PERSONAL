# ESTRUCTURA — La ley del repo

> Antes de crear un archivo, lee esto. Si no sabes dónde va algo, va a `inbox/`.

---

## Estructura definitiva

```
yggdrasil-dew/
│
├── README.md              ← qué es este repo
├── ESTRUCTURA.md          ← este archivo, la ley
├── ROADMAP-MASTER.md      ← qué se está construyendo y en qué orden
│
├── diarios/               ← un .md por día de trabajo (YYYY-MM-DD.md)
├── sesiones/              ← resúmenes de sesiones largas con IAs
├── inbox/                 ← entrada: ideas, tareas, notas rápidas sin clasificar
│
├── docs/                  ← documentación real y estable del ecosistema
│   ├── ecosistema.md      ← visión, arquitectura, repos del ecosistema
│   ├── herramientas.md    ← qué herramientas usa el ecosistema y para qué
│   ├── convenciones.md    ← convenciones de código, nombres, commits
│   ├── seguridad.md       ← plan de seguridad y despliegue
│   └── hardware.md        ← specs del servidor (Madre) y máquina local
│
├── agentes/               ← specs de agentes IA (solo docs, no código)
│   ├── ia-web/            ← Claude, Gemini, ChatGPT, Copilot, Grok, Perplexity
│   └── local/             ← modelos Ollama locales
│
├── infra/                 ← configuración de infraestructura real
│   └── docker/            ← docker-compose y configs de servicios activos
│
├── scripts/               ← scripts bash operativos (apertura, cierre, mantenimiento)
│
└── _archivo/              ← todo lo obsoleto o pendiente de revisar
```

---

## Reglas

1. **Sin carpetas vacías.** Si no hay contenido real, no existe la carpeta.
2. **Sin placeholders.** Un archivo de 3 líneas que dice "TODO" no es documentación.
3. **Sin duplicados.** Un tema = un archivo. Si hay dos, se fusionan.
4. **Inbox primero.** Cualquier cosa nueva entra en `inbox/`. Se clasifica después.
5. **`_archivo/` no es basura.** Es un archivo histórico. Se puede consultar.

---

## Separación del ecosistema

Este repo es el **cerebro**. No contiene código de producción.

| Repo | Propósito | Estado |
|---|---|---|
| `yggdrasil-dew` | Cerebro: docs, diarios, specs, scripts | ✅ Activo |
| `yggdrasil-secops` | Salud, seguridad, watchdogs | 🔴 Por crear |
| `local-brain` | RAG local + embeddings | 🔴 Por crear |
| `thdora-personal` | Interfaz Telegram + vida personal | 🔴 Por crear |
| `osint-stack` | OSINT + Spiderfoot | 🔴 Por crear |

> Los repos marcados 🔴 **no se crean hasta tener contenido real que justifique su existencia.**

---

## Lo que NO va aquí

- **Vida personal** (salud, finanzas, rutinas) → repo privado separado
- **Código de agentes** → en el repo del agente correspondiente
- **Secrets o tokens** → nunca en git, siempre en `.env` local
- **Workflows de automatización** → solo si tienen un script real detrás

---

*Última revisión: 2026-07-04*
