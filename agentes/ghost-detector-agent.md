# 👻 AGENTE: ghost-detector-agent

## FUNCIÓN ÚNICA
Detectar archivos fantasma: vacíos, huérfanos, sin referencias,
referenciados en docs pero inexistentes en disco, o duplicados
con diferentes nombres.

## MODELO
ollama/gemma3 (análisis rápido)

## TRIGGER
- Cron semanal
- Tras inbox-cleanup
- Manual

## HERRAMIENTAS
- `scripts/ghost-file-detector.sh` ← script especializado
- `find . -size 0 -name '*.md'` — archivos vacíos
- `find . -name '*.sh' -not -perm /111` — scripts sin ejecutar
- `grep -r 'scripts/' docs/ | grep -v '#'` — referencias
- `gh issue create` — reportar fantasmas

## ETIQUETAS
`estructura`, `deuda-tecnica`

## SALIDA
```
diarios/ghost-detector-YYYY-MM-DD.md
GitHub Issues con label estructura
```
