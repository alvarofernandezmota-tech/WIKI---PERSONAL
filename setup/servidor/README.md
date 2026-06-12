# Servidor Casa — Documentación

> Última actualización: 12 junio 2026

---

## Arquitectura general

```
┌─────────────────────────────────────────────────────┐
│  RED LOCAL (LAN)                                    │
│                                                     │
│  Router ISP                                         │
│  └── Switch/WiFi                                    │
│       ├── ORDENADOR MADRE  (servidor + workstation) │
│       │    IP: TODO                                 │
│       │    OS: Omarchy (Arch + Hyprland + Wayland)  │
│       │    Rol: servidor principal + trabajo diario │
│       │                                             │
│       ├── ACER Aspire      (servidor secundario)    │
│       │    IP: 10.176.119.171                       │
│       │    OS: Omarchy (Arch + Hyprland + Wayland)  │
│       │    Rol: 24/7 siempre encendido              │
│       │                                             │
│       ├── MacBook          (cliente)                │
│       │    IP: 10.176.119.229                       │
│       │    Rol: portátil, Input Leap cliente        │
│       │                                             │
│       └── HP TouchSmart    (monitor secundario)     │
│            Rol: logs, dashboards, pantalla extra    │
└─────────────────────────────────────────────────────┘
```

---

## Archivos de esta sección

```
setup/servidor/
├── README.md          → este archivo — visión general
├── lan.md             → arquitectura de red, IPs, DNS local
├── servicios.md       → qué corre en cada máquina
├── barrier.md         → teclado/ratón compartido (Input Leap)
├── ollama.md          → LLM local
└── docker-compose.yml → servicios en contenedores (TODO)
```

---

## Estado actual

| Servicio | Máquina | Estado |
|---|---|---|
| Input Leap | Acer (servidor) → MacBook (cliente) | ✅ Funcionando |
| Ollama | Ordenador Madre | ⏳ Pendiente instalar |
| PostgreSQL | Acer | ⏳ Pendiente configurar |
| Nextcloud | Acer | ⏳ Pendiente |
| Pi-hole | TODO | ⏳ Pendiente |
| WireGuard VPN | TODO | ⏳ Futuro |

---

## Decisiones tomadas

- **Ordenador Madre = servidor principal + workstation** — una máquina para todo
- **Acer = servidor 24/7** — siempre encendido para servicios que no pueden parar
- **Docker** para todos los servicios — fácil de replicar, actualizar y documentar
- **IP fija local** para Madre y Acer — configurar en el router

---

_Ver también: `setup/equipos.md` | `setup/servicios.md` | `agentes/gemini.md`_
