# EJERCICIO 4: Dada la siguiente instancia y sus atributos, 
# crea una clase qe la instancie.
class Nobel:
    def __init__(self, category, year, winner):
        self.category = category
        self.year = year
        self.winner = winner

np2005 = Nobel("peace", 2005, "Muhamma Yunus")
print(np2005.category, np2005.year, np2005.winner)
