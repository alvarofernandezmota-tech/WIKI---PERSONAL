# ⌨️ Comandos Frecuentes

> Referencia rápida de comandos organizados por área. Si ejecutas un comando más de 3 veces, añádelo aquí.

---

## Conexión a Madre

```bash
# Conectar por Tailscale
ssh alvaro@100.91.112.32

# Si tienes ~/.ssh/config configurado con alias 'madre'
ssh madre

# Ejecutar un comando remoto sin entrar
ssh alvaro@100.91.112.32 "docker ps"
ssh alvaro@100.91.112.32 "df -h"
```

---

## Diagnóstico del sistema

```bash
# Ver estructura de carpetas (3 niveles)
find /home -maxdepth 3 -type d

# Ver uso de disco
df -h

# Ver procesos consumiendo RAM
ps aux --sort=-%mem | head -20

# Ver logs del sistema
journalctl -f
journalctl -u nombre-servicio -n 100
```

---

## Docker

```bash
# Ver contenedores activos
docker ps

# Ver todos (incluidos parados)
docker ps -a

# Iniciar / parar servicio
docker start nombre
docker stop nombre

# Ver logs en tiempo real
docker logs nombre -f --tail 50

# Entrar en un contenedor
docker exec -it nombre bash

# Reiniciar todo docker-compose
docker compose down && docker compose up -d
```

---

## Git / GitHub

```bash
# Push rápido con mensaje
git add -A && git commit -m "mensaje" && git push

# Ver estado
git status
git log --oneline -10

# Crear rama de trabajo
git checkout -b feature/nombre
```

---

## Tailscale

```bash
# Ver dispositivos conectados
tailscale status

# Ver mi IP de Tailscale
tailscale ip

# Activar Tailscale
sudo tailscale up
```
