# 🛡️ Auditoría del Ecosistema — Guía Completa

> Documento vivo. Actualizar tras cada fase completada.

---

## Arquitectura del núcleo de auditoría

```
meta-orquestador.sh
  └── guardian-maestro.sh
        ├── observador-scripts.sh     → cabeceras Galatea en scripts/
        ├── observador-workflows.sh   → comentarios en .github/workflows/
        ├── observador-islas.sh       → islas/ vs MAPA-ISLAS.md
        ├── observador-inbox.sh       → inbox/drop/ limpio
        ├── observador-diarios.sh     → entradas recientes en diarios/
        └── observador-mcp.sh         → tools y docs en mcp/
```

---

## Comandos de uso desde terminal

```bash
# Auditoría completa (todos los observadores)
bash scripts/guardian-maestro.sh

# Ciclo completo del ecosistema
bash scripts/meta-orquestador.sh all

# Solo auditoría
bash scripts/meta-orquestador.sh audit

# Solo investigación (cuando existan investigadores)
bash scripts/meta-orquestador.sh investigate

# Solo mejora (cuando existan mejoradores)
bash scripts/meta-orquestador.sh improve
```

El reporte se guarda automáticamente en `inbox/_meta/guardian-report-YYYYMMDDTHHMMSS.md`.

---

## Fases del plan global

| Fase | Nombre | Estado |
|------|--------|--------|
| 0 | Punto de partida — limpieza | ✅ Hecho |
| 1 | Estructura y nombres | 🔄 En curso |
| 2 | Estándar Galatea en toda la repo | 🔄 En curso |
| 3 | Núcleo de auditoría (guardian + observadores) | ✅ Scripts creados |
| 4 | MCP, islas y herramientas | ⏳ Pendiente |
| 5 | Agentes avanzados (investigadores, mejoradores, escaladores) | ⏳ Pendiente |
| 6 | Meta-agentes (fábrica, auditor de agentes) | ⏳ Pendiente |

---

## Observadores — referencia rápida

| Script | Qué audita | Output |
|--------|-----------|--------|
| `observador-scripts.sh` | Cabecera Galatea en `scripts/*.sh` | Lista ✅/⚠️ por script |
| `observador-workflows.sh` | Comentario de función en `.github/workflows/` | Lista ✅/⚠️ por workflow |
| `observador-islas.sh` | Islas en disco vs `MAPA-ISLAS.md` | Lista con desfases |
| `observador-inbox.sh` | Archivos pendientes en `inbox/drop/` | Conteo + lista |
| `observador-diarios.sh` | Entradas recientes en `diarios/` | Conteo + último diario |
| `observador-mcp.sh` | Tools y docs en `mcp/` | Conteo + advertencias |

---

## Próximos scripts a crear (Fase 4–6)

```
scripts/
  investigador-estructura.sh
  investigador-deuda-tecnica.sh
  mejorador-scripts.sh
  mejorador-documentacion.sh
  fabrica-agentes.sh
  auditor-agentes.sh
  isla-sync-validator.sh
  mapa-islas-sync.sh
  mcp-auditor.sh
```

---

## Flujo de una sesión con auditoría

```bash
# 1. Sincronizar
git pull origin main

# 2. Trabajar
# ... edits, scripts, commits ...

# 3. Antes de cerrar — auditoría rápida
bash scripts/guardian-maestro.sh

# 4. Cerrar sesión
bash scripts/session-terminal-doc.sh "descripción"
git add inbox/ && git commit -m "docs(sesion): cierre" && git push
```
