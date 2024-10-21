# Modelo Relacional

El modelo relacional fue desarrollado por Edgar F. Codd como un modelo general de los datos.

## Conceptos básicos

En el modelo relacional los datos se almacenan en estructuras de nominadas **relaciones** (no confundir con el concepto de relación utilizado en el modelo relacional). **Toda la información** que contiene una base de datos estará almacenada en una serie de **relaciones**.

### Cabecera

Toda relación consta de una **cabecera** (_heading_) y un **cuerpo**. La cabecera define los **atributos** de la relación. Cada atributo constará de un **nombre** y un **tipo de dato**.

### Cuerpo

El **cuerpo** contiene una serie de _tuplas_. Cada tupla tendrá tantos elementos como **atributos** se hayan definido en la **cabecera**. Cada valor de la tupla se corresponderá con un único atributo. El número de tuplas será la _cardinalidad_ de la relación.

### Restricciones (_constrains_)

En una base de datos se pueden definir una serie de expresiones lógicas (Expresiones que se pueden evaluar a **verdadero** o **falso**) que se denominarán **Restricciones**. Cuando todas las restricciones _se cumplan_ (se evalúen a **verdadero**) diremos que la base de datos es **consistente**, si esto no se cumple la base de datos será **inconsistente**.

Si intentásemos realizar una operación sobre la base de datos que la volviese inconsistente (que provocase que alguna restricción dejase de cumplirse), dicha modificación sería **ilegal** y no se debería de permitir.

### Claves

Las claves están ligadas a las relaciones.

Una **clave candidata** o simplemente **clave** será el subconjunto mínimo de atributos ue pueda identificar de manera unívoca a cada **tupla** de la relación.

#### Claves foráneas

Una clave foránea es un atributo o conjunto de atributos de la _realación a_ que se corresponde con una clave de la _relación b_. Toda clave foránea de la _relación a_ **_apuntará_** a una única tupla de la _relación b_.

Una clave foránea es la forma de _relacionar_ una o más tuplas de una _relación_ (la que tiene la clave foránea) con una **única** tupla de otra relación (aquella donde la clave foránea es clave)

### Operaciones relacionales

Una operación relacional involucrará la manipulación de una o más relaciones para dar como resultado otra relación.

Existen tres tipos de operaciones relacionales:

- Selección: implicará obtener un subconjunto de **tuplas** de una relación que satisfagan una condición. La relación resultante incluirá **todos** los atributos.
- Proyección: implicará filtrar un subconjunto de los atributos de una relación.
- Combinación o _join_: el _join_ permitirá realizar las operaciones de selección y proyección **sobre varias relaciones** a la vez.

Los usuarios de una base de datos solicitarán información de la misma mediante una **consulta** (_query_). En respuesta a la consulta, la base de datos responderá con conjunto de resultados.

En el lenguaje **SQL** la instrucción `SELECT` realizará las operaciones de *selección\*\* y *proyección\* simultáneamente:

```SQL
SELECT (lista de atributos de la proyección) FROM (relación a la que afecta) WHERE (condición de selección de las tuplas);
```

Supongamos que tenemos una relación de libros. Sus atributos serán: título, autor, nº de páginas, fecha de publicación, id_libro (la clave). Si queremos mostrar el título y el autor (proyección) de los libros de más de 100 páginas (selección) escribiremos la siguiente instrucción `SELECT`:

```SQL
SELECT (título, autor) FROM libros WHERE (num_pag > 100);
```

#### _Join_

El _join_ será una operación que se realizará entre dos o más relaciones que _compartan_ una o más _atributos_ (clave - clave foránea).

Si hablamos de dos relaciones (para simplificar) tendremos una relación con una **clave foránea** que será **clave** de otra relación. Si se cumple esto podremos hacer un _join_ entre dichas relaciones.

Por ejemplo, si tenemos una tabla de productos (id, nombre, precio) y una tabla de ventas (id_venta, fecha, id_producto, unidades) donde la columna (o atributo) _id_producto_ de la relación de ventas se corresponde con el atributo _id_ (clave) de productos. Podremos _combinarlas_ mediante la siguiente sentencia `SELECT`:

```SQL
SELECT (fecha, nombre, unidades, precio) FROM productos, ventas WHERE productos.id == ventas.id_producto;
```

Existen varios tipos de join: _inner join_, _left join_, _right join_ y _outer join_. Los veremos más adelante cuando veamos las sentencias en lenguaje SQL.

## Normalización
