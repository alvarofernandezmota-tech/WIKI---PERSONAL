# Hardware del ecosistema

> Dónde físicamente vive todo y cómo se accede.

---

## Dispositivos

### Madre — Servidor casero

| Campo | Valor |
|---|---|
| Rol | Servidor 24/7, base de toda la infraestructura local |
| Ubicación | Casa |
| Acceso | SSH desde Acer / interfaz web |
| OS | Linux (documentar distro) |
| Uptime objetivo | 24/7 |

**Servicios corriendo en Madre** *(documentar en detalle en `infra/`)*

| Servicio | Stack | Puerto | Estado |
|---|---|---|---|
| Ollama | Docker | (documentar) | 🟡 |
| Open WebUI | Docker | (documentar) | 🟡 |
| THDORA bot | Docker/Python | (documentar) | 🟡 |
| OSINT Stack | Docker | (documentar) | 🟡 |
| pgvector / Qdrant | Docker | (documentar) | 🟡 |

**Organización de archivos en Madre** *(a documentar)*
```
/home/alvaro/
  ├── docker/        ← docker-compose de cada servicio
  ├── data/          ← datos persistentes (volumes)
  ├── scripts/       ← scripts de mantenimiento
  └── backups/       ← copias de seguridad
```

---

### Acer — Portátil de trabajo

| Campo | Valor |
|---|---|
| Rol | Máquina de trabajo principal |
| OS | (documentar) |
| Herramientas clave | VSCode, Claude Code, Git, SSH |
| Conexión a Madre | SSH / VPN local |

---

### iPhone — Móvil

| Campo | Valor |
|---|---|
| Rol | Acceso móvil al ecosistema |
| Acceso a Madre | (documentar: VPN / Tailscale / SSH app) |
| Apps clave | Claude app, ChatGPT, Telegram (bot Thdora) |

---

## Red

> Documentar cómo se accede a Madre desde fuera de casa (VPN, Tailscale, port forwarding...)

- Acceso local: red doméstica directa
- Acceso remoto: (documentar)
- Seguridad: ver `docs/seguridad.md`

---

*Última actualización: 2026-07-05 — pendiente completar con datos reales*
