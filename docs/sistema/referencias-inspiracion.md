# Referencias e inspiración — Repos y ecosistemas

> Repos reales investigados para mejorar el ecosistema.
> Actualizado: 24 jun 2026

---

## Repos cerebro / second brain

| Repo | Stars | Por qué vale la pena |
|---|---|---|
| [eugeniughelbur/obsidian-second-brain](https://github.com/eugeniughelbur/obsidian-second-brain) | ★★★ | Cross-CLI skill: vault como IA-first second brain para Claude, Codex, Gemini |
| [breferrari/obsidian-mind](https://github.com/breferrari/obsidian-mind) | ★★ | Memoria persistente para agentes IA, hooks para Claude Code |
| [xlxs4/second-brain](https://github.com/xlxs4/second-brain) | ★★ | Estructura PARA limpia, todo en markdown |
| [Reddit: Agentic Second Brain](https://reddit.com/r/ObsidianMD/comments/1r0oszl) | 120★ | Sistema que se auto-organiza: dump → IA organiza → markdown |

### Ideas clave de estos repos
- `AGENT.md` en raíz = instrucciones para que cualquier IA entienda el vault ✔️ (ya lo tienes)
- Hooks que disparan scripts cuando cambias ficheros → THDORA puede hacer esto en Fase 5
- Inbox auto-procesado por IA cada noche → exactamente el plan con n8n

---

## Repos homelab con Ollama

| Repo | Por qué vale la pena |
|---|---|
| [n8n-io/self-hosted-ai-starter-kit](https://github.com/n8n-io/self-hosted-ai-starter-kit) | Template oficial n8n: Ollama + Qdrant + n8n en un compose — muy parecido a tu Fase 3 |
| [Lucioschenkel/homelab](https://github.com/Lucioschenkel/homelab) | Estructura monorepo homelab limpia, un compose por servicio |
| [ngrok: n8n+Ollama+Docker](https://ngrok.com/blog/self-hosted-local-ai-workflows-with-docker-n8n-ollama-and-ngrok-2025) | Workflows IA self-hosted completos con n8n |

### Ideas clave
- n8n starter kit usa exactamente tu stack → revisar su compose para ideas de Fase 4
- Su estructura: un `docker-compose.yml` por entorno (dev/prod) → considerar para Fase 4
- Watchtower para auto-update de imágenes → ya está en tu Fase 4

---

## Obsidian + Vault 7 carpetas óptimas

Según [MindStudio research (mayo 2026)](https://www.mindstudio.ai/blog/ai-second-brain-obsidian-vault-folder-architecture):

| Carpeta | Propósito | Equivalente en tu sistema |
|---|---|---|
| `00_inbox` | Todo entra aquí | `inbox/` ✔️ |
| `01_projects` | Proyectos activos | `proyectos/` ✔️ |
| `02_areas` | Áreas de responsabilidad continua | `yo/`, `formacion/` ✔️ |
| `03_resources` | Conocimiento de referencia | `docs/`, `agentes/`, `ollama/` ✔️ |
| `04_archive` | Todo lo terminado | `diarios/` ✔️ |
| `05_templates` | Plantillas | `templates/` ✔️ |
| `06_daily` | Notas diarias | `personal/01_diarios/` ✔️ |

**Conclusión: tu estructura actual ya cubre las 7 carpetas óptimas.**

---

## Skills a añadir al ecosistema (investigados)

### IA y agentes
- [ ] **LangGraph** — agentes con estado, más potente que LangChain para flujos complejos
- [ ] **CrewAI** — múltiples agentes colaborando, ideal para THDORA v2
- [ ] **Dify** — plataforma visual de agentes, el n8n de la IA
- [ ] **AnythingLLM** — evaluar como reemplazo stack actual en Fase 5

### Infraestructura
- [ ] **Terraform** — infraestructura como código, cuando escale más allá de Madre
- [ ] **Ansible** — automatizar setup de nuevas máquinas (instalar Arch + stack en < 10 min)
- [ ] **Flux/ArgoCD** — GitOps para Docker, cuando tengas más de 2 servidores

### Seguridad
- [ ] **Trivy** — scan de vulnerabilidades en imágenes Docker
- [ ] **Gitleaks** — detectar secretos en commits antes de push
- [ ] **Semgrep** — SAST para el código Python de THDORA

### Python / Dev
- [ ] **FastAPI async patterns** — para escalar THDORA
- [ ] **Pydantic v2** — validación de datos en agentes
- [ ] **Pytest + coverage** — tests para THDORA antes de Fase 5

---
_Ver: [alternativas-llm.md](alternativas-llm.md) · [ROADMAP.md](../../ROADMAP.md)_
