---
tipo: reglas-islas
version: 1.0
fecha: 2026-07-03
aplicacion: todas las repos del ecosistema Yggdrasil
---

# Reglas para todas las Islas del Ecosistema

> Una isla = cualquier repo del ecosistema Yggdrasil.
> Estas reglas son obligatorias en todas. No hay excepciones.

---

## Reglas de estructura (toda isla debe tener)

```
[repo-isla]/
├── README.md           ← descripcion, rol en el ecosistema, dependencias
├── CHANGELOG.md        ← historial de cambios
├── docs/               ← documentacion tecnica
├── scripts/            ← scripts de la isla (siguen el estandar Yggdrasil)
├── .github/
│   └── workflows/
│       ├── health-check.yml    ← obligatorio en toda isla
│       ├── audit-on-push.yml   ← obligatorio en toda isla
│       └── code-drift.yml      ← obligatorio en toda isla
└── .isla-config.yml    ← metadatos de la isla (ver formato abajo)
```

---

## Formato .isla-config.yml

```yaml
# .isla-config.yml — Metadatos de la isla para el ecosistema
nombre: "nombre-de-la-isla"
rol: "descripcion de que hace esta isla"
type: "core|agente|bot|infra|research|personal"  
dependencias:
  - "yggdrasil-dew"  # isla de la que depende
repos_sync:
  - "yggdrasil-dew"  # repos que deben estar al tanto de cambios
propietario: alvarofernandezmota-tech
estado: "activa|desarrollo|deprecated"
labels_obligatorias:
  - auto
  - human-review
  - drift
agente_responsable: "health-agent"  # quien monitoriza esta isla
```

---

## Reglas de scripts (en cualquier isla)

1. **Shebang obligatorio:** `#!/usr/bin/env bash` o `#!/usr/bin/env python3`
2. **Primeras 3 lineas:** `set -euo pipefail` (bash) o equivalente
3. **Cabecera obligatoria:**
```bash
# =============================================================================
# nombre-script.sh
# Descripcion: una linea clara
# Uso: ./nombre-script.sh [opciones]
# Dependencias: gh, jq, curl
# =============================================================================
```
4. **Funcion `log()`** en scripts >30 lineas
5. **DRY_RUN support** en scripts que crean/modifican recursos
6. **No hardcodear secrets** — usar variables de entorno o Vault
7. **Exit codes:** 0=ok, 1=error, 2=warning

---

## Reglas de workflows (en cualquier isla)

1. **Cabecera comentada** describiendo qué hace el workflow
2. **`timeout-minutes`** en todos los jobs
3. **`permissions`** minimas (principle of least privilege)
4. **`workflow_dispatch`** en workflows importantes (para ejecucion manual)
5. **Labels en issues** que cree el workflow: al menos `auto` y uno especifico
6. **No secrets en logs** — usar `::add-mask::` si es necesario

---

## Reglas de issues (en cualquier isla)

| Label | Significado | Quien actua |
|-------|-------------|-------------|
| `auto` | Creado por el sistema | Sistema |
| `[AUTO]` en titulo | Solo puede ejecutar el sistema | Scripts/Actions |
| `[HUMAN]` en titulo | Requiere decision humana | Alvaro |
| `[RISKY]` en titulo | Requiere aprobacion explicita | Alvaro |
| `drift` | Desviacion del estandar | Code-drift-detector |
| `documentacion` | Falta doc | Copilot/Alvaro |
| `agentes` | Relacionado con agentes | Alvaro + Cursor |
| `alerta` | Urgente, revisar hoy | Guardianbot notifica |

---

## Reglas de commits (en cualquier isla)

```
<tipo>(<scope>): <descripcion> [<FLAG>]

Tipos: feat | fix | docs | chore | refactor | test | ci
Scope: nombre del modulo o area
Flag obligatorio: [AUTO] si lo hizo el sistema | [HUMAN] si lo hizo Alvaro

Ejemplos:
feat(agentes): añadir health-agent spec [HUMAN]
docs(inbox): actualizar guia de procesado [AUTO]
chore(scripts): chmod +x nuevos scripts [AUTO]
```

---

## Reglas de ramas (en cualquier isla)

| Rama | Uso |
|------|-----|
| `main` | Produccion. Solo PR aprobado. |
| `agent/[nombre]` | Cambios propuestos por agentes. Siempre PR. |
| `copilot/[tarea]` | Cambios propuestos por Copilot. Siempre PR. |
| `docs/[tema]` | Solo documentacion. Puede mergear Alvaro directamente. |
| `fix/[issue]` | Correcciones rapidas. PR recomendado. |

---

## Checklist de isla nueva

- [ ] `README.md` con rol en el ecosistema
- [ ] `.isla-config.yml` rellenado
- [ ] `health-check.yml` copiado y adaptado
- [ ] `audit-on-push.yml` copiado y adaptado
- [ ] `code-drift.yml` copiado y adaptado
- [ ] Labels creadas con `labels-setup.sh`
- [ ] Entrada en `REGISTRO-ISLAS.md` de yggdrasil-dew
- [ ] Notificado al health-agent de la nueva isla

---

*Actualizado: 2026-07-03 [AUTO]*
