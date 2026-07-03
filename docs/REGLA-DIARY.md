# 📓 Regla DIARY — Cómo funciona el diario del ecosistema

> Toda sesión queda documentada. Ningún commit se pierde.

---

## 🎯 Objetivo

Que el diario de cada día recoja:
1. Todos los commits con hora, hash y mensaje
2. Las islas tocadas en la sesión
3. Los archivos modificados
4. Un resumen al cerrar la sesión

El diario es **automático** — no hace falta escribir nada a mano.

---

## 📁 Estructura del diario

```
diario/
└── 2026/
    └── 07/
        └── 2026-07-03.md
        └── 2026-07-04.md
        ...
```

Cada fichero `YYYY-MM-DD.md` contiene:
- Encabezado con fecha y sesión
- Islas tocadas
- Tabla de commits (hash, mensaje, hora)
- Lista de archivos modificados
- Bloque de cierre cuando se ejecuta `session-close`

---

## ⚙️ Actions que mueven el diario

### 1. `diary-writer.yml` — se dispara en cada push
- Crea o actualiza el fichero `diario/YYYY/MM/YYYY-MM-DD.md`
- Recoge todos los commits del día hasta ese momento
- Registra islas tocadas y archivos modificados
- Si el fichero ya existe, lo **sobreescribe con los datos actualizados**

### 2. `session-close.yml` — se dispara manualmente
- Se activa desde GitHub Actions → workflow_dispatch
- Añade un bloque de cierre al diary del día
- Pide dos inputs:
  - `session_id`: el ID de la sesión (ej: `S20260703`)
  - `session_summary`: resumen breve de lo hecho
- Actualiza `inbox/SIGUIENTE-PASO.md` automáticamente

### 3. `repo-health.yml` — nocturno 05:00 CEST
- Verifica que existe el diary del día anterior
- Si falta, crea un issue de alerta

---

## 📱 Cómo cerrar una sesión desde Blink

Ir a:
https://github.com/alvarofernandezmota-tech/yggdrasil-dew/actions/workflows/session-close.yml

Pulsar **Run workflow** e introducir:
- `session_id`: `S20260703`
- `session_summary`: lo que se hizo en 1-2 líneas

---

## 📜 Regla de oro

> **El diary se escribe solo. Tú solo tienes que hacer buenos commits.**

Cada commit bien escrito (`fix: corregir timeout en /config`) genera automáticamente
una entrada de diario clara, trazable y útil para el contexto de la próxima sesión.

---

## 🔗 Conexiones

- `diary-writer.yml` ← se activa con cada push
- `session-close.yml` ← cierre manual, añade bloque final
- `repo-health.yml` ← verifica que el diary existe cada mañana
- `isla-context-sync.yml` ← actualiza MAPA-ISLAS.md en cada push
- `repo-audit.yml` ← audita commits y ficheros en cada push

---

*Documentado en sesión S20260703 — 03 Jul 2026*
