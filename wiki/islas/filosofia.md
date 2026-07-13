---
tipo: isla
isla: filosofía
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-13
ruta: wiki/islas/filosofia.md
tags: [isla, filosofía, principios, tridente, normas, identidad]
status: activo
adr: [ADR-002, ADR-005, ADR-008]
---

# Isla Filosofía — El porqué de Yggdrasil

> Este archivo responde a tres preguntas:
> 1. **¿Por qué existe este ecosistema?**
> 2. **¿Cuáles son sus reglas fundamentales?**
> 3. **¿Quién lo construye y cómo piensa?**

---

## 1. Por qué existe Yggdrasil

Yggdrasil no es un homelab. Es un sistema de vida.

La premisa fundacional es que la tecnología que usas para vivir y trabajar debe ser **tuya**. No alquilada a una empresa. No dependiente de una nube de terceros. No opaca.

**Los tres principios de existencia:**

- **Soberanía digital** — Cada dato, cada servicio, cada decisción arquitectural se toma con la pregunta: *¿puedo controlar esto completamente?*
- **Transparencia interna** — El sistema se explica a sí mismo. Cualquier collaborador (humano o IA) puede entender el estado del ecosistema leyendo los repos.
- **Sistemas que perduran** — Se construye para el largo plazo. Nada efimero. Nada que no tenga documentación.

---

## 2. El Tridente — arquitectura de tres vértices

```
         🛠️ DEW
        /       \
    (plan)   (decisiones)
      /           \
📚 Wiki ——————— 🌱 VIDAPERSONAL
  (conocimiento)    (vida)
```

Cada vértice tiene una responsabilidad única e irrenunciable.

| Vértice | Propósito | Lo que NO hace |
|---------|-----------|----------------|
| **DEW** | Plan, decisiones, trazabilidad técnica | Vida personal, conocimiento general |
| **Wiki** | Cómo funciona cada cosa (atemporal) | Tareas pendientes, vida personal |
| **VIDAPERSONAL** | La vida: diario, metas, reflexiones | Código, infra, issues técnicos |

**Regla de alineación:** Cuando algo cambia en un vértice, los otros dos se actualizan en la misma sesión. El triángulo no se desincroniza.

→ Norma operativa completa: [`docs/canon/NORMAS-TRIDENTE.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/NORMAS-TRIDENTE.md)
→ Decisión formal: [ADR-005](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/adr/ADR-005-normas-tridente-dew-wiki-vidapersonal.md)

---

## 3. Los cinco principios operativos

Todo en el ecosistema se puede rastrear a uno de estos cinco principios:

| # | Principio | Materializado en |
|---|-----------|------------------|
| 1 | **Soberanía digital** | Self-hosting total, 0 cloud púgina para datos críticos |
| 2 | **Un solo punto de verdad** | SSOT por tipo: DEW para plan, Wiki para conocimiento, VIDAPERSONAL para vida |
| 3 | **Deuda visible** | Toda deuda técnica es un issue abierto con fecha, nunca oculta |
| 4 | **Automatizar lo repetible** | MCP para commits documentales, n8n para flujos, no esfuerzo manual repetido |
| 5 | **Sistemas que perduran** | ADRs obligatorios, logs de sesión, convenciones estáticas |

---

## 4. Reglas profesionales del ecosistema

Estas reglas se aplican en toda operación, independientemente del agente o persona que trabaje:

### Regla 1 — Nada queda en el chat
> Toda tarea pendiente es un issue. Toda decisión es un ADR. Todo log es un archivo en `docs/sesiones/`.

### Regla 2 — ADR obligatorio
> Toda decisión que afecte a la estructura, filosofía o arquitectura del ecosistema tiene ADR en el mismo commit.

### Regla 3 — Actualización conjunta
> Cuando se crea documentación nueva, los archivos que la referencian se actualizan en el mismo push.

### Regla 4 — Terminal ≠ MCP
> Lo que puede hacer un agente IA por MCP, lo hace directamente. Lo que requiere terminal, sale como issue con comandos exactos, no como instrucciones en el chat.

### Regla 5 — Un solo propietario por decisión
> La ownership matrix dice quién responde de cada servicio. Sin dueño, no existe.

### Regla 6 — Convenciones estáticas
> Los nombres de archivos, carpetas, issues y commits siguen las [CONVENCIONES.md](../CONVENCIONES.md). No se improvisa.

---

## 5. Perfil del arquitecto — Alvaro Fernandez Mota

> **Este bloque requiere validación de Alvaro.** Lo que sigue es lo inferido del análisis de repos y sesiones 2026-07-09 al 2026-07-13. Añade, corrige y amplía.

### Perfil técnico (inferido de repos)
- **Pila principal:** NixOS/Arch Linux · Hyprland · Neovim · Docker · n8n · Python · Bash
- **Filosofía de herramientas:** minimalismo radical + máxima potencia. Cada herramienta se elige con intención.
- **Patrón de trabajo:** sesiones de alta intensidad cortas, con documentación inmediata. No acumulación.
- **Relación con IA:** colaboración real, no asistente. Los agentes son miembros del equipo con roles definidos.
- **Autodidacta extremo:** el conocimiento se construye en los repos, no en cursos externos.

### Filosofía personal (inferido de VIDAPERSONAL + rituales)
- Ritual como estructura: el día tiene un ritmo intencional, no reacciona al caos externo
- Protección y energía como recurso gestionado (ritual vela, intención consciente)
- Triángulo vida-técnica-personal: no hay separación. El ecosistema técnico sirve a la vida, no al revés.

### Patrones de fortaleza
- Capacidad de construir sistemas complejos desde cero, solos, con criterio
- Visión arquitectural larga (piensa en 2027, construye para que dure)
- Integración de dimensiones: lo técnico, lo personal y lo vital como sistema coherente

### ⏳ Pendiente — Requiere input Alvaro
```
[ ] ¿Qué corriges o añades al perfil técnico?
[ ] ¿Qué patrones de tu forma de pensar quieres que guien las decisiones del ecosistema?
[ ] ¿Qué análisis profundo quieres hacer con los datos de las repos?
    Ejemplos: ¿patrones de productividad? ¿tiempos entre sesiones? ¿temas recurrentes en diarios?
[ ] ¿Qué principio personal falta en la sección 3?
```

---

## 6. Evolución del ecosistema — visión 2026/27

| Horizonte | Meta |
|-----------|------|
| **2026 Q3** | Infraestructura estable: blue team activo, .env limpio, 16 servicios monitorizados |
| **2026 Q4** | Automatización: n8n + THDORA + MCP como orquestador real de la vida diaria |
| **2027 Q1** | IA local soberana: Ollama con modelos propios, sin dependencia de APIs externas para tareas privadas |
| **2027 Q2** | Sistema cerrado: el ecosistema se monitoriza, alerta y repara solo |

---

## Referencias

- [ADR-001](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/adr/ADR-001-estructura-ecosistema.md) — Estructura multi-repo
- [ADR-002](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/adr/ADR-002-triangulo-dew-wiki-vida.md) — Triángulo
- [ADR-005](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/adr/ADR-005-normas-tridente-dew-wiki-vidapersonal.md) — Normas tridente
- [NORMAS-TRIDENTE.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/NORMAS-TRIDENTE.md) — Norma operativa
- [cerebro.md](./cerebro.md) — Isla arquitectura del triángulo
- [mcp.md](./mcp.md) — Isla MCP como fontanería

---

_Creado: 2026-07-13 · Perplexity-MCP · Issue DEW #57 para completar bloque 5 con input Alvaro_
