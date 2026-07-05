---
tags: [auditoria, ecosistema, repos, organizacion]
fecha: 2026-07-05
estado: pendiente-ejecutar
---

# 🔍 Auditoría del Ecosistema — Checklist

> Generado en sesión 2026-07-05. Ejecutar repo por repo antes de crear más contenido.

---

## 3 Reglas de Oro

1. **Regla del .gitignore** — Ningún repo de código puede contener datos generados (DBs, logs, `.env`, PDFs indexados)
2. **Regla de la Wiki** — Cómo piensas → `WIKI---PERSONAL`. Cómo arranca un contenedor → `README.md` de ese repo
3. **Repos huérfanos** — Terminados → archivar. Forks sin usar → borrar. Herramientas maduras → repo propio

---

## Fronteras entre repos similares

| Repo | Para qué es | NO va aquí |
|---|---|---|
| `investigacion-ia` | Jupyter Notebooks, pruebas de modelos/prompts | Infraestructura Ollama |
| `local-brain` | Sistema RAG definitivo, embeddings, pgvector | Levantar Ollama |
| `dev-labs` | Sandbox, proyectos en desarrollo | Proyectos maduros (darles repo propio) |
| `ollama-stack` | Infraestructura Docker, configs, despliegue | Código de agentes o pruebas |
| `osint-stack` | Scraping, APIs redes, SpiderFoot, tracking | Auditoría de redes, firewalls |
| `yggdrasil-secops` | Auditoría redes, firewalls, hardening | Scripts OSINT |

---

## Checklist por repo

### 1. WIKI---PERSONAL
- [ ] ¿Hay dotfiles o configs duras? → mover a `acer-config` o `madre-config`
- [ ] ¿Hay apuntes de cursos? → mover a `formacion-tech`
- [ ] ¿Hay credenciales, tokens o IPs críticas en `.md`? → eliminar

### 2. formacion-tech
- [ ] ¿Hay proyectos funcionales mezclados con ejercicios? → mover a `osint-stack` o `dev-labs`
- [ ] ¿Hay apuntes obsoletos? → mover a carpeta `legado/`

### 3. VIDAPERSONAL
- [ ] ¿Hay scripts o código de automatización? → mover a `dev-labs`
- [ ] ¿El repo es privado? → verificar en GitHub Settings

### 4. madre-config
- [ ] ¿Hay docker-compose.yml de servicios apagados? → limpiar o archivar
- [ ] ¿Hay `.env` con secretos subidos? → añadir al `.gitignore` y rotar credenciales
- [ ] ¿Hay solapamiento con la wiki? → elegir uno como fuente de verdad

### 5. acer-config
- [ ] ¿Está actualizado con el sistema real? → verificar tools del día a día
- [ ] ¿Hay scripts generales metidos en `bin/`? → mover a su stack correspondiente

### 6. ollama-stack
- [ ] ¿Hay código de pruebas o agentes? → mover a `investigacion-ia` o `local-brain`
- [ ] ¿Hay Modelfiles gigantes? → sustituir por script de creación

### 7. yggdrasil-secops
- [ ] ¿Hay repos de terceros clonados? → eliminar, usar script de setup
- [ ] ¿Hay reportes con IPs o vulnerabilidades reales? → mover a WIKI privada o VIDAPERSONAL

### 8. investigacion-ia
- [ ] ¿Hay datasets pesados (.csv, .json, PDFs)? → añadir al `.gitignore`
- [ ] ¿Está la frontera clara con `local-brain` y `dev-labs`? → ver tabla de fronteras arriba

### 9. dev-labs
- [ ] ¿Hay proyectos maduros que merecen repo propio? → migrar
- [ ] ¿Hay carpetas de hello-world obsoletas? → borrar

### 10. local-brain
- [ ] ¿Hay solapamiento con `ollama-stack`? → este repo solo consume la API, no levanta Ollama
- [ ] ¿Están las carpetas de persistencia de DB vectorial en `.gitignore`? → verificar

### 11. osint-stack
- [ ] ¿Hay scripts duplicados con `yggdrasil-secops`? → ver tabla de fronteras
- [ ] ¿Hay tokens de APIs expuestos (Shodan, VirusTotal)? → rotar y meter en `.gitignore`

---

## Pendiente — 6 repos no auditados
- `thea-ia`
- `THDORA-PERSONAL`
- `image-calculator`
- `impresion-3d`
- `ai-toolkit`
- `alvarofernandezmota-tech` (profile README)

Filtro: ¿Terminado? → archivar. ¿Fork sin usar? → borrar. ¿Herramienta madura? → dejar sola.
