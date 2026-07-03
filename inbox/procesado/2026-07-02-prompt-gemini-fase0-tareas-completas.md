---
tags: [inbox, gemini, prompt, fase-0, automatizacion, mega-prompt]
fecha: 2026-07-02
estado: listo-para-usar
destino: usar-directamente-en-gemini-2.5-pro
mobile-ok: true
---

# 🤖 MEGA-PROMPT GEMINI — Fase 0 completa + GitHub setup

> Copia este prompt COMPLETO en Gemini 2.5 Pro.
> Gemini ejecuta. Perplexity documenta y hace commits.
> Tarea por tarea, confirmar antes de la siguiente.

---

```
Actuús como ingeniero de sistemas senior con experiencia en DevOps, GitHub y automatización de repos.

Trabajas sobre el repositorio: https://github.com/alvarofernandezmota-tech/yggdrasil-dew

Contexto del sistema:
- Repo central de un homelab personal (Madre: PC torre Docker + Thdora: portátil Arch + iPhone 11)
- Stack: Python, Docker, Tailscale, Ollama, FastAPI, Wazuh, Suricata, n8n
- Filosofía: producción primero, documentación real, sin adornos
- Flujo agentes IA: Perplexity (documenta + MCP GitHub), Claude (código + terminal), Gemini (auditorías masivas)
- Convenciones: CONVENCIONES.md en raíz del repo
- CONTEXT.md es el archivo más importante — estado real del sistema

Tu misión: ejecutar TODAS las tareas de Fase 0 que siguen, en orden.
Despues de cada tarea, confirma qué hiciste antes de pasar a la siguiente.
Si necesitas contenido de un archivo del repo, pídelo.

---

## TAREA 1 — Crear labels personalizados en yggdrasil-dew

Via GitHub API (o MCP si tienes acceso), crear estos labels:

FASES:
- fase-0 | #0075ca | Estructura y docs del repo
- fase-1 | #006b75 | Tailscale / red segura
- fase-2 | #e4e669 | SSH hardening
- fase-3 | #d93f0b | Wazuh SIEM
- fase-4 | #b60205 | Suricata IDS
- fase-5 | #0e8a16 | GitHub Actions
- fase-6 | #1d76db | Cursor + MCP Thdora
- fase-7 | #5319e7 | Ollama agentes IA

EJECUCION:
- needs-terminal | #fbca04 | Requiere terminal en Thdora/Madre
- mobile-ok | #0e8a16 | Se puede desde móvil o Perplexity

TIPO:
- bug | #d73a4a | Roto en producción
- docs | #0075ca | Solo documentación
- infra | #006b75 | Infraestructura
- security | #b60205 | Seguridad
- ai | #5319e7 | IA local / agentes
- blocked | #e11d48 | Bloqueado

PRIORIDAD:
- p0-critico | #b60205 | Sistema caído o brecha
- p1-urgente | #d93f0b | Esta semana
- p2-normal | #fbca04 | Backlog
- p3-cuando-pueda | #c5def5 | No urgente

Eliminar labels por defecto que no usemos (good first issue, help wanted, invalid, question, wontfix).
Mantener: bug (reemplazar con el nuevo), documentation → renombrar a docs.

Confirma cuántos labels creados antes de pasar a tarea 2.

---

## TAREA 2 — Crear milestones

Crear en yggdrasil-dew:

Milestone 1:
- Título: Fase 0 — Repo limpio y documentado
- Descripción: Estructura de carpetas, CONVENCIONES, labels, GitHub Actions base
- Due date: 2026-07-10

Milestone 2:
- Título: Fase 2 — SSH Hardening completo
- Descripción: Claves ED25519, fail2ban avanzado, auditíd, 2FA
- Due date: 2026-07-15

Confirma antes de pasar a tarea 3.

---

## TAREA 3 — Crear archivos .github/

Crear en el repo estos archivos (con el contenido exacto que se indica):

### .github/CODEOWNERS
```
# Todo el repo — Alvaro es el único owner
* @alvarofernandezmota-tech
```

### .github/PULL_REQUEST_TEMPLATE.md
```markdown
## Tipo de cambio
- [ ] feat — nueva funcionalidad
- [ ] fix — corrección
- [ ] docs — solo documentación
- [ ] chore — mantenimiento
- [ ] infra — infraestructura
- [ ] security — seguridad

## ¿Qué hace este PR?
<!-- Descripción concisa -->

## Checklist
- [ ] Sigue CONVENCIONES.md
- [ ] CONTEXT.md actualizado si procede
- [ ] Probado en máquina real
- [ ] Sin secrets ni datos sensibles
```

Commit con mensaje: `chore(.github): añadir CODEOWNERS y PR template`

Confirma antes de tarea 4.

---

## TAREA 4 — Actualizar CHANGELOG.md

Leer el CHANGELOG.md actual del repo y reescribirlo siguiendo formato
[Keep a Changelog](https://keepachangelog.com/es/1.0.0/) con estas entradas:

```markdown
# CHANGELOG

Todos los cambios notables de este proyecto se documentan aquí.
Formato: [Keep a Changelog](https://keepachangelog.com/es/1.0.0/)

## [Unreleased]
### Added
- (próximos cambios aquí)

## [0.3.0] — 2026-07-02
### Added
- CONVENCIONES.md reescrito nivel senior (10 secciones)
- AGENT.md actualizado con fases, stack, iPhone
- CONTRIBUTING.md creado desde cero
- Auditoría herramientas GitHub documentada en inbox
- GitHub Actions 3 workflows draftados
- Labels, milestones, CODEOWNERS, PR template añadidos

## [0.2.0] — 2026-07-01
### Added
- yggdrasil-secops repo creado
- Hardening Docker Fase 1 (puertos Tailscale only)
- SSH hardening completado en Madre y Thdora
- Hallazgo FTP puerto 21 documentado y cerrado

## [0.1.0] — 2026-06-25
### Added
- Estructura inicial del repo
- ECOSISTEMA.md, HOME.md, CONTEXT.md, MASTER-PENDIENTES.md
- Stack Docker inicial documentado
```

Commit: `docs(changelog): adoptar formato Keep a Changelog`

Confirma antes de tarea 5.

---

## TAREA 5 — Crear repo público Profile README

Crear repositorio público con nombre exacto: `alvarofernandezmota-tech`
(Este nombre especial hace que el README aparezca en el perfil de GitHub)

Contenido del README.md: leer `yo/profile-README.md` del repo yggdrasil-dew
y usarlo como contenido del README del nuevo repo.

El repo debe ser:
- Público
- Solo un README.md
- Sin .gitignore ni licencia añadida automáticamente

Confirma URL del repo creado antes de tarea 6.

---

## TAREA 6 — Auditoría automática del repo (script)

Crear script `scripts/maintenance/audit-repo.sh` con este contenido:

```bash
#!/usr/bin/env bash
# audit-repo.sh — Auditoría rápida del estado del repo
# Uso: bash scripts/maintenance/audit-repo.sh
# mobile-ok: false | needs-terminal: true

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
INBOX="$REPO_ROOT/inbox"
DATE=$(date +%Y-%m-%d)

echo "====================================="
echo " AUDIT YGGDRASIL-DEW — $DATE"
echo "====================================="

# 1. Contar ficheros inbox
INBOX_COUNT=$(find "$INBOX" -maxdepth 1 -name '*.md' | wc -l)
echo ""
echo "📥 INBOX: $INBOX_COUNT ficheros (límite: 10)"
if [ "$INBOX_COUNT" -gt 10 ]; then
  echo "  ⚠️ SUPERA EL LÍMITE — procesar inbox"
fi

# 2. Verificar archivos críticos
echo ""
echo "📄 ARCHIVOS CRÍTICOS:"
for f in CONTEXT.md AGENT.md CONVENCIONES.md MASTER-PENDIENTES.md ECOSISTEMA.md HOME.md; do
  if [ -f "$REPO_ROOT/$f" ]; then
    LAST=$(git log -1 --format='%ar' -- "$f" 2>/dev/null || echo 'sin commits')
    echo "  ✅ $f — último cambio: $LAST"
  else
    echo "  ❌ $f — NO EXISTE"
  fi
done

# 3. Verificar CONTEXT.md no tiene más de 7 días
echo ""
echo "🕐 CONTEXT.md:"
CONTEXT_DATE=$(git log -1 --format='%ct' -- CONTEXT.md 2>/dev/null || echo 0)
NOW=$(date +%s)
DAYS_OLD=$(( (NOW - CONTEXT_DATE) / 86400 ))
if [ "$DAYS_OLD" -gt 7 ]; then
  echo "  ⚠️ Sin actualizar hace $DAYS_OLD días — actualizar hoy"
else
  echo "  ✅ Actualizado hace $DAYS_OLD días"
fi

# 4. Archivos grandes (>500KB)
echo ""
echo "🔍 FICHEROS GRANDES (>500KB):"
find "$REPO_ROOT" -not -path '*/.git/*' -size +500k -exec ls -lh {} \; 2>/dev/null | awk '{print "  " $5 " " $9}' || echo "  Ninguno"

# 5. Archivos que no deberían estar rastreados
echo ""
echo "⚠️ POSIBLES ARCHIVOS SENSIBLES RASTREADOS:"
git ls-files | grep -E '\.(apk|env|pem|key|pfx|p12)$|^\.obsidian/' || echo "  Ninguno detectado"

# 6. Conventional Commits últimos 10
echo ""
echo "📝 ÚLTIMOS 10 COMMITS (formato):"
git log --oneline -10 | while read line; do
  if echo "$line" | grep -qE '^[a-f0-9]+ (feat|fix|docs|chore|refactor|test|infra|security|style)(\([a-z-]+\))?:';
  then echo "  ✅ $line"
  else echo "  ⚠️ $line — no sigue Conventional Commits"
  fi
done

echo ""
echo "====================================="
echo " FIN AUDITORÍA"
echo "====================================="
```

Commit: `feat(scripts): audit-repo.sh — auditoría rápida del estado del repo`

Confirma antes de tarea 7.

---

## TAREA 7 — GitHub Actions workflow repo-health-check

Crear `.github/workflows/repo-health-check.yml`:

```yaml
name: repo-health-check

on:
  schedule:
    - cron: '0 8 * * 1'  # Lunes 08:00 UTC
  workflow_dispatch:

jobs:
  health-check:
    runs-on: ubuntu-latest
    permissions:
      issues: write
      contents: read

    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Contar ficheros inbox
        id: inbox
        run: |
          COUNT=$(find inbox -maxdepth 1 -name '*.md' | wc -l)
          echo "count=$COUNT" >> $GITHUB_OUTPUT
          echo "Inbox: $COUNT ficheros"

      - name: Verificar CONTEXT.md actualizado
        id: context
        run: |
          DAYS=$(( ($(date +%s) - $(git log -1 --format=%ct -- CONTEXT.md)) / 86400 ))
          echo "days=$DAYS" >> $GITHUB_OUTPUT
          echo "CONTEXT.md: $DAYS dias sin actualizar"

      - name: Detectar archivos sensibles rastreados
        id: secrets
        run: |
          FOUND=$(git ls-files | grep -E '\.(apk|env|pem|key)$|^\.obsidian/' || true)
          echo "found=$FOUND" >> $GITHUB_OUTPUT

      - name: Abrir issue si hay problemas
        uses: actions/github-script@v7
        with:
          script: |
            const inbox = parseInt('${{ steps.inbox.outputs.count }}');
            const days = parseInt('${{ steps.context.outputs.days }}');
            const secrets = '${{ steps.secrets.outputs.found }}';

            const issues = [];
            if (inbox > 10) issues.push(`⚠️ Inbox tiene ${inbox} ficheros (límite 10)`);
            if (days > 7) issues.push(`⚠️ CONTEXT.md sin actualizar hace ${days} días`);
            if (secrets) issues.push(`🔴 Archivos sensibles rastreados: ${secrets}`);

            if (issues.length > 0) {
              await github.rest.issues.create({
                owner: context.repo.owner,
                repo: context.repo.repo,
                title: `🤖 Repo Health Check — ${new Date().toISOString().split('T')[0]}`,
                body: `## Problemas detectados\n\n${issues.map(i => `- ${i}`).join('\n')}\n\n_Generado automáticamente por repo-health-check workflow_`,
                labels: ['docs', 'p2-normal']
              });
            } else {
              console.log('Todo OK ✅');
            }
```

Commit: `feat(actions): repo-health-check workflow semanal`

---

## RESUMEN FINAL

Despues de completar las 7 tareas, responde con:
1. Lista de todo lo creado / modificado
2. URLs de los recursos creados (repo perfil, labels, milestones)
3. Qué queda pendiente para terminal (needs-terminal)
4. Cualquier problema encontrado

Perplexity hará el commit final actualizando CONTEXT.md con lo realizado.
```

---

## 💡 Cómo usar este prompt

1. Abrir Gemini 2.5 Pro (gemini.google.com)
2. Copiar el bloque de código completo de arriba
3. Pegar y enviar
4. Gemini pedirá confirmación tarea a tarea
5. Cuando termine, volver aquí y decirle a Perplexity qué se completó
6. Perplexity actualiza CONTEXT.md + hace commit de cierre

---
_Creado: 02-jul-2026 20:27 CEST — iPhone 11 — Perplexity vía MCP_
