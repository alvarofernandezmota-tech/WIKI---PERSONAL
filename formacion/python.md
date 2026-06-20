---
tags: [formacion, python, aprendizaje, activo, curso, thdora]
fecha-actualizacion: 2026-06-20
---

# 🐍 Formación Python

---

## 📐 Procedimiento de aprendizaje

```
1. CURSO (base teórica)
   personal/02_formacion/02_python/ → un módulo cada vez
           ↓
2. EXPLORAR thdora (aplicación real)
   Leer archivo real del repo → entender sin ejecutar
           ↓
3. DOCUMENTAR aquí
   Concepto aprendido → sección "Conceptos dominados"
   Duda abierta → sección "Dudas abiertas"
           ↓
4. PREGUNTAR si no se entiende
   Pegar código a Perplexity / Local GPT en Obsidian
           ↓
5. INBOX si aparece algo nuevo mientras estudias
   No interrumpir el flujo — anotar en inbox y seguir
```

---

## 📚 Curso principal

**Repo:** https://github.com/alvarofernandezmota-tech/personal/tree/main/02_formacion/02_python

> El curso vive en `personal` y se acaba allí — no se toca ni se mueve.

### Módulos del curso

| Módulo | Contenido | Estado |
|---|---|---|
| 01 — Introducción | Variables, tipos, operadores | ✅ completado |
| 02 — Fundamentos | Funciones, módulos, `__init__.py` | ✅ completado |
| 03 — POO | Clases, objetos, métodos | ✅ completado |
| 04 — POO Avanzado | Herencia, decoradores, `@lru_cache` | ✅ completado |
| 05 — Módulo 5 | ⏳ en progreso — **SIGUIENTE SESIÓN** | ⏳ activo |
| 06 — Clases extra | Por definir | ⏳ pendiente |
| 07 — Proyecto final | Proyecto integrador | ⏳ pendiente |

> ⏳ **Siguiente:** abrir módulo 05 en `personal/02_formacion/02_python/05_modulo-5/`

---

## 🔍 Exploración thdora — código real

Ver plan detallado: [[proyectos/thdora-docs]]

### Archivos explorados

| Archivo | Conceptos aprendidos | Estado |
|---|---|---|
| `src/bot/main.py` | async/await · polling · entrypoint | ✅ |
| `src/bot/config.py` | @lru_cache · variables de entorno | ✅ |
| `src/bot/handlers/__init__.py` | Módulos · imports | ✅ |
| `src/bot/handlers/menu.py` | ⏳ **SIGUIENTE** | ⏳ |
| `src/bot/handlers/` (resto) | | ⏳ |
| `src/api/` | | ⏳ |
| `Dockerfile` | Multi-stage build | ⏳ |
| `docker-compose.yml` | Orquestación servicios | ⏳ |

---

## 🧠 Conceptos dominados

| Concepto | Dónde lo aprendí | Ejemplo real |
|---|---|---|
| `async/await` | `main.py` thdora + curso M2 | Bot espera mensajes sin bloquear |
| `@lru_cache` | `config.py` thdora | Config se carga una sola vez |
| `__init__.py` | handlers thdora + curso M2 | Los handlers son un paquete |
| POO: clases y herencia | Curso M3-M4 | Handlers heredan de clase base |
| Decoradores | Curso M4 | `@lru_cache`, `@router.get` |
| Docker multi-stage | Dockerfile thdora | Imagen más pequeña en prod |
| Healthcheck Docker | Fix bot unhealthy | `docker inspect` para ver estado |
| Variables de entorno | `config.py` thdora | `.env` → `os.getenv()` |

---

## ❓ Dudas abiertas

- ¿Cómo funciona LangGraph internamente? — usado en thdora para el grafo de conversación
- ¿Cuándo usar `async` y cuándo no? — regla práctica
- ¿Qué es exactamente un `checkpoint` en LangGraph?

---

## 🗓️ Planificación Python semanal

```
Martes   → Módulo 05 del curso (1 hora)
Miércoles → Explorar menu.py en thdora + documentar
Viernes  → Avance libre — lo que salga
```

---

## 🎯 Objetivo final

Entender el 100% del código de thdora sin ayuda externa.
Despues: implementar handlers nuevos de TOKI yo solo.

---

_Curso en `personal` · Exploración en [[proyectos/thdora-docs]] · [[HOME]]_
