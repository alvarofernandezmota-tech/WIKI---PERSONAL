## EJERCICIO 2: Usando la clase Jet, crea nuevas instancias con los siguientes 
# nombres y orígenes: SU33: Russia, AJS37: Sweden, Mirage2000: France, 
# F14: USA, Mig29: USSR, A10: USA
class Jet:
    def __init__(self, name, country):
        self.name = name
        self.origin = country



su33 = Jet("SU33", "Russia")
ajs37 = Jet("AJS37", "Sweden")
mirage2000 = Jet("Mirage2000", "France")
f14 = Jet("F14", "USA")
mig29 = Jet("Mig29", "USSR")
a10 = Jet("A10", "USA")

print("=" * 50)
print(" "*10 + "INVENTARIO JETS")
print("=" * 50)

jets = [su33, ajs37, mirage2000, f14, mig29, a10]

for jet in jets:
    print(f"\n     Nombre: {jet.name} [{jet.origin}]")
print("\n" + "=" * 50)
