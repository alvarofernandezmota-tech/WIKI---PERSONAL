# AGENT.md — {{REPO_NAME}}

> **Lee este archivo al inicio de CADA sesión en este repo.**  
> Contiene todo lo que necesitas para trabajar aquí sin preguntar.  
> Si algo cambió estructuralmente, está aquí reflejado.

---

## 📦 Este repo

| Campo | Valor |
|---|---|
| **Nombre** | `{{REPO_NAME}}` |
| **Rol** | {{REPO_ROL}} |
| **Visibilidad** | {{REPO_VISIBILIDAD}} |
| **Isla wiki** | [`{{ISLA_WIKI_URL}}`](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/{{ISLA_WIKI_URL}}) |
| **Estado actual** | {{ESTADO_ACTUAL}} |
| **Stack principal** | {{STACK_PRINCIPAL}} |

---

## 👤 Usuario

- **Nombre:** Álvaro Fernández Mota
- **Perfil:** Ingeniero de sistemas autodidacta. Stack: Python, Docker, Linux, IA local, OSINT.
- **Filosofía:** Producción primero, perfección después. El ritmo importa más que el sprint.
- **Referencia completa:** [`yggdrasil-wiki/wiki/islas/filosofia.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/wiki/islas/filosofia.md)

---

## 🖥️ Ecosistema de máquinas

| Máquina | OS | IP Tailscale | Rol |
|---|---|---|---|
| Madre | Arch Linux (Omarchy) | `100.91.112.32` | Servidor 24/7 · Docker · Batcueva |
| Acer (Thdora) | Arch Linux + Hyprland | `100.86.119.102` | Terminal de trabajo · Dev · OSINT |
| iPhone 11 | iOS | Tailscale activo | Trabajo remoto · Perplexity MCP |

---

## 🗂️ Repos del ecosistema

| Repo | Rol |
|---|---|
| `yggdrasil-wiki` | Wiki central · mapa conceptual · segundo cerebro |
| `yggdrasil-dew` | Canon técnico · decisiones · ADRs · issues |
| `THDORA-PERSONAL` | Bot TOKI · FastAPI · Docker |
| `madre-config` | Configuración Madre · Docker · servicios |
| `ollama-stack` | Ollama + modelos locales |
| `local-brain` | RAG + Qdrant + memoria |
| `yggdrasil-secops` | Seguridad defensiva |
| `osint-stack` | Seguridad ofensiva · OSINT · pentest |
| `yggdrasil-formacion` | Aprendizaje · cursos · Python |
| `yggdrasil-tracking` | Vida personal · diarios · finanzas |
| `investigacion-ia` | PoCs de IA |
| `acer-config` | Configuración Acer · Arch Linux + Hyprland |
| `dev-labs` | Sandbox antes de crear repo propio |
| `thea-ia` | Core Python IA (decisión arquitectural pendiente) |

---

## 🤖 Agentes del ecosistema

| Agente | Fortaleza | MCP GitHub | Cuándo |
|---|---|---|---|
| **Perplexity** | Búsqueda web + gestión repo + docs | ✅ Activo | Principal — todo lo que se pueda |
| **Grok** | Datos frescos · razonamiento lateral | ❌ | Investigación / noticias |
| **Gemini** | Código largo · arquitectura · contexto grande | ❌ | Ficheros grandes · refactors |
| **Claude** | Razonamiento profundo · código calidad | ⏳ posible Cursor | Arquitectura compleja |
| **OpenCode** | Terminal · local | ✅ local | Cuando esté en Thdora |
| **TOKI** | Control móvil desde Telegram | ⏳ en desarrollo | Bot propio |

---

## 🐛 Issues activas relacionadas con este repo

> Siempre revisar estas issues antes de actuar. Pueden estar bloqueando o cambiando el plan.

| Issue | Título | Prioridad |
|---|---|---|
{{DEW_ISSUES_RELACIONADAS}}

Ver todas: [yggdrasil-dew issues](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

---

## 📋 Reglas del sistema — OBLIGATORIAS

1. **Leer antes de actuar** — `AGENT.md` → `CONTEXT.md` → convenciones del repo
2. **Todo entra por `inbox/`** — nunca sobrescribir ficheros existentes directamente
3. **Verificar SHA** antes de actualizar cualquier fichero existente
4. **CONTEXT.md** = estado actual — actualizar al inicio Y al cierre de cada sesión
5. **Diario de sesión** = obligatorio al cierre en `docs/sesiones/YYYY-MM-DD.md`
6. **No crear stubs vacíos** — si no hay contenido real, no crear el fichero
7. **Convenciones** = `kebab-case` en `docs/` y `wiki/`, `MAYÚSCULAS` en raíz
8. **Issues DEW primero** — si existe issue abierta que afecte a lo que vas a hacer, menciónala
9. **Isla wiki sincronizada** — si cambias estado operativo, actualiza también `{{ISLA_WIKI_URL}}`

---

## 📐 Protocolo de sesión

```
┌─────────────────────────────────────────────┐
│             INICIO DE SESIÓN                │
│  1. Leer AGENT.md (este fichero)            │
│  2. Leer CONTEXT.md (estado actual)         │
│  3. Revisar issues activas del DEW          │
│  4. Verificar estado operativo del repo     │
└──────────────────┬──────────────────────────┘
                   ↓
            Trabajar (inbox/ primero)
                   ↓
┌──────────────────┴──────────────────────────┐
│             CIERRE DE SESIÓN                │
│  1. Escribir sesión en docs/sesiones/       │
│  2. Actualizar CONTEXT.md                   │
│  3. Actualizar AGENT.md si hubo cambio      │
│  4. Actualizar isla wiki si cambió estado   │
│  5. Abrir issue DEW si hay deuda nueva      │
│  6. Commit de cierre con mensaje canónico   │
└─────────────────────────────────────────────┘
```

---

## 🚦 Estado de fases del ecosistema

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo limpio + wiki estructurada | ✅ Completado 2026-07-16 |
| **1** | Tailscale + acceso remoto | ✅ Activo |
| **2** | SSH hardening completo | 🔴 Pendiente |
| **3** | Wazuh SIEM | 🟡 En progreso |
| **4** | Suricata IDS | 🟡 En progreso |
| **5** | GitHub Actions automatización | 🔴 No iniciado |
| **6** | Cursor + MCP en Thdora/Acer | 🔴 Pendiente |
| **7** | Ollama agentes + workflows IA | 🔴 No iniciado |

---

_Actualizado: {{FECHA}} · Perplexity-MCP_
