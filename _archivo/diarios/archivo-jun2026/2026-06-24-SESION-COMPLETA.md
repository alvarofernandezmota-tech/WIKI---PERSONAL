# Resumen Sesión — 2026-06-24

**Hora:** 04:00 - 04:45 CEST  
**Estado:** ✅ Documentada

---

## Qué se hizo esta sesión

### Repos creadas
- ✅ `local-brain` — cerebro cognitivo, modelos Ollama, RAG, pgvector
- ✅ `osint-stack` — stack OSINT, Spiderfoot, pipelines
- Ambas con estructura base completa + inbox documentado + plan de migración

### Documentación creada en ygg
- ✅ `docs/REGLAS-ECOSISTEMA.md` — 10 reglas que aplican a todas las repos
- ✅ `docs/FLUJO-INBOX.md` — cómo fluye la información por el ecosistema

### Decisiones tomadas
- El inbox de ygg es el **inbox global** — si no sabes dónde va algo, aquí primero
- Cada repo tiene su propio inbox para cosas que ya sabes dónde van
- La migración entre repos sigue el protocolo: crear en destino → eliminar en origen → commit en ambos
- `batcueva` NO es una repo separada — ES yggdrasil-dew, el servidor físico
- `personal` se renombra a `huginn` — manual desde GitHub Settings

### Lo que se queda en ygg (nunca migra)
- Docker compose maestro + fases
- Configuración servidor Arch, SSH, sysctl
- Nginx Proxy Manager, Vaultwarden, Watchtower
- Scripts de arranque y status del ecosistema
- Redes Docker globales
- Portainer, Uptime Kuma, Gitea, code-server

---

## Decisiones pendientes (auditoría mañana)

- [ ] ¿Flowise va en `local-brain` o `thdora`?
- [ ] ¿n8n tiene repo propia o va en `thdora`?
- [ ] Renombrar `personal` → `huginn` (manual GitHub Settings)
- [ ] Añadir `docs/REGLAS.md` en thdora, local-brain, osint-stack apuntando al maestro
- [ ] Migrar inbox de ygg relacionados con modelos → `local-brain/inbox/`
- [ ] Migrar inbox de ygg relacionados con OSINT → `osint-stack/inbox/`

---

## Estado descarga modelos Ollama

Script lanzado en segunda terminal con reintentos. Ver `local-brain/inbox/2026-06-24-SCRIPT-DESCARGA.md`.

Modelos en cola:
- qwen2.5:3b (~2GB)
- qwen2.5:7b (~5GB)
- bge-m3 (~600MB)
- nomic-embed-text (~300MB)
- qwen2.5:14b (~9GB) — si hay espacio

---

## Ecosistema completo a fecha 2026-06-24

| Repo | Estado | Responsabilidad |
|------|--------|------------------|
| `yggdrasil-dew` | ✅ Activa + documentada | Infra, servidor, Docker maestro |
| `thdora` | ✅ Activa, pendiente limpiar | Bots, agentes, n8n |
| `local-brain` | ✅ Creada hoy | Ollama, RAG, pgvector |
| `osint-stack` | ✅ Creada hoy | OSINT, Spiderfoot |
| `huginn` (personal) | ⚠️ Renombrar manual | Diario, notas personales |
