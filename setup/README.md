# ⚙️ Setup — Infraestructura y Hardware

> Referencia técnica viva del sistema. No es historial — es documentación consultable hoy.
> Actualizar cuando cambie cualquier configuración real.

---

## Máquinas

| Archivo | Máquina | Rol |
|---|---|---|
| [[setup/varopc]] | Acer Theodora | PC desarrollo principal |
| [[setup/madre]] | Servidor Madre | Producción 24/7 |
| [[setup/red]] | Red / Tailscale | Conectividad entre máquinas |

## Estado rápido (20 jun 2026)

| Servicio | Dónde | Estado |
|---|---|---|
| THDORA API + bot | Madre | ✅ healthy |
| Prometheus + Grafana | Madre | ✅ corriendo |
| Tailscale | varopc + Madre | ✅ |
| Ollama | varopc + Madre | ✅ |
| Obsidian | varopc | ✅ instalado |
| Open WebUI | Madre | ⏳ pendiente |
| UFW + fail2ban | Madre | ⏳ pendiente |
| n8n | Madre | ⏳ pendiente |

## Roadmap servidor Madre

```
FASE 1 — Acceso ✅
  ├── Tailscale instalado
  ├── SSH operativo
  └── Docker + thdora en producción

FASE 2 — Seguridad ⏳
  ├── UFW
  ├── fail2ban
  └── wayvnc autostart

FASE 3 — Servicios 🟢
  ├── PostgreSQL
  ├── Open WebUI (RAG sobre yggdrasil-dew)
  ├── Uptime Kuma
  ├── Pi-hole
  └── n8n (diario nocturno automático)
```

---

_Frecuencia: actualizar cuando cambie config real. Ver [[AGENT]] para reglas del sistema._
