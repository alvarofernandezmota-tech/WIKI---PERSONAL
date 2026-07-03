#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/test-ollama-integration.sh
# VERSION:  1.0.0
# FUNCIÓN:  Prueba de integración Ollama: verifica instalación,
#           modelos disponibles, latencia y calidad básica.
# TIPO:     auditor
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/test-ollama-integration.sh [modelo]
# ============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MODELO="${1:-llama3}"
TS="$(date +%Y%m%d-%H%M%S)"
LOG="$ROOT/inbox/test-ollama-$TS.log"
mkdir -p "$ROOT/inbox" "$ROOT/diary"

log() { echo "[$(date +%H:%M:%S)] [OLLAMA-TEST] $*" | tee -a "$LOG"; }
OK=0; FAIL=0
check() { local desc="$1" result="$2"; if [ "$result" = "0" ]; then log "  ✅ $desc"; OK=$((OK+1)); else log "  ❌ $desc"; FAIL=$((FAIL+1)); fi; }

log "=== TEST INTEGRACIÓN OLLAMA | modelo=$MODELO ==="

# 1. Instalación
if command -v ollama &>/dev/null; then
  log "[1/5] Ollama instalado: $(ollama --version 2>/dev/null || echo 'versión desconocida')"
  check "ollama instalado" 0
else
  log "[1/5] ❌ Ollama NO instalado. Instala desde https://ollama.ai"
  check "ollama instalado" 1
  log "RESULTADO: 0 OK / 1 FAIL — instala Ollama primero"
  exit 1
fi

# 2. Servicio activo
if ollama list &>/dev/null 2>&1; then
  check "ollama service activo" 0
  log "[2/5] Modelos disponibles:"
  ollama list | tee -a "$LOG"
else
  check "ollama service activo" 1
  log "  → Inicia con: ollama serve &"
fi

# 3. Modelo disponible
if ollama list 2>/dev/null | grep -q "$MODELO"; then
  check "modelo $MODELO disponible" 0
else
  log "[3/5] Modelo $MODELO no encontrado. Descargando..."
  if ollama pull "$MODELO" 2>&1 | tee -a "$LOG"; then
    check "modelo $MODELO descargado" 0
  else
    check "modelo $MODELO descargado" 1
  fi
fi

# 4. Latencia
log "[4/5] Midiendo latencia de respuesta..."
START=$(date +%s%N)
RESPUESTA=$(timeout 60 ollama run "$MODELO" "Responde solo: OK" 2>/dev/null || echo "TIMEOUT")
END=$(date +%s%N)
LATENCY=$(( (END - START) / 1000000 ))
log "  Latencia: ${LATENCY}ms"
if [ "$LATENCY" -lt 30000 ]; then
  check "latencia < 30s" 0
else
  check "latencia < 30s (actual: ${LATENCY}ms)" 1
fi

# 5. Calidad básica
log "[5/5] Test de calidad básica..."
PROMPT="En una frase: ¿qué es un repositorio Git? Responde solo la definición."
RESP=$(timeout 60 ollama run "$MODELO" "$PROMPT" 2>/dev/null || echo "TIMEOUT")
if [ -n "$RESP" ] && [ "$RESP" != "TIMEOUT" ]; then
  log "  Respuesta: $RESP"
  check "respuesta no vacía" 0
else
  check "respuesta no vacía" 1
fi

# Reporte
log "=== RESULTADO: $OK OK / $FAIL FAIL ==="
REPORTE="$ROOT/diary/test-ollama-$TS.md"
{
  echo "# Test Ollama Integration"
  echo "**Fecha:** $(date '+%Y-%m-%d %H:%M:%S')"
  echo "**Modelo:** $MODELO"
  echo "**Resultado:** $OK OK / $FAIL FAIL"
  echo "**Latencia:** ${LATENCY}ms"
  echo "**Respuesta calidad:** $RESP"
} > "$REPORTE"

log "  Log:     inbox/test-ollama-$TS.log"
log "  Reporte: diary/test-ollama-$TS.md"
[ "$FAIL" -gt 0 ] && exit 1 || exit 0
