#!/usr/bin/env bash
# agentes/agent-perplexity-informer/test.sh — smoke test
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
TEST_DIR="$ROOT/inbox/ocr/text"
mkdir -p "$TEST_DIR"

echo "Creating test input..."
echo "Test content. PERCENT_COMPLETE: 85% — this is a sample input for testing purposes." \
  > "$TEST_DIR/test-perplexity-sample.txt"

echo "Running agent (PERPLEXITY_URL may not be set — expecting graceful fallback)..."
bash "$(dirname "$0")/run.sh"

OUT="$ROOT/inbox/context/perplexity/test-perplexity-sample.md"
if [ -f "$OUT" ]; then
  echo "PASS: output file created at $OUT"
else
  echo "FAIL: output file not found"
  exit 1
fi

rm -f "$TEST_DIR/test-perplexity-sample.txt" "$OUT" \
  "$ROOT/inbox/context/perplexity/test-perplexity-sample.prompt.txt" 2>/dev/null || true
echo "Cleanup done."
