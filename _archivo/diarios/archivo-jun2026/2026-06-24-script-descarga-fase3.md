---
tags: [inbox, script, descarga, fase3, docker]
fecha: 2026-06-24
destino: setup/servidor/scripts/descarga-fase3.sh
estado: planificado
---

# Script Descarga Fase 3

> Descargar imagenes Fase 3 en segundo plano mientras usas el sistema.

```bash
echo "== DESCARGANDO FASE 3 =="

for img in \
  jc21/nginx-proxy-manager:latest \
  vaultwarden/server:latest \
  containrrr/watchtower:latest \
  n8nio/n8n:latest \
  headscale/headscale:latest \
  gitea/gitea:latest \
  lscr.io/linuxserver/code-server:latest \
  pihole/pihole:latest; do
    until docker pull $img; do
      echo "retry $img..."
      sleep 5
    done
    echo "OK: $img"
done

echo "== FASE 3 IMAGENES OK =="
docker images
```

> Tiempo estimado: 15-30 min dependiendo de conexion.
> Dejar corriendo en tmux: `tmux new -s descargas`

---
_Destino: setup/servidor/scripts/descarga-fase3.sh_
