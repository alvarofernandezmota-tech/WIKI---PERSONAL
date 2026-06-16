# CONTEXT.md — Estado actual del sistema

> Actualizar al inicio de cada sesión con una IA.
> Última actualización: **16 junio 2026 · 19:36 CEST**

---

## Equipos

| Máquina | Rol | IP Tailscale | IP Local | Estado |
|---|---|---|---|---|
| **Madre** | Servidor — torre fija | `100.91.112.32` | `10.134.31.228` | ✅ Operativa, sshd activo |
| **Acer (Theodora / varopc)** | Cliente — portátil dev | `100.86.119.102` | `10.134.31.171` | ✅ Operativo, Arch Linux + Hyprland |
| **HP** | Pendiente rescate | — | — | ❌ BIOHD-8, disco no detectado |

---

## Bloqueante actual

```
AP Isolation en el router bloquea tráfico UDP entre Madre y Acer.
Impide que lan-mouse funcione por red local.
Requiere acceso al panel de configuración del router.
```

---

## Estado del servidor — Pirámide de Resiliencia

| Capa | Objetivo | Estado |
|---|---|---|
| 0 — Acceso | sshd + wayvnc + Tailscale | ✅ Tailscale ✅ · SSH ✅ |
| 1 — Blindaje | UFW + fail2ban | ⚠️ UFW Acer ✅ · Madre ⏳ pendiente |
| 2 — Auditoría | lynis + journald + btop | ⏳ Pendiente |
| 3 — Aislamiento | Docker + contenedores | ✅ Docker Madre operativo |

---

## Servicios instalados (estado real)

| Servicio | Host | Estado |
|---|---|---|
| Tailscale | Madre + Acer | ✅ Activo |
| sshd | Madre | ✅ Activo |
| wayvnc | Madre | ⚠️ Instalado, sin autostart |
| UFW | Acer | ✅ Activo |
| UFW | Madre | ⏳ Pendiente |
| whisrs | Acer | ✅ Instalado, Super+V |
| lan-mouse | Madre + Acer | ⚠️ Config lista, bloqueado por AP Isolation |
| Docker | Madre | ✅ Operativo |
| THDORA | Madre | ✅ En producción (v0.17.0 — pendiente merge a main) |
| Ollama | Madre | ✅ Instalado — llama3.2:3b |
| Ollama | Acer (varopc) | ✅ qwen2.5-coder:14b · deepseek-r1:14b · qwen3:8b |
| PostgreSQL | Madre | ⏳ Pendiente |
| Pi-hole | Madre | ⏳ Pendiente |
| Uptime Kuma | Madre | ⏳ Pendiente |
| Open WebUI | Madre | ⏳ Planificado |
| Obsidian | Acer | ⏳ Planificado (próxima sesión) |
| n8n | Madre | ⏳ Documentado en ai-toolkit, sin levantar |

---

## Proyectos activos

| Proyecto | Repo | Estado | Próximo paso |
|---|---|---|---|
| **THDORA** | [thdora](https://github.com/alvarofernandezmota-tech/thdora) | ✅ v0.17.0 rama activa, pendiente merge | Añadir secrets CI/CD + alembic upgrade + merge |
| **yggdrasil-dew** | [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ✅ Vault central activo | Instalar Obsidian + plugin Git |
| **ai-toolkit** | [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | ✅ Activo | Corregir CEREBRO.md (ref. `personal` → `yggdrasil-dew`) |
| **Python** | — | ⏳ Pendiente retomar | Kaggle primera lección |

---

## Flujo IA actual (roles confirmados)

| IA | Rol | Estado |
|----|-----|--------|
| **Claude Sonnet 4.6** (vía Perplexity) | Código · repos · arquitectura · docs · contexto largo | ✅ Principal |
| **Grok** (xAI) | Investigación · mercado · datos frescos · X/Twitter | ✅ Activo |
| **Gemini 2.0 Pro** | Contexto 1M tokens · código completo · estudios | ✅ Activo |
| **OpenCode** | Agente código en terminal · orquestador multi-repo | ✅ Configurado |
| **Mistral Le Chat** | Investigación EU · privacidad | ⏳ Ficha parcial |

**Flujo investigación:** Grok (brutal, datos frescos) → Perplexity (valida + estructura) → Claude (arquitectura + código) → Gemini (implementación código completo)

---

## Ecosistema nuevo en construcción

Objetivo: conectar thdora + yggdrasil-dew + Obsidian + OpenCode en un second brain vivo.

```
Telegram /diario → thdora → GitHub API → yggdrasil-dew/diarios/
    ↓
Obsidian (plugin Git) → edición visual + RAG local (Ollama)
    ↓
OpenCode → agente código con contexto personal (.opencode-context.md)
    ↓
GitHub Actions 23:00 → resumen nocturno → commit → Telegram notify
```

**Decisiones tomadas:**
- yggdrasil-dew = fuente de verdad única del diario (ai-toolkit/diario/ = changelog técnico del stack)
- Handler /diario usará GitHub Contents API (sin Git local en contenedor)
- Raíz de yggdrasil-dew = raíz del vault Obsidian (sin subcarpeta extra)

---

## Contexto para IAs

- **Usuario:** Álvaro Fernández Mota — dev autodidacta, Madrid
- **Entorno:** Red P2P Tailscale · Hyprland/Wayland · Docker en Madre · Arch Linux en Acer
- **Enfoque:** Sistemas · automatización · agentes IA personales · second brain Git-first
- **Regla:** Si no está en el repo, no existe
- **THDORA:** Bot Telegram en Madre. v0.17.0 en rama `feature/v0.17.0-nlp-llm-multiuser`, pendiente merge.
- **Stack LLM local Madre:** Ollama llama3.2:3b (CPU) · THDORA usa GroqBackend + OllamaBackend (fallback)
- **Stack LLM local Acer:** LiteLLM proxy :8000 · OpenCode configurado · qwen2.5-coder:14b

---

_Ver ecosistema completo: [ECOSISTEMA.md](ECOSISTEMA.md)_
_Ver plan de tareas: [setup/servidor/plan-maestro.md](setup/servidor/plan-maestro.md)_
_Última actualización: 16 junio 2026 — 19:36 CEST_
