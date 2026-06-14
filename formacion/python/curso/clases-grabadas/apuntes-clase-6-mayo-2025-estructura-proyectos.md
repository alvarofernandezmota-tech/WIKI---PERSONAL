# 📝 Apuntes Clase: Estructura de Proyectos POO

**Clase:** 6 Mayo 2025 - POO, Modelado y Estructura de Proyectos  
**Fecha estudio:** 12 Febrero 2026  
**Estado:** En progreso (sesión parcial)  
**Continuar:** Mañana 13 Febrero 2026

---

## 🎯 Conceptos Fundamentales

### ✅ Concepto 1: Separación de Archivos

**Principio:**
- Cada clase va en su propio archivo `.py`
- El `main.py` es donde se ejecuta todo
- Los archivos de clases NO se ejecutan solos

**Ventajas:**
- ✅ Código organizado
- ✅ Fácil de mantener
- ✅ Reutilizable
- ✅ Profesional

---

### ✅ Concepto 2: El Main Orquesta Todo

**`main.py`:**
- Importa las clases
- Crea objetos
- Ejecuta la lógica del programa
- Es el "director de orquesta"

**Archivos de clases:**
- Solo definen la clase
- No ejecutan nada
- Son "moldes/herramientas"

**Ejemplo:**
```python
# main.py
from persona import Persona

# AQUÍ trabajamos con las clases
p1 = Persona("Ana", 25)
p1.presentarse()
```

```python
# persona.py
# Solo la definición, NO se ejecuta nada
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad
```

---

### ✅ Concepto 3: Interrelación entre Clases/Archivos

**SÍ, las clases pueden relacionarse entre sí:**

**Ejemplo: Una clase usa otra clase**
```python
# coche.py
from persona import Persona

class Coche:
    def __init__(self, marca, conductor):
        self.marca = marca
        self.conductor = conductor  # Objeto Persona
    
    def mostrar_info(self):
        return f"{self.marca} conducido por {self.conductor.nombre}"
```

```python
# main.py
from persona import Persona
from coche import Coche

conductor = Persona("Ana")
coche = Coche("Toyota", conductor)
print(coche.mostrar_info())  # "Toyota conducido por Ana"
```

**Tipos de interrelaciones:**
1. **Composición**: Una clase contiene objetos de otra
2. **Asociación**: Clases se comunican entre sí
3. **Herencia**: Una clase extiende otra (veremos después)

---

### ✅ Concepto 4: Módulo 2 → Módulo 3 (Transición)

**Esta clase es el puente:**
- 🔚 **Final Módulo 2:** Imports, módulos, organización de código
- 🚀 **Inicio Módulo 3:** POO + estructura de proyectos profesionales

**Conecta:**
- `import` statements (Módulo 2)
- Clases y objetos (Módulo 3)
- Arquitectura de proyectos

---

### ✅ Concepto 5: Main SIEMPRE en Raíz del Proyecto

**Regla fundamental:**
- ✅ `main.py` debe estar en la **raíz** del proyecto
- ✅ Es el punto de entrada de la aplicación
- ✅ Desde ahí se ejecuta todo: `python main.py`

**Estructura correcta:**
```
gestion-escolar/              ← Raíz del proyecto
├── main.py                   ← AQUÍ (raíz)
├── alumno.py
├── curso.py
├── profesor.py
└── enunciado.py
```

**Estructura INCORRECTA:**
```
gestion-escolar/
├── clases/
│   ├── main.py              ← ❌ NO aquí
│   ├── alumno.py
│   └── curso.py
```

**¿Por qué en raíz?**
1. ✅ Fácil de ejecutar: `python main.py`
2. ✅ Imports más simples
3. ✅ Convención estándar Python
4. ✅ Claridad: se ve inmediatamente cuál es el archivo principal

---

### ✅ Concepto 6: Main es el CEREBRO del Proyecto 🧠

**Analogía:**
```
main.py = CEREBRO 🧠
    ↓
Toma decisiones
Coordina todo
Ejecuta acciones
    ↓
Usa las clases (órganos/herramientas)
```

**El Main:**
- ✅ Decide qué hacer y cuándo
- ✅ Crea objetos (instancias de clases)
- ✅ Llama a métodos
- ✅ Controla el flujo del programa
- ✅ Es el único que se ejecuta directamente

**Las Clases:**
- 🔧 Son herramientas/moldes
- 🔧 NO se ejecutan solas
- 🔧 Esperan a que el Main las use

**Analogía completa:**
```
PROYECTO = CUERPO HUMANO

main.py = 🧠 CEREBRO
    - Toma decisiones
    - Coordina todo
    
alumno.py = 💪 Músculo (herramienta)
curso.py = 🫀 Corazón (herramienta)
profesor.py = 🫁 Pulmones (herramienta)

El CEREBRO (main) usa los ÓRGANOS (clases) para funcionar
```

---

## 🏫 PROYECTO EJEMPLO: Sistema Gestión Escolar

### 🎯 Objetivo:
Desarrollar un sistema de gestión básico dentro de una escuela

### 🗂️ Estructura del Proyecto:
```
gestion-escolar/
├── main.py          # Cerebro - Crea objetos y ejecuta métodos
├── alumno.py        # Clase Alumno
├── curso.py         # Clase Curso
├── profesor.py      # Clase Profesor
└── enunciado.py     # Clase Enunciado (?)
```

### 📋 Principio Clave:
**TODO se hace desde `main.py`:**
- Los archivos de clases SOLO definen clases
- El `main.py` es el encargado de:
  - Crear objetos
  - Ejecutar métodos
  - Gestionar la lógica del programa

---

## 📋 DETALLE DE CLASES

### 3️⃣ `profesor.py` - Clase Profesor ✅ COMPLETA

**Código:**
```python
class Profesor:
    def __init__(self, nombre, materia):
        self.nombre = nombre
        self.materia = materia
    
    def saludar(self):
        return f"Hola, mi nombre es {self.nombre} y soy el nuevo profesor"
```

**Atributos:**
- ✅ `nombre` (str) - Nombre del profesor
- ✅ `materia` (str) - Materia que imparte

**Constructor:**
- ✅ `__init__(self, nombre, materia)` - Inicializa el objeto profesor
  - Recibe nombre y materia como parámetros
  - Asigna valores a atributos de instancia

**Métodos:**
- ✅ `saludar(self)` - Método de presentación
  - **Retorna:** `"Hola, mi nombre es {nombre} y soy el nuevo profesor"`
  - No recibe parámetros (solo `self`)
  - Usa `self.nombre` para acceder al atributo

**Ejemplo de uso:**
```python
# En main.py
from profesor import Profesor

profe = Profesor("Juan García", "Matemáticas")
print(profe.saludar())  
# Output: "Hola, mi nombre es Juan García y soy el nuevo profesor"
```

---

### 1️⃣ `alumno.py` - Clase Alumno ⏳ PENDIENTE

**Estado:** No vista aún en la clase

**Atributos:** ⏳ (por definir mañana)
**Constructor:** ⏳ (por definir mañana)
**Métodos:** ⏳ (por definir mañana)

---

### 2️⃣ `curso.py` - Clase Curso ⏳ PENDIENTE

**Estado:** No vista aún en la clase

**Atributos:** ⏳ (por definir mañana)
**Constructor:** ⏳ (por definir mañana)
**Métodos:** ⏳ (por definir mañana)

---

### 4️⃣ `enunciado.py` - Clase Enunciado ❓ SIN ACLARAR

**Estado:** Mencionada pero no explicada aún

**Posibles funciones:**
- Descripción del proyecto/ejercicio?
- Clase para tareas/enunciados de exámenes?
- ⏳ Pendiente aclaración en próxima sesión

---

### 5️⃣ `main.py` - Ejecutor Principal ⏳ PENDIENTE

**Estado:** No visto aún en la clase

**Funciones esperadas:**
- Importar todas las clases
- Crear objetos (Profesor, Alumno, Curso)
- Ejecutar métodos
- Coordinar interacciones entre objetos

**⏳ Por desarrollar mañana**

---

## 📊 Progreso de la Clase

### ✅ Completado:
- [x] Conceptos teóricos fundamentales (1-6)
- [x] Estructura de proyecto
- [x] Clase Profesor completa

### ⏳ Pendiente (continuar mañana):
- [ ] Clase Alumno
- [ ] Clase Curso
- [ ] Clase Enunciado (aclarar función)
- [ ] Archivo main.py
- [ ] Integración de todas las clases
- [ ] Ejecución del proyecto completo

---

## 🎓 Aprendizajes Clave de Esta Sesión

### 1. Arquitectura de Proyectos POO
- Separación de responsabilidades
- Un archivo = una clase
- Main como punto de control central

### 2. Importancia del Main
- Es el cerebro del proyecto
- Siempre en raíz
- Coordina todas las clases

### 3. Interrelación de Clases
- Las clases pueden usarse entre sí
- Imports permiten conectar módulos
- Composición de objetos

### 4. Estructura Profesional
- Código organizado y mantenible
- Reutilización de componentes
- Escalabilidad

---

## 🚀 Próximos Pasos

### Mañana (13 Febrero 2026):
1. ✅ Continuar viendo clase desde donde dejamos
2. ✅ Completar clases Alumno, Curso, Enunciado
3. ✅ Desarrollar main.py
4. ✅ Ver integración completa del proyecto
5. ✅ Actualizar estos apuntes con lo que falta

### Después de la Clase:
1. 🎯 Crear proyecto propio similar (con tu ayuda)
2. 🎯 Practicar estructura de archivos
3. 🎯 Aplicar en proyecto THDORA

---

## 📝 Notas Adicionales

### Tiempo de Estudio:
- **Inicio sesión:** 16:00 CET
- **Fin sesión:** 21:06 CET  
- **Duración total:** ~5 horas
- **Clase completada:** ~40% (estimado)

### Próxima Sesión:
- **Fecha:** 13 Febrero 2026
- **Continuar desde:** Clase Alumno
- **Objetivo:** Completar clase + crear proyecto propio

---

**Última actualización:** 12 Febrero 2026, 21:06 CET  
**Autor:** Álvaro Fernández Mota  
**Estado:** En progreso - Continuar mañana
