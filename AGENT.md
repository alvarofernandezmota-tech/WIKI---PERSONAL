# AGENT.md — Contexto para agentes IA

> **Lee este archivo al inicio de CADA sesión.**
> Contiene todo lo que necesitas para trabajar en este ecosistema sin preguntar.
> Si algo cambió estructuralmente, está aquí reflejado.

---

## 👤 Usuario

- **Nombre:** Álvaro Fernández Mota
- **Perfil:** Ingeniero de sistemas autodidacta. Stack: Python, Docker, Linux, IA local, OSINT.
- **Filosofía:** Producción primero, perfección después. El ritmo importa más que el sprint. Ver `docs/filosofia/`.
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

## 🗂️ Repos activos del ecosistema

| Repo | Visibilidad | Para qué |
|---|---|---|
| `WIKI---PERSONAL` | Privado | **Este repo** — wiki central, mapa conceptual, segundo cerebro |
| `yggdrasil-dew` | Privado | Segundo cerebro técnico · infraestructura · docs · diarios |
| `thdora` / `THDORA-PERSONAL` | Privado | Bot TOKI · FastAPI · Docker |
| `madre-config` | Privado | Configuración Madre (Arch Linux, Docker, servicios) |
| `ollama-stack` | Privado | Ollama + modelos locales |
| `local-brain` | Privado | RAG + Qdrant + memoria |
| `yggdrasil-secops` | Privado | Seguridad defensiva (hallazgos HAL-XXX) |
| `osint-stack` | Privado | Seguridad ofensiva / OSINT / pentest |
| `formacion-tech` | Privado | Aprendizaje, cursos, Python |
| `investigacion-ia` | Privado | PoCs de IA |
| `acer-config` | Privado | Configuración Acer (Arch Linux + Hyprland) |
| `dev-labs` | Privado | Sandbox antes de crear repo propio |
| `alvarofernandezmota-tech` | Público | Profile README de GitHub |

---

## 📋 Reglas del sistema — OBLIGATORIAS

1. **Leer antes de actuar** — `AGENT.md` → `CONTEXT.md` → `docs/CONVENCIONES.md`
2. **Todo entra por `inbox/`** — nunca sobrescribir ficheros existentes directamente
3. **Verificar SHA** antes de actualizar cualquier fichero existente
4. **CONTEXT.md** = estado actual — actualizar al inicio Y al final de cada sesión
5. **HOME.md** = índice de navegación — actualizar cuando se añade sección nueva
6. **Diario de sesión** = obligatorio al cierre en `docs/diarios/YYYY-MM-DD.md`
7. **Convenciones** = `kebab-case` en `docs/` y `wiki/`, `MAYÚSCULAS` en raíz
8. **No crear stubs vacíos** — si no hay contenido real, no crear el fichero

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
  - Cursor + MCP GitHub               [pendiente en Thdora/Acer]

Seguridad:
  - SSH: ed25519 only, no passwords    [pendiente hardening completo]
  - Fail2ban                           [pendiente]
  - nftables                           [activo]
  - FTP puerto 21 router Digi          [🔴 EXPUESTO — remediar]
  - Wazuh agentes                      [en progreso]
```

---

## 🗺️ Mapa de islas (referencia rápida)

| Isla | Repo | Estado |
|---|---|---|
| 🧠 Cerebro | yggdrasil-dew | ✅ Activo |
| 🗺️ Wiki/Conocimiento | WIKI---PERSONAL (este repo) | ✅ Activo |
| 🖥️ Infra/Madre | madre-config | ✅ Activo |
| 🤖 IA Local | ollama-stack + local-brain | ✅ Activo |
| 🦾 Thdora | THDORA-PERSONAL | ✅ Activo (deuda técnica) |
| 🛡️ Seguridad | yggdrasil-secops + osint-stack | 🟡 Iniciado |
| 📚 Formación | formacion-tech + investigacion-ia | ✅ Activo |
| 🧪 Labs | dev-labs | 🟡 Sandbox |

Ver mapa completo: [`wiki/00-mapa.md`](wiki/00-mapa.md) · [`wiki/mapa-islas.md`](wiki/mapa-islas.md)

---

## 📐 Flujo de trabajo estándar

```
┌─────────────────────────────────────────────────┐
│              INICIO DE SESIÓN                   │
│  1. Leer AGENT.md (este fichero)                │
│  2. Leer CONTEXT.md (estado actual)             │
│  3. Leer docs/CONVENCIONES.md (normas)          │
└───────────────────┬─────────────────────────────┘
                    ↓
             Trabajar (inbox/ primero)
                    ↓
┌───────────────────┴─────────────────────────────┐
│              CIERRE DE SESIÓN                   │
│  1. Escribir diario en docs/diarios/YYYY-MM-DD  │
│  2. Actualizar CONTEXT.md                       │
│  3. Procesar inbox/ si hay items                │
│  4. Commit de cierre                            │
└─────────────────────────────────────────────────┘
```

---

## 🚦 Estado de fases

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo limpio + wiki estructurada | 🟡 95% — islas pendientes de rellenar |
| **1** | Tailscale + acceso remoto | ✅ Activo |
| **2** | SSH hardening completo | 🔴 Pendiente (`PasswordAuthentication no`) |
| **3** | Wazuh SIEM | 🟡 En progreso |
| **4** | Suricata IDS + reglas | 🟡 En progreso |
| **5** | GitHub Actions automatización | 🔴 No iniciado |
| **6** | Cursor + MCP en Thdora/Acer | 🔴 Pendiente |
| **7** | Ollama agentes + workflows IA | 🔴 No iniciado |

---

_Actualizado: 2026-07-05 · Fase 0 activa · wiki reorganizada · Perplexity-MCP_
