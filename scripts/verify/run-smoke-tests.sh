#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"

echo "=== Smoke Tests ==="

echo "1. Check MCP HTTP (expects JSON response)"
curl -s -X POST http://localhost:8080 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${MCP_API_TOKEN:-}" \
  -d '{"tool":"orquestador_total","arguments":{}}' | jq '.' || echo 'WARN: MCP not running'

echo "2. Check OCR output folder"
ls "$ROOT/inbox/ocr/text" 2>/dev/null | head -n5 || echo 'WARN: no OCR outputs'

echo "3. Check meta-deep reports"
ls "$ROOT/reports/meta-deep" 2>/dev/null | head -n5 || echo 'WARN: no meta-deep reports'

echo "4. Check agent-ocr-auditor reports"
ls "$ROOT/reports/agent-ocr-auditor" 2>/dev/null | head -n5 || echo 'WARN: no OCR audit reports'

echo "5. Check context/perplexity outputs"
ls "$ROOT/inbox/context/perplexity" 2>/dev/null | head -n5 || echo 'WARN: no perplexity context'

echo "=== Smoke Tests Done ==="
