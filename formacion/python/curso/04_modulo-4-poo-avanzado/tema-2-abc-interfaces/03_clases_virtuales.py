""""""Tema 2.3: Clases Virtuales con .register()

Este archivo demuestra cómo usar el método .register() para crear
relaciones de herencia virtuales sin modificar las clases existentes.
""""""

from abc import ABC, ABCMeta, abstractmethod


# =============================================================================
# EJEMPLO 1: Registro Básico
# =============================================================================

class Animal(ABC):
    """"""Clase abstracta para animales.""""""
    
    @abstractmethod
    def hacer_sonido(self):
        pass


# Clase existente que NO hereda de Animal
class Perro:
    """"""Clase independiente que implementa hacer_sonido.""""""
    
    def hacer_sonido(self):
        return "GUAU!"


# Clase que tampoco hereda de Animal
class Gato:
    """"""Otra clase independiente.""""""
    
    def hacer_sonido(self):
        return "MIAU!"


# REGISTRAR como subclases virtuales
Animal.register(Perro)
Animal.register(Gato)


# =============================================================================
# EJEMPLO 2: Tipos Numéricos Personalizados
# =============================================================================

class MiNumero(metaclass=ABCMeta):
    """"""Clase abstracta para números personalizados.""""""
    pass


# Registrar tipos nativos de Python como "subclases"
MiNumero.register(int)
MiNumero.register(float)
MiNumero.register(complex)


# =============================================================================
# EJEMPLO 3: Sistema de Archivos Virtual
# =============================================================================

class Almacenable(ABC):
    """"""Interfaz para objetos que pueden ser almacenados.""""""
    
    @abstractmethod
    def guardar(self):
        pass
    
    @abstractmethod
    def cargar(self):
        pass


# Clases de terceros (que no podemos modificar)
class DocumentoTexto:
    """"""Clase de librería externa.""""""
    
    def __init__(self, contenido):
        self.contenido = contenido
    
    def guardar(self):
        return f"Guardando texto: {self.contenido[:30]}..."
    
    def cargar(self):
        return "Cargando documento de texto"


class ImagenJPG:
    """"""Otra clase de librería externa.""""""
    
    def __init__(self, ruta):
        self.ruta = ruta
    
    def guardar(self):
        return f"Guardando imagen: {self.ruta}"
    
    def cargar(self):
        return f"Cargando imagen desde {self.ruta}"


# Registrar como subclases virtuales
Almacenable.register(DocumentoTexto)
Almacenable.register(ImagenJPG)


# =============================================================================
# EJEMPLO 4: Verificación de Subclases
# =============================================================================

def procesar_animal(animal):
    """"""Procesar cualquier objeto considerado 'Animal'.""""""
    if isinstance(animal, Animal):
        print(f"✅ {animal.__class__.__name__} es un Animal")
        print(f"   Sonido: {animal.hacer_sonido()}")
    else:
        print(f"❌ {animal.__class__.__name__} NO es un Animal")


def procesar_almacenable(objeto):
    """"""Procesar objetos almacenables.""""""
    if isinstance(objeto, Almacenable):
        print(f"✅ {objeto.__class__.__name__} es Almacenable")
        print(f"   {objeto.guardar()}")
    else:
        print(f"❌ {objeto.__class__.__name__} NO es Almacenable")


# =============================================================================
# DEMOSTRACIÓN
# =============================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("EJEMPLO 1: Registro de Clases Virtuales")
    print("=" * 60)
    
    # Crear instancias
    perro = Perro()
    gato = Gato()
    
    # Verificar si son subclases (virtualmente)
    print("\n🔹 Verificación con issubclass():")
    print(f"Perro es subclase de Animal: {issubclass(Perro, Animal)}")
    print(f"Gato es subclase de Animal: {issubclass(Gato, Animal)}")
    
    # Verificar instancias
    print("\n🔹 Verificación con isinstance():")
    print(f"perro es instancia de Animal: {isinstance(perro, Animal)}")
    print(f"gato es instancia de Animal: {isinstance(gato, Animal)}")
    
    # Procesar animales
    print("\n🔹 Procesando animales:")
    procesar_animal(perro)
    procesar_animal(gato)
    
    print("\n" + "=" * 60)
    print("EJEMPLO 2: Tipos Numéricos")
    print("=" * 60)
    
    # Verificar tipos nativos
    print("\n🔹 Tipos nativos como subclases virtuales:")
    print(f"int es subclase de MiNumero: {issubclass(int, MiNumero)}")
    print(f"float es subclase de MiNumero: {issubclass(float, MiNumero)}")
    print(f"complex es subclase de MiNumero: {issubclass(complex, MiNumero)}")
    
    # Verificar instancias
    print("\n🔹 Instancias de tipos nativos:")
    print(f"42 es instancia de MiNumero: {isinstance(42, MiNumero)}")
    print(f"3.14 es instancia de MiNumero: {isinstance(3.14, MiNumero)}")
    print(f"'texto' es instancia de MiNumero: {isinstance('texto', MiNumero)}")
    
    print("\n" + "=" * 60)
    print("EJEMPLO 3: Sistema de Archivos Virtual")
    print("=" * 60)
    
    # Crear objetos "externos"
    documento = DocumentoTexto("Este es un documento de prueba muy largo...")
    imagen = ImagenJPG("/ruta/a/imagen.jpg")
    
    # Verificar si son almacenables
    print("\n🔹 Clases de terceros registradas:")
    print(f"DocumentoTexto es Almacenable: {issubclass(DocumentoTexto, Almacenable)}")
    print(f"ImagenJPG es Almacenable: {issubclass(ImagenJPG, Almacenable)}")
    
    # Procesar objetos
    print("\n🔹 Procesando objetos almacenables:")
    procesar_almacenable(documento)
    print()
    procesar_almacenable(imagen)
    
    print("\n" + "=" * 60)
    print("⚠️  IMPORTANTE: Clases Virtuales")
    print("=" * 60)
    print("✅ .register() permite 'fingir' herencia")
    print("✅ Útil para clases de terceros que no puedes modificar")
    print("⚠️  La clase NO hereda métodos, solo se considera subclase")
    print("⚠️  isinstance() e issubclass() retornan True")
    print("❌ NO usar si necesitas heredar métodos reales")
    print("=" * 60)
    
    # Demostrar que NO hereda métodos
    print("\n🔹 Demostración: NO hereda métodos abstractos")
    
    class ClaseSinMetodos:
        pass
    
    Animal.register(ClaseSinMetodos)
    
    print(f"\nClaseSinMetodos es subclase de Animal: {issubclass(ClaseSinMetodos, Animal)}")
    print("Pero NO tiene el método hacer_sonido():")
    
    try:
        obj = ClaseSinMetodos()
        print(f"isinstance(obj, Animal): {isinstance(obj, Animal)}")
        obj.hacer_sonido()  # Esto fallará
    except AttributeError as e:
        print(f"❌ Error: {e}")
    
    print("\n✅ Clase virtual = solo relación lógica, NO herencia real")
