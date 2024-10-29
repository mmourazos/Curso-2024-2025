# Ejercicio 2

## Enunciado

_Se desea informatizar la gestión de una empresa de transportes que reparte **paquetes** por toda España. Los encargados de llevar los paquetes son los **camioneros** de los que se quiere guardar el dni, nombre, teléfono, dirección, salario y población en la que vive. De los **paquetes** transportados interesa conocer el código de paquete, descripción, destinatario y dirección del destinatario. Un camionero distribuye muchos paquetes, y un paquete sólo puede ser distribuido por un camionero. De las **provincias** a las que llegan los paquetes interesa guardar el código de provincia y el nombre. Un paquete sólo se puede llevar a una provincia. Sin embargo, a una provincia pueden llegar varios paquetes. De los **camiones** que llevan los camioneros, interesa conocer la matrícula, modelo, tipo y potencia. Un camionero puede conducir diferentes camiones en fechas diferentes, y un camión puede ser conducido por varios camioneros._

## Entidades

* Camionero: dni, nombre, teléfono, dirección, salario, población.
* Camión: matrícula, modelo, tipo, potencia.
* Paquete: código, descripción, destinatario, dirección.
* Província: código, nombre.

Podría ser interesante añadir una entidad **destinatario** en caso de que se repita muchas veces. Lo mismo con la entidad que envía los paquetes (que podría ser **Cliente**).
Destinatario: dirección.

## Relaciones

* Llevar: Un camionero lleva paquetes. Un paquete está asignado a un camionero y cada caminonero transporta varios paquetes.
* Counducir: Un camionero conduce varios camiones (distintas fechas) y u campión será conducido por varios camioneros.

## Diagrama ER

```mermaid
erDiagram
Camionero {
   string dni pk
   string nombre
   int telefono
   string direccion
   int salario
   string poblacion
}

Camion {
   string matricula pk
}

Paquete {
   int codigo pk
   string direccion
   int cod_provincia fk
}

Provincia {
   int codigo pk
   string nombre
}

Poblaciones {
   int codigo
   int cod_provincia
   string nombre
}

Camionero }o--o{ Camion: conducir
Camionero ||--o{ Paquete: tranportar
```

## Modelo Relacional / tablas
