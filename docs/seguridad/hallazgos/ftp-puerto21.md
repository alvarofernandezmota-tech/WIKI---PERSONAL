# Hallazgo — Puerto 21 FTP expuesto
#seguridad #hallazgo #p1-urgente #fase2 #router

**Fecha detección:** 2026-07-01  
**Severidad:** ALTA  
**Estado:** 🔴 ABIERTO — pendiente acción

---

## Descripción

El router Digi tiene el servicio FTP activo y el puerto 21 expuesto hacia la red local (posiblemente también hacia WAN según configuración).

- **Componente:** Router Digi (gateway `192.168.1.1`)
- **Puerto:** 21/tcp FTP
- **Detectado con:** nmap / auditoría manual

---

## Riesgo

FTP es un protocolo sin cifrado. Si está expuesto a WAN:
- Credenciales en claro interceptables
- Acceso no autorizado al sistema de ficheros del router
- Vector de entrada a la red interna

---

## Acción requerida

1. Acceder a panel router: `http://192.168.1.1`
2. Navegar a configuración avanzada → Servicios → FTP
3. **Desactivar FTP server**
4. Guardar y verificar con `nmap -p 21 192.168.1.1`

**Requiere:** presencia física en Madrid o acceso remoto al panel router.

---

## Estado

- [ ] Desactivado en panel router
- [ ] Verificado con nmap
- [ ] Issue cerrado
