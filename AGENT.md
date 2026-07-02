# AGENT.md — Contexto para agentes IA

> **Lee este archivo al inicio de CADA sesión.**
> Contiene todo lo que necesitas para trabajar en este ecosistema sin preguntar.
> Si algo cambió estructuralmente, está aquí reflejado.

---

## 👤 Usuario

- **Nombre:** Álvaro Fernández Mota
- **Perfil:** Ingeniero de sistemas autodidacta. Stack: Python, Docker, Linux, IA local, OSINT.
- **Filosofía:** Producción primero, perfección después. El ritmo importa más que el sprint. Ver `docs/filosofia.md`.
- **Ubicación habitual:** Casa (Madre + Thdora) / móvil desde iPhone 11 cuando está fuera.

---

## 🖥️ Ecosistema de máquinas

| Máquina | Alias | OS | IP Tailscale | Rol | MCP disponible |
|---|---|---|---|---|---|
| Ordenador Madre | `Madre` | Arch Linux (Omarchy) | `100.91.112.32` | Servidor 24/7 · Docker · Batcueva | ❌ directo |
| Portátil Acer | `Thdora` / `varopc` | Arch Linux + Hyprland | `100.86.119.102` | Terminal de trabajo · Dev · OSINT | ⏳ pendiente Cursor |
| iPhone 11 | `móvil` | iOS | Tailscale activo | Trabajo remoto · Perplexity + MCP | ✅ vía Perplexity |
| HP TouchSmart | `HP` | Linux Mint (pendiente) | — | Dashboard / visualización | ❌ |

---

## 🗂️ Repos activos

| Repo | Visibilidad | Para qué |
|---|---|---|
| `yggdrasil-dew` | Privado | Segundo cerebro · infraestructura · docs · diarios |
| `alvarofernandezmota-tech` | Público | Profile README de GitHub (pendiente crear) |
| `thdora` | Privado | Bot TOKI · FastAPI · Docker |
| `personal` | Privado | Histórico · curso Python · archivado |

---

## 📋 Reglas del sistema — OBLIGATORIAS

1. **Todo entra por `inbox/`** — nunca sobreescribir ficheros existentes directamente
2. **Flujo:** `inbox/ → destino correcto → CONTEXT.md actualizado`
3. **CONTEXT.md** = estado actual del ecosistema — actualizar al inicio Y al final de cada sesión
4. **AGENT.md** = contexto estructural — actualizar solo si cambia algo estructural
5. **HOME.md** = índice de navegación — actualizar cuando se añade sección nueva
6. **MASTER-PENDIENTES.md** = backlog maestro — añadir tareas aquí, no en diarios
7. **CONVENCIONES.md** = normas de estructura — consultar antes de crear ficheros
8. **Diario de sesión** = obligatorio al cierre, en `docs/diarios/` (o `diarios/` hasta migración)

---

## 🤖 Agentes del ecosistema

| Agente | Fortaleza | MCP GitHub | Cuándo usarlo |
|---|---|---|---|
| **Perplexity** | Búsqueda web + gestión repo + docs | ✅ Space configurado | Principal — todo lo que se pueda |
| **Grok** | Datos frescos · razonamiento lateral | ❌ | Investigación / noticias |
| **Gemini** | Código largo · arquitectura · contexto grande | ❌ | Ficheros grandes · refactors |
| **Claude** | Razonamiento profundo · código calidad | ⏳ posible vía Cursor | Arquitectura compleja |
| **OpenCode** | Terminal · local | ✅ local | Cuando esté en Thdora |
| **TOKI** | Control móvil desde Telegram | ⏳ en desarrollo | Bot propio |

---

## 🛠️ Stack técnico activo

```
Infraestructura:
  Madre (24/7):
    - Docker: Batcueva (20+ servicios)
    - Wazuh SIEM + Suricata IDS       [fase 3-4, en progreso]
    - Grafana + Prometheus + Alertmgr  [activo]
    - Ollama (Llama3, Mistral, Phi3)   [activo · GTX 1060 6GB]
    - Open WebUI                       [activo]
    - Nextcloud + Vaultwarden          [activo]
    - Nginx reverse proxy + Let's Enc  [activo]
    - Pi-hole + Unbound DoT            [activo]
    - hostapd WiFi AP (r8852be)        [activo]
    - nftables firewall                [activo]

  Red:
    - Tailscale (WireGuard mesh)       [activo]
    - VLANs / macvlan para OSINT       [en progreso]

Desarrollo:
  - Python 3 + FastAPI + LangGraph
  - Docker Compose (todo containerizado)
  - GitHub Actions CI/CD              [fase 5, pendiente]
  - Cursor + MCP GitHub               [pendiente en Thdora]

Seguridad:
  - SSH: ed25519 only, no passwords    [pendiente hardening completo]
  - Fail2ban                           [pendiente]
  - nftables                           [activo]
  - Wazuh agentes                      [en progreso]
```

---

## 📐 Flujo de trabajo estándar

```
┌─────────────────────────────────────────────────┐
│              INICIO DE SESIÓN                   │
│  1. Leer AGENT.md (este fichero)                │
│  2. Leer CONTEXT.md (estado actual)             │
│  3. Leer MASTER-PENDIENTES.md (backlog)         │
└───────────────────┬─────────────────────────────┘
                    ↓
             Trabajar (inbox/ primero)
                    ↓
┌───────────────────┴─────────────────────────────┐
│              CIERRE DE SESIÓN                   │
│  1. Escribir diario en docs/diarios/            │
│  2. Actualizar CONTEXT.md                       │
│  3. Procesar inbox/ si hay items                │
│  4. Actualizar MASTER-PENDIENTES.md si procede  │
│  5. Commit de cierre                            │
└─────────────────────────────────────────────────┘
```

---

## 🚦 Estado de fases (Fase 0 activa)

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo limpio + documentado | 🟡 80% — migración estructura pendiente (Thdora) |
| **1** | Tailscale + acceso remoto | ✅ Activo |
| **2** | SSH hardening completo | 🔴 Pendiente |
| **3** | Wazuh SIEM | 🟡 En progreso |
| **4** | Suricata IDS + reglas | 🟡 En progreso |
| **5** | GitHub Actions automatización | 🔴 No iniciado |
| **6** | Cursor + MCP en Thdora | 🔴 Pendiente |
| **7** | Ollama agentes + workflows IA | 🔴 No iniciado |

---

_Actualizado: 02-jul-2026 · Fase 0 activa · post-auditoría completa_
