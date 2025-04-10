class Figura {
  constructor(color, material) {
    this.color = color;
    this.material = material;
  }
}

class Cubo extends Figura {
  constructor(color, material, lado) {
    super(color, material);
    this.lado = lado;
  }

  calcularVolumen() {
    return this.lado ** 3;
  }
}
