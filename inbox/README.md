---
tags: [tipo/meta, estado/activo]
---
# 📥 Inbox

Zona de aterrizaje para notas crudas de sesión. **Todo entra aquí primero.**

---

## 🔄 Ciclo de vida de un fichero

```
ATERRIZAJE → SIN EMPEZAR → EN PROCESO → FINALIZADO → CRISTALIZADO
```

| Estado | Etiqueta en frontmatter | Significado |
|---|---|---|
| Recién llegado | `estado: sin-empezar` | Nota cruda, aún no revisada |
| Trabajando en él | `estado: en-proceso` | Se está procesando/moviendo ahora mismo |
| Procesado | `estado: finalizado` | Listo para cristalizar, aún en inbox |
| Movido a destino | `estado: cristalizado` | Ya vive en `docs/`, `diarios/`, `proyectos/`... |

---

## 📌 Reglas de uso

1. **Todo lo nuevo entra aquí primero** — sin excepción
2. **Al abrir la sesión** → ver qué hay pendiente, asignar `en-proceso`
3. **Al cerrar la sesión** → cristalizar todo a su destino final
4. **El inbox debe quedar limpio** al final de cada sesión
5. **`inbox/procesado/`** — archivo de ficheros ya migrados, para trazabilidad

---

## 📂 Destinos de cristalización

| Tipo de nota | Destino |
|---|---|
| Log de sesión / trabajo del día | `diarios/YYYY-MM-DD.md` |
| Conocimiento técnico (docker, infra, ssh...) | `docs/infra/`, `docs/seguridad/`... |
| Hallazgo de seguridad | `docs/seguridad/hallazgos/SEC-NNN-*.md` |
| Ficha de IA / modelo | `docs/ias/` |
| Hardware / dispositivo | `hardware/` |
| Proyecto activo | `proyectos/nombre/` |
| OSINT | `osint/` |
| Tarea pendiente | `MASTER-PENDIENTES.md` + Issue GitHub |

---

## 📄 Formato nombre fichero

```
YYYY-MM-DD-descripcion-kebab-case.md
```

(Regla 14 — CONVENCIONES.md)

---

## 🟢 Estado actual

Inbox limpio ✅ — vaciado 02-jul-2026
