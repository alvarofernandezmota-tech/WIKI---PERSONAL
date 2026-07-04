---
fecha: 2026-06-24
hora-inicio: 22:00
hora-fin: 22:30
desde: movil
diario: "[[diarios/2026-06-24]]"
destino: diarios/
tags: [inbox, sesion, alineacion, repos, docker, obsidian, pendientes]
---

# Sesión noche móvil — 24 jun 2026 22:00-22:30

> Sesión completa desde el móvil. Sin terminal.
> Todo lo hecho esta noche documentado aquí para integrar en el diario del día.

---

## ✅ Lo que se hizo esta sesión

### Commits realizados
| Archivo | Qué se hizo | Commit |
|---|---|---|
| `inbox/MASTER-PENDIENTES.md` | Añadida sección AHORA MISMO desde móvil | c4606f7 |
| `ECOSISTEMA.md` | Reescrito con repos reales + Docker por fases | 96ea192 |
| `ESTADO-SISTEMA.md` | Reescrito con estado real máquinas + inbox | 96ea192 |
| `CONTEXT.md` | Corregidas 7 discordancias + reglas alineación | 4a16614 |
| `diarios/2026-06-24.md` | Bloque 4 noche añadido | 4a16614 |
| `inbox/2026-06-24-PROMPT-GEMINI-DEEP-RESEARCH-ALINEACION.md` | Prompt Deep Research creado | 39eaad3 |

### Decisiones tomadas
1. **CONTEXT.md es el archivo crítico** — agentes lo leen para entender el sistema
2. **Regla nueva**: actualizar CONTEXT + ECOSISTEMA + diario en el mismo commit al cerrar sesión
3. **Simplificar archivos maestros** — de 5 a 2 (CONTEXT + MASTER-PENDIENTES) a medio plazo
4. **Dataview** — reemplazar archivos estáticos con vistas dinámicas en Obsidian
5. **thdora `/cierre`** — handler futuro que automatiza el sync al cerrar sesión
6. **Gemini Deep Research** — lanzar investigación sobre alineación inbox-repo-Obsidian

### Discordancias corregidas en CONTEXT.md
- UFW: decía activo → correcto: pendiente
- inbox: decía vaciada → correcto: ~100 archivos pendientes
- osint-stack: decía pendiente crear → correcto: ya existe desde 02:35
- local-brain: no aparecía → añadido
- Ollama: decía fallido → correcto: 3 modelos listos

---

## 📌 Cosas pendientes detectadas esta sesión

### Repos a crear
- [ ] `ollama-stack` → repo GitHub privado
- [ ] `chatbot-control` → repo GitHub privado
- [ ] `terminal-ia` → repo GitHub privado

### Repos a documentar (existen pero README vacío/mínimo)
- [ ] `local-brain` → añadir README con mapa Docker: Ollama, Open WebUI, LiteLLM, Qdrant
- [ ] `osint-stack` → añadir README con mapa Docker: SpiderFoot, SearXNG, Perplexica

### Obsidian — instalar cuando varopc tenga sync
- [ ] Plugin **Obsidian Git** → auto-commit + push cada X min
- [ ] Plugin **Dataview** → vistas dinámicas inbox, estado, pendientes
- [ ] Plugin **Templater** → plantillas para diarios, ADR, fichas proyecto
- [ ] Plugin **Calendar** → navegación por diarios
- [ ] Plugin **MetaEdit** → editar frontmatter fácil
- [ ] Configurar vault apuntando a `~/yggdrasil-dew`

### Automatización — implementar con Gemini Deep Research como base
- [ ] Frontmatter estándar en cada archivo inbox (fecha, diario, destino, tags)
- [ ] Query Dataview en `inbox/README.md` mostrando pendientes de migrar
- [ ] Workflow n8n o script para sync automático
- [ ] thdora handler `/cierre` → actualiza CONTEXT + diario + git push

---

## 🖥️ Al llegar al PC — orden exacto

```bash
# 1. Sync repo
cd ~/yggdrasil-dew && git pull

# 2. Migrar inbox
bash migrate-inbox.sh

# 3. Verificar Madre
ssh madre "ollama list && docker images | wc -l"

# 4. Levantar fases
ssh madre "docker compose -f setup/servidor/docker-compose.yml up -d"

# 5. Crear repos que faltan
# (hacer desde Perplexity MCP o GitHub CLI)

# 6. Documentar local-brain y osint-stack README
# (hacer desde Perplexity MCP)

# 7. Instalar plugins Obsidian
# (resultado Gemini Deep Research primero)
```

---

## 📦 Rutas destino de archivos pendientes en inbox

| Archivo inbox | Destino final |
|---|---|
| `2026-06-24-PROMPT-GEMINI-DEEP-RESEARCH-ALINEACION.md` | `agentes/prompts/` |
| `2026-06-24-SESION-NOCHE-MOVIL.md` (este) | `diarios/` (integrar en 2026-06-24.md) |
| `2026-06-24-fase1-revisada-con-litellm.md` | `docs/arquitectura/` |
| `2026-06-24-fase3-completa.md` | `docs/arquitectura/` |
| `2026-06-24-fase4-litellm-sops-plan.md` | `docs/arquitectura/` |
| `2026-06-24-script-thdora-handlers.md` | `proyectos/thdora/` |
| `2026-06-24-PENDIENTES-THDORA-COMANDOS-Y-DOCKER.md` | `proyectos/thdora/` |
| `2026-06-25-ADB-ANDROID-GUIA-COMPLETA.md` | `setup/movil/` |
| `2026-06-25-OPENSOURCE-CONTROL-MOVIL.md` | `setup/movil/` |
| `2026-06-25-AUDITAR-HOTSPOT-RED.md` | `setup/red/` |

---
_Creado: 24 jun 2026 22:30 CEST — Perplexity vía MCP_
_Ver: [[diarios/2026-06-24]] · [[CONTEXT]] · [[inbox/MASTER-PENDIENTES]]_
