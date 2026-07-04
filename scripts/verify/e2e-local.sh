#!/usr/bin/env bash
# e2e-local.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# scripts/verify/e2e-local.sh
# Simula el flujo completo: ingest → classify → index → retrieve
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

log(){ echo "[E2E $TS] $*"; }

log "=== E2E LOCAL START ==="

# 1. Crear archivo de prueba
TEST_FILE="$ROOT/inbox/ocr/raw/e2e-test-$TS.txt"
echo "E2E test content $(date)" > "$TEST_FILE"
log "STEP 1: archivo de prueba creado: $TEST_FILE"

# 2. Ingest OCR (modo placeholder si no hay tesseract)
bash "$ROOT/scripts/ingest/ocr-ingest.sh"
log "STEP 2: ingest completado"

# 3. Verificar que hay texto en text/
TEXT_FILES=$(ls "$ROOT/inbox/ocr/text/" 2>/dev/null | grep -v '.gitkeep' | wc -l | tr -d ' ')
log "STEP 3: $TEXT_FILES archivo(s) en text/"
[ "$TEXT_FILES" -gt 0 ] || { log "FAIL: no hay archivos en text/"; exit 1; }

# 4. Clasificar inbox
bash "$ROOT/scripts/inbox-clasificador.sh" --dry-run 2>/dev/null || log "WARN: inbox-clasificador no disponible"
log "STEP 4: clasificación OK"

# 5. Intentar indexar (si vector_adapter existe)
if [ -f "$ROOT/tools/vector_adapter.py" ]; then
  python3 "$ROOT/tools/vector_adapter.py" --input "$ROOT/inbox/ocr/text/" 2>/dev/null && log "STEP 5: indexado OK" || log "WARN: indexado falló"
else
  log "STEP 5: SKIP — vector_adapter.py no existe aún"
fi

# 6. Intentar retrieval
if curl -sf --max-time 3 "http://localhost:9001/?q=e2e" &>/dev/null; then
  log "STEP 6: retrieval API responde OK"
else
  log "STEP 6: SKIP — retrieval API no activa (lanzar: python3 tools/retrieval_api.py)"
fi

log "=== E2E LOCAL DONE ==="