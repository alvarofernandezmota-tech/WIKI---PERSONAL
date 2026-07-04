# Cierre de Sesión — 2026-06-24

**Hora:** ~02:00 - 04:48 CEST  
**Estado:** ✅ Documentado para auditoría mañana

---

## Contexto importante para la auditoría

Esta sesión se hizo sin leer `CONVENCIONES.md` ni `ECOSISTEMA.md` antes de actuar.  
Algunos ficheros creados **duplican o contradicen** lo que ya existía.  
**Regla nueva a añadir a CONVENCIONES.md:** revisar siempre antes de hacer nada.

---

## Qué se hizo bien

- ✅ Repos `local-brain` y `osint-stack` creadas con estructura base correcta
- ✅ Inbox + plan de migración en cada repo nueva
- ✅ Script de descarga Ollama con reintentos lanzado en segunda terminal
- ✅ Decisión arquitectura multi-repo confirmada (Regla 13 ya existía en CONVENCIONES)
- ✅ Nombre `huginn` elegido para repo `personal`

---

## Qué hay que limpiar mañana (OBLIGATORIO antes de cualquier otra cosa)

### Ficheros duplicados a eliminar
- [ ] `docs/REGLAS-ECOSISTEMA.md` ← duplica `CONVENCIONES.md` (raiz)
- [ ] `docs/FLUJO-INBOX.md` ← duplica Regla 1 y Regla 2 de `CONVENCIONES.md`

### Ficheros a corregir
- [ ] `thdora/docs/REGLAS.md` → cambiar enlace a `CONVENCIONES.md` (no a REGLAS-ECOSISTEMA)
- [ ] `local-brain/docs/REGLAS.md` → idem
- [ ] `osint-stack/docs/REGLAS.md` → idem

### Añadir a CONVENCIONES.md
- [ ] **Regla 15** — Revisar ecosistema antes de actuar: leer `CONVENCIONES.md` + `ECOSISTEMA.md` + `ESTADO-SISTEMA.md` antes de crear, mover o decidir nada. Nunca duplicar lo que ya existe.
- [ ] **Regla 16** — Migración entre repos: crear en destino → eliminar en origen → commit en ambos con tipo `migrate:`

### Actualizar ECOSISTEMA.md
- [ ] Añadir `local-brain` a la tabla de repos (sección 3)
- [ ] Añadir `osint-stack` a la tabla de repos (sección 3)
- [ ] Actualizar `personal` → `huginn` cuando esté renombrado
- [ ] Actualizar fecha (sigue en 20 junio 2026)

---

## Decisiones pendientes (no urgentes)

- [ ] ¿Flowise va en `local-brain` o `thdora`?
- [ ] ¿n8n tiene repo propia o va en `thdora`?
- [ ] Renombrar `personal` → `huginn` — manual en GitHub Settings

---

## Modelos Ollama descargando ahora en Madre

Script con reintentos lanzado. Al despertar verificar:

```bash
# Ver qué se está descargando ahora mismo
ps aux | grep ollama

# Ver modelos ya descargados
ollama list

# Ver tamaño ocupado
du -sh ~/.ollama/models/

# Si el script murió, relanzar:
~/run-descarga-ollama.sh
```

Modelos en cola:
| Modelo | Tamaño | Estado |
|--------|--------|--------|
| qwen2.5:3b | ~2GB | ⏳ |
| qwen2.5:7b | ~5GB | ⏳ |
| qwen2.5:14b | ~9GB | ⏳ |
| qwen2.5:32b | ~20GB | ⏳ |
| bge-m3 | ~600MB | ⏳ |
| nomic-embed-text | ~300MB | ⏳ |
| llama3.1:8b | ~5GB | ⏳ |
| mistral:7b | ~4GB | ⏳ |
| codestral:latest | ~12GB | ⏳ |

---

## Orden de trabajo mañana

1. **Leer** `CONVENCIONES.md` + `ECOSISTEMA.md` + `ESTADO-SISTEMA.md`
2. **Limpiar** duplicados (ver sección arriba)
3. **Añadir** Regla 15 y 16 a `CONVENCIONES.md`
4. **Actualizar** `ECOSISTEMA.md` con repos nuevas
5. **Verificar** modelos con `ollama list`
6. **Renombrar** `personal` → `huginn` en GitHub Settings
7. Seguir con migración de inbox de ygg → repos correspondientes
