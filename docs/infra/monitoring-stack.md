---
tags: [infra, monitoring, grafana, prometheus, wazuh, loki]
fecha-creacion: 2026-06-27
ultima-actualizacion: 2026-07-02
---

# 📊 Stack de Monitorización

## Activo ahora

| Herramienta | Puerto | Estado | Rol |
|---|---|---|---|
| Grafana | 3000 | ✅ up | Dashboards principales |
| Prometheus | 9090 | ✅ up | Métricas contenedores |
| Uptime Kuma | 3002 | ✅ up | Monitor disponibilidad |
| Netdata madre | 19999 | ✅ up | Métricas sistema tiempo real |
| Netdata theodora | 19999 | ✅ up | Métricas theodora |

## Pendiente añadir

| Herramienta | Puerto | Por qué |
|---|---|---|
| Wazuh | 1514/55000 | SIEM + detección intrusiones |
| Suricata | — | IDS pasivo en wlan0 |
| Loki + Promtail | 3100 | Logs contenedores → Grafana |
| AlertManager | 9093 | Alertas Prometheus → Telegram |

## Cadena de alertas objetivo

```
Suricata → Wazuh → AlertManager → Telegram (thdora-bot)
                          ↕
                     Grafana (histórico)
```

## Prereqs pendientes

```bash
# Wazuh requiere:
sudo sysctl -w vm.max_map_count=262144
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf
```

---
_Creado desde inbox 2026-06-27 — Perplexity vía MCP_
