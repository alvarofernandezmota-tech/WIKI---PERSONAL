---
tipo: script-propuesta
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:12 CEST
actualizado: 2026-07-03 01:12 CEST
ruta: inbox/2026-07-03-repo-audit-script.md
tags: [script, auditoria, repo-health, python, automatizacion]
status: pendiente-procesar
destino: scripts/repo-audit.py
---

# Script repo-audit.py — Propuesta completa

> Evolución del audit-repo.sh actual hacia un script Python completo
> que detecta discordancias estructurales y delega fixes a otros modelos.

---

## Arquitectura del script

```
scripts/repo-audit.py
  ├── check_obsidian_tracked()      → .obsidian/ en git = CRÍTICO
  ├── check_duplicate_folders()    → osint/ vs osint-stack/, diarios duplicados
  ├── check_root_bloat()            → más de 5 .md en raíz = WARNING
  ├── check_orphan_folders()        → carpetas sin README ni referencias
  ├── check_cross_references()      → fichero en CONTEXT que no existe en repo
  ├── check_authorship()            → todo .md tiene frontmatter author+creado
  ├── check_inbox_age()             → ficheros en inbox/ > 48h sin procesar
  ├── check_conventions()           → nombres de fichero siguen CONVENCIONES.md
  └── check_changelog_fresh()       → CHANGELOG actualizado si hubo commits hoy
```

---

## Código base (Python)

```python
#!/usr/bin/env python3
"""
repo-audit.py — Auditoría estructural del repositorio yggdrasil-dew
Author: Thdora Dev (Perplexity-MCP)
Uso: python3 scripts/repo-audit.py [--output telegram|github|stdout]
"""

import os
import subprocess
import json
from datetime import datetime, timedelta
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
MAX_ROOT_MD = 5
INBOX_MAX_AGE_HOURS = 48

ROOT_WHITELIST = [
    "README.md", "CHANGELOG.md", "CONTRIBUTING.md",
    "CONVENCIONES.md", "AGENT.md", "ROADMAP.md",
    ".gitignore", ".env.template", "LICENSE"
]

results = {"critico": [], "warning": [], "ok": []}

def log(level, check, message):
    results[level].append({"check": check, "msg": message})
    emoji = {"critico": "🔴", "warning": "⚠️", "ok": "✅"}[level]
    print(f"{emoji} [{check}] {message}")


def check_obsidian_tracked():
    """Detecta si .obsidian/ está siendo trackeado por git."""
    result = subprocess.run(
        ["git", "ls-files", ".obsidian"],
        capture_output=True, text=True, cwd=REPO_ROOT
    )
    if result.stdout.strip():
        log("critico", "obsidian_tracked",
            ".obsidian/ está en git. Fix: git rm -r --cached .obsidian/ + corregir .gitignore")
    else:
        log("ok", "obsidian_tracked", ".obsidian/ no trackeado")


def check_duplicate_folders():
    """Detecta carpetas duplicadas conocidas."""
    duplicates = [
        (["diarios", "docs/diarios"], "diarios raíz deprecated — usar docs/diarios/"),
        (["osint", "osint-stack"], "osint/ y osint-stack/ sin diferencia documentada"),
        (["infra", "docs/infra"], "infra/ raíz vs docs/infra/ — separación no documentada"),
        (["agentes", "docs/agentes"], "agentes/ raíz vs docs/agentes/ — verificar propósito"),
    ]
    for folders, msg in duplicates:
        existing = [f for f in folders if (REPO_ROOT / f).exists()]
        if len(existing) > 1:
            log("warning", "duplicate_folders", f"Duplicado: {existing} — {msg}")
        else:
            log("ok", "duplicate_folders", f"Sin duplicado en: {folders[0]}")


def check_root_bloat():
    """Detecta demasiados .md en la raíz."""
    root_mds = [
        f.name for f in REPO_ROOT.iterdir()
        if f.is_file() and f.suffix == ".md" and f.name not in ROOT_WHITELIST
    ]
    total = len([f for f in REPO_ROOT.iterdir() if f.is_file() and f.suffix == ".md"])
    if total > MAX_ROOT_MD:
        log("warning", "root_bloat",
            f"{total} .md en raíz (máx {MAX_ROOT_MD}). Mover: {root_mds}")
    else:
        log("ok", "root_bloat", f"{total} .md en raíz — dentro del límite")


def check_orphan_folders():
    """Detecta carpetas sin README.md."""
    orphans = []
    skip = [".git", ".github", ".obsidian", "inbox", "inbox/procesado"]
    for d in REPO_ROOT.iterdir():
        if d.is_dir() and d.name not in skip and not d.name.startswith("."):
            has_readme = (d / "README.md").exists()
            if not has_readme:
                orphans.append(d.name)
    if orphans:
        log("warning", "orphan_folders",
            f"Carpetas sin README.md: {orphans}")
    else:
        log("ok", "orphan_folders", "Todas las carpetas tienen README.md")


def check_inbox_age():
    """Detecta ficheros en inbox/ con más de 48h sin procesar."""
    inbox = REPO_ROOT / "inbox"
    old_files = []
    now = datetime.now()
    for f in inbox.iterdir():
        if f.is_file() and f.name != "README.md":
            age = now - datetime.fromtimestamp(f.stat().st_mtime)
            if age > timedelta(hours=INBOX_MAX_AGE_HOURS):
                old_files.append(f"{f.name} ({int(age.total_seconds()/3600)}h)")
    if old_files:
        log("warning", "inbox_age",
            f"Ficheros inbox sin procesar > {INBOX_MAX_AGE_HOURS}h: {old_files}")
    else:
        log("ok", "inbox_age", "Inbox limpia o ficheros recientes")


def check_authorship():
    """Verifica que todo .md tenga frontmatter con author y creado."""
    missing = []
    for md in REPO_ROOT.rglob("*.md"):
        if ".git" in str(md) or "procesado" in str(md):
            continue
        content = md.read_text(encoding="utf-8", errors="ignore")
        if not ("author:" in content and "creado:" in content):
            missing.append(str(md.relative_to(REPO_ROOT)))
    if missing:
        log("warning", "authorship",
            f"{len(missing)} ficheros sin bloque autoría. Primeros 5: {missing[:5]}")
    else:
        log("ok", "authorship", "Todos los .md tienen bloque de autoría")


def summary_report():
    """Genera resumen final."""
    print("\n" + "="*50)
    print(f"REPO-AUDIT RESUMEN — {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    print("="*50)
    print(f"🔴 CRÍTICOS : {len(results['critico'])}")
    print(f"⚠️  WARNINGS : {len(results['warning'])}")
    print(f"✅ OK       : {len(results['ok'])}")
    return results


if __name__ == "__main__":
    print(f"🔍 Iniciando repo-audit en {REPO_ROOT}\n")
    check_obsidian_tracked()
    check_duplicate_folders()
    check_root_bloat()
    check_orphan_folders()
    check_inbox_age()
    check_authorship()
    summary_report()
```

---

## Evolución futura — Delegación a LLMs

```python
# Módulo futuro: delegar fixes a modelos según severidad
def delegate_fix(check_result):
    if check_result["level"] == "critico":
        # Notificar a humano vía Telegram (TOKI-DEW)
        send_telegram_alert(check_result)
    elif check_result["level"] == "warning":
        # Ollama local genera PR con fix propuesto
        ollama_generate_fix(check_result)
        # O Perplexity busca best practice y propone solución
        perplexity_research_fix(check_result)
```

---

## Integración GitHub Actions

```yaml
# .github/workflows/repo-audit.yml
name: Repo Audit
on:
  push:
    branches: [main]
  schedule:
    - cron: '0 23 * * *'  # cron diario 23:00

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with: {python-version: '3.12'}
      - run: python3 scripts/repo-audit.py
      - name: Create issue if critical
        if: failure()
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: '🔴 repo-audit: discordancias críticas detectadas',
              labels: ['repo-health']
            })
```

---

## Pendientes antes de implementar

- [ ] Labels `repo-health` creadas en GitHub (manual)
- [ ] Script movido a `scripts/repo-audit.py`
- [ ] GitHub Action creado en `.github/workflows/repo-audit.yml`
- [ ] Testar en Acer antes de activar en Actions
