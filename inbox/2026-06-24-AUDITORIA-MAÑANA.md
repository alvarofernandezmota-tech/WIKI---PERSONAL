# AUDITORÍA MAÑANA — Plan Completo

**Fecha:** 2026-06-24  
**Prioridad:** ALTA — hacer esto lo primero al despertar

---

## ORDEN DE EJECUCIÓN

### 1. Verificar que la descarga nocturna acabó
```bash
docker exec ollama ollama list
docker images | grep -E 'ollama|webui|qdrant|n8n|gitea|portainer'
```

### 2. Auditoría inbox ygg (70+ archivos)
- Clasificar por categoría: sesiones, fases, proyectos, scripts, ADRs
- Migrar fases Docker → `docker/`
- Migrar ADRs → `docs/adr/`
- Migrar fichas proyectos → repos respectivas
- Consolidar sesiones del 23 en un solo diario
- Lo que no tiene destino claro → queda en inbox con tag `#revisar`

### 3. Auditoría repo `personal`
- ¿Qué estructura tiene ahora?
- ¿Qué se queda, qué se elimina, qué se mueve?
- Decidir qué es personal vs qué es ecosistema

### 4. Limpiar root de `thdora`
- Borrar archivos basura: `=`, `[bot`, `[thdora]`, `CACHED` y similares
- Verificar estructura base está completa

### 5. Crear repos que faltan
- [ ] `local-brain` — cerebro cognitivo
- [ ] `osint-stack` — stack OSINT

### 6. Crear docs maestros
- [ ] `yggdrasil-dew/docs/ECOSISTEMA.md`
- [ ] `yggdrasil-dew/scripts/ecosistema-status.sh`

---

## REGLAS DEL ECOSISTEMA (para cada repo)

Cada repo DEBE tener:
- `README.md` — qué es, para qué sirve, cómo funciona
- `inbox/` — entradas sin procesar
- `docs/` — documentación estructurada
- `docs/adr/` — decisiones de arquitectura
- `docker/` — si tiene servicios
- `scripts/` — scripts de utilidad

Cada repo DEBE documentar:
- Su propósito en una línea
- Qué consume y qué expone
- Cómo arrancarlo desde cero
- Sus dependencias con otras repos
