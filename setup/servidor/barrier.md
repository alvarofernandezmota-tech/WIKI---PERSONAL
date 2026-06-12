# Input Leap — Servidor (Systemd + UFW)

> Configuración completa de Input Leap como servicio de producción.
> Diseñado por Gemini · Integrado por Perplexity · 12 junio 2026

---

## Arquitectura

```
Ordenador Madre (servidor Input Leap, puerto 24800)
  ├── Acer Aspire  (cliente — IP: 10.176.119.171)
  └── MacBook      (cliente — IP: 10.176.119.229)
```

---

## 1. Archivo systemd

Crea `/etc/systemd/system/input-leap.service`:

```ini
[Unit]
Description=Input Leap Server Service
After=network.target

[Service]
# Ejecutar como usuario sin privilegios por seguridad
User=tu_usuario
Group=tu_usuario
ExecStart=/usr/bin/input-leap-server --no-tray --address :24800 --config /home/tu_usuario/.config/input-leap.conf
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

> ⚠️ Sustituir `tu_usuario` por tu usuario real de Arch.

### Activar el servicio

```bash
# Recargar systemd
sudo systemctl daemon-reload

# Habilitar al arranque
sudo systemctl enable input-leap

# Arrancar ahora
sudo systemctl start input-leap

# Verificar estado
sudo systemctl status input-leap
```

---

## 2. Reglas UFW — Zero Trust

**Filosofía:** bloquear todo, permitir solo las IPs conocidas.

```bash
# Permitir solo desde nodos conocidos
sudo ufw allow in from 10.176.119.171 to any port 24800 proto tcp   # Acer
sudo ufw allow in from 10.176.119.229 to any port 24800 proto tcp   # MacBook

# Bloquear resto de tráfico al puerto
sudo ufw deny 24800/tcp

# Activar UFW si no está activo
sudo ufw enable

# Verificar reglas aplicadas
sudo ufw status verbose
```

> ⚠️ Cuando el Ordenador Madre tenga IP fija, añadir también su IP como origen permitido.

---

## 3. Auditoría — Logs en tiempo real

```bash
# Ver logs del servicio en tiempo real
journalctl -u input-leap -f

# Ver logs de las últimas 24h
journalctl -u input-leap --since "24 hours ago"

# Ver intentos de conexión fallidos (UFW)
sudo journalctl -k | grep UFW
```

> En una entrevista: *"Uso listas blancas de IPs en lugar de dejar puertos abiertos al mundo, y audito conexiones con journalctl. Eso es Zero Trust aplicado en LAN."*

---

## 4. Próximo paso — TLS

Pendiente: cifrar la comunicación con certificados TLS (openssl) para que nadie en la red pueda interceptar las pulsaciones de teclado.

```bash
# Generar certificados (pendiente implementar)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ~/.config/input-leap/server.key \
  -out ~/.config/input-leap/server.crt
```

Estado: ⏳ Pendiente — implementar en Fase 2 (Seguridad)

---

## Estado

| Tarea | Estado |
|---|---|
| Archivo .service creado | ⏳ Pendiente aplicar |
| Reglas UFW configuradas | ⏳ Pendiente aplicar |
| IP fija Madre en router | ⏳ Pendiente |
| TLS habilitado | ⏳ Fase 2 |
| Logs auditados con journalctl | ⏳ Tras activar servicio |
