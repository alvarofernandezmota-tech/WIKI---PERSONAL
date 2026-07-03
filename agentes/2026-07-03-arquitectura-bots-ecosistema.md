# 📥 INBOX — Arquitectura Multi-Agente y Flota de Bots

> **Fecha:** 2026-07-03  
> **Origen:** Sesión de trabajo matutina + investigación de repos y papers  
> **Estado:** 🔴 Pendiente de análisis y decisión  
> **Prioridad:** Alta — bloquea definición de arquitectura Fase 7+  
> **Responsable:** álvaro + sesión dedicada

---

## ¿Qué hay que decidir?

Esta sesión abrió tres preguntas críticas que necesitan análisis y decisión antes de seguir construyendo:

1. **¿Cuántos bots/agentes tiene el ecosistema y qué hace cada uno?**
2. **¿Thdora-dew es un bot aparte, una capa o un módulo interno?**
3. **¿Qué repos existen, cuáles se crean, cuáles se funden?**

---

## 🧠 Contexto investigado — qué hacen las grandes

### Patrón Supervisor + Especialistas

El patrón más usado en 2026 por sistemas de asistentes personales con múltiples agentes:

- Un **agente supervisor** recibe la intención del usuario y delega a especialistas.
- Cada **agente especialista** tiene su propio dominio, herramientas y memoria.
- La regla de oro: **extraer un agente nuevo SOLO si** tiene dominio propio, merece memoria separada o necesita frontera de seguridad distinta.
- Más de 3-5 agentes sin criterio claro = sobredelegación + coste de coordinación + fiabilidad reducida.

**Fuente:** Damian Galarza (YouTube/2026), Redis AI Architecture Patterns, Google ADK Multi-Agent Guide

### Criterios de extracción de un nuevo agente

1. ¿El dominio es lo suficientemente grande para requerir sus propias reglas?
2. ¿Lo contratarías como humano especialista para SOLO eso?
3. ¿Merece su propia memoria separada de los demás?

Si las tres respuestas son NO → módulo interno, no nuevo agente.

### Repos de referencia open source

| Proyecto | URL | Qué aporta |
|---|---|---|
| OpenHands | [github.com/OpenHands/OpenHands](https://github.com/OpenHands/OpenHands) | Agente autónomo de desarrollo, AGENTS.md, SDK modular |
| OpenClaw | [openclaw.ai](https://openclaw.ai) | Plataforma personal multi-canal, patrón SOUL.md/USER.md/AGENTS.md/MEMORY.md |
| Claude Code | [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices) | CLAUDE.md, subagentes por rol, hooks deterministas |
| Mastra | [mastra.ai/docs/agents/supervisor-agents](https://mastra.ai/docs/agents/supervisor-agents) | Supervisor pattern TypeScript, delegation hooks |
| AndrewAltimit/template-repo | [github.com/AndrewAltimit/template-repo](https://github.com/AndrewAltimit/template-repo) | Template repo con MCP + agentes |

---

## 🤖 Propuesta de flota — 3 agentes estables

### Estado actual

```
thdora          ─ bot personal diario (Telegram)
thdora-guardiana ─ mencionada, no definida formalmente
```

### Propuesta tras investigación

```
┌────────────────────────────────────────────────────────────────┐
│  ECOSISTEMA YGGDRASIL                                           │
│                                                                │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐       │
│  │  thdora   │  │ guardiana  │  │   thdora   │       │
│  │  (vida    │  │ (audit +   │  │    -dew    │       │
│  │  diaria)  │  │ seguridad) │  │ (ecosist.) │       │
│  └────────────┘  └────────────┘  └────────────┘       │
│                                                                │
│  [ ema ] ─ futura (analista/investigadora, pendiente Fase 7+)  │
└────────────────────────────────────────────────────────────────┘
```

### Definición de cada agente

#### 1️⃣ thdora — Bot Personal de Vida Diaria

- **Rol:** Asistente personal principal. Punto de contacto diario del dueño.
- **Herramientas:** Telegram, BBDD, LangGraph, calendario, diario, hábitos, inbox, citas
- **Memoria:** Personal — citas, hábitos, recordatorios, estado emocional
- **Repo:** `thdora` (ya existe)
- **Frontera de seguridad:** Solo responde al dueño (OWNER_TELEGRAM_ID)
- **Criterio de extracción:** ✔️ Ya existe, dominio claro

#### 2️⃣ guardiana — Agente de Auditoría y Seguridad

- **Rol:** Monitoriza el estado del sistema, audita código, detecta deuda técnica y fallos de seguridad. Nunca interactivo con el usuario final.
- **Herramientas:** `ai_audit.py`, GitHub API, prometheus metrics, alertas
- **Memoria:** Técnica — historial de auditorías, issues abiertos, severidades
- **Repo:** Módulo dentro de `thdora` en `src/agents/guardiana/` — NO repo aparte (aún)
- **Frontera de seguridad:** Solo lectura de código, solo escribe issues en GitHub
- **Criterio de extracción:** ✔️ Dominio claramente separado de vida diaria

#### 3️⃣ thdora-dew — Agente Orquestador del Ecosistema

- **Rol:** Coordinación del ecosistema: roadmap, sesiones, fases, normas, decisiones de arquitectura.
- **Herramientas:** yggdrasil-dew (GitHub), ROADMAP.md, MASTER-PENDIENTES.md, CHANGELOG
- **Memoria:** Operativa — estado de fases, pendientes, decisiones tomadas
- **Repo:** Capa ligada a `yggdrasil-dew` — podría ser un módulo o un servicio ligero
- **Frontera de seguridad:** Lee y escribe el ecosistema pero no la vida personal
- **Criterio de extracción:** ⚠️ Pendiente de decidir: ¿módulo o repo?
- **Decisión pendiente:** Ver sección “Preguntas abiertas”

#### ⏳ ema — Analista/Investigadora (Futura, no antes de Fase 7)

- **Rol:** Investigación, análisis comparativo, propuestas de mejora del ecosistema
- **Herramientas:** Web search, GitHub API, papers, repos open source
- **Memoria:** Intelectual — investigaciones pasadas, conocimiento acumulado del ecosistema
- **Repo:** Pendiente — depende de si supera criterios de extracción
- **Criterio de extracción:** ❌ Aún no cumple los 3 criterios de forma clara

---

## 🔄 Lo que hacen las grandes empresas (para inspiración directa)

| Empresa/Proyecto | Patrón | Qué podemos usar |
|---|---|---|
| **Anthropic (Claude Code)** | CLAUDE.md + subagentes por rol + hooks deterministas | CLAUDE.md en thdora con normas, comandos y gotchas |
| **OpenHands** | AGENTS.md + SDK modular + agente autónomo de desarrollo | `AGENTS.md` en yggdrasil-dew como mapa de agentes |
| **OpenClaw** | SOUL.md / USER.md / AGENTS.md / MEMORY.md por agente | Un fichero por agente con su identidad y memoria |
| **Mastra** | Supervisor + especialistas, delegation hooks, iteration monitoring | Patrón para thdora-dew como supervisor |
| **Google ADK** | 8 patrones de multi-agente: secuencial, paralelo, supervisor, pipeline | Pipeline auditía → guardiana → issues |

---

## 📦 Ficheros que faltan en thdora para ser “agent-ready”

Basado en la investigación, thdora necesita estos ficheros que los proyectos líder tienen:

```
thdora/
├── CLAUDE.md                    ← FALTA — contexto persistente para agentes IA
├── AGENTS.md                    ← FALTA — mapa de agentes del ecosistema
├── .claude/
│   ├── agents/
│   │   ├── security-reviewer.md  ← FALTA — rol auditoría seguridad
│   │   ├── debt-hunter.md        ← FALTA — rol caza deuda técnica
│   │   └── doc-curator.md        ← FALTA — rol documentación
│   └── skills/
│       ├── fix-issue/SKILL.md    ← FALTA — flujo leer issue → fix → PR
│       └── audit-repo/SKILL.md   ← FALTA — flujo auditoría completa
└── docs/
    ├── ARCHITECTURE.md          ← FALTA — mapa real del ecosistema
    └── BOTS.md                  ← FALTA — definición de cada bot/agente
```

---

## ❓ Preguntas abiertas — necesitan decisión

### P1: ¿Thdora-dew es bot, módulo o capa?

| Opción | Pros | Contras |
|---|---|---|
| Bot Telegram propio | Interfaz directa, separación total | Duplica infra, nuevo token, más mantenimiento |
| Módulo interno en thdora | Más simple, menos infra | Mezcla responsabilidades |
| Capa de coordinación ligada a yggdrasil-dew | Separa vida personal de ecosistema | Requiere definir protocolo de comunicación |

**Recomendación provisional:** Capa ligada a yggdrasil-dew, sin Telegram propio hasta que demuestre necesidad real.

### P2: ¿Guardiana necesita repo propio?

**Recomendación provisional:** NO todavía. Módulo en `src/agents/guardiana/` dentro de thdora. Separar solo si su ciclo de vida, permisos o stack se diferencia.

### P3: ¿Ema necesita repo propio?

**Recomendación provisional:** NO. Primero funcionar como herramienta en `src/tools/ema/`. El criterio para repo propio: memoria independiente + ciclo de vida distinto + equipo/uso diferente.

### P4: ¿Cuántos repos en total?

**Recomendación provisional:**

```
yggdrasil-dew    ─ gobernanza, normas, sesiones, roadmap (ya existe)
thdora           ─ bot personal + guardiana (módulo) + ema (herramienta) (ya existe)
```

NO crear más repos hasta que un módulo supere los 3 criterios de extracción.

---

## 📋 Próximos pasos sugeridos

- [ ] Decidir P1, P2, P3 en sesión dedicada (no urgente, pero antes de Fase 7)
- [ ] Crear `thdora/CLAUDE.md` — contexto persistente del repo para agentes IA
- [ ] Crear `thdora/AGENTS.md` — mapa oficial de agentes con roles y fronteras
- [ ] Crear `thdora/docs/ARCHITECTURE.md` — mapa del ecosistema completo
- [ ] Crear `thdora/docs/BOTS.md` — definición formal de cada bot/agente
- [ ] Revisar si guardiana merece `src/agents/guardiana/` como directorio propio
- [ ] Revisar ema como `src/tools/ema/` tras Docker estable

---

## 🔗 Referencias

- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [OpenHands AGENTS.md](https://github.com/OpenHands/OpenHands/blob/main/AGENTS.md)
- [OpenClaw Architecture Paper](https://www.clawrxiv.io/abs/2603.00164)
- [Mastra Supervisor Pattern](https://mastra.ai/docs/agents/supervisor-agents)
- [Redis AI Agent Architecture Patterns](https://redis.io/blog/ai-agent-architecture-patterns/)
- [Google ADK Multi-Agent Guide](https://developers.googleblog.com/developers-guide-to-multi-agent-patterns-in-adk/)
- [arXiv: Practical Guide for Agentic AI](https://arxiv.org/abs/2512.08769)
- [AI Coding Agents: Detecting in Open Source (850k commits)](https://arxiv.org/abs/2606.24429v1)
- [Agentpatterns.ai: Central Repo for Shared Agent Standards](https://agentpatterns.ai/workflows/central-repo-shared-agent-standards/)

---

*Generado automáticamente durante sesión 2026-07-03 — pendiente de revisión por álvaro*
