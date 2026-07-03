#!/usr/bin/env python3
"""
Inject Ecosystem Header
Doc: docs/arquitectura/github-action-vs-bot-patron.md

Inyecta el header estándar del ecosistema en archivos nuevos
que no lo tienen. Llamado por el workflow new-file-bootstrap.yml
"""
import sys
import argparse
from pathlib import Path


PYTHON_HEADER_TEMPLATE = '''"""
{filename}
Doc: docs/  <- COMPLETAR ruta al doc relacionado
Fase: <- COMPLETAR fase (ej: Fase 5)

Descripción: <- COMPLETAR descripción en una línea
"""
'''

SHELL_HEADER_TEMPLATE = '''#!/usr/bin/env bash
# {filename}
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
'''

YAML_HEADER_TEMPLATE = '''# {filename}
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
'''


def needs_header(content: str) -> bool:
    return "# Doc:" not in content and '"""' not in content[:200]


def inject(file_path: Path):
    content = file_path.read_text(errors="ignore")
    if not needs_header(content):
        return False

    name = file_path.name
    suffix = file_path.suffix

    if suffix == ".py":
        header = PYTHON_HEADER_TEMPLATE.format(filename=name)
    elif suffix == ".sh":
        header = SHELL_HEADER_TEMPLATE.format(filename=name)
        # Eliminar shebang existente si lo tiene
        if content.startswith("#!/"):
            content = "\n".join(content.splitlines()[1:])
    elif suffix == ".yml":
        header = YAML_HEADER_TEMPLATE.format(filename=name)
    else:
        return False

    file_path.write_text(header + content)
    print(f"Header injected: {file_path}")
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--files", default="")
    args = parser.parse_args()

    files = [f.strip() for f in args.files.strip().splitlines() if f.strip()]
    injected = 0
    for f in files:
        path = Path(f)
        if path.exists() and path.suffix in [".py", ".sh", ".yml"]:
            if inject(path):
                injected += 1

    print(f"Headers injected: {injected}/{len(files)} files")


if __name__ == "__main__":
    main()
