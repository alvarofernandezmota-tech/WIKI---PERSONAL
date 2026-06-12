# personal-v2

> Base de datos personal de Álvaro Fernández Mota.
> Fuente de verdad única · 100% Git · Auditado y versionado.
> Última actualización: 12 junio 2026

---

## Estructura del repo

```
personal-v2/
├── README.md              ← este archivo
├── AGENT.md               ← instrucciones para IAs (leer primero)
├── CONTEXT.md             ← estado actual del sistema (actualizar siempre)
├── CHANGELOG.md           ← historial de cambios importantes
├── filosofia.md           ← principios y valores del sistema
│
├── agentes/               ← instrucciones y flujos por herramienta IA
│   ├── perplexity.md
│   ├── gemini.md
│   └── prompts.md
│
├── yo/                    ← perfil, CV, empleabilidad, certificaciones
├── diarios/               ← diarios de sesión organizados por año
│   └── 2026/
├── formacion/             ← Python, SQL, Linux, SO, C, cursos externos
├── proyectos/             ← THDORA, thea-ia, ai-toolkit, analytics
├── setup/                 ← configuración de máquinas y servicios
│   └── servidor/
│       ├── README.md      ← arquitectura + estado Fases
│       ├── tailscale.md
│       ├── barrier.md
│       └── lan.md
└── .github/               ← config GitHub
```

---

## Carpetas pendientes de poblar

Estas carpetas existen pero aún no tienen contenido migrado desde `personal` (repo madre):

| Carpeta | Contenido pendiente |
|---|---|
| `yo/` | CV, empleabilidad, certificaciones, portfolio, begona.md |
| `formacion/` | Python, SQL, Linux, SO2-kernel, C, cursos externos, chuletas |
| `proyectos/` | THDORA, thea-ia/, ai-toolkit.md, personal-analytics.md |

---

## Archivos raíz

| Archivo | Propósito | Frecuencia de actualización |
|---|---|---|
| `AGENT.md` | Instrucciones para IAs | Al cambiar el flujo de trabajo |
| `CONTEXT.md` | Estado actual del sistema | Cada sesión |
| `CHANGELOG.md` | Historial de cambios | Al hacer cambios importantes |
| `filosofia.md` | Principios del sistema | Cuando evoluciona la filosofía |

---

## Flujo de trabajo

```
Gemini (voz / visual / docs largos)
    ↓
Álvaro revisa
    ↓
Perplexity estructura y sube al repo
    ↓
GitHub — fuente de verdad
```

**Regla de oro:** Si tiene que quedar documentado → acaba en este repo.

---

## Estado del servidor

| Fase | Estado | Fecha |
|---|---|---|
| Fase 1 — Conectividad (Tailscale + Input Leap + UFW) | ✅ Completada | 12 jun 2026 |
| Fase 2 — Seguridad (TLS + fail2ban + Headscale) | ⏳ Pendiente | Próximo fin de semana |
| Fase 3 — Servicios (Ollama + THDORA + PostgreSQL) | ⏳ Pendiente | — |

---

_Ver `AGENT.md` para instrucciones completas de uso con IAs._
