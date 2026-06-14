"""
Ejemplos Prácticos Completos - Herencia y Polimorfismo

Casos de uso reales combinando todos los conceptos.
"""

# Ejemplo práctico: Sistema de empleados
class Empleado:
    """Clase base para empleados"""
    
    def __init__(self, nombre, id_empleado, salario_base):
        self.nombre = nombre
        self.id_empleado = id_empleado
        self.salario_base = salario_base
    
    def calcular_salario(self):
        return self.salario_base
    
    def info(self):
        return f"Empleado: {self.nombre} (ID: {self.id_empleado})"


class Desarrollador(Empleado):
    """Desarrollador con bonus por proyectos"""
    
    def __init__(self, nombre, id_empleado, salario_base, lenguajes):
        super().__init__(nombre, id_empleado, salario_base)
        self.lenguajes = lenguajes
        self.proyectos_completados = 0
    
    def completar_proyecto(self):
        self.proyectos_completados += 1
    
    def calcular_salario(self):
        bonus = self.proyectos_completados * 200
        return super().calcular_salario() + bonus
    
    def info(self):
        base_info = super().info()
        return f"{base_info}\nRol: Desarrollador\nLenguajes: {', '.join(self.lenguajes)}"


class Manager(Empleado):
    """Manager con bonus por equipo"""
    
    def __init__(self, nombre, id_empleado, salario_base, equipo_size):
        super().__init__(nombre, id_empleado, salario_base)
        self.equipo_size = equipo_size
    
    def calcular_salario(self):
        bonus = self.equipo_size * 100
        return super().calcular_salario() + bonus
    
    def info(self):
        base_info = super().info()
        return f"{base_info}\nRol: Manager\nTamaño equipo: {self.equipo_size}"


def procesar_nomina(empleados):
    """Procesar nómina usando polimorfismo"""
    total = 0
    print("=== NÓMINA DEL MES ===")
    print("=" * 50)
    
    for empleado in empleados:
        salario = empleado.calcular_salario()
        total += salario
        print(f"{empleado.nombre}: ${salario:.2f}")
    
    print("=" * 50)
    print(f"TOTAL NÓMINA: ${total:.2f}")
    return total


# Tests
if __name__ == "__main__":
    # Crear empleados
    dev1 = Desarrollador("Ana Gómez", "D001", 3000, ["Python", "JavaScript"])
    dev1.completar_proyecto()
    dev1.completar_proyecto()
    
    dev2 = Desarrollador("Carlos Ruiz", "D002", 3200, ["Java", "C++"])
    dev2.completar_proyecto()
    
    manager = Manager("Laura Martínez", "M001", 4000, 5)
    
    empleados = [dev1, dev2, manager]
    
    # Mostrar info de cada empleado
    for emp in empleados:
        print(emp.info())
        print(f"Salario: ${emp.calcular_salario():.2f}")
        print("-" * 50)
    
    # Procesar nómina
    print("\n")
    procesar_nomina(empleados)
