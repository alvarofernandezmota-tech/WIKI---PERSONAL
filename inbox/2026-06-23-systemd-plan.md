---
tags: [inbox, systemd, ollama, local-brain, arranque, arch, pendiente-implementar]
fecha: 2026-06-23
estado: pendiente-implementar
destino: tools/systemd/
relacionado-anterior: [[inbox/2026-06-23-yggdrasil-v4-diario-maestro]]
bloqueado-por: Ollama descargando
ruta-obsidian: inbox/2026-06-23-systemd-plan.md
---

# Systemd — Arranque Automático Ollama + Local Brain

> Implementar después de validar Ollama y local-brain v4 funcionando.
> Crear en `tools/systemd/`.

## Archivos a crear

```
tools/systemd/
├── ollama.service
├── local-brain.service
└── README.md
```

## ollama.service

```ini
[Unit]
Description=Ollama LLM Server
After=network.target

[Service]
Type=simple
User=varo14f
Environment=OLLAMA_KEEP_ALIVE=10m
Environment=OLLAMA_HOST=127.0.0.1:11434
ExecStart=/usr/local/bin/ollama serve
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## local-brain.service

```ini
[Unit]
Description=Yggdrasil Local Brain RAG v4
After=network.target ollama.service
Requires=ollama.service

[Service]
Type=simple
User=varo14f
WorkingDirectory=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain
EnvironmentFile=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain/.env
# Health check: esperar hasta que Ollama responda
ExecStartPre=/bin/bash -c 'until curl -sf http://localhost:11434/api/tags > /dev/null; do sleep 2; done'
ExecStart=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain/.venv/bin/uvicorn main:app --host 127.0.0.1 --port 8001 --workers 1
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## Instalación

```bash
# Copiar los unit files
sudo cp tools/systemd/ollama.service /etc/systemd/system/
sudo cp tools/systemd/local-brain.service /etc/systemd/system/

# Habilitar y arrancar
sudo systemctl daemon-reload
sudo systemctl enable ollama local-brain
sudo systemctl start ollama
# local-brain arranca solo después de ollama (Requires=)

# Verificar
sudo systemctl status ollama
sudo systemctl status local-brain
journalctl -u local-brain -f
```

## Checklist

- [ ] Validar Ollama funcionando manualmente primero
- [ ] Validar local-brain v4 funcionando manualmente
- [ ] Crear `tools/systemd/` con los dos unit files
- [ ] Instalar y testear arranque desde cero (reboot)
