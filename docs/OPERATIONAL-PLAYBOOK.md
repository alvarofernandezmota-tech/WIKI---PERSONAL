# OPERATIONAL-PLAYBOOK.md — Yggdrasil Dew
> Actualizado: 2026-07-04

Manual operativo completo para trabajar con el ecosistema desde terminal.

---

## Flujo diario

### Inicio de sesión
```bash
git pull origin main
source scripts/session-logger.sh
```

### Trabajo normal
- Editar, ejecutar scripts, hacer commits
- Para clasificar inbox: `bash scripts/inbox-clasificador.sh`
- Para auditar estructura: `bash scripts/maintenance/repo_audit_full.sh`

### Cierre de sesión
```bash
bash scripts/session-terminal-doc.sh "descripción de la sesión"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d) — descripción"
git push origin main
```

---

## Flujo de ingest OCR

```bash
# 1. Copiar imagen/PDF a zona de aterrizaje
cp documento.pdf inbox/ocr/raw/

# 2. Lanzar OCR manualmente (hasta que el worker loop esté activo)
bash scripts/ingest/ocr-ingest.sh

# 3. Verificar resultado
ls inbox/ocr/text/

# 4. Indexar
python3 tools/vector_adapter.py --input inbox/ocr/text/

# 5. Probar retrieval
curl 'http://localhost:9001/?q=mi_busqueda'
```

---

## Flujo de corrección de auditoría

```bash
# Auditar
bash scripts/maintenance/repo_audit_full.sh

# Ver qué falta
grep '\[MISSING\]' reports/audit/full-audit-*.md

# Aplicar templates a agentes
for a in agentes/*/; do
  [ -f "${a}PROFILE.md" ] || cp scripts/agentes/agent-templates/PROFILE-TEMPLATE.md "${a}PROFILE.md"
  [ -f "${a}test.sh" ]    || cp scripts/agentes/agent-templates/TEST-TEMPLATE.sh "${a}test.sh" && chmod +x "${a}test.sh"
done

# Commit de correcciones
git add agentes/
git commit -m "chore: PROFILE y test.sh a agentes faltantes"
git push origin main
```

---

## Runbook: CI falla en secret-scan

1. Ver qué detectó: revisar el job en Actions
2. Si es falso positivo: añadir el patrón a `.github/workflows/secret-scan.yml` en la sección `grep -v`
3. Si es real: revocar la clave inmediatamente, limpiar historial con BFG:
```bash
bfg --replace-text secretos.txt
git push origin --force --all
```

---

## Servicios y puertos

| Servicio | Comando de arranque | Puerto |
|---|---|---|
| MCP Server (Python) | `python3 mcp/server.py` | 8000 |
| MCP Server (Node) | `node mcp/server.js` | 3000 |
| Retrieval API | `python3 tools/retrieval_api.py` | 9001 |
| Prometheus Exporter | `python3 tools/prometheus_exporter.py` | 9090 |
| Ollama | `ollama serve` | 11434 |

---

## Estructura de carpetas críticas

```
yggdrasil-dew/
├── inbox/
│   ├── drop/              # Zona de aterrizaje — copiar aquí para que el clasificador actúe
│   ├── ocr/raw/           # PDFs/imágenes esperando OCR
│   ├── ocr/text/          # Textos extraídos
│   ├── ocr/processed/     # Archivos ya procesados
│   ├── context/perplexity/# Contexto exportado desde Perplexity
│   ├── sesiones/          # Cierres de sesión (van a diarios/ via Actions)
│   └── _meta/             # Reportes de auditoría automáticos
├── scripts/
│   ├── ingest/            # OCR y procesamiento
│   ├── agentes/           # Agentes bash
│   ├── verify/            # Tests y validación
│   └── maintenance/       # Auditoría y mantenimiento
├── tools/                 # APIs Python (retrieval, vector, prometheus, auth)
├── mcp/                   # MCP server (Python + Node) y cliente C
├── diarios/               # Destino final de sesiones cerradas
├── reports/               # Reportes generados por scripts
└── .github/workflows/     # CI/CD
```
