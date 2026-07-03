# 📜 NORMAS DEL ECOSISTEMA YGGDRASIL

> Estas normas son **reglas duras**. No se negocian.
> Si algo las viola, se corrige antes de continuar.

---

## REGLA 0 — NO APAGAR MADRE

```
Madre (Acer, 100.91.112.32) es el servidor central.
ES EL CORAZÓN DEL ECOSISTEMA.

Antes de reiniciar Madre:
  1. ¿Estás físicamente presente o con SSH estable? Si NO → NO reiniciar
  2. Avisar en Telegram: "Reiniciando Madre en 5min"
  3. docker compose down
  4. Reiniciar
  5. Verificar: docker ps (esperar 2-3min)
  6. Confirmar en Telegram

NUNCA: sudo shutdown / sudo reboot sin seguir este protocolo
```

---

## REGLA 1 — UNA TERMINAL, NO OCUPARLA

```
- Crear terminal nueva para cada tarea larga
- Tareas en background: comando & o tmux
- Docker siempre en background: docker compose up -d
- La terminal principal queda SIEMPRE libre
```

---

## REGLA 2 — INBOX FIRST

```
Cualquier idea, log, nota urgente → inbox/ primero
No crear ficheros sueltos en la raíz
No crear ficheros sueltos en directorios que no corresponden
Procesar inbox al inicio de cada sesión
```

---

## REGLA 3 — SINE (Sin Innovar, Normalizar Ecosistema)

```
Antes de crear algo nuevo:
  1. ¿Ya existe en el ecosistema?
  2. ¿Se puede extender lo que hay?
  3. ¿Cumple las normas si se crea?

Solo si las 3 respuestas son correctas → crear
```

---

## REGLA 4 — TODO TIENE SU SITIO

```
Estructura de carpetas:
  agentes/     → documentación de bots
  docker/      → configuración Docker
  docs/        → documentación técnica
  inbox/       → captura sin clasificar
  infra/       → infraestructura (red, hardware)
  osint/       → todo lo relacionado con OSINT
  proyectos/   → proyectos documentados
  scripts/     → scripts de sesión y mantenimiento
  setup/       → bootstrap y configuración inicial
  templates/   → plantillas reutilizables
  tools/       → herramientas del ecosistema

Si no sabes dónde va → inbox/
```

---

## REGLA 5 — NOTIFY-ON-CHANGE

```
Los bots NO spamean.
Solo notifican cuando algo CAMBIA de estado:
  healthy → unhealthy   : 🚨 ALERTA
  unhealthy → healthy   : ✅ RECOVERY
  running → stopped     : 🚨 ALERTA
  Sin cambio            : silencio (log interno)
```

---

## REGLA 6 — UN BOT = UN ROL

```
Cada bot tiene una responsabilidad principal.
Si un bot hace demasiadas cosas → dividirlo.
Ver agentes/ROLES.md para el mapa completo.
```

---

## REGLA 7 — RESTART POLICY SIEMPRE

```
Todo contenedor Docker:
  restart: unless-stopped  (mínimo)
  restart: always          (si es crítico)

Nunca: restart: no
Verificar: docker inspect <nombre> | grep RestartPolicy
```

---

## REGLA 8 — BOOTSTRAP REPRODUCIBLE

```
El ecosistema debe poder levantarse desde cero
con UN SOLO COMANDO en cualquier máquina:

  curl -sL https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/setup/bootstrap.sh | bash

Cualquier configuración manual que no esté en bootstrap.sh
es DEUDA TÉCNICA.
```

---

## REGLA 9 — DOCUMENTAR ANTES DE CERRAR SESIÓN

```
Al cerrar sesión:
  1. bash scripts/maintenance/close-session.sh
  2. Todo lo pendiente → inbox/ o issue en GitHub
  3. MASTER-PENDIENTES.md actualizado
  4. Nada queda "en la cabeza" sin registrar
```

---

_Última revisión: 2026-07-03_
