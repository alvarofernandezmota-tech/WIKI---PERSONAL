---
tags: [proyecto, thdora, documentacion, obsidian, activo]
fecha-actualizacion: 2026-06-20
estado: activo
---

# 📖 Documentación thdora — Plan milimétrico

> Obsidian como centro de documentación técnica de thdora.
> Cada archivo del repo tiene su espejo aquí explicado en lenguaje humano.
> Objetivo: entender el código propio sin depender de la IA.

---

## 📁 Estructura del repo thdora

```
thdora/
├── src/
│   ├── bot/
│   │   ├── main.py              ← ✅ explorado
│   │   ├── handlers/
│   │   │   ├── __init__.py      ← ✅ explorado
│   │   │   ├── menu.py          ← ⏳ SIGUIENTE
│   │   │   └── ...              ← ⏳ pendiente
│   │   └── config.py            ← ✅ explorado
│   └── api/
│       └── ...                  ← ⏳ pendiente
├── docs/
│   ├── APRENDIZAJE_PYTHON.md    ← ✅ existe
│   ├── DEPLOY.md                ← ⏳ crear
│   ├── SERVIDOR_MADRE.md        ← ⏳ crear
│   └── TROUBLESHOOTING.md       ← ⏳ crear
├── Dockerfile
├── docker-compose.yml
└── .github/workflows/
    ├── deploy.yml               ← ✅ funciona
    └── tests.yml                ← ✅ funciona
```

---

## 📝 Plan de documentación — archivo por archivo

### Fase 1 — Entender el bot (ya en curso)

| Archivo | Estado | Qué hace | Concepts aprendidos |
|---|---|---|---|
| `src/bot/main.py` | ✅ | Entrypoint del bot · async/await · polling | async/await, handlers |
| `src/bot/config.py` | ✅ | Configuración centralizada · @lru_cache | @lru_cache, env vars |
| `src/bot/handlers/__init__.py` | ✅ | Qué es `__init__.py` | Módulos Python |
| `src/bot/handlers/menu.py` | ⏳ **SIGUIENTE** | Menú principal TOKI | — |
| `src/bot/handlers/` (resto) | ⏳ | Handlers por comando | — |
| `src/api/` | ⏳ | Endpoints FastAPI | — |

### Fase 2 — Infraestructura

| Archivo | Estado | Qué hace |
|---|---|---|
| `Dockerfile` | ⏳ | Multi-stage build · imagen Docker |
| `docker-compose.yml` | ⏳ | Orquestación servicios |
| `deploy.yml` | ✅ | CI/CD · auto-deploy en push a main |

### Fase 3 — Documentos a crear en thdora/docs/

| Documento | Contenido | Prioridad |
|---|---|---|
| `DEPLOY.md` | Guía deploy paso a paso desde cero | 🔴 |
| `SERVIDOR_MADRE.md` | IP, usuario, rutas, servicios | 🔴 |
| `TROUBLESHOOTING.md` | Errores conocidos + soluciones | 🟡 |
| `ARQUITECTURA.md` | Diagrama del sistema completo | 🟡 |

---

## 📦 Procedimiento de exploración de código

```
1. Abrir archivo en VSCode (Madre vía SSH/CRD)
2. Leer sin ejecutar — entender qué hace cada línea
3. Anotar dudas en [[formacion/python]] sección "Dudas abiertas"
4. Buscar en curso personal si el concepto está en un módulo
5. Documentar aquí lo entendido — con ejemplo propio
6. Marcar como ✅ en la tabla de arriba
```

> Con Obsidian + Local GPT: puedes preguntar directamente
> "qué hace esta función" pegando el código — responde con contexto de tus propias notas.

---

## 🤖 Handlers TOKI a implementar

Ver ficha completa: [[agentes/toki-bot]]

| Handler | Dificultad | Impacto | Estado |
|---|---|---|---|
| `/diario` | Media | ⭐⭐⭐⭐⭐ | ⏳ diseñado |
| `/inbox` | Baja | ⭐⭐⭐⭐ | ⏳ pendiente |
| `/tarea` | Baja | ⭐⭐⭐ | ⏳ pendiente |
| `/estado` | Media | ⭐⭐⭐⭐ | ⏳ pendiente |
| `/deploy` | Alta | ⭐⭐⭐⭐⭐ | ⏳ pendiente |

---

## ✅ Próximos pasos

- [ ] Leer `src/bot/handlers/menu.py` → documentar en [[formacion/python]]
- [ ] Crear `thdora/docs/DEPLOY.md` con Perplexity
- [ ] Crear `thdora/docs/SERVIDOR_MADRE.md` con IPs y rutas reales
- [ ] Implementar handler `/inbox` — más sencillo, buen punto de entrada
- [ ] Implementar handler `/diario`

---

_Ver también: [[proyectos/thdora]] · [[agentes/toki-bot]] · [[formacion/python]] · [[HOME]]_
