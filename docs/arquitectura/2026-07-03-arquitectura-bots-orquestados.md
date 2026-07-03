---
tipo: arquitectura-vision
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:28 CEST
actualizado: 2026-07-03 01:28 CEST
ruta: inbox/2026-07-03-arquitectura-bots-orquestados.md
tags: [thdora, bots, orquestacion, arquitectura, madre, ecosistema]
status: pendiente-procesar
destino: docs/arquitectura/bots-orquestados.md
---

# Arquitectura Bots Orquestados — Ecosistema Vivo en Madre

> Visión: todos los bots conscientes, comunicados y orquestados.
> Cada uno duerme cuando no se necesita, se levanta cuando toca,
> y conviven en perfecta armonía en el servidor Madre.

---

## El ecosistema completo de bots

```
┌─────────────────────────────────────────────────────┐
│                    MADRE (servidor)                  │
│                                                      │
│  ┌─────────────────┐     ┌──────────────────────┐   │
│  │  THDORA-DEW     │     │  THDORA-GUARDIAN     │   │
│  │  (bot personal) │     │  (bot vigilancia)    │   │
│  │                 │     │                      │   │
│  │  - Telegram     │     │  - Docker monitor    │   │
│  │  - Comandos     │◄───►│  - Disco/RAM/CPU     │   │
│  │  - Inbox proc.  │     │  - Servicios salud   │   │
│  │  - Repo acceso  │     │  - Alertas críticas  │   │
│  └────────┬────────┘     └──────────┬───────────┘   │
│           │                         │               │
│           └──────────┬──────────────┘               │
│                      │                              │
│           ┌──────────▼──────────┐                   │
│           │   ORQUESTADOR       │                   │
│           │   (message bus)     │                   │
│           │   Redis / SQLite    │                   │
│           └──────────┬──────────┘                   │
│                      │                              │
│        ┌─────────────┼─────────────┐                │
│        │             │             │                │
│  ┌─────▼───┐  ┌──────▼───┐  ┌─────▼──────┐        │
│  │ Ollama  │  │ GitHub   │  │ repo-audit │        │
│  │ (LLMs)  │  │ MCP      │  │ (checker)  │        │
│  └─────────┘  └──────────┘  └────────────┘        │
│                                                      │
└─────────────────────────────────────────────────────┘
```

---

## Principios del ecosistema vivo

### 1. Cada bot duerme cuando no se necesita
```yaml
# docker-compose: todos con restart: unless-stopped
# y con healthcheck para auto-recuperación
thdora-dew:
  restart: unless-stopped
  deploy:
    resources:
      limits:
        memory: 256M  # presupuesto de RAM fijo

thdora-guardian:
  restart: unless-stopped
  # solo activo en cron + triggers, no polling constante
```

### 2. Se comunican por bus de mensajes (no por polling)
- **Redis Pub/Sub** o **SQLite compartido** como bus interno
- THDORA-GUARDIAN publica evento → THDORA-DEW lo consume y notifica
- repo-audit publica resultado → THDORA-DEW crea issue en GitHub
- No hay llamadas directas entre bots — todo pasa por el bus

### 3. Logs centralizados en repo (docs/logs/)
- Cada bot escribe su log del día en `docs/logs/{bot}/YYYY-MM-DD.md`
- Commit automático al final del día
- Perplexity/Copilot puede leer el histórico para detectar patrones

### 4. Estado compartido en CONTEXT.md
- THDORA-DEW actualiza CONTEXT.md tras cada sesión importante
- THDORA-GUARDIAN actualiza ESTADO-SISTEMA.md cuando hay cambios
- Los LLMs leen estos ficheros para tener contexto siempre fresco

---

## Presupuesto de recursos en Madre

| Bot/Servicio | RAM | CPU | Disco | Prioridad |
|---|---|---|---|---|
| THDORA-DEW | 256MB | baja | 1GB | alta |
| THDORA-GUARDIAN | 128MB | muy baja | 500MB | alta |
| Ollama (modelos) | 4-8GB | alta (on-demand) | 20GB | media |
| repo-audit | 64MB | muy baja (cron) | mín | baja |
| Redis/bus | 64MB | muy baja | 500MB | alta |

> Madre tiene limitaciones reales de RAM. Los bots deben ser ligeros.
> Ollama solo se activa cuando hay petición, no en modo servidor permanente.

---

## Fases de implementación

| Fase | Qué | Cuándo |
|---|---|---|
| **Fase 5** | THDORA-GUARDIAN básico + repo-audit | Próxima semana |
| **Fase 6** | THDORA-DEW en Madre + MCP local Acer | Semana 2 |
| **Fase 7** | Bus de mensajes + comunicación entre bots | Semana 3-4 |
| **Fase 8** | Logs automáticos en repo + análisis LLM | Mes 2 |
| **Fase 9** | Skill análisis repos externos | Mes 2-3 |

---

## Lo que faltaba en la auditoría (añadido ahora)

La auditoría de esta noche NO incluyó:
- [ ] Contenedores Docker documentados en repo (quién, qué, estado)
- [ ] Bots documentados como entidades del ecosistema
- [ ] Relación entre repos (yggdrasil-dew ↔ thdora repo ↔ thdora-guardian repo)

Esto va en `docs/ecosistema/contenedores.md` y `docs/agentes/README.md`.
