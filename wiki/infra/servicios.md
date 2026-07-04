# 🐳 Servicios — Docker y Aplicaciones

> Todos los servicios que corren en Madre.

---

## Estado de servicios

```bash
# Ver todos los contenedores activos
docker ps

# Ver todos (incluidos parados)
docker ps -a

# Ver uso de recursos
docker stats
```

---

## Servicios documentados

| Servicio | Imagen Docker | Puerto | Función | Estado |
|---|---|---|---|---|
| _pendiente_ | — | — | — | — |

---

## Añadir un nuevo servicio

1. Crear `docker/nombre-servicio/docker-compose.yml`
2. Documentar puerto y función en esta tabla
3. Añadir al backup si tiene datos persistentes → ver [`backups.md`](./backups.md)
4. Documentar en [`operaciones/comandos.md`](../operaciones/comandos.md)
