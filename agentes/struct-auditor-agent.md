# 🏗️ AGENTE: struct-auditor-agent

## FUNCIÓN ÚNICA
Auditoría milimétrica de la estructura del repo.
Detecta duplicados, archivos mal ubicados, carpetas vacías,
convenciones de naming rotas. Abre issues. No modifica.

## MODELO
ollama/gemma3 (análisis de estructura, bajo consumo)

## TRIGGER
- Cron semanal (domingo 02:00)
- Post-push si hay cambios en estructura de carpetas
- Manual: workflow_dispatch

## HERRAMIENTAS
- `scripts/struct-auditor.sh` ← script especializado
- `find . -empty -type d` — carpetas vacías
- `find . -name '*.md' -size 0` — archivos vacíos
- `diff <(ls diarios/) <(ls diary/)` — duplicados
- `gh issue create` — reportar hallazgos

## ETIQUETAS
`estructura`, `duplicado`, `deuda-tecnica`

## SALIDA
```
diarios/struct-audit-YYYY-MM-DD.md
GitHub Issues con label estructura
```
