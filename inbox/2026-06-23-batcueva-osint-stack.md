# 🦇 Batcueva OSINT Stack — Sesión 2026-06-23

**Tipo:** Investigación + planificación  
**Fecha:** 23/06/2026 ~13:00 CEST  
**Estado:** TODO — pendiente de instalación

---

## Qué se decidió

El stack definitivo para la batcueva tiene **5 herramientas OSINT** que se complementan en capas:

1. **OSIRIS** — globo 3D, satélites, cámaras CCTV, nuclear, seísmos
2. **Shadowbroker** — aviones (comerciales + militares), 25k barcos AIS, GPS jamming
3. **SpiderFoot** — OSINT digital: IPs, dominios, personas, redes sociales
4. **Kismet** — red local WiFi/Bluetooth
5. **Maltego** — grafos de conexiones (versión Community gratis)

## El dashboard es la capa central

El proyecto Heimdall dashboard embebe todas estas herramientas como iframes/paneles. No es un proyecto secundario — es la pantalla principal siempre abierta.

## Próximo paso

- [ ] Instalar SpiderFoot (estaba a medias)
- [ ] `git clone https://github.com/BigBodyCobain/Shadowbroker.git ~/shadowbroker`
- [ ] Buscar repo oficial OSIRIS y clonar
- [ ] Instalar Kismet desde repos
- [ ] Maltego Community Edition

## Notas
- Shodan no necesita instalación — web gratuita
- Shadowbroker: Next.js + FastAPI, perfecto para la madre
- OSIRIS usa WebGL acelerado por GPU
