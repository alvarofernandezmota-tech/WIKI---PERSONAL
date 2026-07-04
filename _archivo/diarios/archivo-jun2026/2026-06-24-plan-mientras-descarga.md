# Plan mientras acaba la descarga

**Fecha:** 2026-06-24 04:29 CEST  
**Contexto:** Postgres descargando. Queremos dejarlo todo listo antes de dormir.

---

## Fase actual — Esperando descarga

### Lo que podemos hacer AHORA (sin tocar la máquina)

- [x] Documentar mapa maestro del ecosistema → `inbox/2026-06-24-mapa-maestro-ecosistema.md`
- [ ] Crear repo `local-brain` con estructura base completa
- [ ] Crear repo `osint-stack` con estructura base completa
- [ ] Limpiar root de `thdora`
- [ ] Crear `docs/ECOSISTEMA.md` en ygg
- [ ] Crear `scripts/ecosistema-status.sh` borrador

---

## Cuando acabe la descarga — Configuración rápida

1. `docker compose up -d` — levantar Fase 1
2. Verificar que responden:
   - Ollama: `http://localhost:11434`
   - Open WebUI: `http://localhost:3000`
   - n8n: `http://localhost:5678`
   - LiteLLM: `http://localhost:4000`
3. Ajustar lo que falle
4. Lanzar descarga nocturna de modelos grandes

---

## Descarga nocturna (antes de dormir)

Modelos pesados para descargar mientras dormimos:

```bash
# Modelos Ollama grandes
ollama pull qwen2.5:14b
ollama pull llama3.1:8b
ollama pull nomic-embed-text

# O via docker exec si ollama corre en contenedor
docker exec ollama ollama pull qwen2.5:14b
```

La máquina trabaja sola. Mañana nos levantamos con todo listo.

---

## Mañana — Auditoría completa

1. Auditoría inbox ygg — clasificar 70+ archivos
2. Auditoría repo `personal` — qué queda, qué se elimina
3. Auditoría root `thdora` — limpiar basura
4. Decidir estructura definitiva de `local-brain`
5. Crear repos independientes que faltan
6. Migrar contenido de inbox a donde corresponde
