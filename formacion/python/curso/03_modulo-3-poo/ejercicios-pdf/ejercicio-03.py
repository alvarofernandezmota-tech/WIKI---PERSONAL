## EJERCICIO 3: Añade otro atributo llamado "cantidad" a la clase. El usuario le 
# dará valor pasando un nuevo parámetro por el constructor.
#  A continuación, crear 2 instancias para: F14 y Mirage2000 con las cantidades 87 y 35.
class Jet:
    def __init__(self, name, country, cantidad):  
        self.name = name
        self.origin = country
        self.cantidad = cantidad  

f14 = Jet("F14", "USA", 87)
mirage2000 = Jet("Mirage2000", "France", 35)

jets = [f14, mirage2000]

print("=" * 50)
print(" "*10 + "NUMERO JETS")
print("=" * 50)

for jet in jets:
    print(f"\n     {jet.name} [{jet.origin}][{jet.cantidad} Unidades]")
print("\n" + "=" * 50)
