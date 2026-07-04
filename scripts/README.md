# scripts/ — Guía de uso

## Punto de entrada único
```bash
# Dry-run (muestra qué haría sin ejecutar nada)
bash scripts/maintenance/master_run.sh

# Ejecutar de verdad
bash scripts/maintenance/master_run.sh --apply
```

## Flujo de sesión de trabajo
```bash
# 1. Sincronizar
git pull origin main

# 2. Iniciar logging de terminal
source scripts/session-logger.sh

# 3. Trabajar normalmente...

# 4. Auditoría rápida antes de cerrar
bash scripts/verify/run-smoke-tests.sh

# 5. Generar documento de cierre
bash scripts/session-terminal-doc.sh "descripción de la sesión"

# 6. Subir
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d) — descripción"
git push origin main
```

## Inbox
```bash
# Copiar archivo a zona de aterrizaje y commitear
cp /ruta/archivo.md inbox/drop/
bash scripts/inbox-commit.sh "descripción del archivo"

# Clasificar manualmente sin esperar Actions
bash scripts/inbox-clasificador.sh
```

## Auditoría de estructura
```bash
bash scripts/file-arrival-guardian.sh --dry-run
bash scripts/struct-auditor.sh
bash scripts/verify/run-smoke-tests.sh
```

## Perplexity
```bash
# Requiere PERPLEXITY_URL y PERPLEXITY_API_KEY en entorno
export PERPLEXITY_URL="https://..."
export PERPLEXITY_API_KEY="pplx-..."
bash agentes/agent-perplexity-informer/run.sh
bash scripts/agentes/agente-meta-deep.sh
```

## Mantenimiento
```bash
# Ver qué crearía el parche Perplexity (dry-run)
bash scripts/maintenance/create_perplexity_patch.sh

# Aplicar parche en nueva rama + PR draft
bash scripts/maintenance/create_perplexity_patch.sh --apply
```

## Subdirectorios
| Dir | Contenido |
|---|---|
| `scripts/agentes/` | Scripts de agentes de análisis |
| `scripts/maintenance/` | Scripts de mantenimiento y parches |
| `scripts/verify/` | Smoke tests y verificación |
| `scripts/ci/` | Scripts usados por GitHub Actions |
| `scripts/infra/` | Infraestructura y Docker helpers |
| `scripts/backup/` | Backup y restic |
| `scripts/seguridad/` | Hardening y seguridad |
| `scripts/archive/` | Scripts obsoletos archivados |
