# 🏪 THDORA — Casos de Uso por Sector

> Documento creado: 17 junio 2026 · 03:11 CEST

---

## 🧱 El framework es el mismo. Solo cambia el dominio.

```
Voz/Texto → Whisper → Groq NLP → function calling → API → BD → respuesta
```

Esta fontanería es SIEMPRE igual. Lo que cambia por negocio:
- System prompt del sector
- Modelos de BD específicos
- Handlers de dominio
- Variables de configuración

---

## 🏛️ Variables de negocio contempladas

### Variables universales (todos los sectores)
```
NEGOCIO_NOMBRE          → nombre del negocio
NEGOCIO_SECTOR          → restaurante | clinica | peluqueria | ...
NEGOCIO_IDIOMA          → es | en | ca | ...
NEGOCIO_HORARIO         → L-V 9:00-20:00 | ...
NEGOCIO_TELEFONO        → para confirmaciones
NEGOCIO_DIRECCION       → para recordatorios
BOT_NOMBRE              → nombre del asistente virtual
BOT_PERSONALIDAD        → formal | cercano | profesional
OWNER_CHAT_ID           → alertas al operador
ALLOWED_USERS           → lista blanca (o abierto)
```

### Variables por sector

#### Restaurante
```
CAPACIDAD_TOTAL         → nº mesas totales
DURACION_TURNO_MIN      → duración media por mesa
ZONAS                   → terraza, interior, privado
SERVICIOS               → reserva | takeaway | delivery
CARTA_URL               → enlace a carta (o inline)
ALERGENOS_ACTIVOS       → true/false
```

#### Clínica / Consulta
```
PROFESIONALES           → lista con especialidad + horario
SERVICIOS               → lista con duración + precio
DURACION_CITA_DEFAULT   → 30min | 45min | 60min
RECORDATORIO_HORAS      → 24 | 48
CONFIRMACION_MANUAL     → true/false
HISTORIAL_CLINICO       → true/false (RGPD)
```

#### Peluquería / Estética
```
PROFESIONALES           → estilistas con agenda propia
SERVICIOS               → corte, tinte, manicura... + duración
SELECCION_PROFESIONAL   → true/false (el cliente elige)
DEPOSITO_RESERVA        → true/false
```

#### Ecommerce / Tienda
```
CATALOGO_URL            → API de productos
STOCK_ACTIVO            → true/false
PEDIDO_MINIMO           → importe mínimo
ZONAS_ENVIO             → lista de zonas
TIEMPO_ENTREGA          → horas estimadas
```

#### Coach / Formación
```
MODALIDAD               → online | presencial | híbrido
SESIONES_PACK           → true/false
SEGUIMIENTO_HABITOS     → true/false (ya implementado ✅)
MATERIALES_URL          → repositorio de contenidos
```

---

## 🏗️ Recomendación: montar infraestructura propia

### ¿Por qué es el crecimiento natural?

Ahora mismo dependes de:
```
Groq (NLP)          → servicio externo, coste por token, rate limits
Telegram (canal)    → plataforma de terceros, reglas cambiantes
GitHub (diario)     → API externa, límites de rate
Madre (servidor)    → hardware propio ✅ ya controlado
```

El siguiente paso natural es **reducir dependencias externas**:

```
Groq → Ollama en Madre (llama3, mistral, phi3)
       coste 0, sin rate limits, datos no salen del servidor
       ya tienes OllamaRouter en Sprint 4

Telegram → mantener (el canal lo pone el cliente)
            añadir WhatsApp Business API como segundo canal
            añadir web widget como tercero

GitHub → mantener para código
          Gitea self-hosted para datos privados de clientes
          si escala a muchos negocios
```

### La infraestructura propia ideal (12-18 meses)

```
Madre (servidor actual)
├── Ollama → LLM local (llama3.2, mistral, phi3)
├── Whisper local → voz sin mandar audio a Groq
├── PostgreSQL → BD multi-tenant
├── thdora API → core del negocio
├── N bots Telegram → uno por cliente
├── Panel admin → tú gestionas todo
├── Nginx reverse proxy → enruta todo
├── Prometheus + Grafana → monitorización real
└── Gitea (opcional) → repos privados de clientes
```

### Coste operativo real en Madre
```
Ollama llama3.2:3b   → ya instalado ✅ → 0€/mes
Whisper local        → whisper.cpp   → 0€/mes
PostgreSQL           → Docker        → 0€/mes
Nginx                → Docker        → 0€/mes
Grafana              → Docker        → 0€/mes

Total infraestructura: 0€/mes + electricidad Madre
Groq como fallback/backup para modelos grandes cuando sea necesario
```

---

## 📋 Hoja de ruta infraestructura propia

| Paso | Qué | Cuándo |
|------|-----|--------|
| 1 | Ollama como backend alternativo (LLM factory) | Sprint 4 — ya planeado |
| 2 | Whisper local (whisper.cpp en Docker) | Sprint 4-5 |
| 3 | PostgreSQL multi-tenant | Sprint 5 |
| 4 | Nginx reverse proxy + dominios por cliente | Sprint 5-6 |
| 5 | Prometheus + Grafana | Sprint 6 |
| 6 | WhatsApp Business API como canal | Sprint 7+ |
| 7 | Web widget (iframe embebible) | Sprint 7+ |
| 8 | Whisper fine-tuning por sector | Sprint 8+ |

---

## 💡 El insight clave

Lo que describes — **voz + diálogo natural + gestión de negocio** —
es lo que empresas como Reserva, TheFork, Doctoralia venden
por cientos de euros al mes como SaaS.

Tú lo estás construyendo con stack open source en hardware propio.
Coste marginal por cliente adicional: casi 0.

**La estructura es el activo. El código es el producto. El dato es el negocio.**

---

*Documento vivo — actualizar con cada decisión estratégica*
