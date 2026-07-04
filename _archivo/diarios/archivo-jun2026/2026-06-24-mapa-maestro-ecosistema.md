# Mapa Maestro del Ecosistema

**Fecha:** 2026-06-24 04:29 CEST  
**Estado:** Borrador — pendiente auditoría completa mañana

---

## Visión general

El ecosistema está compuesto por repos independientes, cada una con una responsabilidad única, documentada y estructurada de la misma manera. `yggdrasil-dew` es el orquestador — el nodo que referencia a todos los demás.

---

## Mapa de repos

```
┌─────────────────────────────────────────────────────┐
│                  yggdrasil-dew                      │
│         Orquestador / Infra / Homelab               │
│  servidor · docker · fases · networking · hardening │
└──────────────────┬──────────────────────────────────┘
                   │ orquesta
       ┌───────────┼───────────────┐
       ▼           ▼               ▼
 ┌──────────┐ ┌─────────┐  ┌────────────┐
 │local-brain│ │ thdora  │  │osint-stack │
 │  Cerebro  │ │  Bots   │  │   OSINT    │
 └──────────┘ └────┬────┘  └────────────┘
      ▲            │ consume
      └────────────┘
```

---

## Repos del ecosistema

### `yggdrasil-dew` — Orquestador
- **Qué es:** El cerebro de infraestructura. Gestiona el servidor, docker, fases de despliegue, red, seguridad.
- **Qué NO es:** No contiene modelos, no contiene bots, no contiene lógica de agentes.
- **Estado:** ✅ Activa
- **Docs destino:** `docs/ECOSISTEMA.md` (este archivo, migrado)

### `local-brain` — El Cerebro Cognitivo
- **Qué es:** Ollama, modelos locales, pgvector, RAG, embeddings, memoria vectorial.
- **Qué NO es:** No gestiona infraestructura, no contiene bots.
- **Consumen:** thdora, osint-stack, cualquier agente del ecosistema.
- **Estado:** 🔧 Pendiente crear repo
- **Modelos previstos:** qwen2.5:3b, qwen2.5:7b, bge-m3, llama3.1

### `thdora` — Fábrica de Bots y Agentes
- **Qué es:** Bots de chat (Telegram, web), agentes de terminal, handlers, lógica de agentes.
- **Qué NO es:** No gestiona servidor, no aloja modelos.
- **Consume:** `local-brain` para razonamiento y memoria.
- **Estado:** ✅ Activa — pendiente limpiar root y estructurar

### `osint-stack` — Stack OSINT
- **Qué es:** Spiderfoot, Maltego, tools OSINT, pipelines de investigación.
- **Qué NO es:** No gestiona infra general.
- **Consume:** `local-brain` para enriquecer investigaciones.
- **Estado:** 🔧 Pendiente crear repo

### `personal` — Repositorio Personal
- **Qué es:** Diarios, reflexiones, vida, planificación personal.
- **Estado:** ✅ Activa

---

## Estructura base de cada repo (estándar)

Todas las repos del ecosistema siguen la misma estructura:

```
repo/
├── inbox/          ← entradas sin procesar, ideas, notas rápidas
├── docs/           ← documentación estructurada
│   └── adr/        ← decisiones de arquitectura
├── src/            ← código fuente
├── docker/         ← docker-compose y configs
├── scripts/        ← scripts de utilidad
└── README.md       ← qué es esta repo y cómo funciona
```

---

## Script maestro de status (pendiente implementar)

```bash
# scripts/ecosistema-status.sh
# Hace ping a todos los servicios y dice qué está vivo

servicios=(
  "ollama:11434"
  "open-webui:3000"
  "n8n:5678"
  "litellm:4000"
  "vaultwarden:8888"
  "pgvector:5432"
  "nginx-proxy:80"
)
```

Destino: `yggdrasil-dew/scripts/ecosistema-status.sh`

---

## Destino final de este documento

Este inbox se migrará a: `yggdrasil-dew/docs/ECOSISTEMA.md`  
Con el diagrama completo, links a cada repo y estado actualizado.

---

## TODOs pendientes (auditoría mañana)

- [ ] Crear repo `local-brain` con estructura base
- [ ] Crear repo `osint-stack` con estructura base  
- [ ] Limpiar root de `thdora` (archivos basura: `=`, `[bot`, `[thdora]`, `CACHED`)
- [ ] Migrar fichas de proyectos de inbox ygg a sus repos
- [ ] Migrar fases Docker de inbox a `docker/`
- [ ] Crear `docs/ECOSISTEMA.md` en ygg con este mapa
- [ ] Implementar `scripts/ecosistema-status.sh`
- [ ] Auditoría repo `personal` — qué queda, qué se elimina
