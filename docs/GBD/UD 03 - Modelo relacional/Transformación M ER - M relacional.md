# Transformación de un modelo entidad-relación a un modelo relacional

La conversión del modelo entidad-relación (MER) a un modelo relacional (MR) es una fase fundamental el el diseño de una base de datos. Mientras que el MER nos da una representación conceptual de los datos, el MR no dará una representación física de los mismos que podremos implementar en un sistema de gestión de bases de datos relacionales (SGBDR). Para poder llevar a cabo esta transformación, es necesario seguir una serie de pasos que se describen a continuación.

## Entidades

Primero veremos cómo se transforman las entidades del MER en tablas del MR. Cada entidad se transformará en una tabla y cada atributo de la entidad se transformará en un campo (o columna) de la tabla. La clave primaria de la tabla será la clave primaria de la entidad.

Cuando tenemos una entidad **débil** (una entidad cuya existencia depende de otra entidad) la transformación es sencilla. La **clave primaria de la entidad fuerte** pasará a ser una **clave foránea en la entidad débil**.

## Atributos

Los atributos pasarán a ser campos o columnas de las tablas creadas. Habrá que tener en cuenta los posibles valores de los atributos para asignarles los tipos de datos que correspondan. Habrá que tener también en cuenta cuando un atributo es opcional u obligatorio para definir si el campo correspondiente puede ser `NULL` o no (mediante una restricción).

## Relaciones

Lo que determinará la forma de representar las relaciones (en el MR no se contemplan) dependerá de la cardinalidad de las mismas. A continuación se describen los casos más comunes.

### Relación binaria con cardinalidad 1:1

El paso as seguir dependerá de la cardinalidad mínima.

#### 1 : 1 en ambas direcciones

Se elegirá **arbitrariamente** una de las dos tablas para que contenga la clave foránea de la otra tabla. En este caso, la tabla `Entidad_A` tendrá un campo `id_b` que será clave foránea de la tabla `Entidad_B`.

```mermaid
erDiagram

Entidad_A ||--|| Entidad_B : "relacionada con"

Entidad_A {
int id pk
int id_b fk
}
```

#### 1 : 1 en una dirección y 0 : 1 en la otra

En este caso, para _preservar la relación_ bastará con incluir como **clave foránea** de la tabla que tiene la cardinalidad 1 : 1 la clave primaria de la otra tabla. En este caso, la tabla `Entidad_A` tendrá un campo `id_b` que será clave foránea de la tabla `Entidad_B`. De esta forma evitamos tener campos con valores nulos.

_Si pasamos la clave primara de la `Entidad_A` a la tabla `Entidad_B`, y **no todas las instancias de `Entidad_B` se corresponden con una instancia de `Entidad_A`** tendríamos que tener campos con valores nulos de la clave foránea `id_a` en la tabla `Entidad_B`._

```mermaid
erDiagram

Entidad_A |o--|| Entidad_B : "relacionada con"

Entidad_A {
int id pk
int id_b fk
}

Entidad_B {
int id pk
}
```

#### 0 : 1 en ambas direcciones

En este caso, además de crear una tabla para cada entidad, habrá que crear una tabla para la relación. En esta tabla se incluirán las claves primarias de las **instancias** de las entidades que participen de la relación.

```mermaid
erDiagram

Entidad_A {
  int id pk
}

Entidad_B {
  int id pk
}

"Relación" {
  int id_a pk
  int id_b pk
}

Entidad_A ||--o| "Relación": "participa en"
Entidad_B |o--|| "Relación": "participa en"
```

### Relación binaria con cardinalidad 1:N

En este caso vuelve a ser relevante si la es 1:N en ambas direcciones o en una sola. En el caso de que sea 1:N en una sola dirección, la clave foránea se incluirá en la tabla de la entidad que tiene la cardinalidad 1 (ó 0:1).

```mermaid
erDiagram

Entidad_A |o--o{ Entidad_B : "relacionada con"

Entidad_A {
  int id pk
}

Entidad_B {
  int id pk
  int id_a fk
}
```

En el caso de que fuese 1:N en ambas direcciones, habría que crear una tabla para la relación.

```mermaid
erDiagram

Entidad_A ||--|{ "Relación" : "participa en"

Entidad_A {
  int id pk
}

Entidad_B {
  int id pk
}

"Relación" {
  int id_a pk
  int id_b pk
}

Entidad_B ||--|{ "Relación" : "participa en"
```
