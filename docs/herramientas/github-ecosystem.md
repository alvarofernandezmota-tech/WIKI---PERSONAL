# GitHub Ecosystem — Herramientas y configuración
#herramientas #github #fase0 #organización

**Fecha auditoría:** 2026-07-02
**Repo:** yggdrasil-dew

---

## Estado actual

| Herramienta | Existe | Configurado | Usando |
|---|---|---|---|
| Issues | ✅ | ❌ sin labels | ❌ no |
| Labels | ✅ nativas | ❌ solo defaults | ❌ |
| Milestones | ✅ | ❌ vacío | ❌ |
| Projects (board) | ✅ | ❌ no existe | ❌ |
| Pull Requests | ✅ | ❌ sin plantilla | ❌ |
| GitHub Actions | ✅ `.github/workflows/` | ❌ sin workflows | ❌ |
| Wiki | ✅ | ❌ no activada | ❌ |
| Discussions | ✅ | ❌ no activada | ❌ |
| Security tab | ✅ | ❌ no configurada | ❌ |
| Branch protection | ✅ | ❌ sin reglas | ❌ |
| CODEOWNERS | ❌ | — | — |
| Release tags | ✅ | ❌ no usamos | ❌ |

---

## ✅ Qué añadir — con razón clara

### 1. Labels personalizados

```
Fases:
  fase-0   #0075ca   Estructura y limpieza del repo
  fase-1   #006b75   Tailscale / red segura
  fase-2   #e4e669   SSH hardening
  fase-3   #d93f0b   Wazuh SIEM
  fase-4   #b60205   Suricata IDS
  fase-5   #0e8a16   GitHub Actions
  fase-6   #1d76db   Cursor + MCP Thdora
  fase-7   #5319e7   Ollama agentes IA

Ejecución:
  needs-terminal  #fbca04  Requiere Acer con terminal
  mobile-ok       #0e8a16  Se puede desde móvil/Perplexity

Tipo:
  bug       #d73a4a   Algo roto en producción
  docs      #0075ca   Solo documentación
  blocked   #e11d48   Bloqueado por dependencia
  security  #b60205   Issue de seguridad
  infra     #006b75   Infraestructura Madre/Thdora
  ai        #5319e7   IA local / agentes

Prioridad:
  p0-critico      #b60205  Sistema caído o brecha
  p1-urgente      #d93f0b  Resolver esta semana
  p2-normal       #fbca04  Backlog normal
  p3-cuando-pueda #c5def5  No urgente
```

### 2. Issue Templates

Crear en `.github/ISSUE_TEMPLATE/`:
- `bug.yml` — sistema caído, servicio roto
- `tarea.yml` — tarea de infraestructura o docs
- `seguridad.yml` — hallazgo de seguridad

### 3. GitHub Actions — 3 workflows iniciales

| Workflow | Trigger | Acción |
|---|---|---|
| `update-diario-index.yml` | push a `docs/diarios/` | Regenerar `diarios/README.md` |
| `lint-commits.yml` | push cualquier rama | Validar Conventional Commits |
| `update-context-reminder.yml` | schedule lunes 09:00 | Abrir issue si CONTEXT.md >7 días sin actualizar |

### 4. CODEOWNERS

```
# .github/CODEOWNERS
* @alvarofernandezmota-tech
```

### 5. PR Template

```markdown
# .github/PULL_REQUEST_TEMPLATE.md
## Tipo de cambio
- [ ] feat / fix / docs / chore / infra / security

## Descripción

## Checklist
- [ ] Sigue CONVENCIONES.md
- [ ] CONTEXT.md actualizado si procede
- [ ] Tested en máquina real
```

### 6. Profile README

Crear repo público `alvarofernandezmota-tech` con el README en `yo/profile-README.md`.

### 7. Milestones por fase

```
Fase 0 — Repo limpio    Due: 2026-07-10
Fase 2 — SSH Hardening  Due: 2026-07-15
```

---

## ❌ Qué NO activar

| Herramienta | Razón |
|---|---|
| Wiki | Duplica `docs/` — todo vive en el repo |
| Discussions | Solo trabajamos uno |
| Dependabot | Sin dependencias rastreadas de paquetes ahora |
| GitHub Pages | No necesario hasta Fase 8+ |
| Codespaces | Tenemos Cursor + Thdora + Madre |

---

## 📋 Órdenes de ejecución

### Mobile-ok (Perplexity MCP)
- [ ] Crear labels personalizados en yggdrasil-dew
- [ ] Crear milestones Fase 0 y Fase 2
- [ ] Crear `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] Crear `.github/CODEOWNERS`
- [ ] Crear repo `alvarofernandezmota-tech` con Profile README
- [ ] Actualizar `CHANGELOG.md` con formato Keep a Changelog

### Needs-terminal
- [ ] Crear Issue Templates `.github/ISSUE_TEMPLATE/*.yml`
- [ ] Configurar branch protection en Settings
- [ ] Crear workflows GitHub Actions
