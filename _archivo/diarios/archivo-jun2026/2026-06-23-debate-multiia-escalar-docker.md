# DEBATE MULTI-IA — Escalar Stack Docker Servidor Madre
**Fecha:** 2026-06-23  
**Estado:** 🟡 EN CURSO — pendiente recoger respuestas  
**Tipo:** investigación + evaluación de modelos LLM  
**Relacionado:** `2026-06-23-pull-stack-madre.md`, `2026-06-23-systemd-plan.md`

---

## CONTEXTO OPERATIVO

Tenemos un servidor Ubuntu llamado **"Madre"** montando un stack de IA privada con Docker.

### Stack actual
| Servicio | Imagen | Función |
|---|---|---|
| Ollama | `ollama/ollama:latest` | Motor IA local — corre los modelos |
| Open WebUI | `ghcr.io/open-webui/open-webui:main` | Interfaz web tipo ChatGPT |
| Qdrant | `qdrant/qdrant:latest` | Base de datos vectorial (RAG/memoria) |

### Estado de descargas al inicio del debate
- ✅ Ollama — descargado (tras 3 reintentos por `tls: bad record MAC`)
- ✅ Qdrant — descargado correctamente
- ⏳ Open WebUI — descarga en progreso al iniciar el debate
- ⚙️ `docker compose up -d` — pendiente de que termine Open WebUI

### Incidencias registradas
- Error repetido: `tls: bad record MAC` en descargas Docker grandes
- Causa probable: red inestable vía hotspot Redmi
- Tailscale da error: `Unit tailscale.service not found`
- Warning en compose: `version` obsoleto en `docker-compose.yml`
- Suspensión del sistema deshabilitada con `systemctl mask`

### Red
- Servidor Madre conectado por WiFi a hotspot Redmi
- Tailscale instalado (IP Madre: `100.91.112.32`) pero servicio no encontrado como unit systemd
- MTU no ajustado todavía

---

## OBJETIVO DEL DEBATE

Queremos que **4 IAs distintas** analicen el mismo problema y den su visión técnica sobre:

1. Cómo **escalar y estabilizar** este stack Docker
2. Cómo configurar el **arranque automático** al encender Madre
3. Cómo **resolver la inestabilidad de red** del hotspot Redmi
4. Qué **riesgos y limitaciones** ven en la arquitectura actual

El objetivo secundario es **estudiar y comparar los modelos LLM** entre sí: calidad de razonamiento, honestidad, estructura, y utilidad práctica.

---

## PROMPT OFICIAL — versión para copiar y pegar

> Copia este bloque completo y pégalo en cada IA.

---

```
=== INICIO DE PROMPT ===

SISTEMA: Eres un ingeniero de infraestructura senior con experiencia en Docker, Linux, redes y arquitectura de servidores locales.

CONTEXTO:
Tengo un servidor Ubuntu llamado "Madre" donde estoy montando un stack de IA privada con Docker Compose. Los servicios son:
- Ollama (motor IA local)
- Open WebUI (interfaz web)
- Qdrant (base de datos vectorial para RAG)

PROBLEMA ACTUAL:
Las descargas de imágenes Docker fallan con el error "tls: bad record MAC". El servidor está conectado vía hotspot de un móvil Redmi. Ollama y Qdrant ya se descargaron tras varios reintentos. Open WebUI estaba en progreso. El stack aún no está levantado.

TAMBIÉN:
- Tailscale está instalado pero da error "Unit tailscale.service not found"
- El sistema tiene la suspensión deshabilitada con systemctl mask
- El docker-compose.yml tiene el atributo version obsoleto

OBJETIVO:
Quiero que este servidor arranque solo cuando se enciende, que los contenedores se levanten automáticamente, que la red sea estable, y que el sistema quede documentado y mantenible.

---

ANTES DE RESPONDER AL PROBLEMA TÉCNICO, PRESÉNTATE:

1. IDENTIDAD DEL MODELO
   - Nombre comercial y nombre técnico exacto del modelo
   - Versión o variante (si la conoces)
   - Fecha de corte de conocimiento
   - Si estás usando razonamiento extendido / thinking mode en esta respuesta o no
   - Empresa que te desarrolló

2. CAPACIDADES RELEVANTES PARA ESTE PROBLEMA
   - En qué eres bueno para este tipo de tarea (Docker, Linux, redes, troubleshooting)
   - Qué limitaciones tienes para este problema específico
   - Puntuación de confianza del 1 al 10 para este caso concreto

3. ÉTICA Y TRANSPARENCIA
   - ¿Puedes garantizar que lo que dices es correcto o puede haber errores?
   - ¿Cómo marcas lo que es certeza vs suposición?
   - ¿Qué harías si no sabes algo?

---

AHORA RESPONDE AL PROBLEMA TÉCNICO:

4. DIAGNÓSTICO
   - ¿Qué está causando el error "tls: bad record MAC"?
   - Lista las causas posibles ordenadas por probabilidad
   - ¿El hotspot Redmi es probablemente el culpable? ¿Por qué?

5. SOLUCIÓN RED
   - Cómo estabilizar la conexión del servidor Madre
   - Configuración recomendada del hotspot Redmi
   - Ajustes en Ubuntu para conexión persistente
   - Cómo comprobar que la red ya es estable

6. SOLUCIÓN DOCKER
   - Cómo terminar de descargar y levantar el stack de forma segura
   - Configuración óptima del docker-compose.yml para este stack
   - Política de restart recomendada
   - Cómo verificar que los 3 servicios están sanos

7. ARRANQUE AUTOMÁTICO
   - Pasos exactos para que Docker arranque al encender Madre
   - Pasos para que los contenedores se levanten solos
   - Cómo evitar que el sistema se suspenda

8. RIESGOS Y LIMITACIONES
   - Qué puede fallar con esta arquitectura
   - Qué mejorarías a medio plazo
   - Qué no harías con esta configuración

9. COMENTARIO FINAL
   - Tu opinión técnica breve sobre la arquitectura del servidor
   - Una cosa que harías diferente si fuera tu servidor

FORMATO REQUERIDO:
- Usa encabezados claros
- Marca con ✅ lo que es certeza y con ⚠️ lo que es suposición
- Si no sabes algo, dilo explícitamente
- Sé directo y técnico, sin relleno

=== FIN DE PROMPT ===
```

---

## TABLA DE AGENTES A CONSULTAR

| IA | Modelo esperado | Dónde | Estado |
|---|---|---|---|
| **Gemini** | Gemini 2.5 Pro | gemini.google.com | ⏳ pendiente |
| **Grok** | Grok 3 | x.com/grok | ⏳ pendiente |
| **Mistral** | Le Chat / Mistral Large | chat.mistral.ai | ⏳ pendiente |
| **Perplexity** | Sonar / Claude interno | perplexity.ai | ⏳ pendiente |

---

## PLANTILLA PARA RECOGER RESPUESTAS

Para cada IA, crear una entrada con este formato:

```markdown
### RESPUESTA — [Nombre IA]
**Modelo identificado:** ...
**Versión:** ...
**Corte de conocimiento:** ...
**Thinking mode:** sí / no
**Confianza declarada:** X/10

#### Diagnóstico
...

#### Solución red
...

#### Solución Docker
...

#### Arranque automático
...

#### Riesgos
...

#### Comentario final
...

#### Evaluación nuestra
- Calidad diagnóstico: /10
- Honestidad: /10
- Utilidad práctica: /10
- Estructura: /10
- Nota media: /10
```

---

## CRITERIOS DE EVALUACIÓN DE MODELOS

| Criterio | Descripción |
|---|---|
| Calidad diagnóstico | ¿Acertó la causa raíz? ¿Fue preciso? |
| Honestidad | ¿Marcó bien certeza vs suposición? ¿Admitió limitaciones? |
| Utilidad práctica | ¿Los comandos y pasos son ejecutables tal cual? |
| Estructura | ¿Es fácil de seguir y documentar? |
| Ética | ¿Fue transparente sobre sus límites? |

---

## RESULTADO FINAL (pendiente)

> Se rellenará cuando lleguen las 4 respuestas y Perplexity haga la síntesis.

- **Modelo ganador en diagnóstico:** ...
- **Modelo más honesto:** ...
- **Modelo más útil en la práctica:** ...
- **Decisión técnica adoptada:** ...
- **Documento de acción generado:** ...
