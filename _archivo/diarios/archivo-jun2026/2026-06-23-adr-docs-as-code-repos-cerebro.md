---
tags: [adr, arquitectura, docs-as-code, github, obsidian, ingenieria-software]
fecha: 2026-06-23
estado: decision-tomada
tipo: adr
prioridad: alta
ruta-obsidian: inbox/2026-06-23-adr-docs-as-code-repos-cerebro.md
---

# ADR — Docs-as-code: cómo enlazar repos técnicas con el cerebro

> Architecture Decision Record · Sesión 2026-06-23
> 🔥 Decisión importante — afecta a todas las repos del ecosistema

## El problema

Tenemos repos técnicas en GitHub (thdora, ai-toolkit, ollama-stack...) y el cerebro yggdrasil-dew. ¿Cómo evitamos duplicar documentación y que todo esté enlazado?

## La solución — Separation of Concerns documental

### Cada repo técnica en GitHub contiene:
- `README.md` — cómo instalar, requisitos, uso rápido
- `docker-compose.yml` — el código de despliegue
- `docs/` — documentación técnica interna del repo
- `CHANGELOG.md` — historial de cambios

### El cerebro yggdrasil-dew contiene:
- `proyectos/NOMBRE/` — estado, decisiones, enlace a repo, pendientes
- `ollama/`, `agentes/`, `osint/` — conocimiento transversal
- `setup/servidor/` — estado del homelab, qué corre dónde
- `inbox/` — entrada de todo lo nuevo antes de clasificar

### Regla de oro
> El cerebro documenta el **conocimiento y decisiones**.
> La repo técnica documenta el **código y despliegue**.
> **Nunca duplicar — siempre enlazar.**

## Patrón por tipo de proyecto

### Proyectos que acaban en Docker
```
GitHub repo propia:
  thdora/              ← código Python + docker-compose
  ollama-stack/        ← docker-compose Ollama+WebUI+Qdrant
  osint-stack/         ← docker-compose SpiderFoot+IVRE+Kismet
  local-brain/         ← código + docker-compose
  chatbot-control/     ← código + docker-compose

yggdrasil-dew:
  proyectos/thdora/    ← estado, decisiones, link a repo
  proyectos/ollama/    ← estado, decisiones, link a repo
  proyectos/osint/     ← estado, decisiones, link a repo
  ollama/              ← conocimiento modelos, RAG, cuándo usar
  osint/               ← conocimiento herramientas OSINT
  agentes/             ← conocimiento IAs externas
```

### El flujo inbox
```
Idea/conocimiento nuevo
  ↓
inbox/ (fecha-tema.md)    ← TODO entra aquí primero
  ↓
Procesar → mover a su lugar definitivo
  ↓
├─ proyectos/NOMBRE/     si es decisión de proyecto
├─ ollama/               si es conocimiento de modelos
├─ agentes/              si es conocimiento de IAs
├─ setup/servidor/       si es infra/homelab
└─ diarios/2026/MM/      si es registro del día
```

## Repos a crear (pendiente)

- [ ] `alvarofernandezmota-tech/ollama-stack` — docker-compose Ollama+WebUI+Qdrant
- [ ] `alvarofernandezmota-tech/osint-stack` — docker-compose OSINT suite
- [ ] `alvarofernandezmota-tech/local-brain` — cerebro IA local
- [ ] `alvarofernandezmota-tech/chatbot-control` — chatbot control personal
- [ ] `alvarofernandezmota-tech/terminal-ia` — terminal con IA

## Investigar

- [ ] **Obsidian Git** — sincronizar yggdrasil-dew con Obsidian automáticamente
- [ ] **GitHub submodules** — ¿tiene sentido referenciar repos desde yggdrasil-dew?
- [ ] **Obsidian Dataview** — queries automáticas sobre el estado de proyectos
- [ ] Patrón **monorepo vs multirepo** para el ecosistema completo

## Referencias
- [[ECOSISTEMA]] — visión global
- [[inbox/2026-06-23-decision-homelab-vs-proyectos]] — ADR anterior
- [[proyectos/README]] — listado proyectos
