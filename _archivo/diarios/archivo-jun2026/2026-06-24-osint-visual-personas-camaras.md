# OSINT Visual — Personas, Fotos, Cámaras 2026
**Fecha:** 2026-06-24  
**Fuente:** social-searcher visual OSINT 2026, talkwalker, geoseeer AI OSINT  
**Contexto:** Investigación para integrar en el stack OSINT de Batcueva

---

## Flujo OSINT Visual por Foto de Persona

### Paso 1 — Preparar imagen
```
- Crop al rostro limpio
- Eliminar fondo si hay ruido
- Resolución mínima 200x200px
- Formato JPG/PNG, sin metadatos EXIF (privacidad)
```

### Paso 2 — Reverse image search
```
Herramientas en orden de potencia:
1. Google Lens          — objetos, lugares, ropa, texto
2. TinEye              — historial de la imagen en web
3. Yandex Images       — mejor que Google para rostros
4. Bing Visual Search  — alternativa
```

### Paso 3 — Facial recognition OSINT
```
- FaceCheck.ID         — links a perfiles RRSS del rostro
- PimEyes             — busca cara en toda la web (pago premium)
- Lenso.ai            — búsqueda visual por similitud
```

### Paso 4 — Pivot desde resultado
```
Si encuentras username:
  → sherlock [username]     # 400+ redes sociales
  → maigret [username]      # más profundo, árbol de conexiones

Si encuentras nombre real:
  → SpiderFoot OSINT        # agregador automático
  → IVRE si hay IP asociada
```

---

## Herramientas Self-Hosted para el Stack

### Sherlock — Username hunting
```bash
docker run --rm -t sherlock/sherlock [username]
# o
pip install sherlock-project
sherlock username1 username2
```

### Maigret — Username + árbol relaciones
```bash
pip install maigret
maigret username --html  # reporte visual
```

### Metagoofil — Metadatos de documentos/fotos
```bash
# Extrae EXIF, autor, software de archivos públicos
pip install metagoofil
metagoofil -d dominio.com -t pdf,doc,jpg -o resultados/
```

### ExifTool — Metadatos EXIF de fotos
```bash
sudo pacman -S perl-image-exiftool
exiftool foto.jpg  # GPS, cámara, fecha, edits
```

---

## OSINT de Cámaras — Shodan + IVRE

### Shodan (requiere API key gratuita)
```bash
# Buscar cámaras Hikvision en España
curl "https://api.shodan.io/shodan/host/search?key=TU_KEY&query=hikvision+country:ES"

# Cámaras RTSP expuestas
query: port:554 has_screenshot:true

# Webcams sin auth
query: "webcam 7" has_screenshot:true
```

### IVRE — Self-hosted, red local o internet
```bash
# IVRE ya está en nuestro stack SpiderFoot
# Para escanear cámaras en red local:
ivre runscans --network 192.168.1.0/24
ivre view  # dashboard web

# Buscar dispositivos con puertos de cámara
ivre db-nmap --category camaras 192.168.1.0/24
```

### Comandos nmap para cámaras locales
```bash
# Detectar cámaras IP en red local
nmap -p 80,443,554,8080,8554 --open -sV 192.168.1.0/24

# Scripts NSE específicos
nmap --script rtsp-methods 192.168.1.0/24 -p 554
nmap --script http-auth-finder 192.168.1.0/24 -p 80,8080
```

---

## Detección de Imágenes Sintéticas (Deepfakes)

Problema 2026: muchas fotos de "personas" son AI-generated.

```
Herramientas detección:
- Hive Moderation API    — detecta AI-generated faces
- Illuminarty            — % de probabilidad IA
- AI or Not              — simple, gratuito
- Forensically           — análisis forense foto (clone detection, ELA)
```

Señales manuales de imagen sintética:
- Orejas asimétricas o deformes
- Pelo en zonas de transición extraño
- Reflejo en gafas/ojos no coherente
- Fondo desenfocado con artefactos
- Dientes demasiado perfectos

---

## Integración con SpiderFoot (ya en stack)

SpiderFoot automatiza muchos de estos pasos:

```bash
# Módulos relevantes ya activos:
- sfp_shodan          # cámaras y dispositivos expuestos
- sfp_hunter          # emails desde dominio
- sfp_linkedin        # perfil empresarial
- sfp_twitter         # actividad RRSS
- sfp_pgp             # keys públicas
- sfp_haveibeenpwned  # brechas
```

Ejemplo de scan persona:
```
Target: nombre@email.com
Modules: all (o seleccionar)
Output: reporte HTML completo
```

---

## Flujo completo automatizado con n8n

```
Trigger: Telegram bot recibe foto
  → n8n workflow:
    1. Extraer EXIF (ExifTool API)
    2. Reverse image search (SerpAPI Google Lens)
    3. FaceCheck.ID API
    4. Si hay username → Sherlock
    5. Si hay IP/dominio → SpiderFoot scan
    6. Compilar resultados → Ollama resume
    7. Responder en Telegram con informe
```

---

## Consideraciones legales y éticas

```
⚠️  IMPORTANTE:
- OSINT es legal sobre información PÚBLICAMENTE disponible
- Facial recognition de personas privadas = zona gris legal (GDPR en ES)
- Cámaras: solo escanear redes propias o con permiso explícito
- Documentar siempre el objetivo y justificación
- Para CTF/laboratorio: usar datos ficticios o propios
```

---

## Próximos pasos OSINT stack

- [ ] Instalar Sherlock + Maigret en Batcueva
- [ ] Configurar IVRE correctamente (ya está en compose)
- [ ] Crear workflow n8n: foto → informe OSINT
- [ ] Conseguir API key Shodan gratuita
- [ ] Añadir Forensically a bookmarks OSINT
- [ ] Script bash: osint-persona.sh (automatiza pasos 1-4)
