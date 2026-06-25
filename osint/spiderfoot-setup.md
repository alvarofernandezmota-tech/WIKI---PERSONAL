# 🕷️ SpiderFoot — Setup y Error Resolution

> Migrado: 2026-06-25
> Origen: `inbox/2026-06-24-error-spiderfoot-descarga.md`

## Error detectado el 2026-06-24
Error al descargar/instalar SpiderFoot por conflicto de dependencias Python.

## Solución: Docker oficial

```bash
# Opción recomendada: imagen Docker
docker run -p 5001:5001 -d smicallef/spiderfoot

# Con volumen para persistir datos
docker run -p 5001:5001 -v /opt/spiderfoot:/var/lib/spiderfoot -d smicallef/spiderfoot
```

## Acceso
- Web UI: `http://localhost:5001`
- Crear nuevo scan → introducir objetivo → seleccionar módulos OSINT

## Integración con el stack
- Añadir al `docker-compose-final.yml` como servicio `spiderfoot`
- Ver: `setup/docker-compose-final.md`

## Módulos clave para nuestro uso
- `sfp_shodan` — dispositivos IoT expuestos
- `sfp_camera` — cámaras IP
- `sfp_dns*` — reconocimiento DNS
- `sfp_whois` — información de dominios

## Estado
- [ ] Desplegar con Docker
- [ ] Integrar en compose
- [ ] Primera búsqueda de prueba
