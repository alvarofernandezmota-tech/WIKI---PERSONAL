"""Ejercicios Prácticos - Tema 1: Herencia y Polimorfismo

Ejercicios progresivos para consolidar los conceptos de:
- Herencia simple y múltiple
- Uso de super()
- Polimorfismo
- Sobrescritura de métodos

Instrucciones:
1. Lee cada ejercicio
2. Implementa la solución debajo del enunciado
3. Ejecuta y prueba tu código
4. Verifica que funciona correctamente
"""

print("📚 MÓDULO 4 - TEMA 1: EJERCICIOS PRÁCTICOS")
print("=" * 70)
print()

# =============================================================================
# EJERCICIO 1: Herencia Simple - Sistema de Vehículos
# =============================================================================
"""
🎯 EJERCICIO 1: Sistema de Vehículos

Crea un sistema de vehículos con las siguientes especificaciones:

1. Clase base 'Vehiculo' con:
   - Atributos: marca, modelo, año
   - Método: mostrar_info() que imprime todos los atributos
   - Método: arrancar() que imprime "El vehículo está arrancando"

2. Clase 'Coche' que hereda de Vehiculo:
   - Atributo adicional: num_puertas
   - Sobrescribe arrancar() para imprimir "El coche está arrancando con llave"
   - Sobrescribe mostrar_info() usando super() para añadir num_puertas

3. Clase 'Moto' que hereda de Vehiculo:
   - Atributo adicional: tipo (deportiva, custom, touring)
   - Sobrescribe arrancar() para imprimir "La moto está arrancando con botón"
   - Sobrescribe mostrar_info() usando super() para añadir tipo

Prueba creando:
- Un Coche: Toyota Corolla 2024 con 4 puertas
- Una Moto: Harley Davidson 2023 tipo custom
"""

print("=" * 70)
print("📝 EJERCICIO 1: Sistema de Vehículos")
print("=" * 70)
print()

# ✅ COMPLETADO:

class Vehiculo:
   def __init__(self, marca, modelo, año):
        self.marca = marca
        self.año = año
        self.modelo = modelo
      
   def mostrar_info(self):
         print(f"Marca: {self.marca}, modelo: {self.modelo}, año: {self.año}")

   def arrancar(self):
         print("El vehículo está arrancando")

class Coche(Vehiculo):
    def __init__(self, marca, modelo, año, num_puertas):
        super().__init__(marca, modelo, año)
        self.num_puertas = num_puertas

    def arrancar(self):
        print("El coche está arrancando con llave")

    def mostrar_info(self):
        super().mostrar_info()
        print(f"Número de puertas: {self.num_puertas}")

class Moto(Vehiculo):
      def __init__(self, marca, modelo, año, tipo):
         super().__init__(marca, modelo, año)
         self.tipo = tipo
   
      def arrancar(self):
         print("La moto está arrancando con botón")
   
      def mostrar_info(self):
         super().mostrar_info()
         print(f"Tipo de moto: {self.tipo}")
      
# Prueba de las clases
coche = Coche("toyota", "corolla", 2024, 4)
moto = Moto("Harley Davidson", "Street 750", 2023, "custom")
coche.mostrar_info()
coche.arrancar()
print("=====" * 10)
moto.mostrar_info()
moto.arrancar()

print("\n✅ Ejercicio 1 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# EJERCICIO 2: Herencia Múltiple - Dispositivos Electrónicos
# =============================================================================
"""
🎯 EJERCICIO 2: Herencia Múltiple

Crea un sistema de dispositivos electrónicos con herencia múltiple:

1. Clase 'DispositivoElectronico':
   - Atributos: marca, consumo_watts
   - Método: encender() imprime "Dispositivo encendido"

2. Clase 'Conectividad':
   - Atributos: tiene_wifi, tiene_bluetooth
   - Método: conectar(tipo) imprime el tipo de conexión

3. Clase 'Smartphone' que hereda de AMBAS:
   - Atributos adicionales: modelo, sistema_operativo
   - Usa super().__init__() correctamente para ambas clases padre
   - Método propio: hacer_llamada(numero)

4. Clase 'Tablet' que también hereda de AMBAS:
   - Atributos adicionales: tamaño_pantalla
   - Usa super().__init__() correctamente
   - Método propio: leer_ebook(titulo)

Prueba creando:
- Un Smartphone: iPhone 15, iOS, 10W, WiFi y Bluetooth
- Una Tablet: Samsung Galaxy Tab, 12.4\", 15W, WiFi y Bluetooth
"""

print("\n" + "=" * 70)
print("📝 EJERCICIO 2: Herencia Múltiple")
print("=" * 70)
print()

# ✅ COMPLETADO:
class DispositivoElectronico:
   def __init__(self, marca, consumo_watts):
        self.marca = marca
        self.consumo_watts = consumo_watts

   def encender(self):
       print("Dispositivo encendido")

class Conectividad:
   def __init__(self, tiene_wifi, tiene_bluetooth):
       self.tiene_wifi = tiene_wifi
       self.tiene_bluetooth = tiene_bluetooth

   def conectar(self, tipo):
       print(f"Conectando por {tipo}...")

class Smartphone(DispositivoElectronico, Conectividad):
    def __init__(self, marca, consumo_watts, tiene_wifi, tiene_bluetooth, modelo, sistema_operativo):
        DispositivoElectronico.__init__(self, marca, consumo_watts)
        Conectividad.__init__(self, tiene_wifi, tiene_bluetooth)
        self.modelo = modelo
        self.sistema_operativo = sistema_operativo
      
    def hacer_llamada(self, numero):
        print(f"Haciendo llamada al {numero}...")
    
class Tablet(DispositivoElectronico, Conectividad):
    def __init__(self, marca, consumo_watts, tiene_wifi, tiene_bluetooth, tamaño_pantalla):
        DispositivoElectronico.__init__(self, marca, consumo_watts)
        Conectividad.__init__(self, tiene_wifi, tiene_bluetooth)
        self.tamaño_pantalla = tamaño_pantalla

    def leer_ebook(self, titulo):
        print(f"Leyendo el ebook: {titulo}...")

# Prueba de las clases
smartphone = Smartphone("Apple", 10, True, True, "iPhone 15", "iOS")
tablet = Tablet("Samsung", 15, True, True, "12.4\"")

print("\n✅ Ejercicio 2 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# EJERCICIO 3: Polimorfismo - Sistema de Empleados
# =============================================================================
"""
🎯 EJERCICIO 3: Polimorfismo con Empleados

Crea un sistema de empleados con polimorfismo:

1. Clase base 'Empleado':
   - Atributos: nombre, salario_base
   - Método: calcular_salario() que retorna salario_base
   - Método: presentarse() que imprime nombre

2. Clase 'EmpleadoTiempoCompleto' (hereda de Empleado):
   - Atributo adicional: bono_anual
   - Sobrescribe calcular_salario() para incluir bono_anual / 12

3. Clase 'EmpleadoMedioTiempo' (hereda de Empleado):
   - Atributo adicional: horas_semanales
   - Sobrescribe calcular_salario() multiplicando por horas_semanales / 40

4. Clase 'Freelancer' (hereda de Empleado):
   - Atributos: proyectos_completados, tarifa_proyecto
   - Sobrescribe calcular_salario() como proyectos * tarifa

5. Crea función 'procesar_nomina(empleados)' que:
   - Recibe lista de empleados
   - Imprime nombre y salario calculado de cada uno
   - Usa polimorfismo (mismo método, diferente comportamiento)

Prueba con:
- EmpleadoTiempoCompleto: Ana, 3000€/mes, 6000€ bono
- EmpleadoMedioTiempo: Luis, 3000€/mes, 20 horas/semana
- Freelancer: María, 2 proyectos, 5000€/proyecto
"""

print("\n" + "=" * 70)
print("📝 EJERCICIO 3: Polimorfismo con Empleados")
print("=" * 70)
print()

# ✅ COMPLETADO:

class Empleado:
    def __init__(self, nombre, salario_base):
        self.nombre = nombre
        self.salario_base = salario_base

    def calcular_salario(self):
        return self.salario_base

    def presentarse(self):
        print(f"Hola, soy {self.nombre}")


class EmpleadoTiempoCompleto(Empleado):
    def __init__(self, nombre, salario_base, bono_anual):
        super().__init__(nombre, salario_base)
        self.bono_anual = bono_anual

    def calcular_salario(self):
        return self.salario_base + (self.bono_anual / 12)


class EmpleadoMedioTiempo(Empleado):
    def __init__(self, nombre, salario_base, horas_semanales):
        super().__init__(nombre, salario_base)
        self.horas_semanales = horas_semanales

    def calcular_salario(self):
        return self.salario_base * (self.horas_semanales / 40)


class Freelancer(Empleado):
    def __init__(self, nombre, proyectos_completados, tarifa_proyecto):
        super().__init__(nombre, 0)
        self.proyectos_completados = proyectos_completados
        self.tarifa_proyecto = tarifa_proyecto

    def calcular_salario(self):
        return self.proyectos_completados * self.tarifa_proyecto


def procesar_nomina(empleados):
    """Procesa nómina mostrando polimorfismo"""
    print("\n💰 PROCESANDO NÓMINA")
    print("=" * 70)
    total = 0
    for empleado in empleados:
        salario = empleado.calcular_salario()
        total += salario
        print(f"{empleado.nombre:<20s} → {salario:>10,.2f}€")
    print("=" * 70)
    print(f"{'TOTAL':<20s} → {total:>10,.2f}€")
    print("=" * 70)


# Pruebas
ana = EmpleadoTiempoCompleto("Ana", 3000, 6000)
luis = EmpleadoMedioTiempo("Luis", 3000, 20)
maria = Freelancer("María", 2, 5000)

procesar_nomina([ana, luis, maria])

print("\n✅ Ejercicio 3 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# EJERCICIO 4: super() Avanzado - Cadena de Inicialización
# =============================================================================
"""
🎯 EJERCICIO 4: Cadena de super()

Crea una jerarquía de clases donde super() es crucial:

1. Clase 'SerVivo':
   - Atributo: edad
   - __init__(edad)
   - Método: respirar() imprime "Respirando..."

2. Clase 'Mamifero' (hereda SerVivo):
   - Atributo adicional: tipo_pelo
   - __init__(edad, tipo_pelo) usando super()
   - Método: amamantar() imprime "Amamantando crías..."

3. Clase 'Carnivoro' (hereda Mamifero):
   - Atributo adicional: dieta
   - __init__(edad, tipo_pelo, dieta) usando super()
   - Método: cazar() imprime "Cazando presa..."

4. Clase 'Leon' (hereda Carnivoro):
   - Atributo adicional: nombre_manada
   - __init__ completo usando super() correctamente
   - Método: rugir() imprime "ROAAARRR!"

IMPORTANTE: Cada __init__ debe llamar a super().__init__() 
con los parámetros correctos.

Prueba creando:
- Un León: 5 años, pelo corto, carnívoro estricto, manada "Simba"
- Llama a todos los métodos para verificar la herencia
"""

print("\n" + "=" * 70)
print("📝 EJERCICIO 4: Cadena de super()")
print("=" * 70)
print()

# ✅ COMPLETADO:

class SerVivo:
    def __init__(self, edad):
        self.edad = edad
        print(f"  → SerVivo creado con edad: {edad}")
    
    def respirar(self):
        print("💨 Respirando...")


class Mamifero(SerVivo):
    def __init__(self, edad, tipo_pelo):
        super().__init__(edad)
        print(f"  → Mamífero creado con tipo_pelo: {tipo_pelo}")
        self.tipo_pelo = tipo_pelo
    
    def amamantar(self):
        print("🍼 Amamantando crías...")


class Carnivoro(Mamifero):
    def __init__(self, edad, tipo_pelo, dieta):
        super().__init__(edad, tipo_pelo)
        print(f"  → Carnívoro creado con dieta: {dieta}")
        self.dieta = dieta
    
    def cazar(self):
        print("🦁 Cazando presa...")


class Leon(Carnivoro):
    def __init__(self, edad, tipo_pelo, dieta, nombre_manada):
        super().__init__(edad, tipo_pelo, dieta)
        print(f"  → León creado, manada: {nombre_manada}")
        self.nombre_manada = nombre_manada
    
    def rugir(self):
        print("🦁 ROAAARRR!")


# Pruebas
print("\n🦁 CREANDO LEÓN - Observa la cadena de super():")
print("=" * 70)
simba = Leon(5, "corto", "carnívoro estricto", "Simba")

print("\n📊 ATRIBUTOS DEL LEÓN:")
print("=" * 70)
print(f"🔹 Edad: {simba.edad} años")
print(f"🔹 Tipo de pelo: {simba.tipo_pelo}")
print(f"🔹 Dieta: {simba.dieta}")
print(f"🔹 Manada: {simba.nombre_manada}")

print("\n🎬 MÉTODOS HEREDADOS:")
print("=" * 70)
simba.respirar()
simba.amamantar()
simba.cazar()
simba.rugir()

print("\n✅ Ejercicio 4 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# EJERCICIO 5: Polimorfismo - Sistema de Figuras Geométricas
# =============================================================================
"""
🎯 EJERCICIO 5: Figuras Geométricas

Crea un sistema de figuras geométricas con polimorfismo:

1. Clase base 'Figura':
   - Atributo: nombre
   - Método: area() que retorna 0 (será sobrescrito)
   - Método: perimetro() que retorna 0 (será sobrescrito)

2. Clase 'Rectangulo' (hereda Figura):
   - Atributos: base, altura
   - Implementa area() = base * altura
   - Implementa perimetro() = 2 * (base + altura)

3. Clase 'Circulo' (hereda Figura):
   - Atributo: radio
   - Implementa area() = π * radio² (usa 3.14159)
   - Implementa perimetro() = 2 * π * radio

4. Clase 'Triangulo' (hereda Figura):
   - Atributos: lado1, lado2, lado3, base, altura
   - Implementa perimetro() = lado1 + lado2 + lado3
   - Implementa area() = (base * altura) / 2

5. Función 'comparar_areas(figuras)':
   - Recibe lista de figuras
   - Imprime área de cada una
   - Encuentra y muestra la figura con mayor área

Prueba con:
- Rectángulo 5x3
- Círculo radio 4
- Triángulo base 6, altura 4, lados 5,5,6
"""

print("\n" + "=" * 70)
print("📝 EJERCICIO 5: Figuras Geométricas")
print("=" * 70)
print()

# ✅ COMPLETADO:

class Figura:
    def __init__(self, nombre):
        self.nombre = nombre
    
    def area(self):
        return 0
    
    def perimetro(self):
        return 0


class Rectangulo(Figura):
    def __init__(self, base, altura):
        super().__init__("Rectángulo")
        self.base = base
        self.altura = altura
    
    def area(self):
        return self.base * self.altura
    
    def perimetro(self):
        return 2 * (self.base + self.altura)


class Circulo(Figura):
    def __init__(self, radio):
        super().__init__("Círculo")
        self.radio = radio
        self.pi = 3.14159
    
    def area(self):
        return self.pi * (self.radio ** 2)
    
    def perimetro(self):
        return 2 * self.pi * self.radio


class Triangulo(Figura):
    def __init__(self, lado1, lado2, lado3, base, altura):
        super().__init__("Triángulo")
        self.lado1 = lado1
        self.lado2 = lado2
        self.lado3 = lado3
        self.base = base
        self.altura = altura
    
    def area(self):
        return (self.base * self.altura) / 2
    
    def perimetro(self):
        return self.lado1 + self.lado2 + self.lado3


def comparar_areas(figuras):
    """Compara áreas usando polimorfismo"""
    print("\n📐 COMPARACIÓN DE ÁREAS DE FIGURAS")
    print("=" * 70)
    
    mayor_figura = None
    mayor_area = 0
    
    for figura in figuras:
        area = figura.area()
        perimetro = figura.perimetro()
        
        print(f"\n🔹 {figura.nombre}:")
        print(f"   Área:      {area:.2f} unidades²")
        print(f"   Perímetro: {perimetro:.2f} unidades")
        
        if area > mayor_area:
            mayor_area = area
            mayor_figura = figura
    
    print("\n" + "=" * 70)
    print(f"🏆 FIGURA CON MAYOR ÁREA:")
    print(f"   {mayor_figura.nombre} con {mayor_area:.2f} unidades²")
    print("=" * 70)


# Pruebas
rectangulo = Rectangulo(5, 3)
circulo = Circulo(4)
triangulo = Triangulo(5, 5, 6, 6, 4)

figuras = [rectangulo, circulo, triangulo]
comparar_areas(figuras)

print("\n✅ Ejercicio 5 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# EJERCICIO 6: Desafío - Sistema de Videojuego
# =============================================================================
"""
🎯 EJERCICIO 6: Sistema de Videojuego (DESAFÍO)

Crea un sistema de personajes para un videojuego:

1. Clase 'Personaje':
   - Atributos: nombre, vida, nivel
   - Método: atacar() retorna daño base (nivel * 10)
   - Método: recibir_dano(cantidad) reduce vida
   - Método: esta_vivo() retorna True si vida > 0

2. Clase 'Guerrero' (hereda Personaje):
   - Atributo adicional: fuerza
   - Sobrescribe atacar() = nivel * 10 + fuerza * 2
   - Método especial: golpe_critico() = atacar() * 2

3. Clase 'Mago' (hereda Personaje):
   - Atributo adicional: mana, inteligencia
   - Sobrescribe atacar() = nivel * 10 + inteligencia * 3
   - Método especial: hechizo(costo_mana) si tiene suficiente mana

4. Clase 'Arquero' (hereda Personaje):
   - Atributo adicional: precision, num_flechas
   - Sobrescribe atacar() = nivel * 10 + precision * 1.5
   - Método especial: disparo_multiple() usa 3 flechas

5. Función 'simular_batalla(personaje1, personaje2)':
   - Turnos alternados de ataque
   - Muestra vida después de cada ataque
   - Declara ganador cuando uno muere

Prueba con:
- Guerrero: "Conan", 100 vida, nivel 5, fuerza 15
- Mago: "Gandalf", 80 vida, nivel 5, 50 mana, inteligencia 20
- Simula una batalla entre ellos
"""

print("\n" + "=" * 70)
print("📝 EJERCICIO 6: Sistema de Videojuego (DESAFÍO)")
print("=" * 70)
print()

# ✅ COMPLETADO:

class Personaje:
    def __init__(self, nombre, vida, nivel):
        self.nombre = nombre
        self.vida = vida
        self.vida_maxima = vida
        self.nivel = nivel
    
    def atacar(self):
        return self.nivel * 10
    
    def recibir_dano(self, cantidad):
        self.vida -= cantidad
        if self.vida < 0:
            self.vida = 0
    
    def esta_vivo(self):
        return self.vida > 0
    
    def mostrar_estado(self):
        barra_vida = "█" * int((self.vida / self.vida_maxima) * 20)
        print(f"   {self.nombre}: {barra_vida} {self.vida}/{self.vida_maxima} HP")


class Guerrero(Personaje):
    def __init__(self, nombre, vida, nivel, fuerza):
        super().__init__(nombre, vida, nivel)
        self.fuerza = fuerza
    
    def atacar(self):
        return self.nivel * 10 + self.fuerza * 2
    
    def golpe_critico(self):
        dano_normal = self.atacar()
        dano_critico = dano_normal * 2
        print(f"   💥 ¡{self.nombre} usa GOLPE CRÍTICO!")
        return dano_critico


class Mago(Personaje):
    def __init__(self, nombre, vida, nivel, mana, inteligencia):
        super().__init__(nombre, vida, nivel)
        self.mana = mana
        self.mana_maxima = mana
        self.inteligencia = inteligencia
    
    def atacar(self):
        return self.nivel * 10 + self.inteligencia * 3
    
    def hechizo(self, costo_mana):
        if self.mana >= costo_mana:
            self.mana -= costo_mana
            dano = self.atacar() * 1.5
            print(f"   ✨ ¡{self.nombre} lanza HECHIZO! (Mana: {self.mana}/{self.mana_maxima})")
            return int(dano)
        else:
            print(f"   ⚠️ {self.nombre} no tiene suficiente mana, ataque normal")
            return self.atacar()
    
    def mostrar_estado(self):
        super().mostrar_estado()
        barra_mana = "▓" * int((self.mana / self.mana_maxima) * 20)
        print(f"   {self.nombre}: {barra_mana} {self.mana}/{self.mana_maxima} MP")


class Arquero(Personaje):
    def __init__(self, nombre, vida, nivel, precision, num_flechas):
        super().__init__(nombre, vida, nivel)
        self.precision = precision
        self.num_flechas = num_flechas
        self.flechas_maximas = num_flechas
    
    def atacar(self):
        if self.num_flechas > 0:
            self.num_flechas -= 1
            return self.nivel * 10 + self.precision * 1.5
        else:
            print(f"   ⚠️ {self.nombre} no tiene flechas, ataque débil")
            return self.nivel * 5
    
    def disparo_multiple(self):
        if self.num_flechas >= 3:
            self.num_flechas -= 3
            dano = self.atacar() * 3
            print(f"   🏹 ¡{self.nombre} usa DISPARO MÚLTIPLE! (Flechas: {self.num_flechas}/{self.flechas_maximas})")
            return dano
        else:
            print(f"   ⚠️ {self.nombre} no tiene 3 flechas, ataque normal")
            return self.atacar()
    
    def mostrar_estado(self):
        super().mostrar_estado()
        print(f"   {self.nombre}: 🏹 {self.num_flechas}/{self.flechas_maximas} flechas")


def simular_batalla(personaje1, personaje2):
    """Simula batalla épica por turnos"""
    print("\n" + "=" * 70)
    print("⚔️  COMIENZA LA BATALLA ÉPICA")
    print("=" * 70)
    print(f"\n🔴 {personaje1.nombre} ({personaje1.__class__.__name__}) VS {personaje2.nombre} ({personaje2.__class__.__name__}) 🔵")
    
    turno = 1
    atacante = personaje1
    defensor = personaje2
    
    while personaje1.esta_vivo() and personaje2.esta_vivo():
        print(f"\n{'─' * 70}")
        print(f"⚔️  TURNO {turno}")
        print(f"{'─' * 70}")
        
        dano = atacante.atacar()
        print(f"🗡️  {atacante.nombre} ataca a {defensor.nombre}")
        print(f"   💥 Daño infligido: {dano:.1f}")
        
        defensor.recibir_dano(dano)
        
        print(f"\n📊 Estado después del ataque:")
        personaje1.mostrar_estado()
        personaje2.mostrar_estado()
        
        if not defensor.esta_vivo():
            break
        
        atacante, defensor = defensor, atacante
        turno += 1
    
    print("\n" + "=" * 70)
    if personaje1.esta_vivo():
        print(f"🏆 ¡VICTORIA! {personaje1.nombre} gana la batalla!")
        print(f"   Vida restante: {personaje1.vida}/{personaje1.vida_maxima} HP")
    else:
        print(f"🏆 ¡VICTORIA! {personaje2.nombre} gana la batalla!")
        print(f"   Vida restante: {personaje2.vida}/{personaje2.vida_maxima} HP")
    print("=" * 70)


# Pruebas
conan = Guerrero("Conan", 100, 5, 15)
gandalf = Mago("Gandalf", 80, 5, 50, 20)

simular_batalla(conan, gandalf)

print("\n✅ Ejercicio 6 completado!\n")
print("\n" + "=" * 70)


# =============================================================================
# RESUMEN FINAL
# =============================================================================

print("\n" + "=" * 70)
print("🎉 ¡FELICIDADES! TODOS LOS EJERCICIOS COMPLETADOS")
print("=" * 70)
print()
print("✅ Ejercicio 1: Sistema de Vehículos")
print("✅ Ejercicio 2: Herencia Múltiple")
print("✅ Ejercicio 3: Polimorfismo con Empleados")
print("✅ Ejercicio 4: Cadena de super()")
print("✅ Ejercicio 5: Figuras Geométricas")
print("✅ Ejercicio 6: Sistema de Videojuego")
print()
print("🎯 Conceptos dominados:")
print("   ✅ Herencia simple y múltiple")
print("   ✅ Uso correcto de super()")
print("   ✅ Polimorfismo en acción")
print("   ✅ Sobrescritura de métodos")
print("   ✅ Cadenas de inicialización")
print()
print("🚀 ¡Listo para el Tema 2: Abstract Base Classes!")
print("=" * 70)
