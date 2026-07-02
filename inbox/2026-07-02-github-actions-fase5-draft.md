---
tags: [inbox, github-actions, fase-5, automatizacion, draft]
fecha: 2026-07-02
estado: draft
destino: docs/herramientas/github-actions.md + .github/workflows/
mobile-ok: false
needs-terminal: true
---

# 📥 INBOX — Draft GitHub Actions Fase 5

> Workflows listos para implementar cuando tengamos terminal en Thdora.

---

## Workflow 1: `lint-commits.yml`

```yaml
name: lint-commits
on:
  push:
    branches: ['**']
  pull_request:

jobs:
  commitlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm install -g @commitlint/cli @commitlint/config-conventional
      - run: npx commitlint --from HEAD~1 --to HEAD
```

## Workflow 2: `update-diario-index.yml`

```yaml
name: update-diario-index
on:
  push:
    paths:
      - 'docs/diarios/**'
      - 'diarios/**'

jobs:
  update-index:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - name: Regenerar índice de diarios
        run: python3 scripts/maintenance/gen-diario-index.py
      - uses: peter-evans/create-pull-request@v7
        with:
          commit-message: 'chore(diarios): regenerar índice automático'
          branch: 'bot/update-diario-index'
          title: 'chore: actualizar índice de diarios'
```

## Workflow 3: `context-reminder.yml`

```yaml
name: context-reminder
on:
  schedule:
    - cron: '0 9 * * 1'  # Lunes 09:00

jobs:
  reminder:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Comprobar última actualización de CONTEXT.md
        run: |
          DAYS=$(( ($(date +%s) - $(git log -1 --format=%ct -- CONTEXT.md)) / 86400 ))
          echo "Días desde última actualización: $DAYS"
          if [ "$DAYS" -gt 7 ]; then
            echo "STALE=true" >> $GITHUB_ENV
          fi
      - name: Abrir issue recordatorio
        if: env.STALE == 'true'
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: '⚠️ CONTEXT.md sin actualizar hace más de 7 días',
              body: 'Recordatorio automático: actualiza CONTEXT.md con el estado actual del ecosistema.',
              labels: ['docs', 'p2-normal']
            })
```

---
_Draft: 02-jul-2026 — ejecutar en Thdora_
