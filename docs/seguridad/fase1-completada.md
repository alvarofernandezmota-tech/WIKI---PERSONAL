# Fase 1 — Seguridad de red: COMPLETADA
#seguridad #fase1 #ssh #ufw #tailscale

**Fecha de completado:** 2026-06-28 23:11 CEST
**Ejecutado en:** Madre (varpc, Arch Linux)

---

## Checklist Fase 1 — Todo ✅

| Tarea | Estado | Fecha |
|---|---|---|
| UFW activo — deny incoming, allow outgoing | ✅ | 28-jun |
| UFW reglas — 15 puertos LAN + Tailscale `100.64.0.0/10` | ✅ | 28-jun |
| fail2ban sshd — `maxretry:5 bantime:86400` | ✅ | 28-jun |
| SSH `PasswordAuthentication no` | ✅ | 28-jun |
| SSH `PubkeyAuthentication yes` | ✅ | 28-jun |
| tailscaled autoarranque (`systemctl enable tailscaled`) | ✅ | 01-jul |
| Suspensión desactivada (sleep/suspend/hibernate masked) | ✅ | 01-jul |
| Wazuh prereq `vm.max_map_count=262144` | ✅ | 01-jul |
| SSH clave ed25519 Acer→Madre | ✅ | 01-jul |
| dnsmasq DHCP en wlan0 | ✅ | 28-jun |
| Puerto 53 UFW wlan0 abierto (DNS clientes AP) | ✅ | 28-jun |
| Madre reboot limpio post-fase1 | ✅ | 28-jun |
| Script `06-verificacion-post-reboot.sh` | ✅ | 28-jun |
| SSH `PasswordAuthentication` desactivada definitivo | ❌ **pendiente 01-jul** | — |

---

## Fase 2 — Siguiente

```bash
# Verificación post-reboot
bash scripts/06-verificacion-post-reboot.sh

# Levantar stack Docker completo
bash scripts/04-fase2-start-batcueva.sh

# Modelos Ollama
bash scripts/05-fase7-ollama-pull.sh
```

> Ver: [`PLAN-SEGURIDAD-Y-DESPLIEGUE.md`](../../PLAN-SEGURIDAD-Y-DESPLIEGUE.md)
