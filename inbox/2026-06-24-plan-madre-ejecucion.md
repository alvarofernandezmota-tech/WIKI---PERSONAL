---
tags: [inbox, plan, madre, docker, ollama, ejecucion, pendiente]
fecha: 2026-06-24
estado: pendiente
prioridad: maxima
---

# Plan Ejecucion Madre — Stack IA Completo

> Ejecutar en Madre en orden exacto cuando llegues a casa.
> Docs en [[setup/servidor/README.md]]

---

## PASO 1 — Traer repo

```bash
cd ~/yggdrasil-dew && git pull
```

## PASO 2 — Levantar stack optimizado

```bash
docker compose down
cp setup/servidor/docker-compose.yml docker-compose.yml
docker compose up -d
docker compose ps
curl http://localhost:11434/api/tags
curl http://localhost:6333/healthz
```

## PASO 3 — Descargar modelos

```bash
docker exec -it ollama ollama pull qwen2.5:3b
docker exec -it ollama ollama pull nomic-embed-text
```

qwen2.5:3b ~2GB | nomic-embed-text ~270MB | tiempo: 5-15 min

## PASO 4 — Modelfile CPU

```bash
cat > /tmp/Modelfile << 'EOF'
FROM qwen2.5:3b
PARAMETER num_thread 6
PARAMETER num_gpu 0
PARAMETER num_ctx 4096
EOF
docker cp /tmp/Modelfile ollama:/Modelfile
docker exec -it ollama ollama create qwen2.5:3b-cpu -f /Modelfile
```

## PASO 5 — Open WebUI: conectar Qdrant

1. Abrir http://localhost:3001
2. Admin Panel > Settings > Documents
3. Vector Database: qdrant
4. Qdrant URL: http://qdrant:6333
5. Embedding Model: nomic-embed-text
6. Chunk Size: 512 / Overlap: 100
7. Guardar

## PASO 6 — Tailscale permanente

```bash
sudo systemctl enable --now tailscaled
# Genera authkey en https://admin.tailscale.com/settings/keys
# Marca: Reusable + No expiry
sudo tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX
tailscale status
```

## PASO 7 — UFW

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow from 192.168.1.0/24 to any port 3001
sudo ufw allow from 100.64.0.0/10 to any port 3001
sudo ufw allow from 192.168.1.0/24 to any port 11434
sudo ufw allow from 100.64.0.0/10 to any port 11434
sudo ufw enable && sudo ufw status
```

## PASO 8 — Test RAG end-to-end

1. Open WebUI > Workspace > Knowledge > New Collection
2. Subir MASTER-PENDIENTES.md
3. Chat con collection activa, preguntar algo del contenido
4. Verificar respuesta con RAG

## Verificacion final

```bash
docker compose ps
tailscale status
sudo ufw status
docker exec -it ollama ollama list
```

Exito = 3 servicios healthy + RAG funciona + Tailscale sobrevive reboot

---
_Creado: 24 jun 2026 01:11_
