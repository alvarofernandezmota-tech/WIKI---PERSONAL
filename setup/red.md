# 🌐 Red — Tailscale y conectividad

---
tags: [setup, red, tailscale, network]
fecha-actualizacion: 2026-06-20
---

## Qué es

Tailscale crea una red P2P cifrada entre varopc y Madre.
Es la forma **principal y recomendada** de conectar las máquinas — incluso si están en la misma LAN.

## IPs Tailscale

| Máquina | IP Tailscale | IP Local LAN |
|---|---|---|
| Madre | `100.91.112.32` | `10.134.31.228` |
| varopc (Acer Theodora) | `100.86.119.102` | `10.134.31.171` |

## Problema conocido — AP Isolation

**Síntoma:** lan-mouse y herramientas UDP LAN no funcionan entre varopc y Madre.

**Causa:** el router tiene **AP Isolation** activado — bloquea tráfico UDP directo entre dispositivos de la misma LAN.

**Solución:** usar siempre Tailscale (P2P, cifrado, atraviesa AP Isolation).

```bash
# ✅ Correcto — siempre por Tailscale
ssh alvaro@100.91.112.32

# ❌ Evitar — puede fallar por AP Isolation
ssh alvaro@10.134.31.228
```

## Verificar conectividad

```bash
# Desde varopc — ver máquinas en la red Tailscale
tailscale status

# Ping a Madre por Tailscale
ping 100.91.112.32

# Si necesitas la IP local de Madre (para casos puntuales)
ip neigh | grep -v FAILED
arp -a
```

## Estado

- [x] Tailscale instalado en varopc
- [x] Tailscale instalado en Madre
- [x] SSH varopc → Madre operativo
- [ ] Dominio / subdomain configurado (pendiente)
- [ ] HP TouchSmart en Tailscale (pendiente — equipo en rescate)

---

_Ver también: [[setup/varopc]] · [[setup/madre]] · [[HOME]]_
