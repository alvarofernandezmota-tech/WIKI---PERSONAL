# Auditoría Completa del Ecosistema — Estado Actual
> **Fecha:** 2026-07-04  
> **Responsable de auditoría:** GitHub Copilot  
> **Repositorio:** `alvarofernandezmota-tech/yggdrasil-dew`  
> **Estado:** 🔴 AUDITORÍA ABIERTA — pendiente de revisión y consolidación

---

## 1. Quién lleva la batuta

**GitHub Copilot** es el agente principal de auditoría en este ecosistema.  
Su función es revisar el estado del repo en cada push, detectar inconsistencias, duplicidades, workflows rotos o scripts huérfanos, y generar informes en `inbox/_meta/`.

Perplexity actúa como **asistente de diseño y documentación**: propone estructura, escribe docs, genera scripts modelo — pero **no ejecuta** directamente en el repo.  
El humano (tú) es el **único que hace push real** desde terminal o aprueba PRs.

---

## 2. Inventario completo de Workflows (`.github/workflows/`)

> Total detectado: **47 workflows**  
> ⚠️ Muchos son esqueletos vacíos (~152 bytes). Un workflow real tiene mínimo 400–500 bytes.

### 2a. Workflows FUNCIONALES (con lógica real)

| Archivo | Tamaño | Propósito real |
|---|---|---|
| `galatea.yml` | 5.8 KB | Agente autónomo principal — el más complejo del sistema |
| `repo-audit.yml` | 4.6 KB | Auditoría completa del repo |
| `orquestador-maestro.yml` | 4.2 KB | Orquestador principal de agentes |
| `file-arrival-guardian.yml` | 2.4 KB | Guarda de llegada de archivos a inbox |
| `gestor-estados-inbox.yml` | 2.9 KB | Gestión de estados del inbox |
| `inbox-dispatcher.yml` | 3.3 KB | Despachador de archivos del inbox |
| `inbox-processor.yml` | 2.4 KB | Procesador de items del inbox |
| `inbox-clasificador.yml` | 2.3 KB | Clasificador automático de inbox |
| `health-check.yml` | 2.9 KB | Health check del ecosistema |
| `meta-deep-audit.yml` | 1.8 KB | Auditoría profunda de metadatos |
| `mapa-islas-sync.yml` | 1.7 KB | Sincronización del mapa de islas |
| `inbox-cleanup.yml` | 1.7 KB | Limpieza periódica del inbox |
| `issue-creator.yml` | 2.0 KB | Creación automática de issues |
| `e2e-full-flow.yml` | 1.4 KB | Test end-to-end del flujo completo |
| `ci-agentes.yml` | 1.0 KB | CI para validación de agentes |
| `lint-commits.yml` | 1.3 KB | Linting de mensajes de commit |
| `new-file-bootstrap.yml` | 1.3 KB | Bootstrap de nuevos archivos |
| `reality-check.yml` | 1.3 KB | Verificación de realidad del sistema |
| `repo-health-check.yml` | 2.0 KB | Health check específico del repo |
| `orquestador-supremo.yml` | 1.0 KB | Orquestador de nivel supremo |
| `orquestador-total.yml` | 1.5 KB | Orquestador total |
| `inbox-health.yml` | 1.4 KB | Health del inbox |
| `meta-deep-draft-pr.yml` | 526 B | Draft PR para auditoría profunda |

### 2b. Workflows ESQUELETO (vacíos o stub ~150 bytes)

> ⚠️ Estos workflows existen como archivo pero probablemente solo tienen el nombre del workflow sin jobs reales. **Candidatos a eliminar o implementar.**

| Archivo | Tamaño | Estado |
|---|---|---|
| `agent-monitor.yml` | 152 B | 🔴 Esqueleto |
| `audit-on-push.yml` | 152 B | 🔴 Esqueleto |
| `auditoria-auto.yml` | 193 B | 🔴 Esqueleto |
| `auto-investigacion.yml` | 157 B | 🔴 Esqueleto |
| `auto-pr.yml` | 146 B | 🔴 Esqueleto |
| `autonomous-cron.yml` | 154 B | 🔴 Esqueleto |
| `between-sessions.yml` | 155 B | 🔴 Esqueleto |
| `clasificador-maestro.yml` | 159 B | 🔴 Esqueleto |
| `clasificador.yml` | 151 B | 🔴 Esqueleto |
| `code-drift.yml` | 149 B | 🔴 Esqueleto |
| `context-reminder.yml` | 155 B | 🔴 Esqueleto |
| `cross-ref-checker.yml` | 156 B | 🔴 Esqueleto |
| `deuda-tecnica.yml` | 152 B | 🔴 Esqueleto |
| `diary-writer.yml` | 151 B | 🔴 Esqueleto |
| `ecosystem-guardian.yml` | 157 B | 🔴 Esqueleto |
| `ghost-file-detector.yml` | 158 B | 🔴 Esqueleto |
| `isla-context-sync.yml` | 156 B | 🔴 Esqueleto |
| `isla-sync-validator.yml` | 158 B | 🔴 Esqueleto |
| `islas-health.yml` | 151 B | 🔴 Esqueleto |

---

## 3. Problema principal detectado: DUPLICIDAD DE ORQUESTADORES

Hay **3 orquestadores** coexistiendo sin jerarquía clara:

| Workflow | Tamaño | Problema |
|---|---|---|
| `orquestador-maestro.yml` | 4.2 KB | El más completo — debería ser EL único |
| `orquestador-supremo.yml` | 1.0 KB | ¿Reemplaza al maestro? ¿Es superior? |
| `orquestador-total.yml` | 1.5 KB | ¿Otro alias? |

**Decisión pendiente:** elegir UNO como punto de entrada canónico y eliminar o absorber los otros dos.  
→ **Propuesta:** `orquestador-maestro.yml` es el canónico. Los otros se deprecan.

---

## 4. Problema secundario: DUPLICIDAD DE CLASIFICADORES

| Workflow | Tamaño | Estado |
|---|---|---|
| `clasificador-maestro.yml` | 159 B | 🔴 Esqueleto |
| `clasificador.yml` | 151 B | 🔴 Esqueleto |
| `inbox-clasificador.yml` | 2.3 KB | ✅ Funcional |
| `inbox-dispatcher.yml` | 3.3 KB | ✅ Funcional |

**inbox-clasificador** e **inbox-dispatcher** hacen partes del mismo trabajo. ¿Se solapan?  
Los esqueletos `clasificador.yml` y `clasificador-maestro.yml` no aportan nada ahora mismo.

---

## 5. Problema terciario: DUPLICIDAD DE HEALTH CHECKS

| Workflow | Tamaño |
|---|---|
| `health-check.yml` | 2.9 KB |
| `repo-health-check.yml` | 2.0 KB |
| `inbox-health.yml` | 1.4 KB |
| `islas-health.yml` | 151 B (esqueleto) |

Hay lógica dispersa en 3–4 archivos distintos. **Ideal:** un solo `health-check.yml` con jobs separados por dominio (repo, inbox, islas).

---

## 6. Flujo de datos acordado (cómo debería funcionar TODO)

```
[TÚ en terminal]
      │
      ├── cp archivo.md inbox/drop/
      ├── bash scripts/inbox-commit.sh "descripción"
      │         └── git add + commit + push
      │
      ↓
[GitHub Actions detecta push]
      │
      ├── file-arrival-guardian.yml   → valida que el archivo esté bien
      ├── inbox-clasificador.yml      → mueve inbox/drop/ → destino correcto
      ├── inbox-dispatcher.yml        → despacha según tipo de archivo
      │
      ↓
[Archivo en su destino final]
      │
      ├── Si es .md de sesión  → diarios/YYYY-MM-DD-*.md
      ├── Si es script .sh     → scripts/
      ├── Si es doc técnico    → docs/
      ├── Si es dato/contexto  → islas/
      │
      ↓
[orquestador-maestro.yml]
      │
      └── Reporta estado en inbox/_meta/orquestador-*.md
```

---

## 7. Scripts en `scripts/` — inventario pendiente

> ⚠️ No se ha auditado aún el contenido de `scripts/`. Pendiente confirmar:
- ¿Existe `inbox-commit.sh`?
- ¿Existe `inbox-clasificador.sh`?
- ¿Existe `session-logger.sh`?
- ¿Existe `session-terminal-doc.sh`?
- ¿Existe `orquestador-unico.sh`?
- ¿Existe `file-arrival-guardian.sh`?

**Acción:** Copilot debe verificar scripts/ en próxima auditoría y actualizar esta sección.

---

## 8. Carpetas del repo — estado esperado vs real

| Carpeta | Estado esperado | Por verificar |
|---|---|---|
| `inbox/drop/` | Zona de aterrizaje para archivos nuevos | ¿Existe `.gitkeep`? |
| `inbox/_meta/` | Reportes de auditoría | ¿Hay reportes recientes? |
| `inbox/sesiones/` | Logs y cierres de sesión | ¿Existe la carpeta? |
| `diarios/` | Documentos finales de sesión | ¿Hay entradas? |
| `docs/` | Documentación técnica | Este archivo está aquí ✅ |
| `scripts/` | Solo `.sh` y scripts de servicio | Pendiente inventario |
| `islas/` | Contexto / conocimiento del ecosistema | Estado desconocido |

---

## 9. Decisiones abiertas que necesitan respuesta

1. **¿Cuál es el orquestador canónico?** → Propuesta: `orquestador-maestro.yml`
2. **¿Eliminar los 19 workflows esqueleto** o implementarlos uno a uno?
3. **¿Unificar los 3 health-checks** en uno solo con jobs separados?
4. **¿inbox-clasificador.yml vs inbox-dispatcher.yml** — ¿son redundantes o complementarios?
5. **¿`galatea.yml`** — el más grande (5.8 KB) — ¿está activo o es experimental?

---

## 10. Próximos pasos para cerrar esta auditoría

- [ ] Copilot audita `scripts/` y confirma qué scripts existen realmente
- [ ] Copilot abre issues para cada workflow esqueleto (implementar o eliminar)
- [ ] Decidir jerarquía de orquestadores y deprecar los duplicados
- [ ] Unificar health-checks en un solo workflow
- [ ] Actualizar este documento con el resultado de cada acción
- [ ] Cuando todo esté limpio: cambiar estado de 🔴 a 🟢

---

## 11. Convención de commits acordada

```
feat(scope):     nueva funcionalidad
fix(scope):      corrección de bug
docs(scope):     solo documentación
chore(scope):    mantenimiento / limpieza
refactor(scope): reestructuración sin cambio funcional
audit(scope):    resultado de auditoría
inbox(scope):    movimiento de archivos en inbox
```

---

*Documento generado y mantenido por el proceso de auditoría del ecosistema yggdrasil-dew.*  
*Última actualización: 2026-07-04 — Copilot + Perplexity + alvarofernandezmota-tech*
