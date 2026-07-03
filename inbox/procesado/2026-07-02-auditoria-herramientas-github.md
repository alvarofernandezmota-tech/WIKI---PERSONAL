---
tags: [inbox, github, herramientas, auditoria, fase-0]
fecha: 2026-07-02
hora: 20:23
estado: pendiente-migrar
destino: docs/herramientas/github-ecosystem.md
mobile-ok: true
---

# 📥 INBOX — Auditoría herramientas GitHub + qué activar

> Procesar → mover a `docs/herramientas/github-ecosystem.md`
> Alineado con `CONVENCIONES.md` y filosofía: producción primero, perfectamente organizado.

---

## 📊 Estado actual de herramientas GitHub en yggdrasil-dew

| Herramienta | Existe | Configurado | Usando |
|---|---|---|---|
| Issues | ✅ | ❌ sin labels | ❌ no usamos |
| Labels | ✅ nativas | ❌ solo defaults | ❌ |
| Milestones | ✅ | ❌ vacío | ❌ |
| Projects (board) | ✅ | ❌ no existe | ❌ |
| Pull Requests | ✅ | ❌ sin plantilla | ❌ casi nunca |
| GitHub Actions | ✅ carpeta `.github/workflows/` | ❌ sin workflows | ❌ |
| Wiki | ✅ | ❌ no activada | ❌ |
| Discussions | ✅ | ❌ no activada | ❌ |
| Security tab | ✅ | ❌ no configurada | ❌ |
| Dependabot | ✅ | ❌ no configurado | ❌ |
| Branch protection | ✅ | ❌ sin reglas | ❌ |
| CODEOWNERS | ❌ | — | — |
| Release tags | ✅ | ❌ no usamos | ❌ |
| Pinned repos | ✅ perfil | ❌ no configurado | ❌ |
| Profile README | ❌ repo no existe | — | — |

---

## ✅ QUÉ AÑADIR — con razón de negocio clara

### 1. Labels personalizados (PRIORITARIO — mobile-ok)

Sustituir los labels por defecto por labels alineados con las fases:

```
Fases:
  fase-0        #0075ca   Estructura y limpieza del repo
  fase-1        #006b75   Tailscale / red segura
  fase-2        #e4e669   SSH hardening
  fase-3        #d93f0b   Wazuh SIEM
  fase-4        #b60205   Suricata IDS
  fase-5        #0e8a16   GitHub Actions
  fase-6        #1d76db   Cursor + MCP Thdora
  fase-7        #5319e7   Ollama agentes IA

Ejecución:
  needs-terminal  #fbca04  Requiere Acer con terminal
  mobile-ok       #0e8a16  Se puede desde móvil/Perplexity

Tipo:
  bug             #d73a4a  Algo roto en producción
  docs            #0075ca  Solo documentación
  blocked         #e11d48  Bloqueado por dependencia
  security        #b60205  Issue de seguridad
  infra           #006b75  Infraestructura Madre/Thdora
  ai              #5319e7  IA local / agentes

Prioridad:
  p0-critico      #b60205  Sistema caído o brecha
  p1-urgente      #d93f0b  Resolver esta semana
  p2-normal       #fbca04  Backlog normal
  p3-cuando-pueda #c5def5  No urgente
```

### 2. Issue Templates (mobile-ok)

Crear en `.github/ISSUE_TEMPLATE/`:
- `bug.yml` — sistema caído, servicio roto
- `tarea.yml` — tarea de infraestructura o docs
- `seguridad.yml` — hallazgo de seguridad

### 3. GitHub Actions — 3 workflows iniciales (needs-terminal para probar)

```
Workflow 1: update-diario-index.yml
  Trigger: push a docs/diarios/
  Acción: regenerar diarios/README.md con índice automático

Workflow 2: lint-commits.yml
  Trigger: push a cualquier rama
  Acción: validar que los commits siguen Conventional Commits
  Tool: commitlint

Workflow 3: update-context-reminder.yml
  Trigger: schedule (lunes 09:00)
  Acción: abrir issue automático recordando actualizar CONTEXT.md
  útil cuando no hay actividad más de 7 días
```

### 4. Branch Protection en `main` (needs-terminal — configurar en Settings)

```
Regla para main:
  - Required status checks: lint-commits (cuando exista)
  - Allow direct push: sí (somos uno solo, no bloquear flujo)
  - No require PR: mantén flujo ágil
  - Delete branch on merge: sí
```

### 5. Profile README repo (PRIORITARIO — mobile-ok)

Crear repo público `alvarofernandezmota-tech` con el README que ya tenemos
en `yo/profile-README.md`. Da presencia profesional inmediata.

### 6. Pinned repos en perfil (mobile-ok — desde github.com)

Pinear estos 4 repos en el perfil público:
- `yggdrasil-dew` (si se hace público o se crea una versión pública)
- `ai-toolkit`
- `thdora`
- `local-brain`

### 7. Milestones por fase (mobile-ok)

```
Milestone: Fase 0 — Repo limpio
  Due: 2026-07-10
  Issues: todos los de label fase-0

Milestone: Fase 2 — SSH Hardening
  Due: 2026-07-15
```

---

## ❌ QUÉ NO ACTIVAR / QUITAR

| Herramienta | Razón |
|---|---|
| **Wiki** | Duplica docs/ — todo vive en el repo como markdown, no necesitamos otro sistema |
| **Discussions** | Somos uno solo trabajando — no tiene sentido la feature de "discusiones" |
| **Dependabot** | El repo no tiene dependencias de paquetes (no hay `package.json`, `requirements.txt` rastreado) — revisar si procede más adelante |
| **GitHub Pages** | No necesitamos web pública de este repo ahora — puede ser útil para una web del ecosistema en Fase 8+ |
| **GitHub Codespaces** | Tenemos Cursor + Thdora + Madre. No necesitamos entorno en la nube. |
| **Sponsor button** | No aplica ahora |

---

## ✅ QUÉ DEJAR COMO ESTÁ

| Herramienta | Por qué no tocar |
|---|---|
| **Issues** | Ya funciona, solo falta añadir labels y templates |
| **PRs** | Flujo actual (push directo a main para diarios/docs) es correcto para cómo trabajamos |
| **Security tab** | Activar secret scanning pasivo no cuesta nada — dejar con config por defecto |
| **Actions carpeta** | `.github/workflows/` ya existe — añadir workflows sin tocar estructura |

---

## 💡 COSAS EXTRA QUE AÑADIR

### CHANGELOG.md versionado semántico

Actualmente existe pero no sigue formato estándar.
Adoptar [Keep a Changelog](https://keepachangelog.com/):

```markdown
## [Unreleased]
### Added
### Changed
### Removed

## [0.2.0] — 2026-07-02
### Added
- CONVENCIONES.md reescrito nivel senior
- AGENT.md actualizado con fases
- CONTRIBUTING.md creado
```

### `.github/CODEOWNERS`

Para que quede registrado el ownership, aunque seamos uno:
```
* @alvarofernandezmota-tech
```

### `.github/PULL_REQUEST_TEMPLATE.md`

Plantilla mínima para PRs automáticos (bots, Fase 5):
```markdown
## Tipo de cambio
- [ ] feat / fix / docs / chore / infra / security

## Descripción
<!-- Qué hace este PR -->

## Checklist
- [ ] Sigue CONVENCIONES.md
- [ ] CONTEXT.md actualizado si procede
- [ ] Tested en máquina real
```

---

## 📌 ÓRDENES DE EJECUCIóN

### Ahora mismo (mobile-ok — Perplexity MCP)
- [ ] Crear labels en yggdrasil-dew
- [ ] Crear milestones Fase 0 y Fase 2
- [ ] Crear repo `alvarofernandezmota-tech` con Profile README
- [ ] Crear `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] Crear `.github/CODEOWNERS`
- [ ] Actualizar `CHANGELOG.md` con formato Keep a Changelog

### Próxima sesión con terminal (needs-terminal)
- [ ] Crear Issue Templates `.github/ISSUE_TEMPLATE/*.yml`
- [ ] Configurar branch protection en Settings (web GitHub)
- [ ] Crear workflows GitHub Actions (lint-commits, update-diario-index)
- [ ] Probar workflow update-perplexity-docs.yml ya documentado

---
_Creado: 02-jul-2026 20:23 CEST — iPhone 11 — Perplexity vía MCP_
_Destino: `docs/herramientas/github-ecosystem.md`_
