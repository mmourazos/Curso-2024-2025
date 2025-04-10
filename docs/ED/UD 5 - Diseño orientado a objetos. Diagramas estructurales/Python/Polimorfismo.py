class Animal:
    def __init__(self, name):
        self.name = name

    def sonido(self):
        raise NotImplementedError("Subclasses must implement this method")

    def comida_favorita(self):
        raise NotImplementedError("Subclasses must implement this method")


class Perro(Animal):
    def sonido(self) -> str:
        return "Guau"

    def comida_favorita(self) -> str:
        return "Carne"


class Gato(Animal):
    def sonido(self) -> str:
        return "Miau"

    def comida_favorita(self) -> str:
        return "Pescado"


if __name__ == "__main__":
    animals = [Perro("Rex"), Gato("Colorado")]
    for animal in animals:
        print(
            f"{animal.name} hace {animal.sonido()} y su comida favorita es {animal.comida_favorita()}"
        )
