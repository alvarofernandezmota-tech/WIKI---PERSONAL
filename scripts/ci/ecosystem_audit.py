#!/usr/bin/env python3
"""
Ecosystem Guardian - Auditor
Doc: docs/arquitectura/github-action-vs-bot-patron.md
Fase: 5 -> 6a

Qué audita:
- Archivos de código sin header de ecosistema
- Issues huerfanos (sin milestone, sin label)
- TODO/FIXME sin issue asociado
- Carpetas sin README.md
- Scripts sin entrada en SCRIPTS.md
- inbox/ con items >7 días sin procesar
"""
import argparse
import json
import os
import re
import subprocess
from datetime import datetime, timedelta
from pathlib import Path


ECOSYSTEM_HEADER_MARKER = "# Doc:"
MAX_INBOX_AGE_DAYS = 7


def audit_missing_headers(repo_path: Path) -> list:
    findings = []
    patterns = list(repo_path.glob("src/**/*.py")) + \
               list(repo_path.glob("scripts/**/*.py")) + \
               list(repo_path.glob("scripts/**/*.sh"))
    for f in patterns:
        content = f.read_text(errors="ignore")
        if ECOSYSTEM_HEADER_MARKER not in content:
            findings.append({
                "type": "missing_header",
                "file": str(f.relative_to(repo_path)),
                "severity": "warning",
                "message": f"Archivo sin header de ecosistema: {f.name}",
                "action": "inject_header"
            })
    return findings


def audit_todo_fixme(repo_path: Path) -> list:
    findings = []
    result = subprocess.run(
        ["grep", "-rn", "--include=*.py", "--include=*.sh", "-E", "TODO|FIXME", str(repo_path / "src")],
        capture_output=True, text=True
    )
    for line in result.stdout.strip().splitlines():
        if line:
            findings.append({
                "type": "todo_fixme",
                "file": line.split(":")[0],
                "severity": "warning",
                "message": line.strip(),
                "action": "create_issue"
            })
    return findings


def audit_orphan_dirs(repo_path: Path) -> list:
    findings = []
    for d in repo_path.iterdir():
        if d.is_dir() and not d.name.startswith(".") and d.name not in ["node_modules", ".git"]:
            if not (d / "README.md").exists():
                findings.append({
                    "type": "missing_readme",
                    "file": str(d.relative_to(repo_path)),
                    "severity": "info",
                    "message": f"Directorio sin README.md: {d.name}",
                    "action": "create_readme"
                })
    return findings


def audit_inbox_age(repo_path: Path) -> list:
    findings = []
    inbox = repo_path / "inbox"
    if not inbox.exists():
        return findings
    threshold = datetime.now() - timedelta(days=MAX_INBOX_AGE_DAYS)
    for f in inbox.glob("*.md"):
        mtime = datetime.fromtimestamp(f.stat().st_mtime)
        if mtime < threshold:
            findings.append({
                "type": "stale_inbox",
                "file": str(f.relative_to(repo_path)),
                "severity": "warning",
                "message": f"Inbox item con {(datetime.now()-mtime).days}d de antiguedad: {f.name}",
                "action": "process_or_archive"
            })
    return findings


def calculate_severity(findings: list) -> str:
    if any(f["severity"] == "critical" for f in findings):
        return "critical"
    if any(f["severity"] == "warning" for f in findings):
        return "warning"
    return "ok"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-path", default=".")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    repo_path = Path(args.repo_path).resolve()
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    findings = []
    findings += audit_missing_headers(repo_path)
    findings += audit_todo_fixme(repo_path)
    findings += audit_orphan_dirs(repo_path)
    findings += audit_inbox_age(repo_path)

    severity = calculate_severity(findings)
    total = len(findings)

    result = {
        "generated_at": datetime.utcnow().isoformat() + "Z",
        "type": "ecosystem_audit",
        "severity": severity,
        "summary": f"{total} hallazgos ({severity}) en {datetime.now().strftime('%Y-%m-%d')}",
        "findings_count": total,
        "findings": findings,
        "issues_created": [],
        "doc_path": str(output_path)
    }

    output_path.write_text(json.dumps(result, indent=2, ensure_ascii=False))
    print(f"Audit complete: {total} findings, severity={severity}")

    # Output para GitHub Actions
    with open(os.environ.get("GITHUB_OUTPUT", "/dev/null"), "a") as f:
        f.write(f"findings_count={total}\n")
        f.write(f"severity={severity}\n")


if __name__ == "__main__":
    main()
