---
tipo: problema-detectado
fecha: 2026-06-24
hora: "23:42"
status: activo
tags: [inbox, documentacion, deuda-tecnica, plan, proceso, pendientes]
priority: CRÍTICA
---

# 🚨 PROBLEMA: Acumulación de Inbox Sin Documentar

> Detectado en sesión noche 2026-06-24 con Perplexity.
> Este fichero documenta el problema, su causa raíz y el plan para resolverlo.

---

## El Problema

**Hacemos mucho. No documentamos lo suficiente.**

En las últimas 48 horas se han generado **+90 ficheros en inbox/** repartidos en dos días:
- 23-06: ~40 ficheros
- 24-06: ~55 ficheros

De todos ellos, en `docs/` **solo existen ficheros del 23-06** (y ninguno del 24-06).

Esto significa que toda la actividad real del 24 de junio — decisiones tomadas, stack levantado, modelos descargados, arquitectura definida, scripts creados — **no está documentada** en el lugar que le corresponde dentro del repo.

---

## Causa Raíz

El flujo actual es:

```
Sesión de trabajo
    ↓
Se genera contenido → se vuelca en inbox/
    ↓
Se pasa a la siguiente sesión sin procesar inbox
    ↓
inbox crece · docs queda desactualizado
```

No existe ningún mecanismo que **obligue o automatice** el procesado de inbox antes de cerrar sesión.

---

## Inventario del Daño (24-06-2026)

Ficheros en inbox del 24-06 sin documentar agrupados por tema:

### 🧠 Ecosistema y arquitectura
- `2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md`
- `2026-06-24-mapa-maestro-ecosistema.md`
- `2026-06-24-mapa-completo-repo-real.md`
- `2026-06-24-ecosistema-comparativa-repos.md`
- `2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md`
- `2026-06-24-TESIS-ARQUITECTURA-MINIMALISTA-OPENSOUECE.md`

### ⚖️ Decisiones tomadas (candidatos a ADR)
- `2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md` → **ADR-003**
- `2026-06-24-fase1-revisada-con-litellm.md` → **ADR-004**
- `2026-06-24-ADR-OBSIDIAN-PLUGINS-SSOT.md` → **ADR-005**
- `2026-06-24-DEBATE-GROK-OLLAMA-VS-LLAMACPP.md`
- `2026-06-24-BITACORA-GEMINI-TURNO3-LLAMACPP-MARKOV.md`

### 🐳 Stack Docker / Setup
- `2026-06-24-docker-compose-final-completo.md` → `docs/setup/`
- `2026-06-24-sesion-stack-madre-levantado.md`
- `2026-06-24-fase3-completa.md`
- `2026-06-24-fase4-litellm-sops-plan.md`
- `2026-06-24-n8n-litellm-integracion.md`
- `2026-06-24-nginx-proxy-manager.md`

### 🔧 Scripts y configuración
- `2026-06-24-macro-script-madre.md`
- `2026-06-24-mega-script-nocturno.md`
- `2026-06-24-script-configuracion-completa.md`
- `2026-06-24-script-descarga-completa.md`
- `2026-06-24-arch-linux-optimizacion-completa.md`
- `2026-06-24-kernel-sysctl-hardening.md`
- `2026-06-24-hypridle-desactivado.md`

### 🤖 Modelos e IAs
- `2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md` → `docs/ias/`
- `2026-06-24-langchain-ollama-optimizacion.md`
- `2026-06-24-ollama-modelfile-erika.md`
- `2026-06-24-protocolo-autoconocimiento-agentes.md`
- `2026-06-24-BITACORA-GROK-PERPLEXICA-FASES.md`
- `2026-06-24-PROMPT-MAESTRO-DOCUMENTACION-IAS.md`
- `2026-06-24-PROMPT-MAESTRO-DEBATE-MULTI-IA.md`

### 🔬 OSINT y proyectos
- `2026-06-24-osint-visual-personas-camaras.md`
- `2026-06-24-PENDIENTES-THDORA-COMANDOS-Y-DOCKER.md`
- `2026-06-24-script-thdora-handlers.md`
- `2026-06-24-proyectos-fichas.md`
- `2026-06-24-batcueva-fase2-plan.md`
- `2026-06-24-REPOS-CREAR-CHATBOT-TERMINAL.md`

### 📋 Registro histórico / Sesiones
- `2026-06-24-SESION-COMPLETA-RESUMEN.md` → `diarios/`
- `2026-06-24-SESION-NOCHE-MOVIL.md`
- `2026-06-24-sesion-madrugada.md`
- `2026-06-24-CIERRE-DEFINITIVO-06h00.md`
- `2026-06-24-CIERRE-SESION.md`
- `2026-06-24-ESTADO-CIERRE-NOCHE.md`
- `2026-06-24-contexto-manana.md`

---

## Plan de Documentación (próxima sesión)

### Orden de ejecución recomendado

```
PASO 1 — Diario maestro del 24-06
  → docs/diarios/2026-06-24.md
  Fuente: SESION-COMPLETA-RESUMEN + CIERRE-DEFINITIVO-06h00 + ESTADO-CIERRE-NOCHE

PASO 2 — ADR-003: Ollama vs llama.cpp
  → docs/adr/ADR-003-ollama-vs-llamacpp.md
  Fuente: BITACORA-FINAL-OLLAMA-VS-LLAMACPP + DEBATE-GROK

PASO 3 — ADR-004: LiteLLM como gateway de IAs
  → docs/adr/ADR-004-litellm-gateway.md
  Fuente: fase1-revisada-con-litellm + n8n-litellm-integracion

PASO 4 — ADR-005: Obsidian plugins SSOT
  → docs/adr/ADR-005-obsidian-plugins-ssot.md
  Fuente: ADR-OBSIDIAN-PLUGINS-SSOT (ya en inbox, mover tal cual)

PASO 5 — Setup docker stack madre
  → docs/setup/docker-stack-madre.md
  Fuente: docker-compose-final-completo + fase3-completa + sesion-stack-madre-levantado

PASO 6 — Setup Arch Linux optimizado
  → docs/setup/arch-linux-optimizacion.md
  Fuente: arch-linux-optimizacion-completa + kernel-sysctl-hardening

PASO 7 — Estado ecosistema 2026-06-24
  → docs/sistema/ecosistema-estado-2026-06-24.md
  Fuente: ECOSISTEMA-COMPLETO-MIGRACION + mapa-maestro-ecosistema + mapa-completo-repo-real

PASO 8 — Protocolo agentes e IAs
  → docs/ias/protocolo-agentes.md
  Fuente: protocolo-autoconocimiento-agentes + PROMPT-MAESTRO-DOCUMENTACION-IAS

PASO 9 — Decisión arquitectura minimalista
  → docs/decisiones/arquitectura-minimalista-open-source.md
  Fuente: TESIS-ARQUITECTURA-MINIMALISTA + DEEP-RESEARCH-ALINEACION-SSOT

PASO 10 — Scripts activos
  → setup/servidor/scripts/ (revisar si ya existen o son nuevos)
  Fuente: macro-script-madre + script-configuracion-completa
```

---

## Solución Estructural (pendiente implementar)

### Regla nueva del repo: "No commit de cierre sin diario"

Añadir al `cierre-sesion.sh` o como hook pre-push:
```
❌ BLOQUEADO: No hay diario de hoy en diarios/YYYY-MM-DD.md
   Crea el diario antes de hacer commit de cierre.
```

### Tabla tipo → destino (para migración automática)

| tipo (frontmatter) | Destino |
|--------------------|---------|
| `resumen-sesion` | `diarios/` |
| `plan-sesion` | borrar o `diarios/planes/` |
| `bitacora-debate` | `docs/ias/debates/` |
| `sesion-investigacion` | `docs/investigacion/` |
| `adr` | `docs/adr/` |
| `setup` | `docs/setup/` |
| `ficha-modelo` | `docs/ias/modelos/` |
| `prompt-maestro` | `agentes/prompts/` |
| `tesis-arquitectura` | `docs/decisiones/` |
| `problema-detectado` | `docs/sistema/` |
| `estado-ecosistema` | `docs/sistema/` |
| `script` | `setup/servidor/scripts/` |

### Automatización propuesta
- [ ] Script Python `inbox-processor.py` que lea frontmatter y mueva a destino
- [ ] Cron dominical para migración automática (como fallback)
- [ ] Hook `post-commit` que avise si inbox tiene >10 ficheros sin procesar
- [ ] THDORA con comando `/procesar-inbox` que dispare el script

---

## Referencias

- Plan próxima sesión: [2026-06-24-PLAN-PROXIMA-SESION.md](2026-06-24-PLAN-PROXIMA-SESION.md)
- Procesador inbox anterior: [../docs/2026-06-23-inbox-processor-implementacion.md](../docs/2026-06-23-inbox-processor-implementacion.md)
- Estado cierre noche: [2026-06-24-ESTADO-CIERRE-NOCHE.md](2026-06-24-ESTADO-CIERRE-NOCHE.md)
