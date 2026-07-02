# Hallazgo — Puerto 21 FTP expuesto en IP pública
#seguridad #hallazgo #pentest #red #router

**Fecha:** 2026-07-01 01:49 CEST
**Severidad:** 🟡 MEDIA (riesgo actual bajo, potencial alto)
**Estado:** ❌ Pendiente cerrar

---

## Datos

```
IP pública:  79.116.247.44 (Digi/Digimobil, dinámica)
Puerto:     21/tcp
Servicio:   FTP
Banner:     421 Service not available, remote server has closed connection
Origen:     Router Digi (no es Docker)
Descubierto: nmap -Pn -sV --open 79.116.247.44
```

## Evaluación

- **Riesgo actual:** BAJO — router rechaza conexiones externas (421)
- **Riesgo potencial:** ALTO — puerto visible = bots lo encuentran en minutos
- **FTP en 2026:** protocolo sin cifrado, credenciales en texto plano

## Buenas noticias del scan

```
Resultado: 999 puertos filtered, 1 puerto abierto

PORT   STATE SERVICE
21/tcp open  ftp?
```

Todos los servicios Docker (Gitea :2222, Thdora :8000, etc.) NO son accesibles desde internet. Solo vía Tailscale. ✅

## Acción requerida

- [ ] Acceder panel router Digi: `http://192.168.1.1` o `http://192.168.72.1`
- [ ] Localizar: `USB Sharing` / `FTP Server` / `Storage` / `NAS`
- [ ] **Desactivar servidor FTP**
- [ ] Verificar:
  ```bash
  nmap -Pn --open -p 21 79.116.247.44
  # Resultado esperado: 21/tcp filtered
  ```
