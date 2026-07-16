# 🏟️ Infra

> Capa transversal de infraestructura del ecosistema: máquinas, red, configs y automatización.

| Campo | Valor |
|---|---|
| **Repos principales** | [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) · [`acer-config`](https://github.com/alvarofernandezmota-tech/acer-config) |
| **Máquinas** | Madre (Madrid) · Acer Thdora (Toledo) · iPhone 11 |
| **Estado operativo** | ✅ Activo · parcialmente hardenizado |
| **Última auditoría** | 2026-07-16 |

---

## 📌 Qué es

Isla transversal que documenta la capa física y de red del ecosistema: máquinas, sistemas operativos, red Tailscale, configuraciones de sistema y repos de configuración. Es la base sobre la que corren todas las demás islas.

---

## 🛠️ Máquinas del ecosistema

| Máquina | Alias | OS | IP Tailscale | Rol | Isla wiki |
|---|---|---|---|---|---|
| Torre de sobremesa | Madre | Arch Linux (Omarchy) | `100.91.112.32` | Servidor 24/7 · Docker · GPU | [madre.md](madre.md) |
| Portátil Acer | Thdora / varopc | Arch Linux + Hyprland | `100.86.119.102` | Terminal dev · OSINT | [acer.md](acer.md) |
| iPhone 11 | móvil | iOS | Tailscale activo | Trabajo remoto · Perplexity MCP | — |
| HP TouchSmart | HP | Linux Mint (pendiente) | — | Dashboard / visualización | — |

---

## 📊 Estado actual

| Área | Estado | Notas |
|---|---|---|
| Red Tailscale | ✅ Activo | Madre + Acer conectados |
| SSH Madre | 🟡 Parcial | Falta `PasswordAuthentication no` |
| SSH Acer | 🟡 Parcial | Pendiente hardening |
| Cursor MCP Acer | 🔴 Pendiente | Token full + `~/.cursor/mcp.json` |
| FTP router Digi | 🔴 EXPUESTO | Puerto 21 — p0 crítico |
| HP TouchSmart | ⏳ Pendiente | Sin OS instalado |

---

## 🗺️ Relaciones con el ecosistema

```
Infra
  ├── base física de → todas las islas
  ├── gestiona configs → madre-config, acer-config
  ├── red privada → Tailscale (WireGuard mesh)
  └── seguridad → isla seguridad.md
```

---

## 🔗 DEW — Issues y decisiones

### Issues activas

| Issue | Título | Prioridad |
|---|---|---|
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Cursor MCP en Acer — token full pendiente | 🟡 Medio |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Tailscale como VPN mesh del ecosistema | ✅ Vigente |
| — | Arch Linux como OS base (Madre + Acer) | ✅ Vigente |
| — | SSH ed25519 only, sin contraseñas | ⏳ Parcialmente implementado |

---

## 📝 Decisiones pendientes

- [ ] SSH hardening completo en Madre y Acer — Fase 2
- [ ] Activar Tailscale en iPhone 11
- [ ] Configurar HP TouchSmart con Linux Mint
- [ ] Completar MCP en Cursor Acer — issue #15

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
