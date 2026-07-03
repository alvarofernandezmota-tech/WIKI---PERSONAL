#!/bin/bash
# Fase 6 — THDORA handlers y Uptime Kuma

set -euo pipefail

REPO_DIR="$HOME/yggdrasil-dew"
THDORA_DIR="$REPO_DIR/thdora"
SCRIPTS_DIR="$REPO_DIR/scripts"

echo "🔄 [08] Fase 6 — THDORA handlers"

if [ ! -d "$THDORA_DIR" ]; then
  echo "❌ No existe directorio THDORA en $THDORA_DIR"
  exit 1
fi

cd "$THDORA_DIR"

echo "→ Actualizando código THDORA desde Git (si aplica)…"
if [ -d .git ]; then
  git pull --rebase || echo "⚠️ No se pudo hacer git pull, revisa manualmente."
fi

echo "→ Verificando presencia de handlers Python…"
if [ ! -f "$SCRIPTS_DIR/thdora-handlers.py" ]; then
  echo "❌ Falta scripts/thdora-handlers.py"
  exit 1
fi

# Aquí asumimos que thdora-handlers.py contiene funciones o clases para:
#   /estado, /inbox, /diario, /pull, /webhook/uptime
# y que el proyecto THDORA expone una API FastAPI.

echo "→ Copiando/actualizando handlers dentro del proyecto THDORA (si aplica)…"
# Este bloque se deja como plantilla: ajusta rutas según tu layout real.
# Ejemplo: copiar thdora-handlers.py a thdora/app/handlers.py
# cp "$SCRIPTS_DIR/thdora-handlers.py" "$THDORA_DIR/app/handlers.py"

echo "⚠️ Ajusta manualmente este script para encajar con la estructura exacta de THDORA."

echo "→ Recordatorio: endpoints a implementar/probar"
echo "   - /estado        → resumen de servicios (Madre, Docker, Tailscale)"
echo "   - /inbox         → listar y procesar inbox/"   
echo "   - /diario        → crear entrada en diarios/"   
echo "   - /pull <modelo> → gestionar ollama pull"
echo "   - /webhook/uptime → recibir alertas de Uptime Kuma"

echo "→ Cuando termines de wiring de handlers, reinicia THDORA y THDORA-bot en Madre."

echo "✅ Fase 6 — THDORA handlers preparados: $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Documenta en MASTER-PENDIENTES.md qué endpoints están listos y probados."
