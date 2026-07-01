---
tags: [inbox, gemini, auditoria, ecosistema]
fecha: 2026-07-01
estado: pendiente-ejecutar
---

# 🤖 PROMPT COMPLETO PARA GEMINI — AUDITORÍA ECOSISTEMA

> Copiar todo el bloque entre `---INICIO---` y `---FIN---` y pegarlo en Gemini 2.5 Pro.

---INICIO---

Eres un arquitecto de sistemas senior especializado en homelab, DevSecOps e infraestructura IA local.
Vas a auditar y mejorar un ecosistema técnico completo. Lee todo antes de responder.

## CONTEXTO DEL DUEÑO

Nombre: Álvaro
Perfil: Desarrollador Python · Pentest Linux · Ingeniero IA local · Homelab autodidacta
Objetivo: SRE/DevSecOps con diferencial en IA local y seguridad defensiva

---

## HARDWARE

| Máquina | Rol | IP Tailscale | Specs |
|---|---|---|---|
| Madre (varpc) | Servidor Docker + Ollama | 100.91.112.32 | i5-8400 · 16GB RAM · sin GPU |
| Acer (varo12f) | Dev + Obsidian | 100.86.119.102 | Portátil |
| Redmi A5 | Control móvil | Tailscale pendiente | Android |

---

## ESTADO DOCKER (Madre) — 2026-07-01

### Stack Fase 1 (~/docker-compose.yml) — HARDENED HOY
```
ollama              100.91.112.32:11434  (LLM chat — qwen2.5:7b)
ollama-embeddings   100.91.112.32:11435  (RAG — bge-m3 pendiente pull)
qdrant              100.91.112.32:6333   (vector DB)
open-webui          100.91.112.32:3001   (interfaz web)
```

### Stack resto (batcueva + THDORA) — AÚN en 0.0.0.0 — PENDIENTE HARDENING
```
grafana             0.0.0.0:3000
prometheus          0.0.0.0:9090
n8n                 0.0.0.0:5678
gitea               0.0.0.0:3003
code-server         0.0.0.0:8443
portainer           0.0.0.0:9000
uptime-kuma         0.0.0.0:3002
thdora              0.0.0.0:8000
```
Tarea: aplicar sed para portar todos a 100.91.112.32.

---

## REPOS DEL ECOSISTEMA

| Repo | Privado | Estado | Propósito |
|---|---|---|---|
| yggdrasil-dew | ❌ público | ✅ activo | Cerebro + infra + docs + Docker |
| yggdrasil-secops | ✅ privado | nuevo hoy | OSINT defensivo + Tripwires |
| thdora | ❌ público | handlers pendientes | FastAPI + bot Telegram |
| local-brain | ✅ privado | en desarrollo | Ollama + RAG + Qdrant |
| osint-stack | ✅ privado | en desarrollo | Kali + SpiderFoot |
| personal | ❌ público | estable | — |
| ai-toolkit | ❌ público | estable | — |

---

## ESTRUCTURA CARPETAS YGGDRASIL-DEW (problema actual)

Carpetas en raíz: agentes/ assets/ cli-tools/ diarios/ docker/ docs/ formacion/
hardware/ inbox/ infra/ mocs/ ollama/ osint-stack/ osint/ proyectos/
scripts/ setup/ templates/ thdora/ tools/ yo/

Archivos en raíz: AGENT.md CHANGELOG.md CONTEXT.md CONVENCIONES.md ECOSISTEMA.md
ESTADO-SISTEMA.md HOME.md MASTER-PENDIENTES.md PLAN-SEGURIDAD-Y-DESPLIEGUE.md
README.md ROADMAP.md filosofia.md

Problema: mezcla de conocimiento personal (diarios, yo, mocs) con infra técnica
(docker, scripts, infra) en el mismo nivel. Sin jerarquía clara.

---

## PLAN DE FASES (2026-07-01)

| Fase | Nombre | Estado |
|---|---|---|
| 1 | Seguridad red + Hardening puertos | ✅ 100% HOY |
| 2 | start-batcueva.sh | 🟡 50% |
| 3 | Backup Restic | 🟡 30% |
| 4 | Monitoring completo | 🟡 50% |
| 5 | Seguridad avanzada (SOPS, rootless) | 🔴 0% |
| 6 | Handlers THDORA | 🟡 30% |
| 7 | Modelos Ollama + RAG | 🟡 20% |
| 8 | Seguridad Acer | 🟡 30% |
| 9 | Pentest + OSINT real | 🟡 20% |

---

## LO QUE NECESITO (en orden de prioridad)

### 1. REORGANIZACIÓN DE YGGDRASIL-DEW
Propón nueva estructura con máximo 6 carpetas en raíz.
Especifica exactamente qué absorbe qué y por qué.
Escalable para 6 meses. Mantén los archivos clave en raíz (CONTEXT.md, AGENT.md, etc).

### 2. HARDENING RESTANTE — COMANDOS SED EXACTOS
Genera los comandos sed en UNA SOLA LÍNEA (sin backslash, sin saltos) para:

Archivo 1: ~/Obsidian/cerebro/tecnico/setup/servidor/batcueva-fase2.yml
Puertos a migrar: 9000:9000, 3001:3001 (uptime-kuma), 5001:5001

Archivo 2: ~/Obsidian/cerebro/tecnico/setup/servidor/batcueva-fase3.yml
Puertos a migrar: 5678:5678, 3003:3000 (gitea), 8443:8443

Archivo 3: ~/thdora/docker-compose.yml (o la ruta real del compose de thdora)
Puertos a migrar: 9090:9090, 3000:3000 (grafana), 8000:8000

OJO: el patrón de sed que funcionó hoy fue:
sed -i 's/"PUERTO:PUERTO"/"100.91.112.32:PUERTO:PUERTO"/g' archivo.yml

### 3. HOJA DE RUTA 30 DÍAS
Dado i5-8400, 16GB sin GPU:
- ¿Qué fases bloquean a las demás?
- 3 hitos concretos para los próximos 30 días
- ¿Qué está sobrediseñado para este hardware?

### 4. SISTEMA AGENTES — HANDOFF SIN PÉRDIDA DE CONTEXTO
Actualmente: Perplexity documenta vía MCP GitHub. Gemini audita. Claude ejecuta.
¿Qué debería leer cada agente al inicio de cada sesión?
¿Qué información debería estar en AGENT.md vs CONTEXT.md?
¿Cómo estructurar el handoff para no perder contexto entre sesiones?

### 5. INBOX — RITUAL DE PROCESADO
Reglas actuales: máx 10 archivos, wikilink al diario del día.
Propón una plantilla de procesado semanal (15min máximo).

---

## FORMATO ESPERADO

- Secciones numeradas 1-5
- Markdown limpio, listo para copiar en el repo
- Comandos listos para copiar-pegar
- Sin explicar conceptos básicos
- Directo al grano

---FIN---

---

## Contexto adicional (no incluir en el prompt, solo para referencia)

- `yggdrasil-secops` ya existe con tripwire_service.py listo
- Kali se descarga en tmux ahora mismo
- Puertos fase1 hardened HOY — ese trabajo ya está hecho
- Perplexity actualizará CONTEXT.md tras procesar la respuesta de Gemini
