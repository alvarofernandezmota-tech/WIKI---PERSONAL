#!/usr/bin/env python3
"""
inbox_migrate.py — Thdora Dev
Migración automática diaria de inbox/ → docs/

Uso:
    python3 scripts/thdora-dev/inbox_migrate.py
    python3 scripts/thdora-dev/inbox_migrate.py --dry-run
    python3 scripts/thdora-dev/inbox_migrate.py --commit

Cron en Madre (06:00 diario):
    0 6 * * * cd /ruta/yggdrasil-dew && python3 scripts/thdora-dev/inbox_migrate.py --commit
"""

import os
import re
import shutil
import argparse
import subprocess
from datetime import datetime
from pathlib import Path

# ─── CONFIG ───────────────────────────────────────────────────────────────────

REPO_ROOT = Path(__file__).resolve().parents[2]
INBOX = REPO_ROOT / "inbox"
PROCESADO = INBOX / "procesado"
DOCS = REPO_ROOT / "docs"

# Reglas de clasificación: (lista de palabras clave) → destino relativo a docs/
CLASIF_RULES = [
    # Prompts → archivo en procesado, no migrar a docs
    (["prompt-gemini", "prompt-"],                          "__procesado__"),

    # Diarios de sesión → docs/diarios/
    (["sesion", "cierre", "tarde", "madrugada",
      "volcado", "diario", "pendientes", "analisis-productividad",
      "plan-vs-ejecutado", "sesion-noche", "sesion-pentest-completa"],
                                                             "diarios"),

    # Infraestructura
    (["compose", "docker", "fase1", "fase2", "fase3",
      "thdora-auditoria", "ap-wifi"],                        "infra"),

    # Seguridad
    (["pentest", "hallazgo", "ssh", "ftp", "hardening",
      "secops", "monitoring", "capas"],                      "seguridad"),

    # Herramientas
    (["ollama", "modelos", "chromium", "herramienta",
      "thdora", "mcp"],                                      "herramientas"),

    # Arquitectura / bots
    (["bots", "telegram", "roadmap", "arquitectura",
      "github-actions"],                                     "arquitectura"),

    # Dispositivos
    (["redmi", "adb", "acer", "bluetooth"],                  "dispositivos"),

    # Auditorías de repo / inbox (meta-docs)
    (["auditoria-inbox", "auditoria-herramientas",
      "auditoria-plan", "auditoria-infraestructura",
      "engineering-excellence"],                             "meta"),
]

# Ficheros que se quedan en inbox/ permanentemente
SKIP = {".gitkeep", "README.md"}

# ─── HELPERS ──────────────────────────────────────────────────────────────────

def extract_date(name: str) -> str | None:
    """Extrae YYYY-MM-DD del nombre del fichero si existe."""
    m = re.search(r"(\d{4}-\d{2}-\d{2})", name)
    return m.group(1) if m else None


def normalize_name(name: str) -> str:
    """Convierte MAYÚSCULAS a lowercase con guiones."""
    return name.lower()


def classify(name: str) -> str:
    """Devuelve la carpeta destino o '__procesado__'."""
    name_lower = name.lower()
    for keywords, dest in CLASIF_RULES:
        if any(kw in name_lower for kw in keywords):
            return dest
    return "diarios"  # fallback: si no encaja, va a diarios


def merge_or_create(dest_path: Path, source_path: Path, label: str) -> None:
    """Si dest existe, añade el contenido al final. Si no, crea el fichero."""
    sep = f"\n\n---\n<!-- merged from {source_path.name} -->\ \n\n"
    content = source_path.read_text(encoding="utf-8")
    if dest_path.exists():
        dest_path.write_text(
            dest_path.read_text(encoding="utf-8") + sep + content,
            encoding="utf-8"
        )
        print(f"  [MERGE]  {source_path.name} → {dest_path.relative_to(REPO_ROOT)}")
    else:
        dest_path.parent.mkdir(parents=True, exist_ok=True)
        dest_path.write_text(content, encoding="utf-8")
        print(f"  [NUEVO]  {source_path.name} → {dest_path.relative_to(REPO_ROOT)}")


# ─── MAIN ─────────────────────────────────────────────────────────────────────

def run(dry_run: bool = False, commit: bool = False) -> None:
    files = sorted(
        f for f in INBOX.iterdir()
        if f.is_file() and f.name not in SKIP
    )

    if not files:
        print("✅ inbox/ vacía — nada que migrar.")
        return

    print(f"📥 Ficheros a procesar: {len(files)}\n")
    moved = []

    for f in files:
        # Normalizar nombre si está en MAYÚSCULAS
        name = normalize_name(f.name)
        if name != f.name and not dry_run:
            f = f.rename(f.parent / name)

        dest_category = classify(name)
        date_str = extract_date(name)

        if dest_category == "__procesado__":
            dest = PROCESADO / name
            if not dry_run:
                PROCESADO.mkdir(parents=True, exist_ok=True)
                shutil.move(str(f), str(dest))
                print(f"  [ARCH]   {name} → inbox/procesado/")
            else:
                print(f"  [DRY]    {name} → inbox/procesado/")
            moved.append(f)
            continue

        # Diarios: merge en docs/diarios/YYYY-MM-DD.md
        if dest_category == "diarios" and date_str:
            dest_path = DOCS / "diarios" / f"{date_str}.md"
        elif dest_category == "diarios":
            # Sin fecha en el nombre: usar fecha de hoy
            today = datetime.now().strftime("%Y-%m-%d")
            dest_path = DOCS / "diarios" / f"{today}.md"
        else:
            # Resto: docs/<categoria>/<nombre>
            dest_path = DOCS / dest_category / name

        if dry_run:
            action = "merge" if dest_path.exists() else "nuevo"
            print(f"  [DRY/{action.upper()}] {name} → {dest_path.relative_to(REPO_ROOT)}")
        else:
            merge_or_create(dest_path, f, dest_category)
            f.unlink()  # eliminar de inbox tras migrar
            moved.append(f)

    print(f"\n✅ Migrados: {len(moved)} ficheros.")

    if commit and moved and not dry_run:
        today = datetime.now().strftime("%Y-%m-%d")
        subprocess.run(["git", "-C", str(REPO_ROOT), "add", "-A"], check=True)
        subprocess.run([
            "git", "-C", str(REPO_ROOT), "commit",
            "-m", f"chore(inbox): migración automática {today} [{len(moved)} ficheros]"
        ], check=True)
        subprocess.run(["git", "-C", str(REPO_ROOT), "push"], check=True)
        print(f"🚀 Commit y push realizados.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Thdora Dev — inbox migrator")
    parser.add_argument("--dry-run", action="store_true",
                        help="Muestra qué haría sin ejecutar nada")
    parser.add_argument("--commit", action="store_true",
                        help="Hace git commit + push al final")
    args = parser.parse_args()
    run(dry_run=args.dry_run, commit=args.commit)
