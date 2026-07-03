#!/bin/bash
# Fase 8 — Seguridad Acer (theodora)

set -euo pipefail

echo "🔄 [09] Fase 8 — Seguridad Acer (theodora)"

# Este script está pensado para ejecutarse EN EL PORTÁTIL (theodora).
# Aplica tareas listadas en MASTER-PENDIENTES.md para seguridad Acer.

# 1. Prey (rastreo antirrobo)
echo "→ Comprobando si Prey está instalado…"
if ! command -v prey >/dev/null 2>&1; then
  echo "⚠️ Prey no está instalado. Instálalo siguiendo la guía oficial (Linux)."
else
  echo "✅ Prey instalado. Verifica configuración de cuenta en su panel web."
fi

# 2. Computrace en BIOS (solo se puede verificar parcialmente desde Linux)
echo "→ Intentando detectar referencias a Computrace en BIOS…"
if command -v dmidecode >/dev/null 2>&1; then
  sudo dmidecode -t bios | grep -i -E "computrace|Absolute" || echo "⚠️ No se encontraron referencias a Computrace en la salida de dmidecode."
else
  echo "⚠️ dmidecode no disponible. Instala dmidecode para continuar con esta comprobación."
fi

# 3. Número de serie del sistema
echo "→ Obteniendo número de serie del sistema…"
if command -v dmidecode >/dev/null 2>&1; then
  sudo dmidecode -t system | grep -i Serial || echo "⚠️ No se pudo obtener el número de serie con dmidecode."
else
  echo "⚠️ dmidecode no disponible para extraer número de serie."
fi

# 4. SSH hardening theodora (recordatorio)
echo "→ Recordatorio SSH Acer:"
echo "   - Usar solo autenticación por clave pública."
echo "   - Asegurar que ~/.ssh/authorized_keys tiene la clave correcta."
echo "   - Revisar /etc/ssh/sshd_config para desactivar PasswordAuthentication si aplica."

echo "✅ Fase 8 — Seguridad Acer (theodora) revisada: $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Documenta resultados en ESTADO-SISTEMA.md y MASTER-PENDIENTES.md (sección Seguridad Acer)."
