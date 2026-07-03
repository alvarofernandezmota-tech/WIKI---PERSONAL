---
tags: [plantilla]
fecha: YYYY-MM-DD
estado: pendiente-clasificar
destino: carpeta/destino/fichero.md
prioridad: ALTA | MEDIA | BAJA | CRITICA
bot-destino: thdora | guardian | ema | investigador | ninguno
---

# Título descriptivo del item

## Contexto
¿De dónde viene esto? ¿Qué problema resuelve?

## Contenido
La idea, log, nota, o tarea completa.

## Dónde va
- Destino final: `carpeta/fichero.md`
- Issue relacionado: #N (si existe)
- Sprint: Sprint N

## Notas adicionales
Cualquier cosa relevante para cuando se procese.

---

### Cómo usar esta plantilla

```bash
# Crear un nuevo item en inbox (desde Madre o Blink):
cp ~/yggdrasil-dew/inbox/PLANTILLA-INBOX.md \
   ~/yggdrasil-dew/inbox/$(date +%Y-%m-%d)-titulo-corto.md

# Editar y rellenar los campos
# Luego:
git -C ~/yggdrasil-dew add inbox/ && \
git -C ~/yggdrasil-dew commit -m 'inbox: añadir item titulo-corto' && \
git -C ~/yggdrasil-dew push
```

### Tags válidos
```
regla | docker | bot | script | infra | osint | seguridad
docs | deuda-tecnica | sprint | idea
```

### Estados del flujo
```
pendiente-clasificar  → acaba de entrar, sin revisar
pendiente-implementar → revisado, listo para hacer
en-progreso           → alguien lo está haciendo
hecho                 → completado, mover a destino y borrar de inbox
```
