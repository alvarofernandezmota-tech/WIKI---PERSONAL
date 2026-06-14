# personal-v2

> Base de datos personal de Álvaro Fernández Mota.
> Fuente de verdad única · 100% Git · Auditado y versionado.
> Última actualización: 14 junio 2026

---

## 🧠 Principio de este repo

**Este repo NO es un archivo histórico. Es una herramienta de trabajo viva.**

Cada sección existe en dos capas:
- **Histórico** → lo que se aprendió o hizo (para repasar)
- **Referencia técnica** → lo que se consulta en producción (para trabajar)

Un ingeniero consulta su repo como consulta documentación oficial — rápido, preciso, sin buscar entre carpetas de "cuándo lo aprendí".

---

## Estructura del repo

```
personal-v2/
├── README.md              ← este archivo
├── AGENT.md               ← instrucciones para IAs (leer primero)
├── CONTEXT.md             ← estado actual del sistema
├── CHANGELOG.md           ← historial de cambios
├── filosofia.md           ← principios y valores del sistema
├── .gitignore
│
├── agentes/               ← instrucciones y flujos por herramienta IA
├── yo/                    ← perfil, CV, empleabilidad, certificaciones
├── diarios/               ← diarios de sesión por año
├── formacion/             ← Python, SQL, Linux, SO, C, cursos
│   └── python/
│       ├── curso/         ← módulos Escuela Musk (M1→M7) — para estudiar
│       └── referencia/    ← diccionario técnico vivo — para trabajar
├── proyectos/             ← THDORA, thea-ia, ai-toolkit, analytics
└── setup/                 ← configuración de máquinas y servicios
    ├── equipos.md
    ├── software.md
    ├── workspace.md
    ├── servicios.md
    ├── omarchy/
    └── servidor/
```

---

## Ecosistema de máquinas

| Máquina | Rol | IP Tailscale | OS |
|---|---|---|---|
| **Madre** | Workstation principal + GPU | `100.91.112.32` | Arch Linux / Hyprland |
| **Acer** | Servidor 24/7 | `100.86.119.102` | Arch Linux |
| **MacBook** | Cliente puro | Pendiente | macOS |

> **Regla:** Madre produce y sirve. Acer corre 24/7. MacBook solo consume.

---

## Estado del servidor — Pirámide de Resiliencia

| Capa | Objetivo | Estado | Fecha |
|---|---|---|---|
| 0 — Acceso | sshd + wayvnc + Tailscale | ⚠️ Tailscale ✅, SSH pendiente | 13 jun 2026 |
| 1 — Blindaje | UFW + fail2ban | ⚠️ UFW Acer ✅, Madre pendiente | 13 jun 2026 |
| 2 — Auditoría | lynis + journald + btop | ⏳ Pendiente | — |
| 3 — Aislamiento | Docker + contenedores | ⏳ Pendiente | — |

---

## Flujo de trabajo IA

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

## Archivos raíz

| Archivo | Propósito | Frecuencia |
|---|---|---|
| `AGENT.md` | Instrucciones para IAs | Al cambiar el flujo |
| `CONTEXT.md` | Estado actual del sistema | Cada sesión |
| `CHANGELOG.md` | Historial de cambios | Al hacer cambios |
| `filosofia.md` | 7 principios del sistema | Mensual o menos |

---

## Carpetas pendientes de poblar

| Carpeta | Contenido pendiente |
|---|---|
| `yo/` | CV, empleabilidad, certificaciones, portfolio |
| `formacion/python/referencia/` | Diccionario técnico consolidado desde M1–M5 |
| `proyectos/` | THDORA, thea-ia, ai-toolkit, analytics |

---

_Ver `AGENT.md` para instrucciones completas de uso con IAs._
_Ver `setup/servidor/plan-maestro.md` para tareas pendientes._
