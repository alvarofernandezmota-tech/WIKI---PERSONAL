# Planificación Diaria — Dónde va cada cosa

**Fecha:** 2026-06-24  
**Estado:** 🔧 Referencia permanente — actualizar según evolucione el ecosistema

---

## ¿Dónde va la planificación y el trabajo diario?

### `huginn` (personal) — Tu espacio personal
Todo lo que es TUYO como persona, no como dev:
- Diario diario (reflexiones, qué hiciste, cómo fue el día)
- Ideas personales, proyectos creativos
- Lecturas, aprendizajes personales
- Objetivos vitales
- **La planificación personal del día** — qué quieres hacer, prioridades de vida

### `yggdrasil-dew` — Tu espacio de trabajo técnico
Todo lo que es del ecosistema técnico:
- **Planificación técnica** — qué hay que construir, en qué repo, cuándo
- Estado del servidor
- Decisiones de arquitectura (ADR)
- Auditorías del ecosistema
- **El inbox global** — si no sabes dónde va, aquí

### Cada repo específica — Su propio trabajo
- `thdora/inbox/` — ideas de bots, agentes, flows n8n
- `local-brain/inbox/` — ideas de modelos, RAG, prompts
- `osint-stack/inbox/` — investigaciones, herramientas, targets

---

## Flujo del día a día

```
Mañana:
  1. Revisar huginn — ¿qué quiero hacer hoy? (personal)
  2. Revisar ygg/inbox — ¿qué quedó pendiente? (técnico)
  3. Trabajar en la repo que toca

Durante el día:
  - Cualquier idea → inbox de la repo que corresponda
  - Si no sabes → ygg/inbox/

Noche / fin de jornada:
  - Commit de lo que hiciste
  - Apuntar en huginn cómo fue
  - Si quedó algo → inbox con fecha de hoy
```

---

## Trabajo planificado próximos días

### Hoy (descanso — descarga corriendo)
- [x] Crear local-brain
- [x] Crear osint-stack
- [x] Documentar reglas del ecosistema
- [x] Documentar sesión
- [ ] Descarga modelos Ollama (corriendo en background ~45min)

### Mañana — Auditoría + Migración
- [ ] Renombrar `personal` → `huginn`
- [ ] Añadir REGLAS.md en thdora, local-brain, osint-stack
- [ ] Migrar docs OSINT de ygg → osint-stack
- [ ] Migrar docs Ollama/RAG de ygg → local-brain
- [ ] Decidir Flowise y n8n
- [ ] Verificar modelos descargados con `ollama list`
- [ ] Primer docker-compose de local-brain

### Esta semana
- [ ] local-brain: docker-compose Ollama + pgvector funcionando
- [ ] local-brain: pipeline RAG básico
- [ ] thdora: limpiar estructura root
- [ ] osint-stack: docker-compose Spiderfoot
- [ ] huginn: estructura personal definida
