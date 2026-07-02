# Workflow Inbox — cómo procesar
#operativa #inbox #workflow #fase0

Flujo estándar para vaciar la inbox sin perder nada y dejando todo trazable.

---

## El flujo en 6 pasos

```
1. CAPTURAR    → inbox/YYYY-MM-DD-nombre.md
2. REVISAR     → leer el fichero, decidir destino
3. MIGRAR      → crear docs/ruta/destino.md con contenido procesado
4. ARCHIVAR    → reemplazar inbox/ con stub en inbox/procesado/
5. REGISTRAR   → añadir entrada en docs/operativa/migraciones-inbox.md
6. COMMITEAR   → git commit -m "migration(inbox): descripción"
```

---

## Destinos habituales

| Tipo de contenido | Destino |
|---|---|
| Sesión de trabajo completa | `docs/diarios/YYYY-MM-DD.md` |
| Config o setup de infra | `docs/infra/[servicio]/` |
| Hallazgo de seguridad | `docs/seguridad/hallazgos/` |
| Decisión arquitectural | `docs/proyectos/[proyecto]/` |
| Herramienta o ecosistema | `docs/herramientas/` |
| Script ejecutado | `scripts/` |
| Plan o roadmap | raíz del repo (`PLAN-*.md`) |

---

## Estructura de un stub de archivado

```yaml
---
archivado: YYYY-MM-DD
migrado_a: docs/ruta/destino.md
---

# → ARCHIVADO

Contenido migrado a [docs/ruta/destino.md](../../docs/ruta/destino.md)
```

---

## Automatización

- **`inbox-health.yml`** — alerta automática si inbox > 10 ficheros
- **`scripts/migrar-inbox.sh`** — script semi-automático de migración por lotes
- **TOKI-DEW `/inbox`** — comando Telegram para ver estado de la inbox

---

## Señales de que la inbox está sana

- `inbox/` tiene < 5 ficheros
- Todos los ficheros son del día actual o máximo del día anterior
- `inbox/procesado/` tiene stubs de todo lo migrado
- El log `docs/operativa/migraciones-inbox.md` está actualizado
