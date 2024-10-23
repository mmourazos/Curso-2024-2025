# Vistas

## ¿Qué es una vista?

Una vista es una consulta almacenada que devuelve un conjunto de resultados al ser invocada. Funciona como una tabla virtual que contiene datos de una o más tablas. Las vistas se utilizan para restringir el acceso a los datos de una tabla, mostrando sólo los datos que el usuario tiene permiso para ver. Además, las vistas permiten a los usuarios ver los datos de una manera más sencilla y organizada.

Como tabla virtual, una vista estará compuesta por filas y columnas que podrán pertenecer a diferentes tablas.

Si intentamos verlo en el contexto de los lenguajes de programación, una vista es como una subrutina. La definimos una vez y podremos utilizarla indefinidamente.

## Crear una vista

Para crear una vista se usará la siguiente sentencia:

```sql
CREATE VIEW <nombre_de_la_vista> AS
SELECT <columnas> FROM <tabla>
WHERE <condiciones>;
```

Para crear una vista que combine los datos de múltiples tablas se utilizará una sentencia similar a la siguiente:

```sql
CREATE VIEW <nombre_de_la_vista> AS
SELECT <columnas> FROM <tabla A, table B>
WHERE <condiciones>;
```

## Consultar una vista

Para consultar una vista se utilizará como cualquier otra tabla. La siguiente sentencia mostraría todos los datos de la vista creada anteriormente:

```sql
SELECT * FROM <nombre_de_la_vista>;
```

## Modificar una vista

Para modificar valores en una vista se usará la sentencia `UPDATE`. Cuando se modifica una vista, se modificarán los datos de la tabla a la que hace referencia.

En general, MySQL permite modificar una vista pero con ciertas restricciones. **Sólo se pueden modificar las vistas que referencien a una sola tabla.** Además, no se pueden modificar las vistas que contengan funciones agregadas como SUM(), COUNT(), AVG(), etc. No es obligatorio usar una cláusula `WHERE` cuando se modifica una vista. Hay que tener en cuenta que si usamos `WHERE` se modificará sólo una selección de registros mientras que **si no incluimos** la cláusula `WHERE` **se modificarán TODOS los registros** de la tabla.

## Permisos de vista

Podemos garantizar que una vista sólo sea accesible por un usuario concreto, o por un grupo de usuarios. Esto se hace de la misma forma que con las tablas, mediante la asignación de permisos. Para ello, debemos escribir el comando:

```
GRANT SELECT ON <nombre_de_la_vista> TO <usuario>;
```

Si tuviésemos que retirar el permiso de acceso a una vista, deberíamos escribir:

```sql
REVOKE SELECT ON <nombre_de_la_vista> FROM <usuario>;
```

## Otras limitaciones de las vistas

* En MySQL una vista *sólo* puede abarcar, como máximo, 61 tablas.
* No se pueden crear índices sobre una vista.



```
