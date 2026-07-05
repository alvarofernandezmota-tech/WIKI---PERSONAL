# AUDITORIA-COMPLETA-YGG.md

> **Fecha:** 2026-07-04 12:38 CEST  
> **Scope:** yggdrasil-dew — capa raíz  
> **Islas:** pendiente (próxima sesión)  
> **Generado por:** Perplexity + inventario real vía GitHub API  
> **Lee esto ANTES de tocar nada.**

---

## RESUMEN EJECUTIVO

Copilot ha ejecutado las fases 1→4 sobre `scripts/`. El repo tiene ahora:
- **47 workflows** en `.github/workflows/` — inventario completo abajo
- **Scripts consolidados** (orquestador-unico como canónico)
- **4 .md fuera de sitio** en `scripts/` pendientes de mover (Paso 0)
- **Duplicados de workflows** detectados — misma función, distinto nombre

### Estado por capa

| Capa | Descripción | Estado | Prioridad |
|------|-------------|--------|-----------|
| CAPA 1 | `scripts/` | 🟡 Copilot ejecutando P1→P4 | URGENTE |
| CAPA 2 | `agentes/` | 🔴 Sin auditar | Esta semana |
| CAPA 3 | `mcp/` | 🔴 Sin auditar | Esta semana |
| CAPA 4 | `.github/workflows/` | 🟠 47 detectados, duplicados a resolver | Esta semana |
| CAPA 5 | Raíz + docs + islas | 🔴 Sin auditar | Próxima sesión |

---

## INVENTARIO REAL — `.github/workflows/` (47 archivos)

### Workflows con implementación real (tamaño > 500 bytes)

| Archivo | Tamaño | Estado | Acción |
|---------|--------|--------|---------|
| `galatea.yml` | 5.8 KB | 🟢 Activo complejo | Auditar triggers |
| `repo-health.yml` | 4.4 KB | 🟢 Activo | OK |
| `repo-audit.yml` | 4.6 KB | 🟢 Activo | OK |
| `orquestador-maestro.yml` | 4.2 KB | 🟡 Posible duplicado | Revisar vs orquestador-supremo |
| `gestor-estados-inbox.yml` | 2.9 KB | 🟢 Activo | OK |
| `health-check.yml` | 2.9 KB | 🟡 Duplicado parcial | Revisar vs repo-health |
| `tripwire-repo.yml` | 2.8 KB | 🟢 Activo | OK |
| `inbox-dispatcher.yml` | 3.3 KB | 🟢 Activo | OK |
| `inbox-processor.yml` | 2.4 KB | 🟡 Duplicado parcial | Revisar vs inbox-dispatcher |
| `file-arrival-guardian.yml` | 2.4 KB | 🟢 Canónico | OK |
| `inbox-clasificador.yml` | 2.3 KB | 🟢 Canónico | OK |
| `mapa-islas-sync.yml` | 1.7 KB | 🟢 Activo | OK |
| `e2e-full-flow.yml` | 1.2 KB | 🟢 Activo | OK |
| `inbox-cleanup.yml` | 1.7 KB | 🟢 Activo | OK |
| `inbox-health.yml` | 1.4 KB | 🟡 Duplicado parcial | Revisar vs inbox-cleanup |
| `issue-creator.yml` | 2.0 KB | 🟢 Activo | OK |
| `lint-commits.yml` | 1.3 KB | 🟢 Activo | OK |
| `meta-deep-audit.yml` | 1.8 KB | 🟢 Activo | OK |
| `meta-deep-draft-pr.yml` | 526 B | 🟢 Activo | OK |
| `new-file-bootstrap.yml` | 1.3 KB | 🟢 Activo | OK |
| `orquestador-supremo.yml` | 1.0 KB | 🟡 Duplicado | Revisar vs orquestador-maestro |
| `orquestador-total.yml` | 1.5 KB | 🟡 Duplicado | Archivar o consolidar |
| `reality-check.yml` | 1.3 KB | 🟢 Activo | OK |
| `repo-health-check.yml` | 2.0 KB | 🟡 Duplicado | Revisar vs repo-health |
| `repo-research-on-push.yml` | 1.2 KB | 🟢 Activo | OK |
| `resumen-diario.yml` | 1.5 KB | 🟢 Activo | OK |
| `secret-scan.yml` | 1.6 KB | 🟢 Activo | OK |
| `session-close.yml` | 995 B | 🟢 Canónico | OK |
| `struct-auditor.yml` | 963 B | 🟢 Activo | OK |
| `sync-drive.yml` | 949 B | 🟢 Activo | OK |
| `sync-estado.yml` | 1.8 KB | 🟢 Activo | OK |
| `test-scripts.yml` | 1.9 KB | 🟢 Activo | OK |
| `tool-inventory-auditor.yml` | 1.0 KB | 🟢 Activo | OK |
| `yamllint.yml` | 943 B | 🟢 Activo | OK |
| `watchdog.yml` | 920 B | 🟢 Activo | OK |
| `watchdog-monitor.yml` | 998 B | 🟡 Duplicado | Revisar vs watchdog |
| `ci-agentes.yml` | 599 B | 🟢 Activo | OK |

### Workflows stub (< 200 bytes — sin implementación real)

Estos 10 workflows sólo tienen el esqueleto. **Copilot debe implementarlos o eliminarlos:**

| Archivo | Tamaño | Acción recomendada |
|---------|--------|---------------------|
| `agent-monitor.yml` | 152 B | Implementar o eliminar |
| `audit-on-push.yml` | 152 B | Implementar o eliminar |
| `auditoria-auto.yml` | 193 B | Implementar o eliminar |
| `auto-investigacion.yml` | 157 B | Implementar o eliminar |
| `auto-pr.yml` | 146 B | Implementar o eliminar |
| `autonomous-cron.yml` | 154 B | ⚠️ PELIGRO: cron autónomo vacío |
| `between-sessions.yml` | 155 B | Implementar o eliminar |
| `clasificador-maestro.yml` | 159 B | Duplicado de inbox-clasificador |
| `clasificador.yml` | 151 B | Duplicado de inbox-clasificador |
| `code-drift.yml` | 149 B | Implementar o eliminar |
| `context-reminder.yml` | 155 B | Implementar o eliminar |
| `cross-ref-checker.yml` | 156 B | Implementar o eliminar |
| `deuda-tecnica.yml` | 152 B | Implementar o eliminar |
| `diary-writer.yml` | 151 B | Implementar o eliminar |
| `ecosystem-guardian.yml` | 157 B | Implementar o eliminar |
| `ghost-file-detector.yml` | 158 B | Implementar o eliminar |
| `isla-context-sync.yml` | 156 B | Implementar vs mapa-islas-sync |
| `isla-sync-validator.yml` | 158 B | Implementar o eliminar |
| `islas-health.yml` | 151 B | Implementar o eliminar |

### Duplicados de workflows detectados

| Grupo | Canónico | A revisar/archivar |
|-------|----------|--------------------|
| Orquestadores | `orquestador-maestro.yml` | `orquestador-supremo.yml`, `orquestador-total.yml` |
| Health checks | `repo-health.yml` | `repo-health-check.yml`, `health-check.yml` |
| Inbox | `inbox-dispatcher.yml` | `inbox-processor.yml` |
| Inbox salud | `inbox-cleanup.yml` | `inbox-health.yml` |
| Watchdog | `watchdog.yml` | `watchdog-monitor.yml` |
| Clasificador | `inbox-clasificador.yml` | `clasificador.yml`, `clasificador-maestro.yml` |
| Islas sync | `mapa-islas-sync.yml` | `isla-context-sync.yml` |

---

## TAREAS PARA COPILOT — orden de ejecución

### 🔴 TAREA 0 (ejecutar ahora mismo, terminal)

```
Lee AUDITORIA-COMPLETA-YGG.md y COPILOT-AUDIT-PLAN.md.

Ejecuta exactamente esto desde la raíz del repo:

git checkout main && git pull origin main
git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/
git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/
git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/
git mv scripts/2026-07-03-reality-check.md diarios/
git add -A
git commit -m "fix(estructura): mover 4 .md fuera de scripts/ a sus destinos correctos"
git push origin main

Despues confirma con: git log --oneline -n 3
```

---

### 🟡 TAREA 1 — Consolidar scripts (CAPA 1) — YA INICIADA POR COPILOT

Copilot ha ejecutado P1→4 del COPILOT-AUDIT-PLAN.md. Verificar:

```
Verifica que se han completado estas acciones:
1. scripts/archive/ contiene los orquestadores redundantes
2. scripts/cierre-sesion.sh tiene el snippet de auto-commit
3. scripts/migrar-sesiones-diarios.sh existe y es ejecutable
4. scripts/apertura-sesion.sh tiene el bloque de pre-audit

Si alguno falta, ejectuarlo según COPILOT-AUDIT-PLAN.md PRIORIDAD correspondiente.
Actualizar scripts/SCRIPTS-AUDITORIA.md con el resultado de cada acción.
```

---

### 🟡 TAREA 2 — Resolver workflows stub (CAPA 4)

```
Tengo 19 workflows en .github/workflows/ con menos de 200 bytes (solo esqueleto).
Lista completa en AUDITORIA-COMPLETA-YGG.md sección "Workflows stub".

Para cada uno:
1. Leer el nombre y decidir si tiene un workflow real equivalente ya existente.
2. Si es duplicado -> eliminarlo o vaciarlo con un comentario "# DEPRECATED: ver <canonical>.yml"
3. Si es nuevo y necesario -> implementarlo con los pasos mínimos reales.
4. Si es peligroso (autonomous-cron.yml) -> desactivarlo hasta revision humana.

Empezar por los duplicados claros:
- clasificador.yml -> reemplazar por referencia a inbox-clasificador.yml
- clasificador-maestro.yml -> igual
- isla-context-sync.yml -> revisar vs mapa-islas-sync.yml
- autonomous-cron.yml -> desactivar (poner on: workflow_dispatch solo)

Crear rama: maintenance/workflows-stub-cleanup
Abrir PR draft cuando termines.
```

---

### 🟡 TAREA 3 — Consolidar workflows duplicados (CAPA 4)

```
Tengo estos grupos de workflows duplicados (tabla completa en AUDITORIA-COMPLETA-YGG.md):

Grupo orquestadores:
- CANONICO: orquestador-maestro.yml
- ARCHIVAR: orquestador-supremo.yml, orquestador-total.yml

Grupo health:
- CANONICO: repo-health.yml
- ARCHIVAR: repo-health-check.yml, health-check.yml

Grupo inbox:
- CANONICO: inbox-dispatcher.yml
- REVISAR: inbox-processor.yml (puede ser complementario)

Grupo watchdog:
- CANONICO: watchdog.yml
- ARCHIVAR: watchdog-monitor.yml

Para cada archivo a archivar:
1. Comparar contenido con el canónico
2. Si es igual o subconjunto -> añadir comentario DEPRECATED y desactivar el trigger
3. Si tiene algo único -> fusionar esa parte al canónico
4. Commit: "chore(workflows): deprecate duplicate <nombre>.yml in favor of <canonico>.yml"

Crear rama: maintenance/workflows-dedup
Abrir PR draft.
```

---

### 🔴 TAREA 4 — Auditar `agentes/` (CAPA 2)

```
Audita la carpeta agentes/ completa:

1. Listar todos los archivos con: find agentes/ -type f | sort
2. Para cada agente:
   a. ¿Tiene README.md propio?
   b. ¿Tiene header de documentación (qué hace, cómo se lanza, qué genera)?
   c. ¿Está referenciado en HERRAMIENTAS-ECOSISTEMA.md?
3. Crear docs/agentes-inventario.md con tabla de todos los agentes
4. Actualizar HERRAMIENTAS-ECOSISTEMA.md con los que falten

Crear rama: maintenance/agentes-audit
Abrir PR draft.
```

---

### 🔴 TAREA 5 — Auditar `mcp/` y actualizar mcp-config.json (CAPA 3)

```
Audita la carpeta mcp/ y el archivo mcp-config.json:

1. Listar: find mcp/ -type f | sort
2. Comparar con la whitelist en COPILOT-AUDIT-PLAN.md sección CAPA 3
3. Verificar que mcp-config.json refleja los scripts canónicos actuales
   (despues de la consolidación de TAREA 1)
4. Añadir al mcp-config.json la lista blocked de scripts peligrosos
5. Crear docs/mcp-guia.md con instrucciones para conectar Copilot y Gemini

Crear rama: maintenance/mcp-audit
Abrir PR draft.
```

---

### 🔴 TAREA 6 — Archivar duplicados en raíz + plantillas

```
Archivos raiz a revisar:
- ROADMAP.md vs ROADMAP-MASTER.md -> decidir cuál es el activo
- ECOSISTEMA.md vs ECOSYSTEM-ARCHITECTURE.md -> decidir cuál es el activo
- Carpeta sesiones/ en raiz vs inbox/sesiones/ -> consolidar

Plantillas a crear en templates/:
- templates/sesion-apertura.md
- templates/sesion-cierre.md
- templates/isla-readme.md
- templates/script-header.sh (cabecera estándar para todos los scripts)
- templates/workflow-base.yml (esqueleto mínimo de workflow)
- templates/agente-readme.md

Crear rama: maintenance/root-cleanup-and-templates
Abrir PR draft.
```

---

### 🔴 TAREA 7 — Islas (próxima sesión)

```
Audit completo de islas/ siguiendo el mismo patron:
1. Listar todas las islas: ls islas/
2. Para cada isla verificar: README.md, estructura, referencia en MAPA-ISLAS.md
3. Crear/actualizar MAPA-ISLAS.md con estado real de cada isla
4. Verificar que cada isla tiene su propio CHANGELOG o al menos un estado

Crear rama: maintenance/islas-audit
Abrir PR draft.
```

---

## CONVENCIÓN ANTI-LOOP (OBLIGATORIA PARA WORKFLOWS ESCRITORES)

Todo workflow que escribe en el repo DEBE seguir este patrón:

```yaml
# OBLIGATORIO en todo workflow escritor:
- name: Crear rama de trabajo
  run: |
    BRANCH="bot/${GITHUB_WORKFLOW}-$(date +%Y%m%dT%H%M%S)"
    git checkout -b "$BRANCH"
    # ... hacer cambios ...
    git commit -m "..."
    git push origin "$BRANCH"

- name: Abrir PR draft
  run: |
    gh pr create --title "..." --body "..." --draft
    # NUNCA auto-merge
```

NINGÚN workflow debe hacer push directo a main sin revisión humana.

---

## CHECKLIST DE VERIFICACIÓN FINAL

Despues de completar todas las tareas:

- [ ] `scripts/` sin archivos `.md` sueltos
- [ ] `scripts/archive/` contiene duplicados archivados
- [ ] `scripts/SCRIPTS-AUDITORIA.md` actualizado con todas las acciones
- [ ] 0 workflows stub activos (todos implementados o desactivados)
- [ ] 0 workflows duplicados activos (uno archivado en cada par)
- [ ] `mcp-config.json` con whitelist + blocked actualizados
- [ ] `docs/agentes-inventario.md` creado
- [ ] `docs/mcp-guia.md` creado
- [ ] `templates/` con 6 plantillas base
- [ ] `MAPA-ISLAS.md` refleja estado real
- [ ] `MASTER-PENDIENTES.md` actualizado
- [ ] `CHANGELOG.md` con entrada por cada tarea completada

---

## HISTORIAL DE AUDITORÍA

| Fecha | Acción | Por | Resultado |
|-------|--------|-----|-----------|
| 2026-07-03 | Auditoría inicial estructura scripts/ | Copilot | Detectados duplicados y .md fuera de sitio |
| 2026-07-04 | COPILOT-AUDIT-PLAN.md creado con 5 capas | Perplexity | En repo |
| 2026-07-04 | Copilot ejecuta P1→4 sobre scripts/ | Copilot | Verificar resultado |
| 2026-07-04 | AUDITORIA-COMPLETA-YGG.md creado | Perplexity | Este archivo |
| 2026-07-04 | Inventario real 47 workflows | Perplexity vía GitHub API | Tabla completa arriba |
| Pendiente | Tarea 0: mover 4 .md | Tú / Copilot | — |
| Pendiente | Tarea 2: resolver 19 stubs | Copilot | — |
| Pendiente | Tarea 3: consolidar duplicados | Copilot | — |
| Pendiente | Tarea 4: auditar agentes/ | Copilot | — |
| Pendiente | Tarea 5: auditar mcp/ | Copilot | — |
| Pendiente | Tarea 6: raíz + plantillas | Copilot | — |
| Pendiente | Tarea 7: islas (próxima sesión) | Copilot | — |

---

_Actualizar la tabla de historial al completar cada tarea._  
_Última actualización: 2026-07-04 12:38 CEST — Perplexity_
