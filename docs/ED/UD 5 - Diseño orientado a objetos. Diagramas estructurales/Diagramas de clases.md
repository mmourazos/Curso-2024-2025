# Diagramas de clases

## Especificación de una clase

### Atributos

### Métodos

## Relaciones entre clases

### Cardinalidad de una relación

### Relación de herencia

Una relación de herencia representa una relación entre dos clases, donde una clase (la subclase) hereda los atributos y métodos de otra clase (la superclase).

```mermaid
classDiagram
    class ClasePadre {
        +atributo1: tipo
        +atributo2: tipo
        +metodo1(): tipo
        +metodo2(): tipo
    }
    class ClaseHija {
        +atributo3: tipo
        +metodo3(): tipo
    }
    ClasePadre <|-- ClaseHija : hereda de
```

### Relaciones de agregación y composición

Clases que contienen (como atributos) otras clases.

Cuando hablamos de agregación las clases que están contenidas pueden existir por sí solas, mientras que en la composición no pueden existir sin la clase contenedora.

### Relación de agregación

Se representa mediante una línea con un rombo vacío en el extremo de la clase contenedora.

```mermaid
classDiagram
    class ClaseContenedora {
        +atributo1: tipo
        +atributo2: tipo
        +metodo1(): tipo
        +metodo2(): tipo
    }
    class ClaseContenida {
        +atributo3: tipo
        +metodo3(): tipo
    }
    ClaseContenedora o-- ClaseContenida : contiene a
```

Por ejemplo, podemos decir que una **empresa** tiene _contratos_ con varios **clientes**. En este caso, la empresa puede existir sin los clientes, y los clientes pueden existir sin la empresa.

```mermaid
classDiagram
    class Empresa {
        +NIF: String
        +nombre: String
        +direccion: String
        +telefono: String
        +contratados: List<Empleado>
    }
    class Cliente {
        +nombre: String
        +apellido: String
        +dni: String
    }
    Empresa "1" o-- "1..*" Cliente: tiene a
```

#### Relación de composición

```mermaid
classDiagram
    class ClaseAgregadora {
        +atributo1: tipo
        +atributo2: tipo
        +metodo1(): tipo
        +metodo2(): tipo
    }
    class ClaseAgragada {
        +atributo3: tipo
        +metodo3(): tipo
    }
    ClaseAgregadora *-- ClaseAgregada: contiene a
```

En el caso de una composición, podemos decir que una **universidad** tiene _departamentos_ y cada departamento tiene _profesores_. En este caso, la universidad no puede existir sin los departamentos, y los departamentos no pueden existir sin la universidad. Por lo tanto, la relación es de composición.

```mermaid
classDiagram
    class Universidad {
        +nombre: String
        +direccion: String
        +telefono: String
        +departamentos: List<Departamento>
    }
    class Departamento {
        +nombre: String
        +codigo: String
        +profesores: List<Profesor>
    }
    class Profesor {
        +nombre: String
        +apellido: String
        +dni: String
    }
    Universidad *-- Departamento : tiene a
    Departamento *-- Profesor : petenece a
```
