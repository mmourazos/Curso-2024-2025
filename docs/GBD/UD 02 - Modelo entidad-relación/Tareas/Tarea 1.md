# Tarea 1 - Modelo entidad-relación

## Apartado 1: Entidades y atributos

Representa utilizando el diagrama de entidad-relación (notación Crow's Foot) las siguientes entidades y atributos:
*(Indica las claves primarias, atributos calculados)*

**a)** Un instituto de formación profesional tiene cierto número **alumnos**. Cada **alumno**, al matricularse en el instituto, se le asigna un número de matrícula. De cada alumno se desea guardar su nombre, apellidos, fecha de nacimiento, dirección y teléfono. Además, se desea guardar la fecha de matriculación y el ciclo en el que se matricula (código del ciclo).

**b)** En el instituto trabajan varios **profesores**. De cada **profesor** se desea guardar su nombre, apellidos, dirección, teléfono, fecha de nacimiento y especialidad. Además, se desea guardar la fecha de incorporación al instituto y el número de horas semanales que imparte.

**c)** En dicho instituto, como hemos dicho, se imparten distintos **ciclos**. De cada **cicló** se ha de conocer su código, nombre, número de horas, duración en semanas y el número de horas semanales. Además hemos de saber quien es el tutor del ciclo, que es un profesor del instituto.

**d)** Cada ciclo se compone de distintos **módulos**. De cada **módulo** se ha de conocer su código, nombre, número de horas y el ciclo al que pertenece. Del mismo modo tendremos que saber el nombre del profesor que imparte el módulo (no tendremos en cuenta el desdoblamiento en grupos de los módulos).

## Apartado 2: Relaciones

**a)** Representa la relación entre `ALUMNO` y `CICLO`. Un alumno se matricula en un ciclo (ignoraremos la posibilidad de matricularse simultáneamente de dos ciclos) y un ciclo tiene matriculados a varios alumnos.

**b)** Representa la relación entre `CICLO` y `MODULO`. Un ciclo se compone de varios módulos y un módulo pertenece a un solo ciclo.

**c)** Representa la relación entre `PROFESOR` y `MODULO`, y la relación entre `PROFESOR` y `CICLO`.

## Apartado 3: Modelo final

Representa el modelo entidad-relación completo, incluyendo las entidades y relaciones descritas en los apartados anteriores.
