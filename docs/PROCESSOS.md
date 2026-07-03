# PROCESSOS: plantilla por trabajador

Cada agente del ecosistema debe tener su entrada aquí, siguiendo esta plantilla.

---

## Plantilla

### Nombre del proceso
- **Agente**: nombre
- **Rol**: auditor | mejorador | vigilante | fixer | fabrica | orquestador
- **Owner**: nombre del responsable

### Propósito
Descripción breve del objetivo del agente.

### Entradas
- Rutas: inbox/, diary/, scripts/, docs/

### Salidas
- Archivos JSON en inbox/
- Reportes en diary/
- Branches agent-fix/* y PRs

### Flags soportados
- `--dry-run`
- `--verbose`
- `--out DIR`
- `--apply` (si aplica)

### Pasos
1. Observación: cómo detecta eventos.
2. Validación: checks y pruebas.
3. Acción: commits, PRs, correcciones.
4. Reporte: formato JSON y ubicación.

### Tests
```bash
bash tests/run-agent-tests.sh
```

### Notas de seguridad
- No incluir secrets en reportes.
- Usar tokens con permisos mínimos.
- Revisar OWNERS antes de ejecutar con --apply.

---

## Agentes registrados

| Agente | Rol | Owner | Estado |
|---|---|---|---|
| agente-mejorador | mejorador | alvaro | ✅ activo |
| agente-fixer | fixer | alvaro | ✅ activo |
| agente-vigilante | vigilante | alvaro | ✅ activo |
| galatea-fabrica-agentes | fabrica | alvaro | ✅ activo |
| agente-filtro-info | filtro | alvaro | ⚠️ pendiente |
| agente-investigador | investigador | alvaro | ⚠️ bloqueado (MCP) |
| agente-sync-reglas | sync | alvaro | ⚠️ pendiente |
| agente-self-heal | self-heal | alvaro | ⚠️ pendiente |
| agente-roadmap-master | roadmap | alvaro | ⚠️ pendiente |
| orquestador-inbox | orquestador | alvaro | ✅ activo |

---

## Flujo colmena

```
Vigilante (cada 6h)
  └─ si staleness → diary/sla-*.json + issue GitHub

Auditor (semanal)
  └─ inbox/meta-deep/*.json

Mejorador (tras auditoría o manual)
  └─ branch agent-fix/* + inbox/mejorador/*.json

Fixer (revisión manual → --apply)
  └─ commit en branch + PR via gh

Fábrica
  └─ genera agentes nuevos con plantilla unificada

Orquestador
  └─ coordina todo → artefactos en inbox/ y diary/
```
