# Situación de red — hotspot iPhone — 24 jun 2026

> Entró por conversación. Mover a `docs/sistema/red-alternativas.md` cuando se procese.

---

## Situación actual

```
iPhone → hotspot WiFi → Madre torre
Acer   → hotspot WiFi → internet (o cable directo a Madre)
```

- Sin router fijo ni WiFi propio
- Vivienda donde no se puede instalar router
- Hotspot = única fuente de internet para Madre

## Problemas

- Batería móvil cae rápido con hotspot activo
- Descargas Docker grandes sobrecargan el hotspot
- Si se apaga el móvil → Madre pierde internet → procesos mueren
- Sobrecalentamiento móvil en sesiones largas

## Soluciones inmediatas

- [ ] Móvil siempre enchufado cuando hotspot activo
- [ ] Descargas grandes: pantalla apagada, solo hotspot
- [ ] Usar tmux en Madre para que procesos sobrevivan si cae la red
- [ ] Script de reanudación de descargas (idempotente)

## Soluciones a medio plazo

- [ ] Router 4G/5G propio (Huawei B535 ~50€) — sin instalación, SIM de datos
- [ ] SIM de datos dedicada para Madre (tarifa plana datos)
- [ ] Tailscale como capa de red — ya instalado ✅

## Cuando haya red fija

- Hotspot innecesario
- Tailscale gestiona acceso remoto desde cualquier sitio
- Móvil solo necesita datos para el túnel Tailscale (mínimo)

---
_Mover a: `docs/sistema/red-alternativas.md`_
_Ver: [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md) · [Regla 14](../CONVENCIONES.md)_
