# Creación de procedimientos almacenados

<!-- toc -->

- [Creación del procedimiento](#creacion-del-procedimiento)
  * [Comando `DELIMITER`](#comando-delimiter)
  * [Declaración de variables](#declaracion-de-variables)
    + [Tipos de variables en MySQL](#tipos-de-variables-en-mysql)
      - [Variables de sistema](#variables-de-sistema)
      - [Variables de usuario](#variables-de-usuario)
      - [Variables de procedimiento](#variables-de-procedimiento)
  * [Sección `COMMENT`](#seccion-comment)
  * [Sección `SQL SECURITY`](#seccion-sql-security)
- [Permisos relacionados con procedimientos almacenados](#permisos-relacionados-con-procedimientos-almacenados)
- [Mostrar procedimientos almacenados](#mostrar-procedimientos-almacenados)

<!-- tocstop -->

## Creación del procedimiento

Para crear un procedimiento almacenado en MySQL, se utiliza la siguiente sintaxis:

```sql
CREATE PROCEDURE nombre_procedimiento()
COMMENT 'Comentario del procedimiento'
LANGUAGE SQL
SQL SECURITY INVOKER -- O DEFINER. Define con qué identidad se ejecutará el procedimiento, lo explicaremos más adelante.
BEGIN
    -- Cuerpo del procedimiento
END;
```

### Comando `DELIMITER`

Para evitar que se ejecuten las sentencias SQL (lo harían cada vez que el intérprete encuentre un carácter `;`) durante el proceso de definición del procedimiento utilizaremos el comando `DELIMITER` que permite cambiar el delimitador de sentencias de `;` a otro carácter, por ejemplo `//`.

De este modo el ejemplo anterior quedaría de la siguiente manera:

```sql
DELIMITER // -- Cambiamos el delimitador de sentencias.

CREATE PROCEDURE nombre_procedimiento()
COMMENT 'Comentario del procedimiento'
LANGUAGE SQL
SQL SECURITY INVOKER -- O DEFINER. Define con qué identidad se ejecutará el procedimiento, lo explicaremos más adelante.
BEGIN
    -- Cuerpo del procedimiento, CON SENTENCIAS TERMINADES EN ; QUE NO SE EJECUTARÁN.
END// -- Usamos el nuevo delimitador, //, para finalizar la definición del procedimiento.
DELIMITER ; -- Volvemos a establecer el delimitador por defecto.
```

### Declaración de variables

Cuando vayamos a escribir un procedimiento almacenado, es importante tener en cuenta que las variables se declaran al principio del procedimiento. Por ejemplo:

```sql
CREATE PROCEDURE nombre_procedimiento()

-- Declaración de variables
DECLARE variable INT;

-- Resto del código.
SELECT cduser FROM usuario WHERE birthdate > 2000 ORDER BY name INTO variable;
```

#### Tipos de variables en MySQL

En MySQL tenemos tres tipos de variables: variables de usuario, variables de sistema y variables de procedimiento.

##### Variables de sistema

Las variables de sistema se utilizan para almacenar información sobre el entorno de ejecución de MySQL. Por ejemplo, `@@version` nos devuelve la versión de MySQL que estamos utilizando. Para acceder a una variable de sistema hay que precederla de `@@`. Por ejemplo, `SELECT @@version`.

##### Variables de usuario

Las variables definidas por el usuario se utilizan para almacenar valores que se pueden utilizar en las consultas. Para _crear_ las variables de usuario hay que precederlas de `@`. Por ejemplo, `SELECT @variable := 1`. Con la sentencia anterior estamos asignando el valor `1` a la variable `@variable`.
Otra forma de establecer el valor de una variable es mediante la sentencia `SET`. Por ejemplo, `SET @variable = 1`.
Otra forma de asignar un valor a una variable es mediante una consulta. Por ejemplo, `SELECT cduser FROM usuario WHERE birthdate > 2000 ORDER BY name INTO @variable`.

##### Variables de procedimiento

Las variables de procedimiento se utilizan para almacenar valores temporales que se pueden utilizar en el procedimiento. Para declarar una variable de procedimiento hay que que utilizar la sentencia `DECLARE`. Por ejemplo, `DECLARE variable INT;`.

Al utilizar la variable en el cuerpo del procedimiento, no es necesario precederla de `@` ni de `@@`. Por ejemplo, `SELECT cduser FROM usuario WHERE birthdate > 2000 ORDER BY name INTO variable;`.

**La diferencia entre las variables de usuario y de procedimiento es que mientras las primeras mantienen su valor durante toda la sesión, las segundas solo mantienen su valor durante la ejecución del procedimiento.**

### Sección `COMMENT`

Es opcional y se utiliza para agregar un comentario al procedimiento. Se puede utilizar para describir la funcionalidad del procedimiento.

### Sección `SQL SECURITY`

`SQL SECURITY` es una cláusula que interactua con el valor opcional `DEFINER = 'usuario'@'origen'` que podemos especificar en la definición del procedimiento:

`CREATE DEFINER = 'usuario'@'origen' PROCEDURE nombre_procedimiento()`

Este apartado es importante. Su valor por defecto es `DEFINER`. Es decir, si omitimos esta sección será igual a usar `SQL SECURITY DEFINER`.

Cuando definimos un procedimiento podemos hacer uso de la cláusula `DEFINER = 'usuario'@'origen'`. Si usamos esta cláusula y más adelante establecemos la opción `SQL SECURITY DEFINER`, esto hará que el ejecutor del procedimiento sea el usuario especificado en la cláusula `DEFINER`. Es decir, se ejecutará el procedimiento como si lo hiciera `'usuario'@'origen'`.

| VALOR DE `DEFINER` | VALOR DE `SQL SECURITY` | EJECUTOR DEL PROCEDIMIENTO            |
|--------------------|-------------------------|---------------------------------------|
| Omitido            | Omitido                 | El usuario que creó el procedimiento. |
| Omitido            | `DEFINER`               | El usuario que creó el procedimiento. |
| `DEFINER = 'usuario'@'origen'` | `DEFINER` | `'usuario'@'origen'` |
| Omitido            | `INVOKER`               | El usuario que invoca el procedimiento. |
| `DEFINER = 'usuario'@'origen'` | `INVOKER` | El usuario que invoca el procedimiento. |

En lenguaje llano, si **no especificamos nada** (ni `DEFINER =` ni `SQL SECURITY`), el procedimiento se ejecutará con los permisos del usuario que lo creó. Si **especificamos `SQL SECURITY INVOKER`** se ejecutará como el usuario que lo invoca. Si **especificamos `DEFINER = 'usuario'@'origen'`** y **`SQL SECURITY DEFINER`**, se ejecutará como el usuario especificado en `DEFINER`.

De este modo es importante tener en cuenta quién será el usuario que ejecutará el procedimiento y si queremos asegurarnos de que ejecutará. Es decir, para que el procedimiento pueda ejecutarse han de cumplirse dos condiciones:

* El usuario que ejecuta el procedimiento ha de tener permisos de ejecución `EXECUTE` sobre el procedimiento.
* El usuario que ejecuta el procedimiento ha de tener permisos de ejecución sobre los objetos que se utilizan en el procedimiento (por ejemplo las tablas de las bases de datos a la que acceda).

## Permisos relacionados con procedimientos almacenados

Supongamos que `'admin@'localhost'` es el usuario que crea el procedimiento y tiene permisos de acceso y modificación sobre las bases de datos.

Los permisos relacionados con los procedimientos almacenados son los siguientes:

* `CREATE ROUTINE`: Permite **crear** procedimientos almacenados y funciones.
* `ALTER ROUTINE`: Permite **modificar** procedimientos almacenados y funciones.
* `EXECUTE`: Permite **ejecutar** procedimientos almacenados y funciones.

De este modo podemos tener un usuario que es el encargado de crear los procedimientos almacenados, otro usuario con permisos de acceso o modificación sobre distintas bases de datos (que podemos usar en `DEFINER`) y otro usuario que puede ejecutar los procedimientos almacenados sin que tenga permisos de acceso o modificación sobre las bases de datos.

```sql
DELIMITER //
CREATE DEFINER 'admin'@'localhost' PROCEDURE Cliente.mantenimiento ()
SQL SECURITY DEFINER BEGIN
    -- Cuerpo del procedimiento
END//
DELIMITER ;
```

Si creamos un usuario (`'usuario'@'%'`) **sin permiso sobre ninguna base de datos** pero con permiso de ejecución sobre el procedimiento, podrá ejecutar el procedimiento sin problemas:

`GRANT EXECUTE ON PROCEDURE Cliente.mantenimiento TO 'usuario'@'%';`

## Mostrar procedimientos almacenados

Para listar los procedimientos almacenados de una base de datos, podemos utilizar la siguiente consulta:

```sql
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
```

Si quisiéramos ver las _funciones_ almacenadas habremos de cambiar `PROCEDURE` por `FUNCTION` respectivamente:

```SQL
SHOW FUNCTION STATUS WHERE Db = 'nombre_base_datos';
```

Y para mostrar los _triggers_ que se han definido:

```sql
SHOW TRIGGERS FROM 'nombre_base_datos';
```

Si queremos ver los _triggers_ asociados a una tabla en concreto:

```sql
SHOW TRIGGERS FROM 'nombre_base_datos' WHERE `Table` = 'nombre_tabla';
```

**Nótese que la palabra `Table` está entre comillas invertidas (`) porque es una palabra reservada de MySQL.**

En MySQL se usan las comillas invertidas para referirse a nombres de tablas, columnas, etc. **cuando coincidan con palabras reservadas del sistema**.
