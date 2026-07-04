# 💾 Backups — Estrategia de Copias de Seguridad

---

## Qué se hace backup

| Dato | Frecuencia | Destino | Método |
|---|---|---|---|
| Volúmenes Docker | Diario | _pendiente_ | rsync / borgbackup |
| Wiki (este repo) | Cada commit | GitHub | git push |
| Configuraciones | Semanal | _pendiente_ | _pendiente_ |

---

## Comandos de backup manual

```bash
# Backup de un volumen Docker
docker run --rm -v nombre_volumen:/data -v $(pwd):/backup alpine \
  tar czf /backup/volumen-$(date +%Y%m%d).tar.gz -C /data .

# Verificar integridad de backup
tar tzf volumen-YYYYMMDD.tar.gz | head -20
```

---

## Restauración

_Documentar aquí el proceso de restauración cuando se pruebe por primera vez._
