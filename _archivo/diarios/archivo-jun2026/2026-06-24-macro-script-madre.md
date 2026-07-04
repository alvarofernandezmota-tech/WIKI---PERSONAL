---
tags: [inbox, script, madre, docker, ollama, setup, ejecutar]
fecha: 2026-06-24
estado: listo-para-ejecutar
prioridad: maxima
---

# Macro-Script Setup Completo Madre

> Ejecutar en Madre cuando tengas acceso SSH o fisico.
> Un script por fase. Copia, pega, ejecuta. Nada mas.

---

## PRE-REQUISITO — Despertar Madre y evitar suspension

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

---

## FASE 1 — Repo y compose (30 segundos)

```bash
cd ~/yggdrasil-dew && git pull
cp setup/servidor/docker-compose.yml docker-compose.yml
echo "Compose actualizado OK"
```

---

## FASE 2 — Levantar stack Docker (2 minutos)

```bash
docker compose down 2>/dev/null; docker compose up -d
echo "Esperando healthchecks..."
sleep 30
docker compose ps
curl -s http://localhost:11434/api/tags && echo " Ollama OK"
curl -s http://localhost:6333/healthz && echo " Qdrant OK"
curl -s -o /dev/null -w "%{http_code}" http://localhost:3001 && echo " WebUI OK"
```

---

## FASE 3 — Descargar modelos (10-15 minutos, dejar corriendo)

```bash
docker exec -it ollama ollama pull qwen2.5:3b
docker exec -it ollama ollama pull nomic-embed-text
docker exec -it ollama ollama list
```

---

## FASE 4 — Modelfile CPU optimizado

```bash
cat > /tmp/Modelfile << 'EOF'
FROM qwen2.5:3b
PARAMETER num_thread 6
PARAMETER num_gpu 0
PARAMETER num_ctx 4096
EOF
docker cp /tmp/Modelfile ollama:/Modelfile
docker exec -it ollama ollama create qwen2.5:3b-cpu -f /Modelfile
docker exec -it ollama ollama list
echo "Modelfile CPU OK"
```

---

## FASE 5 — Tailscale permanente

```bash
sudo systemctl enable --now tailscaled
sudo systemctl status tailscaled --no-pager
# 1. Ve a https://admin.tailscale.com/settings/keys
# 2. Crea key: Reusable + No expiry
# 3. Pega abajo:
sudo tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX
tailscale status
echo "Tailscale permanente OK"
```

---

## FASE 6 — UFW firewall

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow from 192.168.1.0/24 to any port 3001
sudo ufw allow from 100.64.0.0/10 to any port 3001
sudo ufw allow from 192.168.1.0/24 to any port 11434
sudo ufw allow from 100.64.0.0/10 to any port 11434
sudo ufw --force enable
sudo ufw status
echo "UFW OK"
```

---

## FASE 7 — Open WebUI RAG (manual, 2 minutos)

```
1. Abrir http://localhost:3001
2. Admin Panel > Settings > Documents
3. Vector Database: qdrant
4. Qdrant URL: http://qdrant:6333
5. Embedding Model: nomic-embed-text
6. Chunk Size: 512 / Overlap: 100
7. Guardar
```

---

## VERIFICACION FINAL

```bash
echo "=== DOCKER ==="
docker compose ps
echo "=== MODELOS ==="
docker exec -it ollama ollama list
echo "=== TAILSCALE ==="
tailscale status
echo "=== UFW ==="
sudo ufw status
echo "=== TODO LISTO ==="
```

Exito = 3 servicios healthy + 2 modelos + Tailscale connected + UFW active

---

## CUANDO FUNCIONE — test RAG

```
1. Open WebUI > Workspace > Knowledge > New Collection
2. Subir: inbox/MASTER-PENDIENTES.md
3. Activar collection en chat
4. Preguntar: que tengo pendiente esta semana?
5. Verificar respuesta con contexto real
```

---
_Creado: 24 jun 2026 01:18 | Listo para ejecutar en Madre_
_Ver docs: [[setup/servidor/README.md]]_
