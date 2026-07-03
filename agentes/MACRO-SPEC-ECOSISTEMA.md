---
tipo: spec-maestra
version: 1.0
fecha: 2026-07-03
tags: [agentes, filosofia, roadmap, bots, mcp, rag, autonomia]
---

# Macro-Spec: Ecosistema Autónomo Yggdrasil

> Este documento es el **contrato del ecosistema**: cómo debe pensar, actuar, documentar y evolucionar mientras duermes.

---

## 1. Hardware

| Nodo | CPU | RAM | GPU | OS |
|------|-----|-----|-----|----|
| Madre (varpc) | i5-8400 | 16GB | GTX 1060 6GB | Linux |
| Theodora | Ryzen 5 | - | - | Arch + Hyprland |
| Móviles | - | - | - | vía Tailscale |

---

## 2. Servicios activos en Madre (Docker)

- Ollama (`qwen2.5-coder:7b`, `llama3.1:8b`, `bge-m3`)
- Qdrant (RAG)
- Open WebUI
- n8n
- Gitea
- Grafana + Prometheus
- `thdora` (FastAPI + Telegram)
- Spiderfoot
- Portainer, code-server, uptime-kuma

---

## 3. Repos clave

| Repo | Rol |
|------|-----|
| `yggdrasil-dew` | Second brain, ROADMAP, AGENTES, 23 Actions |
| `yggdrasil-secops` | Salud, seguridad, watchdogs |
| `local-brain` | RAG + embeddings |
| `osint-stack` | OSINT |
| `thdora-personal` | Interfaz humana (Telegram + FastAPI) |
| `ai-toolkit` | Stack IA open source |

---

## 4. Filosofía y ética

### 4.1 Principios

- **Autonomía con límites:** Agentes solo actúan en tareas `[AUTO]`. NUNCA tocan producción, NUNCA hacen merge, NUNCA borran.
- **Transparencia radical:** Todo se documenta en Markdown + audit log MCP + RAG sobre historial.
- **Responsabilidad humana:** Tareas `[HUMAN]` y `[RISKY]` requieren tu decisión. CRITICAL → pausa + Telegram.
- **Memoria responsable:** Solo acumula datos necesarios para operar y aprender.
- **Laboratorio controlado (LAB-AGENTES):** Agentes nuevos se prueban en entorno de lab antes de producción.

### 4.2 Lenguaje correcto con la IA

```
[AUTO]    → el agente puede ejecutar solo
[HUMAN]   → requiere tu aprobación
[RISKY]   → pausar + notificar por Telegram
CRITICAL  → parar todo + Telegram urgente
OK        → solo log
WARN      → issue GitHub
```

Documentos de alineación:
- `REGLAS-AGENTES.md` → ley del ecosistema
- `ROADMAP-MASTER.md` → intención y prioridades
- `Tesis-y-Metodo-Sistema-de-Alineacion-Cognitiva.md` → marco mental
- `Arquitectura-de-Inteligencia-Artificial-Soberana-y-Open-Source.md` → visión IA soberana

---

## 5. Arquitectura de agentes

| Agente | Runtime | Repo | Orquestación |
|--------|---------|------|--------------|
| MCP server | Madre (host/Docker) | `yggdrasil-dew/agentes/mcp-server` | Punto central de tools |
| Health-agent | Docker en Madre | `yggdrasil-secops/health-agent` | n8n + MCP |
| Roadmap-agent | GitHub Actions | `yggdrasil-dew/agentes/roadmap` | Actions + MCP |
| Docs-agent | GitHub Actions | `yggdrasil-dew/agentes/docs` | Actions |
| OSINT-agent | Docker + Spiderfoot | `osint-stack/agentes/osint` | n8n + cron |
| Security-agent | Docker | `yggdrasil-secops/security` | n8n + logs |
| Optimization-agent | Docker ligero | `yggdrasil-secops/optimize` | n8n + Prometheus |
| Obsidian-agent | Docker + vault | `local-brain/obsidian-agent` | MCP + Telegram + n8n |
| Álvaro-agent | Docker | `yggdrasil-dew/agentes/alvaro` | MCP + RAG + n8n |

---

## 6. MCP server

Tools expuestas:
- `check_docker`
- `get_ecosystem_state`
- `read_roadmap`
- `list_services`
- `search_obsidian_notes(query)` (futuro)
- `get_obsidian_note(path)` (futuro)
- `create_obsidian_note(title, content)` (futuro)

Garantiza:
- `REGLAS-AGENTES.md` aplicado en cada tool
- Audit log estructurado (JSON + Markdown)
- `dry_run: true` por defecto en acciones de riesgo
- Scopes explícitos por agente

---

## 7. Health-agent + n8n (flujo)

```
n8n cron (15 min)
  ↓
ecosystem-snapshot: contenedores + servicios + workflows
  ↓
health-agent (FastAPI + LLM local)
  ↓
OK → solo log
WARN → issue GitHub
CRITICAL → Telegram + pausa
  ↓
log Markdown + ingest RAG
```

---

## 8. Modelos y eficiencia (GTX 1060 6GB)

| Modelo | Uso | Cuantización |
|--------|-----|---------------|
| `phi3:mini` | Salud, respuestas cortas | Q4_K_M |
| `qwen2.5-coder:7b` | Código | Q4_K_M |
| `mistral:7b` | Síntesis general | Q4_K_M |
| `gemma2:9b` | Razonamiento profundo | Q4_K_M (cuando la GPU lo permita) |
| `bge-m3` | Embeddings RAG | — |

Máximo 2 modelos simultáneos.

---

## 9. Roadmap 4 semanas

**Semana 1:** MCP server + audit log + dry_run + health-agent Docker + ecosystem-snapshot n8n  
**Semana 2:** Roadmap-agent (Actions) + Docs-agent (Actions)  
**Semana 3:** OSINT-agent + Security-agent (Docker + n8n)  
**Semana 4:** Obsidian-agent + PERFIL-ALVARO.md + Álvaro-agent + Optimization-agent  

---

## 10. Regla de oro

> Los agentes solo pueden ser tan buenos como:
> - La claridad de tus reglas.
> - La estructura de tu conocimiento.
> - La precisión del lenguaje que usas con ellos.

*Última actualización: 2026-07-03 [AUTO]*
