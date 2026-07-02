# Auditoría Docker Compose — Madre
#docker #compose #auditoria #madre #infra

**Fecha:** 2026-07-01  
**Estado:** divergencias detectadas, pendiente alinear

---

## Divergencias detectadas

| Servicio | Config repo | Realidad en Madre | Acción |
|---|---|---|---|
| Portainer | `docker-compose.yml` | Running ✅ | OK |
| Grafana | definido | Running ✅ | OK |
| Ollama | definido | Running ✅ | OK |
| Watchtower | definido | Estado desconocido | Verificar |

---

## Pendiente

- [ ] Verificar `docker compose ps` en Madre
- [ ] Alinear `docker/docker-compose.yml` con realidad
- [ ] Documentar puertos expuestos de cada contenedor
- [ ] Revisar restart policies

```bash
# En Madre:
docker compose ps
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```
