# NORMA: Plantillas y Headers de Archivos

> Norma del ecosistema Yggdrasil — Nivel: OBLIGATORIO  
> Aplicada por: `.github/workflows/new-file-bootstrap.yml`  
> Auditada por: `.github/workflows/ecosystem-guardian.yml`

---

## Principio

Cada archivo de código del ecosistema tiene que saber **dónde está** y **a qué pertenece**.  
Eso se consigue con un header estándar en las primeras líneas.

El GitHub Action `new-file-bootstrap.yml` lo inyecta automáticamente.  
Lo único que tienes que hacer es **completar los campos** marcados con `<-`.

---

## Headers por tipo de archivo

### Python (`.py`)

```python
"""
nombre_archivo.py
Doc: docs/ruta/al/documento-relacionado.md
Fase: Fase 5

Descripción breve en una línea.
"""
```

### Shell (`.sh`)

```bash
#!/usr/bin/env bash
# nombre_script.sh
# Doc: docs/ruta/al/documento-relacionado.md
# Fase: Fase 5
# Descripción: breve descripción
```

### GitHub Action (`.yml`)

```yaml
# nombre-workflow.yml
# Doc: docs/ruta/al/documento-relacionado.md
# Fase: Fase 5
```

### Markdown (`.md`)

Primer párrafo del doc incluye:
```
> Doc relacionado: [ruta/archivo.md](ruta/archivo.md)  
> Fase: Fase X  
> Actualizado: YYYY-MM-DD
```

---

## Conexión bidireccional (obligatoria)

Cada archivo apunta a su doc. Cada doc apunta a sus archivos.

```
archivo.py  ---> docs/tema/MI-DOC.md  (campo "Doc:" en header)
docs/tema/MI-DOC.md  ---> archivo.py   (sección "## Archivos relacionados")
```

Esta bidireccionalidad es lo que permite que el Guardian detecte archivos huérfanos.

---

## Cuándo se convierte en GitHub Action

Usa el Decision Tree en `docs/arquitectura/github-action-vs-bot-patron.md`:

```
Script local (Madre)  -->  cron en Madre
Script que analiza repo  -->  GitHub Action
Script que notifica usuario  -->  Bot Telegram
Script que hace las 3 cosas  -->  GitHub Action (produce artifact) + Bot (consume)
```

---

## Filosofia de los bots

### TOKI-Guardian — "El Vigilante"
- **Mentalidad:** Sysadmin paranoico. Asume que algo puede fallar siempre.
- **Criterio de búsqueda:** Estado de servicios (Docker, Tailscale, Wazuh, disk, CPU)
- **Cuándo habla:** Solo cuando hay un problema o cuando se le pregunta directamente
- **Tono:** Directo, técnico, sin florituras
- **No hace:** Recomendaciones de productividad, gestión de tareas

### TOKI-DEW — "El Bibliotecario"
- **Mentalidad:** Arquitecto de información. Cada cosa en su sitio.
- **Criterio de búsqueda:** Estado de repos, issues, documentación, fases, tareas
- **Cuándo habla:** Al recibir artifacts del Guardian + comandos directos
- **Tono:** Estructurado, con emojis de estado (✅⚠️🔴), conciso
- **No hace:** Infraestructura, seguridad, ejecución de comandos en Madre

### ROUTER-BOT (futuro) — "El Dispatcher"
- **Mentalidad:** Centralita inteligente. No resuelve, redirige.
- **Criterio:** Intent detection por palabras clave del mensaje
- **Ejemplo:** "docker caido" → delega a Guardian | "issue cerrado" → delega a DEW
- **Activo cuando:** Los 2 bots anteriores estén estables y documentados

---

_Norma creada: 2026-07-03_  
_Auditada por: ecosystem-guardian.yml (diario a las 03:00)_
