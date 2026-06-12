# Tailscale — Red Mesh para IPs Fijas

> Solución al problema de IPs dinámicas por WiFi/hotspot.
> Diseñado por Gemini · Integrado por Perplexity · 12 junio 2026
> Aplica en: Ordenador Madre + Acer Aspire

---

## Por qué Tailscale

Sin IPs fijas, Input Leap y SSH se rompen cada vez que cambias de red o usas hotspot.
Tailscale crea una red mesh privada donde cada máquina tiene una IP fija (`100.x.x.x`) que nunca cambia, independientemente de la red a la que esté conectada.

**Cliente Tailscale: open source ✅**
**Servidor de coordinación: propietario ⚠️**
→ Solución 100% open source: **Headscale** (self-hosted) — mismo proceso, añadir `--login-server` al levantar. Ver sección Headscale abajo.

---

## Instalación — igual en Madre y Acer

### 1. Instalar paquete

```bash
sudo pacman -S tailscale
```

### 2. Habilitar servicio con systemd

```bash
# Arrancar ahora y habilitar al inicio (antes de entrar a Hyprland)
sudo systemctl enable --now tailscaled.service

# Verificar que corre
sudo systemctl status tailscaled.service
```

### 3. Autenticación

**Opción A — Tailscale oficial (para empezar rápido):**

```bash
sudo tailscale up
```

Te devuelve un enlace web → ábrelo en el navegador → autoriza el nodo.
Repetir en cada máquina (Madre y Acer).

**Opción B — Headscale self-hosted (100% open source, Fase 2):**

```bash
sudo tailscale up --login-server https://tu-servidor-headscale.dominio
```

### 4. Reglas UFW — Zero Trust

```bash
# Permitir tráfico solo desde dentro de la red Tailscale
# Bloquea WiFi público y hotspot externo automáticamente
sudo ufw allow in on tailscale0
```

---

## Verificar conectividad

```bash
# Ver IPs Tailscale de todas las máquinas
tailscale status

# Ping entre máquinas por IP Tailscale
ping 100.x.x.x
```

Las IPs `100.x.x.x` son permanentes. Anótalas aquí cuando las tengas:

| Máquina | IP Tailscale |
|---|---|
| Ordenador Madre | `100.` — pendiente |
| Acer Aspire | `100.` — pendiente |
| MacBook | `100.` — pendiente |

---

## Usar IPs Tailscale para SSH e Input Leap

Una vez activo, **olvidar las IPs 10.176.x.x** — usar siempre las Tailscale:

```bash
# SSH de Madre a Acer
ssh usuario@IP_TAILSCALE_ACER

# En barrier.md / input-leap.conf
# Cambiar IP del servidor por IP_TAILSCALE_MADRE
```

---

## Headscale — Ruta hacia 100% open source

Headscale es el servidor de coordinación de Tailscale pero self-hosted.
Mismo cliente, mismos comandos, tus datos solo en tu servidor.

```bash
# Instalar Headscale en el Acer (servidor 24/7)
# Ver: https://github.com/juanfont/headscale
yay -S headscale
```

Estado: ⏳ Fase 2 — implementar cuando Tailscale oficial esté estable

---

## Estado

| Tarea | Estado |
|---|---|
| Tailscale instalado en Madre | ⏳ Pendiente |
| Tailscale instalado en Acer | ⏳ Pendiente |
| IPs Tailscale anotadas arriba | ⏳ Pendiente |
| UFW regla `tailscale0` aplicada | ⏳ Pendiente |
| SSH funcionando por IP Tailscale | ⏳ Pendiente |
| Input Leap usando IP Tailscale | ⏳ Pendiente |
| Migrar a Headscale | ⏳ Fase 2 |
