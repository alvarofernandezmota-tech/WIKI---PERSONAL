# agent-perplexity-informer — Profile

| Campo | Valor |
|---|---|
| Nombre | agent-perplexity-informer |
| Owner | @alvarofernandezmota-tech |
| Tipo | Extractor / Classifier |
| Trigger | Manual / GitHub Actions |
| Input | `inbox/ocr/text/*.txt` |
| Output | `inbox/context/perplexity/*.md` |
| Crítico | No (puede fallar sin bloquear pipeline) |
| Versión | 1.0.0 |
| Creado | 2026-07-04 |
| Dependencias | `tools/perplexity_adapter.py`, Python 3.11+, requests |
