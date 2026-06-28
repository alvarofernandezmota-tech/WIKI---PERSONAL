#!/bin/bash
# Verificación completa del sistema tras reboot de Fase 1

echo "🔍 Verificación post-reboot — Madre"
echo "Fecha: $(date '+%d-%m-%Y %H:%M CEST')"
echo ""

PASS=0; FAIL=0

check() {
  local desc="$1"; local cmd="$2"
  if eval "$cmd" > /dev/null 2>&1; then
    echo "  ✅ $desc"; PASS=$((PASS+1))
  else
    echo "  ❌ $desc"; FAIL=$((FAIL+1))
  fi
}

echo "━━ Red ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check "UFW activo"                    "sudo ufw status | grep -q 'Status: active'"
check "Tailscale conectado"           "tailscale status | grep -q '100\\."
check "IP Tailscale = 100.91.112.32" "tailscale ip -4 | grep -q '100.91.112.32'"
check "hostapd (MadreAP) activo"     "systemctl is-active hostapd"
check "dnsmasq activo"               "systemctl is-active dnsmasq"

echo ""
echo "━━ Seguridad ━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check "SSH sin password auth"         "sshd -T | grep -q 'passwordauthentication no'"
check "fail2ban activo"              "systemctl is-active fail2ban"
check "sleep.target masked"          "systemctl status sleep.target | grep -q 'masked'"
check "Driver 8188fu config presente" "[ -f /etc/modprobe.d/8188fu.conf ]"

echo ""
echo "━━ Docker ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check "Docker daemon activo"         "systemctl is-active docker"
check "≥10 contenedores running"     "[ \$(docker ps --filter status=running -q | wc -l) -ge 10 ]"

echo ""
echo "→ Estado contenedores:"
docker ps --format "  {{.Status}}  {{.Names}}" | sort

echo ""
echo "━━ Ollama ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check "Ollama API responde"          "curl -s http://localhost:11434/api/tags"
echo "→ Modelos:"
ollama list 2>/dev/null | sed 's/^/  /' || echo "  (no responde)"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Resultado: ✅ $PASS OK  ❌ $FAIL FALLOS"
[ $FAIL -eq 0 ] && echo "🎉 Sistema completamente operativo" || echo "⚠️  Hay $FAIL checks fallidos"
echo ""
echo "📝 Copia este output a ESTADO-SISTEMA.md"
