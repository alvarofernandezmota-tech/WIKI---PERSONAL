# Tailscale — Red Privada Zero Trust

> Red mesh entre Madre y Acer para IPs estables 100.x.x.x.
> Sustituye IPs DHCP inestables. Base de toda la Fase 1.
> **Frecuencia de actualización: al cambiar nodos o IPs.**
> Última actualización: 12 junio 2026

---

## Arquitectura

```
Madre  (100.x.x.x)  ←→  Tailscale mesh  ←→  Acer (100.x.x.x)
                              ↑
                     MacBook (opcional)
```

Tailscale asigna IPs `100.x.x.x` permanentes a cada nodo.
Estas IPs no cambian aunque el DHCP de la LAN rote.
UFW e Input Leap usan estas IPs — no las de la LAN.

---

## Estado actual

| Nodo | Estado | IP Tailscale |
|---|---|---|
| **Madre** | ⏳ NeedsLogin — pendiente reauth | [anotar tras login] |
| **Acer** | ⏳ Pendiente instalar | [anotar tras login] |

---

## 1. Instalación en MADRE (Omarchy/Arch)

```bash
# Instalar
sudo pacman -Syu tailscale --noconfirm

# Habilitar servicio
sudo systemctl enable --now tailscaled.service

# Levantar y autenticar
sudo tailscale up
```

### Fix: NeedsLogin (token expirado o proceso cancelado)

Si `tailscale ip -4` devuelve `state: NeedsLogin`:

```bash
sudo tailscale up --force-reauth
```

Abre el enlace generado → autoriza en el panel web → vuelve a verificar.

```bash
# Verificar IP asignada
tailscale ip -4
# → IP_TAILSCALE_MADRE: ___________
```

---

## 2. Instalación en ACER (Arch)

```bash
# Instalar (solo crítico, sin entorno dev)
sudo pacman -Syu tailscale --noconfirm

# Habilitar servicio
sudo systemctl enable --now tailscaled.service

# Levantar y autenticar
sudo tailscale up
```

```bash
# Verificar IP asignada
tailscale ip -4
# → IP_TAILSCALE_ACER: ___________
```

---

## 3. Verificación de interconexión

Desde Madre, verificar que ve a Acer:

```bash
tailscale status
# Debe mostrar ambos nodos con sus IPs 100.x.x.x
```

Ping de prueba:

```bash
ping -c 3 <IP_TAILSCALE_ACER>
```

---

## IPs registradas

> Rellenar cuando estén disponibles.

```
IP_TAILSCALE_MADRE = 
IP_TAILSCALE_ACER  = 
```

Estas IPs van a:
- `setup/servidor/barrier.md` → UFW allowlist
- `setup/servidor/lan.md` → mapa de red completo

---

## Siguientes pasos tras completar esto

1. ✅ Tailscale en Madre
2. ✅ Tailscale en Acer
3. → SSH Madre → Acer con IP Tailscale
4. → Input Leap server en Madre, client en Acer
5. → UFW en Acer: solo acepta Input Leap desde IP Tailscale de Madre

---

## Fase 2 — Headscale (self-hosted)

Tailscale usa servidores de coordinación propietarios.
En Fase 2 se sustituye por **Headscale** (open source, self-hosted en Acer).
Los clientes Tailscale siguen funcionando — solo cambia el servidor de coordinación.

---

_Open source: Tailscale cliente (BSD) · Headscale servidor (MIT)_
