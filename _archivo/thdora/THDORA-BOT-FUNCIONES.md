# 🤖 thdora — Funciones del bot

> Plan completo de funcionalidades. Lo que existe, lo que se va a hacer y cómo conecta con el ecosistema.

---

## 📊 Estado actual (F1 — deuda técnica)

| Issue | Problema | Impacto |
|---|---|---|
| [#12](https://github.com/alvarofernandezmota-tech/thdora/issues/12) | Código zombie | Bot inestable, consumo extra |
| [#10](https://github.com/alvarofernandezmota-tech/thdora/issues/10) | /config timeout | Comando roto |

---

## ✅ Funciones que tendrá thdora

### Capa 1 — Comandos básicos (F1)
| Comando | Qué hace |
|---|---|
| `/estado` | Devuelve contenido de `ESTADO-SISTEMA.md` |
| `/roadmap` | Devuelve fases activas del `ROADMAP-MASTER.md` |
| `/pendientes` | Lista `inbox/SIGUIENTE-PASO.md` |
| `/config` | Configura el bot (fix issue #10) |
| `/ayuda` | Lista todos los comandos |

### Capa 2 — Monitoreo del ecosistema (F3)
| Comando / Trigger | Qué hace |
|---|---|
| `/islas` | Devuelve tabla de `MAPA-ISLAS.md` |
| `/health` | Lanza `repo-health.yml` y devuelve resultado |
| Notificación automática | Cuando GitHub Actions crea un issue → manda mensaje a Telegram |
| Daily report 08:00 | Resumen del día anterior: commits, islas tocadas, pendientes |

### Capa 3 — IA local (F4)
| Comando | Qué hace |
|---|---|
| `/pregunta [texto]` | Manda consulta a ollama local y devuelve respuesta |
| `/resumir [url o texto]` | Solicita resumen a ollama |
| `/analizar` | Analiza el último commit con ollama |

### Capa 4 — Automatizaciones (F3)
| Trigger | Acción |
|---|---|
| Nuevo issue en ygg | Mensaje Telegram con título + link |
| PR mergeado | Notificación con resumen de cambios |
| Health check falla | Alerta urgente en Telegram |
| Sesión cerrada | Resumen de la sesión en Telegram |

---

## 🔄 ¿Bot o GitHub Action?

Regla clara:

| Tarea | Dónde va |
|---|---|
| Auditar archivos, READMEs, commits | GitHub Action |
| Notificar en Telegram | Bot thdora |
| Responder comandos del usuario | Bot thdora |
| Lanzar workflows | Bot thdora → llama a Action via API |
| IA local (ollama) | Bot thdora |
| Documentar diary | GitHub Action |

El bot **no reemplaza las Actions** — las complementa. Las Actions son el sistema inmune, el bot es la interfaz humana.

---

## 🚨 Cuándo separar una funcionalidad a isla propia

Sepa una funcionalidad de thdora cuando:
1. Tiene más de 500 líneas de código propio
2. Necesita su propio proceso/daemon
3. Tiene dependencias que no comparte con el bot
4. Otros proyectos la quieren usar independientemente

Ejemplo: si el módulo IA crece mucho → separar a isla `local-brain` con su propio repo.

---

## 📝 Conexión con el ecosistema

```
thdora bot
├── lee ← ESTADO-SISTEMA.md, MAPA-ISLAS.md, ROADMAP-MASTER.md
├── escribe ← inbox/ (cuando recibe ideas por Telegram)
├── llama ← ollama (isla local-brain)
└── notifica → Telegram
```

---

*Ver `ROADMAP-MASTER.md` F1 y F3 para el plan de implementación.*
