"""
Módulo 4 - Tema 1.7: Uso de issubclass()

Ejemplos del uso de issubclass() e isinstance().
"""

# Jerarquía de clases para ejemplos
class Animal:
    pass


class Mamifero(Animal):
    pass


class Perro(Mamifero):
    pass


class Ave(Animal):
    pass


class Aguila(Ave):
    pass


# Tests
if __name__ == "__main__":
    # issubclass() - Verifica relaciones entre clases
    print("=== issubclass() ===")
    print(f"Perro es subclase de Mamifero: {issubclass(Perro, Mamifero)}")
    print(f"Perro es subclase de Animal: {issubclass(Perro, Animal)}")
    print(f"Perro es subclase de Ave: {issubclass(Perro, Ave)}")
    print(f"Mamifero es subclase de Animal: {issubclass(Mamifero, Animal)}")
    
    # isinstance() - Verifica tipo de instancias
    print("\n=== isinstance() ===")
    mi_perro = Perro()
    mi_aguila = Aguila()
    
    print(f"mi_perro es instancia de Perro: {isinstance(mi_perro, Perro)}")
    print(f"mi_perro es instancia de Mamifero: {isinstance(mi_perro, Mamifero)}")
    print(f"mi_perro es instancia de Animal: {isinstance(mi_perro, Animal)}")
    print(f"mi_perro es instancia de Ave: {isinstance(mi_perro, Ave)}")
    
    print(f"\nmi_aguila es instancia de Ave: {isinstance(mi_aguila, Ave)}")
    print(f"mi_aguila es instancia de Animal: {isinstance(mi_aguila, Animal)}")
