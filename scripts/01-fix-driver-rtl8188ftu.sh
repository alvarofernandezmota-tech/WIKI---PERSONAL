#!/bin/bash
# Fix inestabilidad AP — driver RTL8188FTV / 8188fu

set -euo pipefail

echo "🔧 [01] Fix driver RTL8188FTV — MadreAP"

echo "options 8188fu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8188fu.conf
echo "✅ /etc/modprobe.d/8188fu.conf creado"

sudo modprobe -r 8188fu 2>/dev/null || true
sleep 1
sudo modprobe 8188fu
echo "✅ Módulo recargado"

sudo systemctl restart hostapd
sleep 2

STATUS=$(systemctl is-active hostapd)
if [ "$STATUS" = "active" ]; then
  echo "✅ hostapd: ACTIVE"
else
  echo "❌ hostapd: $STATUS"
  journalctl -u hostapd -n 20
  exit 1
fi

ip link show wlan0 | grep -E "state|mtu" || ip link show | grep -E "wlan|wlp"

echo ""
echo "✅ COMPLETADO — $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Marca en PLAN: [x] Fix driver RTL8188FTV"
