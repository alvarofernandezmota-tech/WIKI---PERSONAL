#!/usr/bin/env bash
# daily-sync.sh — Sync diario yggdrasil-dew con GitHub
# Uso: bash setup/scripts/daily-sync.sh "mensaje opcional"
# Última actualización: 17 junio 2026

set -e

MSG=${1:-"vault: daily sync $(date '+%Y-%m-%d %H:%M')"}

echo "🔄 Sincronizando yggdrasil-dew con GitHub..."

git pull --rebase origin main
git add -A
git diff --cached --quiet && echo "✅ Nada que commitear." && exit 0
git commit -m "$MSG"
git push origin main

echo "✅ Sync completado: $MSG"
