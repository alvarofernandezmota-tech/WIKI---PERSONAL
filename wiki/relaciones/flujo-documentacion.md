---
tipo: relacion
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05 21:18 CEST
ruta: wiki/relaciones/flujo-documentacion.md
tags: [relacion, flujo, documentacion, inbox, clasificador, dew, wiki, guardian]
status: vigente
islas: [cerebro, conocimiento]
---

# 📄 Flujo de Documentación del Ecosistema

> Cómo entra la información, cómo se clasifica, transforma y archiva.
> Este flujo es la columna vertebral del ecosistema cognitivo.

---

## Diagrama del flujo

```
Entrada (nueva información)
    ↓
Inbox (bruto, sin clasificar)
    ↓
Clasificador Maestro
    ├── ¿Hace funcionar el sistema?  → yggdrasil-dew (diario / issue / doc)
    ├── ¿Es de seguridad?             → yggdrasil-secops (hallazgo HAL-XXX)
    ├── ¿Es de infra / Madre?         → madre-config (script / config)
    ├── ¿Es formación técnica?         → formacion-tech (apunte / ejercicio)
    ├── ¿Me ayuda a pensar / navegar? → WIKI (isla / relación)
    └── ¿Es vida personal?            → VIDAPERSONAL
    ↓
Documentación estable (fuente de verdad en su repo)
    ↓
Guardian Maestro (audita coherencia y detecta desviaciones)
    ↓
Árbol de agentes (observadores, investigadores, mejoradores)
    ↓
Sincronización entre capas (según MAPA-SYNC)
```

---

## Paso a paso

### 1. Entrada

La información entra por:
- Sesiones de trabajo con MCP (iPhone / Acer)
- Sesiones SSH en Madre
- Hallazgos de auditoría
- Aprendizajes de formación
- Conversaciones con IA (Perplexity, Ollama)

### 2. Inbox

> El inbox es temporal. Nunca es fuente de verdad.

- En Dew: `inbox/` (si existe) → se procesa en el mismo día
- En WIKI: no hay inbox — todo entra ya clasificado
- En Madre: archivos sueltos en `~/` → se mueven a su repo

### 3. Clasificador Maestro

Aplica la regla de oro:

> ¿Hace funcionar el sistema? → **Dew**
> ¿Me ayuda a pensar / navegar? → **WIKI**

Si hay duda: va a **Dew** como issue o diario primero.

### 4. Documentación estable

| Tipo | Ruta canónica | Formato |
|---|---|---|
| Diario de sesión | `yggdrasil-dew/docs/diarios/YYYY-MM-DD.md` | Markdown |
| Decisión técnica | `yggdrasil-dew/docs/decisiones/` | Markdown (ADR) |
| Hallazgo seguridad | `yggdrasil-secops/hallazgos/HAL-XXX.md` | Markdown |
| Isla conceptual | `WIKI/wiki/islas/<nombre>.md` | Markdown |
| Relación entre islas | `WIKI/wiki/relaciones/<nombre>.md` | Markdown |
| Config de servicio | `madre-config/services/<nombre>/` | YAML / bash |
| Apunte de formación | `formacion-tech/<area>/` | Markdown |

### 5. Guardian Maestro

Periódicamente (o bajo demanda) verifica:
- ¿Todo lo que hay en inbox fue procesado?
- ¿Hay duplicados entre repos?
- ¿Hay docs técnicos viviendo en WIKI?
- ¿Hay diarios sin fecha ni contexto?
- ¿Hay issues abiertos sin repo correcto?

### 6. Sincronización

Según [`yggdrasil-dew/docs/canon/MAPA-SYNC.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/MAPA-SYNC.md):
- Dew → WIKI (unidireccional)
- Madre → WIKI (unidireccional)
- SecOps → Dew + WIKI (unidireccional)

---

## Reglas del flujo

1. **El inbox siempre se vacía.** Nada vive en inbox más de 24h.
2. **La duda va a Dew.** Si no sabes dónde va algo, abre un issue en Dew.
3. **WIKI no tiene inbox.** Todo lo que entra en WIKI ya está clasificado.
4. **Los diarios son sagrados.** Cada sesión importante tiene su diario en Dew.
5. **El Guardian audita, no decide.** Las decisiones las toma el Clasificador o el humano.

---

## Conexiones

- → [[cerebro]] (Dew es el destino principal)
- → [[conocimiento]] (WIKI es el destino conceptual)
- → `yggdrasil-dew/docs/canon/MAPA-SYNC.md` (reglas de sincronización)
- → `yggdrasil-dew/docs/canon/DICCIONARIO.md` (vocabulario del flujo)

---
_Actualizado: 2026-07-05 21:18 CEST · Perplexity-MCP_
