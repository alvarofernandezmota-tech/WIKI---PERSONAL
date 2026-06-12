# LAN — Arquitectura de Red

> Última actualización: 12 junio 2026

---

## Mapa de red

```
Internet
   │
 Router ISP
   │  Red: TODO (ej: 192.168.1.0/24)
   │
   ├── Ordenador Madre    IP fija: TODO  (workstation + servidor)
   ├── Acer Aspire        IP fija: 10.176.119.171  (servidor 24/7)
   ├── MacBook            IP: 10.176.119.229  (cliente)
   └── HP TouchSmart      IP: TODO  (monitor/dashboard)
```

---

## IPs del sistema

| Equipo | IP actual | IP fija asignada | Notas |
|---|---|---|---|
| Ordenador Madre | TODO | TODO | Configurar IP fija en router |
| Acer Aspire | 10.176.119.171 | TODO | Servidor 24/7 |
| MacBook | 10.176.119.229 | — | Portátil, puede cambiar |
| HP TouchSmart | TODO | — | Dashboard |

> ⚠️ **Pendiente:** asignar IPs fijas en el router para Madre y Acer. Sin IP fija los servicios se rompen al reiniciar.

---

## DNS local (futuro)

Con Pi-hole o AdGuard Home se puede tener DNS local:

```
madre.local    → IP del Ordenador Madre
acer.local     → IP del Acer
ollama.local   → servicio Ollama en Madre
```

---

## Puertos usados

| Puerto | Servicio | Máquina | Protocolo |
|---|---|---|---|
| 24800 | Input Leap / Barrier | Acer (servidor) | TCP |
| 11434 | Ollama API | Madre | HTTP |
| 8080 | Open WebUI | Madre | HTTP |
| 5432 | PostgreSQL | Acer | TCP |
| 53 | Pi-hole DNS | TODO | UDP/TCP |
| 51820 | WireGuard VPN | TODO | UDP |

---

## Seguridad básica

- [ ] IPs fijas para servidores
- [ ] Firewall (nftables/ufw) en Madre y Acer
- [ ] Barrier/Input Leap con TLS activado
- [ ] PostgreSQL solo accesible en red local
- [ ] WireGuard para acceso externo (no exponer puertos al exterior sin VPN)

---

_Ver también: `setup/servidor/README.md` | `setup/servidor/barrier.md`_
