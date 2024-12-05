# Normalización en el modelo relacional

<!-- toc -->

- [Formas normales](#formas-normales)
  * [Primera forma normal (1FN)](#primera-forma-normal-1fn)
  * [Segunda forma normal (2FN)](#segunda-forma-normal-2fn)
  * [Tercera forma normal (3FN)](#tercera-forma-normal-3fn)

<!-- tocstop -->

El objetivo de la normalización es simple y claro: **reducir la redundancia de datos**. Es decir, evitar que existan datos repetidos en distintas _relaciones_ (tablas) de la base de datos. Esto tiene tres efectos:

* Reducir la redundancia de datos.
* Facilitar las operaciones de actualización de datos: si un dato está _repetido_ en varios sitios y lo cambiamos en uno habrá que asegurarse de que se cambia en todos lados.
* Proteger la integridad de los datos: que se producirían si en el punto anterior no se actualizasen correctamente todas las copias del valor.

Para lograr esto se aplican una serie de reglas a las _relaciones_ obtenidas del paso del modelo ER al relacional.

_**Nota:** En la actualidad evitar la redundancia de datos no es tan importante e incluso puede verse como una ventaja. Por ejemplo, en las **bases de datos No SQL** se puede sacrificar la integridad de los datos en favor de la velocidad de acceso o la disponibilidad de los mismos._

## Formas normales

Una forma normal indica una serie de restricciones. Decimos que una relación (tabla) _cumple una forma normal_ cuando cumple las restricciones especificadas en dicha forma. Una base de datos estará en la forma normal X si todas sus relaciones lo están.

En general todas las bases de datos (relacionales) deben cumplir las tres primeras formas normales (1ª formal normal, 2ª FN y 3ª FN).

### Primera forma normal (1FN)

Una tabla estará en 1FN si:

* Todos los atributos son atómicos: Los elementos del _dominio_ (tipo de dato) son simples e indivisibles.
* No debe existir variación en el número de columnas: todas las tuplas de una relación tendrán el mismo número de atributos.
* Los atributos que no sean clave han de poder identificarse mediante la clave: _dependencia funcional_ que veremos en un momento.
* Debe existir una independencia entre el orden y el significado de los datos: Si cambiamos la organización de las columnas o el orden de las tuplas, la información contenida en la tabla no cambia.

**Dependencia funcional** de los atributos respecto a la clave quiere decir (de manera simplificada) que, dada una clave, se podrán obtener el resto de atributos a partir de ella.

### Segunda forma normal (2FN)

Una tabla estará en 2FN si está en 1FN y además:

* Los atributos que no forman parte de **ninguna clave** depende de forma completa de la clave primaria.

La mejor forma de entender esta restricción es con un ejemplo.

Supongamos que tenemos una relación: DNI, Nombre, Apellidos, Id proyecto, Horas de trabajo. La **clave primaria** de esta relación sería `{DNI, Id proyecto}`.
Esta relación **NO ESTARíA EN 2FN**. Pues los atributos `Nombre` y `Apellidos` **NO DEPENDEN** de la combinación `{DNI, Id proyecto}` si no que dependen únicamente de `DNI`. Para que se cumpliese la 2FN tendríamos que dividir la relación anterior en dos relaciones:

* Relación A: `DNI`, `Nombre`, `Apellidos`. Donde la clave primaria sería `DNI`.
* Relación B: `DNI`, `Id proyecto`, `Horas de trabajo`. Donde la clave primaria sería `{DNI, Id proyecto}` (`DNI` también sería a su vez clave foránea).

### Tercera forma normal (3FN)

Una tabla estará en 3FN cuando esté en 2FN y además _no exista ninguna **dependencia funcional transitiva** en los atributos que no son clave_.

De nuevo, intentemos verlo con un ejemplo en lugar de profundizar en el concepto de dependencia funcional.

Supongamos que tenemos la relación `Estudiantes` con los atributos `Id estudiante`, `nombre`, `apellidos`, `región`, `país`, `fecha de nacimiento`. Las dependencias entre los atributos se podrán expresar de la siguiente manera:

* `Id estudiante` &rarr; `nombre`.
* `Id estudiante` &rarr; `apellidos`.
* `Id estudiante` &rarr; `región`.
* `Id estudiante` &rarr; `fecha de nacimiento`.
* ~~`Id estudiante` &rarr; `país`.~~
* `región` &rarr; `país`.

No todos los atributos dependen **directamente** de la clave primaria `Id estudiante` ya que `país` depende de `región`, que a su vez sí depende de `Id estudiante`. Por eso podríamos decir que `país` depende **transitivamente** de `Id estudiante` a través de la dependencia `región` &rarr; `país`. Que es lo que queremos evitar. Para ello hemos de dividir la relación en otras dos:

* Relación A: `Id estudiante`, `nombre`, `apellidos`, `fecha de nacimiento`, `región`. Con clave primaria `Id estudiante`
* Relación B: `región`, `país`. Con clave primaria = `regíon`.

Y aquí lo vamos a dejar aunque existan otras tres formas normales: [Forma normal Boyce-Codd](https://es.wikipedia.org/wiki/Forma_normal_de_Boyce-Codd), [4FN](https://es.wikipedia.org/wiki/Cuarta_forma_normal) y [5FN](https://es.wikipedia.org/wiki/Quinta_forma_normal).
