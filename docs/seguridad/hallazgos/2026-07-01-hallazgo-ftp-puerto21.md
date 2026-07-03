---
tags: [tipo/hallazgo, estado/pendiente, seguridad, red/router, pentest]
fecha: 2026-07-01
hora: 01:54 CEST
prioridad: alta
---

# ⚠️ Hallazgo Seguridad — Puerto 21 FTP expuesto en IP pública

## Resumen

Durante el primer scan real con Nmap contra la IP pública de varopc (`79.116.247.44`)
se detectó el **puerto 21/tcp abierto y visible desde internet**.

## Datos del hallazgo

```
IP pública:     79.116.247.44 (Digi/Digimobil, dinámica)
Puerto:        21/tcp
Servicio:      FTP
Banner:        421 Service not available, remote server has closed connection
Origen:        Router Digi (no es ningún contenedor Docker)
Descubierto:   nmap -Pn -sV --open 79.116.247.44
Fecha:         2026-07-01 01:49 CEST
```

## Verificación realizada

```bash
# Confirmado que ningún contenedor Docker expone el puerto 21:
docker ps --format "table {{.Names}}\t{{.Ports}}" | grep 21
# → sin resultados — el origen es el router

# Banner FTP:
ftp 79.116.247.44
# → Connected to 79.116.247.44.
# → 421 Service not available, remote server has closed connection
```

## Evaluación de riesgo

- **Riesgo actual**: BAJO — el router rechaza conexiones externas (421)
- **Riesgo potencial**: ALTO — puerto visible = superficie de ataque, bots lo encuentran en minutos
- **FTP en 2026**: protocolo sin cifrado, credenciales en texto plano
- **Credenciales por defecto**: si el router tiene user/pass de fábrica = compromiso total

## ✅ Acción requerida

- [ ] Entrar al panel del router Digi: `http://192.168.72.1` o `http://192.168.1.1`
- [ ] Localizar: `USB Sharing` / `FTP Server` / `Storage` / `NAS`
- [ ] **Desactivar el servidor FTP**
- [ ] Verificar con nuevo nmap que el puerto ya no aparece:
  ```bash
  nmap -Pn --open -p 21 79.116.247.44
  ```

## Contexto del scan completo

```
Comando:   nmap -Pn -sV --open 79.116.247.44
Duración:  195.91 segundos
Resultado: 999 puertos filtered, 1 puerto abierto

PORT   STATE SERVICE VERSION
21/tcp open  ftp?
```

> ✅ BUENA NOTICIA: Solo 1 puerto abierto en internet.
> El resto (999) están filtrados — el router Digi bloquea todo por defecto.
> Todos los servicios Docker (Gitea :2222, thdora :8000, etc.) NO son accesibles desde internet.
> Solo accesibles vía Tailscale (100.x.x.x) — correcto.

---
_Hallazgo documentado por Perplexity vía MCP — 01 jul 2026 01:56 CEST_
_Procesar a: `docs/seguridad/` cuando se cree la carpeta_
