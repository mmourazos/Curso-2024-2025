# Introducción a la programación en bases de datos

<!-- toc -->

- [Variables](#variables)
    * [Variables del sistema](#variables-del-sistema)
    * [Variables de usuario](#variables-de-usuario)
    * [Variables locales](#variables-locales)
- [Sentencias compuestas / bloques de código](#sentencias-compuestas--bloques-de-codigo)
    * [Estructuras condicionales](#estructuras-condicionales)
        + [Sentencia `IF`](#sentencia-if)
        + [Sentencia `CASE`](#sentencia-case)
    * [Estructura de repetición](#estructura-de-repeticion)
        + [`WHILE` y `REPEAT`](#while-y-repeat)
        + [Loop](#loop)
- [Cursores](#cursores)
    * [¿Qué es un cursor?](#%C2%BFque-es-un-cursor)
    * [¿Qué es un handler?](#%C2%BFque-es-un-handler)
- [Rutinas almacenadas: procedimientos, funciones, eventos y triggers](#rutinas-almacenadas-procedimientos-funciones-eventos-y-triggers)
    * [Procedimiento](#procedimiento)
        + [Parámetros de entrada y salida](#parametros-de-entrada-y-salida)
        + [Seguridad en la ejecución: `DEFINER` y `SQL SECURITY`](#seguridad-en-la-ejecucion-definer-y-sql-security)
    * [Funciones](#funciones)
        + [`DETERMINISTIC` y `NON DETERMINISTIC`](#deterministic-y-non-deterministic)
    * [Triggers](#triggers)

<!-- tocstop -->

Cuando trabajamos con una base de datos podemos necesitar que se ejecute la misma secuencia de sentencias de manera repetida. Por ejemplo, si tenemos que realizar una serie de consultas SQL para obtener un resultado específico, podríamos crear un script SQL que contenga todas estas sentencias y ejecutarlo cada vez que necesitemos obtener el mismo resultado. Sin embargo, esto puede resultar poco eficiente y poco práctico si tenemos que ejecutar el mismo script varias veces.

Para evitar esto podemos **almacenar esta sentencias** en el servidor y después podríamos ejecutarlas aunque no tengamos acceso a los scripts.

Antes de entrar directamente en la escritura de rutinas almacenadas debemos entender algunos conceptos básicos de programación. En este apartado vamos a ver algunos de estos conceptos que nos ayudarán a entender mejor la programación en bases de datos.

## Variables

Una variable es un mecanismo que permite almacenar un valor temporalmente. Para acceder a este valor se utilizará un nombre, el nombre de la variable, un ejemplo de uso de una variable en MySQL sería el siguiente:

```sql
set @mi_variable = 10;
```

(En MySQL hemos de preceder el nombre de la variable con el símbolo `@` para indicar que es una variable de usuario). En este caso hemos creado una variable llamada `mi_variable` y le hemos asignado el valor `10`. A partir de este momento podremos utilizar la variable `mi_variable` en cualquier parte de la consulta SQL. Por ejemplo:

```sql
select @mi_variable as "mi variable";
+-------------+
| mi variable |
+-------------+
|          10 |
+-------------+
1 row in set (0.0014 sec)
```

En MySQL, existen dos tipos de variables: **variables del sistema** y **variables de usuario**.

### Variables del sistema

Las variables del sistema son variables que se utilizan para almacenar información sobre el estado de la base de datos y su configuración. Estas variables son definidas por el sistema y pueden ser utilizadas para obtener información sobre la configuración del servidor, el estado de las conexiones, etc. Se pueden consultar utilizando la sentencia `SHOW VARIABLES` o `SELECT @@nombre_variable`. Por ejemplo:

```sql

SHOW VARIABLE LIKE 'max_connections';
+-----------------+-------+
| Variable_name   | Value |
+-----------------+-------+
| max_connections | 151   |
+-----------------+-------+
1 row in set (0.0022 sec)
```

```sql
SELECT @@max_connections;
+-------------------+
| @@max_connections |
+-------------------+
|               151 |
+-------------------+
1 row in set (0.0011 sec)
```

Estas variables pueden tener un **scope global o de sesión** . Las variables de **scope global** son aquellas que afectan a todo el servidor y se pueden consultar utilizando la sentencia `SHOW GLOBAL VARIABLES` y su valor se mantiene hasta que se reinicia el servidor. Las variables de **scope de sesión** son aquellas que afectan a la sesión actual y se pueden consultar utilizando la sentencia `SHOW SESSION VARIABLES`. Estas estas últimas se eliminan al cerrar la sesión.

_El **scope** de una variable se refiere a los lugares desde los cuales se puede acceder a la misma._

_Así, si decimos que el **scope** de una variable es global, significa que se puede acceder a ella desde cualquier lado y su valor se mantiene entre sessiones. Por el contrario, si decimos que el **scope** de una variable es de sesión, significa que se puede acceder a ella desde cualquier parte de la sesión actual pero no se asegura que su valor será el mismo en otra sesión._

_Finalmente, si decimos que el **scope** de una variable es local, significa que sólo se puede acceder a ella desde dentro de la rutina donde se ha declarado pero no existirá (y no será visible) fuera de ella._

### Variables de usuario

Las variables de usuario son variables que se pueden utilizar para guardar datos temporales (como el resultado de una consulta) y pasarlos entre diferentes sentencias SQL. Se definen con el símbolo `@` seguido de caracteres alfanuméricos y los símbolos `.`, `_` y `$`, con una longitud máxima de 64 caracteres. Si necesitamos que incluyan algún otro carácter hemos de indicar el texto entre comillas `""`, `''` o `` ` `` `` ` `` pueden ser de cualquier tipo de datos.

Para definir una variable de usuario hemos de utilizar la sentencia `SET` o `SELECT`.

```sql
SET @nombre_variable = valor;
```

```sql
SELECT @nombre_variable := valor;
```

Para consultar el valor de una variable de usuario hemos de utilizar la sentencia `SELECT`:

```sql
SELECT @nombre_variable;
```

Las variables se pueden utilizar en la mayoría de los contextos donde se permiten expresiones. Por ejemplo, se pueden utilizar en la cláusula `WHERE` de una consulta SQL, en la cláusula `SET` de una sentencia `UPDATE`, o en la cláusula `VALUES` de una sentencia `INSERT`:

```sql
SET @year = 2006;

SELECT film_id, title FROM film WHERE release_year = @year;
+---------+-----------------------------+
| film_id | title                       |
+---------+-----------------------------+
|       1 | ACADEMY DINOSAUR            |
|       2 | ACE GOLDFINGER              |
|       3 | ADAPTATION HOLES            |
|       4 | AFFAIR PREJUDICE            |
|       5 | AFRICAN EGG                 |
...
```

Sin embargo, no se pueden utilizar los contextos donde debería ir una constante o valor literal. Por ejemplo, no se pueden utilizar en la cláusula `LIMIT` de una consulta SQL.

```sql
SET @limit = 10;

SELECT actor_id, first_name, last_name FROM actor ORDER BY last_name LIMIT @limit;
ERROR: 1064: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '@limit' at line 1

SET @col_1 = 'release_year';
SET @col_2 = 'rental_rate';

SELECT film_id, title, rental_rate, release_year FROM film ORDER BY @col_2 LIMIT 5;
+---------+------------------+-------------+--------------+
| film_id | title            | rental_rate | release_year |
+---------+------------------+-------------+--------------+
|       1 | ACADEMY DINOSAUR |        0.99 |         2006 |
|       2 | ACE GOLDFINGER   |        4.99 |         2006 |
|       3 | ADAPTATION HOLES |        2.99 |         2006 |
|       4 | AFFAIR PREJUDICE |        2.99 |         2006 |
|       5 | AFRICAN EGG      |        2.99 |         2006 |
+---------+------------------+-------------+--------------+

SELECT film_id, title, @col_2, @col_1 FROM film LIMIT 5;
+---------+------------------+-------------+--------------+
| film_id | title            | @col_2      | @col_1       |
+---------+------------------+-------------+--------------+
|       1 | ACADEMY DINOSAUR | rental_rate | release_year |
|       2 | ACE GOLDFINGER   | rental_rate | release_year |
|       3 | ADAPTATION HOLES | rental_rate | release_year |
|       4 | AFFAIR PREJUDICE | rental_rate | release_year |
|       5 | AFRICAN EGG      | rental_rate | release_year |
+---------+------------------+-------------+--------------+
```

Como podemos ver en las dos últimas sentencias **no se muestra ningún error** aunque el resultado **no es el esperado**.

### Variables locales

Las variables locales son variables que se utilizan dentro de un bloque de código de una _rutina almacenada_ (como un procedimiento o una función) y sólo son accesibles dentro de ese bloque. Se definen con la sentencia `DECLARE` y deben ser inicializadas antes de ser utilizadas. La sintaxis es la siguiente:

```txt
DECLARE nombre_variable tipo_dato [DEFAULT valor];
```

```sql
BEGIN
  DECLARE nombre_variable INT DEFAULT 0;
END
```

En sentencia anterior hemos declarado una variable de nombre `nombre_variable` de tipo entero `INT` y le asignamos un valor inicial de `0`. Esta variable sólo será accesible dentro del bloque `BEGIN ... END` en el que se ha declarado. Si no se asigna un valor inicial, la variable tendrá un valor nulo `NULL` por defecto.

**IMPORTANTE: Cuando declaramos variables en una rutina almacenada hemos de hacerlo antes de cualquier otra sentencia SQL. En caso contrario nos dará un error de sintaxis. Las variables han de declararse también antes de _handlers_ o _cursores_ (elementos que veremos más adelante).**

Para ver una lista de los tipos de datos que se pueden utilizar para declarar variables locales, podemos consultar la documentación oficial de MySQL en el siguiente enlace: [MySQL Data Types](https://dev.mysql.com/doc/refman/8.4/en/data-types.html).

## Sentencias compuestas / bloques de código

Cuando creamos alguna de estas rutinas almacenadas (funciones, procedimientos, eventos o triggers) podemos utilizar _sentencias compuestas_ ([_compound statements_](https://dev.mysql.com/doc/refman/8.4/en/sql-compound-statements.html)). Una sentencia compuesta consiste en un conjunto ordenado de instrucciones o sentencia que se han de escribir dentro de un bloque delimitado por `BEGIN` y `END`.

```txt
[etiqueta_del_begin:] BEGIN
    [statement_list]
END [end_label]
```

Para definir la lógica de ejecución utilizaremos estructuras de control. Estas estructuras son similares a las que se utilizan en otros lenguajes de programación y nos permiten controlar el flujo de ejecución del código.

### Estructuras condicionales

Una estructura condicional nos permite ejecutar diferentes bloques de código según se cumplan o no ciertas condiciones. En MySQL, podemos utilizar las setencias IF y CASE para implementar estructuras condicionales.

#### Sentencia `IF`

La sintaxis de una sentencia `IF` tiene la siguiente forma:

```txt
IF search_condition THEN statement_list
    [ELSEIF search_condition THEN statement_list] ...
    [ELSE statement_list]
END IF
```

Para verlo con un ejemplo:

```sql
IF resultados > limit THEN
    SELECT CONCAT('Hay más de ', limit, ' resultados');
ELSE
    SELECT CONCAT('Hay menos de ', limit, ' resultados');
END IF;
```

Se pueden _encadenar_ instrucciones `IF` utilizando la cláusula `ELSEIF` para evaluar múltiples condiciones. La sentencia `ELSE` se ejecuta si ninguna de las condiciones anteriores se cumple.

```sql
IF resultados > limit THEN
    SELECT CONCAT('Hay más de ', limit, ' resultados');
ELSEIF resultados = limit THEN
    SELECT CONCAT('Hay exactamente ', limit, ' resultados');
ELSE
    SELECT CONCAT('Hay menos de ', limit, ' resultados');
END IF;
```

Un ejemplo más completo utilizando esta sentencia en un procedimiento almacenado sería el siguiente:

```sql
DELIMITER $$

USE sakila$$

CREATE PROCEDURE test(IN input_value INT,  OUT output_value INT)
READS SQL DATA
BEGIN

    SELECT COUNT(*) FROM actor INTO output_value;

    IF output_value > input_value THEN
        SELECT CONCAT('The number of actors (', output_value, ') is greater than the limit (', input_value, ').') AS message;
    ELSE
        SELECT 'The number of actors is within the limit.' AS message;
    END IF;

END$$

DELIMITER ;
```

Más adelante veremos en detalle la creación de procedimientos por lo que no explicaremos el significado de cada una de las partes de la sentencia.

#### Sentencia `CASE`

La sentencia `CASE` es otra forma de implementar estructuras condicionales en MySQL. Esta sentencia no aporta nada nuevo respecto a la sentencia `IF`, pero puede resultar más legible en algunos casos. La sintaxis de la sentencia `CASE` es la siguiente:

```txt
CASE case_value
    WHEN when_value THEN statement_list
    [WHEN when_value THEN statement_list] ...
    [ELSE statement_list]
END CASE
```

Esta expresión sería equivalente a:

```txt
IF case_value = when_value THEN statement_list
    [ELSEIF case_value = when_value THEN statement_list] ...
    [ELSE statement_list]
END IF
```

Un ejemplo de la sentencia `CASE` sería el siguiente:

```sql
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "The quantity is greater than 30"
    WHEN Quantity = 30 THEN "The quantity is 30"
    ELSE "The quantity is under 30"
END
FROM OrderDetails;
```

Un ejemplo más completo utilizando esta sentencia en un procedimiento almacenado sería el siguiente:

```sql
DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_case(IN input INT)
READS SQL DATA
BEGIN

    CASE WHEN input < 0 THEN
        SELECT 'Negative number';
    WHEN input = 0 THEN
        SELECT 'Zero';
    WHEN input > 0 AND input < 10 THEN
        SELECT 'Single digit positive number';
    WHEN input >= 10 AND input < 100 THEN
        SELECT 'Double digit positive number';
    ELSE
        SELECT 'Large positive number';
    END CASE;

    CASE input
        WHEN 1 THEN
            SELECT 'Case 1';
        WHEN 2 THEN
            SELECT 'Case 2';
        ELSE
            SELECT 'Default case';
    END CASE;

END$$

DELIMITER ;
```

### Estructura de repetición

Una estructura repetitiva se utiliza para ejecutar un bloque de código varias veces. En MySQL, podemos utilizar las siguientes estructuras de repetición:

- `WHILE`
- `REPEAT`
- `LOOP`

#### `WHILE` y `REPEAT`

Las sentencias `WHILE` y `REPEAT` son similares. En ambas se define una **condición de terminación** para el bucle. Es decir, el bucle se repetirá mientras se cumpla o no una condición. La única diferencia entre ambas es que la sentencia `WHILE` evalúa la condición **antes de ejecutar** el bloque de código, mientras que la sentencia `REPEAT` evalúa la condición **después de ejecutar** el bloque de código.

La sintaxis de una sentencia `WHILE` es la siguiente:

```txt
[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label]
```

La sintaxis de una sentencia `REPEAT` es la siguiente:

```txt
[begin_label:] REPEAT
    statement_list
UNTIL search_condition
END REPEAT [end_label]```

Un ejemplo más completo utilizando estas sentencias en un procedimiento almacenado sería el siguiente:

```sql
DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_while_repeat(IN input INT)
READS SQL DATA
BEGIN

    DECLARE iteration INT DEFAULT 0;

    SELECT 'Bucle while:';
    WHILE iteration < input DO
        SELECT 'Iteration: ', iteration;
        SET iteration = iteration + 1;
    END WHILE;

    SET iteration = 0;
    SELECT 'Bucle repeat:';
    REPEAT
        SELECT 'Iteration: ', iteration;
        SET iteration = iteration + 1;
    UNTIL iteration >= input
    END REPEAT;

END$$

DELIMITER ;
```

Compor se puede intuir por la estructura del código escrito, el bucle `WHILE` se ejecuta mientras (_while_) la condición `iteration < input` sea verdadera. En cambio, el bucle `REPEAT` se ejecuta al menos una vez y luego evalúa la condición `iteration >= input` y se seguirá ejecutando hasta (_until_) que la condición sea verdadera. Podríamos decir que si queremos transformar un bucle _while_ en un bucle _repeat_ deberíamos _invertir_ la condición de terminación.

#### Loop

Este bucle es, en principio, un bucle infinito pues no tiene una condición de terminación. Para salir del bucle se utiliza la sentencia `LEAVE`. La sintaxis es la siguiente:

```txt
[begin_label:] LOOP
    statement_list
END LOOP [end_label]
```

Este tipo de bucle se utiliza cuando no se conoce el número de iteraciones de antemano como, por ejemplo, cuando queremos _iterar_ sobre un cursor. Un ejemplo más completo utilizando esta sentencia en un procedimiento almacenado sería el siguiente:

```sql
DELIMITER $$

CREATE PROCEDURE sakila.test_loop(IN input INT)
BEGIN

    etiqueta: LOOP

        DECLARE iteration INT DEFAULT 0;

        IF iteration = 10 THEN
            LEAVE etiqueta;
        END IF;

    END LOOP etiqueta;

END$$

DELIMITER ;
```

## Cursores

Antes de continuar explicando como crear rutinas almacenadas es conveniente explicar el concepto de _cursor_. Es bastante común que en una rutina almacenada necesitemos recorrer un conjunto de filas devueltas por una consulta SQL. Para ello utilizamos un _cursor_.

### ¿Qué es un cursor?

De manera informal podemos decir que un _cursor_ es una _variable_ que almacena un conjunto de filas devueltas por una consulta SQL. Se entiende, por lo tanto, que un _cursor_ estará siempre asociado a una consulta SQL. En este sentido, un _cursor_ es similar a una tabla temporal que se crea en memoria y que se puede recorrer fila a fila.

En realidad, un _cursor_ es un objeto que permite recorrer fila a fila el resultado de una consulta SQL. Un _cursor_ se puede utilizar para realizar operaciones en cada fila del conjunto de resultados, como actualizar o eliminar filas.

La sintaxis para declarar un _cursor_ es la siguiente:

```txt
DECLARE cursor_name CURSOR FOR select_statement;
```

### ¿Qué es un handler?

De nuevo, de manera informal, un _handler_ es una _variable_ que almacena el estado de un _cursor_. Un _handler_ se utiliza para controlar el flujo de ejecución del código en función del estado del _cursor_. Por ejemplo, si el _cursor_ ha llegado al final del conjunto de resultados, podemos utilizar un _handler_ para salir del bucle que recorre el _cursor_.

La sintaxis para declarar un _handler_ es la siguiente:

```txt
DECLARE handler_action HANDLER FOR condition_value statement;
```

`handler_action` indicará qué acción deseamos que se realice cuando suceda `condition_value` y puede ser una de las siguientes:

- `CONTINUE`: Indica que se continuará la ejecución del código después de que se produzca la condición especificada.
- `EXIT`: Indica que se saldrá del bloque de código después de que se produzca la condición especificada.
- `UNDO`: Indica que se deshará la última acción realizada después de que se produzca la condición especificada.

`condition_value` hace referencia a la condición que hará que se active el _hancler_. Esta condición puede ser un error específico (como `NOT FOUND`, `SQLEXCEPTION`, etc.) o una condición personalizada definida por el usuario.

A nosotros nos interesarán los valores `SQLWARNING`, `NOT FOUND` y `SQLEXCEPTION`:

- `SQLWARNING`: Indica que se ha producido una advertencia en la ejecución de una sentencia SQL. Esto no es un error, pero puede indicar que algo no ha salido como se esperaba.
- `SQLEXCEPTION`: Indica que se ha producido un error en la ejecución de una sentencia SQL. Esto puede ser un error de sintaxis, un error de conexión, etc.
- `NOT FOUND`: Indica que no se ha encontrado ninguna fila en el conjunto de resultados del _cursor_. Esto puede ocurrir cuando se ha llegado al **final del conjunto de resultados** o cuando no hay filas que cumplan la condición de la consulta SQL asociada al _cursor_.

Finalmente, `statement` será una instrucción o un bloque de código que se ejecutará cuando se produzca la condición especificada. Esta instrucción puede ser cualquier sentencia SQL válida o un bloque de código que contenga sentencias SQL.

_(Cuando se trata de una sola instrucción no es necesario rodearla de `BEGIN` y `END`)._

No entraremos aquí en la definición de condiciones ni explicaremos los distintos tipos de [códigos de error de MySQL](https://dev.mysql.com/doc/mysql-errors/8.0/en/server-error-reference.html) ni los posibles [valores de sql](https://www.ibm.com/docs/en/i/7.4.0?topic=codes-listing-sqlstate-values) ya que excede lo necesario para esta sección.

Un ejemplo más concreto dentro de como declarar y recorrer un cursor en un procedimiento almacenado sería el siguiente:

```sql
DELIMITER $$

CREATE PROCEDURE sakila.test_cursor()
BEGIN

    -- Declaramos unas variables para almacenar los valores de ciertas columnas.
    DECLARE done INT DEFAULT FALSE;
    DECLARE actor_id INT;
    DECLARE actor_name VARCHAR(255);

    -- Declaramos el cursor.
    DECLARE actor_cursor CURSOR FOR SELECT actor_id, first_name FROM actor;

    -- Declaramos el manejador para cerrar el cursor.
    -- Este manejador detectará si se produce un "NOT FOUND" (no hay más filas
    -- que leer en el cursor) y, como respuesta, ejecutará la sentencia:
    -- "SET done = TRUE"
    -- que establece el valor de la variable "done" a "TRUE" que a su vez se
    -- utilizará para decidir si salimos o no del bucle ("LEAVE read_loop;").
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Abrir el cursor
    OPEN actor_cursor;

    -- Bucle para recorrer el cursor.
    -- Utilizamos un bucle LOOP para recorrer el cursor.
    read_loop: LOOP
        -- Obtener la siguiente fila del cursor:
        FETCH actor_cursor INTO actor_id, actor_name;

        -- Si en la sentencia anterior no se ha podido obtener una fila habrá 
        -- saltado el error `NOT FOUND`, y el manejador habrá establecido la
        -- variable `done` a `TRUE`.
        IF done THEN
            -- Utilizamos una sentencia `LEAVE` para salir del bucle.
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Actor ID: ', actor_id, ', Actor Name: ', actor_name);
    END LOOP;

    -- Cerrar el cursor
    CLOSE actor_cursor;

END$$
```

## Rutinas almacenadas: procedimientos, funciones, eventos y triggers

Estas estructuras permiten encapsular lógica y automatizar tareas dentro de la base de datos:

- **Procedimientos**: Bloques de código que se almacenan en la base de datos y se ejecutan mediante un nombre específico utilizando `CALL`.
- **Funciones**: Similares a los procedimientos, pero devuelven un valor y se pueden usar en consultas SQL. Se invocan con la sentencia `SELECT` o dentro de otras funciones o procedimientos.
- **Eventos**: Tareas programadas que se ejecutan automáticamente en un momento específico o de forma recurrente.
- **Triggers**: Bloques de código que se ejecutan automáticamente en respuesta a eventos como `INSERT`, `UPDATE` o `DELETE` en una tabla.

### Procedimiento

Para declarar un procedimiento almacenado utilizamos la sentencia `CREATE PROCEDURE`. La sintaxis es la siguiente:

```txt
CREATE
    [DEFINER = user]
    PROCEDURE [IF NOT EXISTS] sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body
```

A continuación iremos viendo cada una de las partes de la sentencia:

- `DEFINER`: Indica a quién _pertenece_ el procedimiento. Este parámetro es opcional y si no se especifica se utilizará el usuario que lo ha creado.
- `proc_parameter`: Aquí especificamos los parámetros de entrada y salida del procedimiento.
- `characteristic`: Aquí especificamos las características del procedimiento como `CONTAINS SQL`, `NO SQL`, `READS SQL DATA`, `MODIFIES SQL DATA`, etc. Las características más importantes serán las que indican si el procedimiento lee o modifica datos de la base de datos.

#### Parámetros de entrada y salida

```sql
CREATE PROCEDURE mi_procedimiento (IN parametro1 INT, OUT parametro2 VARCHAR(50), INOUT parametro3 INT)
```

Des esta forma estaremos indicando que el procedimiento `mi_procedimiento` tiene un parámetro de entrada `parametro1` de tipo entero y un parámetro de salida `parametro2` de tipo cadena de caracteres con una longitud máxima de 50 caracteres y un parámetro de entrada y salida `parametro3` de tipo entero. Los parámetros de entrada se utilizan para pasar valores al procedimiento, mientras que los parámetros de salida se utilizan para devolver valores al llamador del procedimiento y los parámetros de entrada y salida se utilizan para pasar y devolver valores al mismo tiempo.

Un ejemplo de como usar estos parámetros sería el siguiente:

```sql
DELIMITER $$

CREATE PROCEDURE sakila.test_parametros(IN parametro1 INT, OUT parametro2 VARCHAR(50), INOUT parametro3 INT)
BEGIN
    SELECT CONCAT('El valor de parametro1 es: ', parametro1) AS mensaje1;
    SET parametro2 = "Hola mundo";
    SELECT CONCAT('El valor de parametro3 es: ', parametro3, ' y lo hemos cambiado a ', parametro1) AS mensaje2;
END$$

DELIMITER ;
```

Para probarlo podríamos utilizarlo en la siguiente sentencia:

```sql
SET @parametron_inout = 10;

CALL test_parametros(5, @parametro_out, @parametro_inout);

SELECT @parametro_out AS "Parametro de salida", @parametro_inout AS "Parametro de entrada y salida";
```

Y obtendríamos el siguiente resultado:

```txt
CALL test_parametros(1, @parametro_out, @parametro_inout);
+------------------------------+
| mensaje1                     |
+------------------------------+
| El valor de parametro1 es: 1 |
+------------------------------+
1 row in set (0.0034 sec)

+-------------------------------------------------------+
| mensaje2                                              |
+-------------------------------------------------------+
| El valor de parametro3 es: 10 y lo hemos cambiado a 1 |
+-------------------------------------------------------+

SELECT @parametro_out AS "Parametro de salida", @parametro_inout AS "Parametro de entrada y salida";
1 row in set (0.0034 sec)
+---------------------+-------------------------------+
| Parametro de salida | Parametro de entrada y salida |
+---------------------+-------------------------------+
| Hola mundo          |                            10 |
+---------------------+-------------------------------+
```

#### Seguridad en la ejecución: `DEFINER` y `SQL SECURITY`

Este parámetro funciona en combinación con la cláusula `SQL SECURITY` y se utiliza para definir el contexto de seguridad del procedimiento. `SQL SECURITY` puede tomar dos valores:

- `DEFINER`: El procedimiento se ejecuta con los privilegios del usuario que lo creó (el usuario definido en `DEFINER = ...`).
- `INVOKER`: El procedimiento se ejecuta con los privilegios del usuario que lo invoca (el usuario que llama al procedimiento).

Si omitimos el parámetro `DEFINER` se utilizará el usuario que ha creado el procedimiento.

Por ejemplo, si creamos un procedimiento con el usuario "admin" y deseamos que se ejecute con los privilegios de "admin", utilizaremos la siguiente sentencia:

```sql
CREATE DEFINER = 'admin'@'%' PROCECURE mi_procedimiento()
SQL SECURITY DEFINER
```

_En la práctica no haría falta especificar `DEFINER` si estamos creando el procedimiento como admin. Tampoco haría falta indicar `SQL SECURITY DEFINER` ya que este es el valor por defecto._

Si por el contrario creamos un procedimiento como `admin` pero no queremos que se ejecute con sus privilegios, sino con los del usuario que lo invoca, utilizaremos la siguiente sentencia:

```sql
CREATE PROCEDURE mi_procedimiento()
SQL SECURITY INVOKER
```

Obviamente, si el usuario que invoca (ejecuta la instrucción `CALL mi_procedimiento()`) no tiene privilegios para ejecutar el procedimiento, o no tiene privilegios para acceder a los objetos de la base de datos que se utilizan dentro del procedimiento, se producirá un error.

### Funciones

Las funciones se parecen mucho a los procedimientos en que ambos se pueden ejecutar directamente por parte de un usuario. Los procedimientos se ejecutan con la instrucción `CALL` y las funciones se ejecutan con la instrucción `SELECT`. La diferencia principal entre ambos es que las funciones devuelven un valor y los procedimientos no. Cuando decimos que una función devuelve una valor queremos decir que podríamos substituir la llamada a la función por el valor que devuelve. Esto no es lo que sucede con los procedimientos que _no devuelven un valor_ si no que pueden modificar los parámetros `OUT` e `INOUT`.

Al igual que los procedimientos, las funciones también tienen la cláusula `SQL SECURITY` que indica el contexto de seguridad en el que se ejecuta la función y funciona de manera similar a los procedimientos.

La sintaxis para crear una función es la siguiente:

```txt
CREATE 
    [DEFINER = user] 
    FUNCTION [IF NOT EXISTS] func_name ([func_parameter[,...]])
    RETURNS data_type
    [characteristic ...] routine_body
```

El significa de `DEFINER` y la cláusula `SQL SECURITY` (dentro del bloque `characteristic`) es el mismo que en los procedimientos. La diferencia principal es que las funciones tienen la cláusula `RETURNS` que indica el tipo de dato que devuelve la función. Esta cláusula es obligatoria y no se puede omitir. Dentro de la función habrá siempre una sentencia `RETURN` que devolverá el valor de la función.

Otra diferencia lógica entre procedimientos y funciones es que en los parámetros de una función no se pueden utilizar los modificadores `IN`, `OUT` o `INOUT`. Todos los parámetros de una función son de entrada y no se pueden modificar. En este sentido, las funciones son más restrictivas que los procedimientos.

Veamos un ejemplo de como crear una función:

```sql
DELIMITER $$

USE sakila$$

CREATE FUNCTION test_funcion(parametro1 INT, parametro2 INT)
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE resultado INT;
    SET resultado = parametro1 + parametro2;
    RETURN resultado;
END$$

DELIMITER ;
```

Como mencionamos antes, para invocar una función hemos de utilizarla dentro de una sentencia `SELECT`:

```sql
SELECT test_funcion(5, 10);
+---------------------+
| test_funcion(5, 10) |
+---------------------+
|                  15 |
+---------------------+
1 row in set (0.0027 sec)
```

#### `DETERMINISTIC` y `NON DETERMINISTIC`

Una de las características que podemos ignorar en la creación de procedimientos pero no en las funciones es `DETERMINISTIC` y `NON DETERMINISTIC`. Esta característica indica si la función devuelve siempre el mismo resultado para los mismos parámetros de entrada. Si la función es `DETERMINISTIC` significa que siempre devolverá el mismo resultado para los mismos parámetros de entrada. Si la función es `NON DETERMINISTIC` significa que puede devolver resultados diferentes para los mismos parámetros de entrada. Esto ha de indicarse pues el SGBD lo utilizará para optimizar la ejecución de la función. Si no se indica, el SGBD asumirá que la función es `NON DETERMINISTIC` y no podrá optimizar su ejecución.

Además de usar explícitamente `DETERMINISTIC` o `NON DETERMINISTIC`, también podemos utilizar:

- `CONTAINS SQL`: Indica que una rutina no tiene sentencias que **lean o escriban datos**. Este es el caso de nuestro ejemplo anterior.
- `NO SQL`: Indica que la rutina no contiene sentencias SQL.
- `READS SQL DATA`: Indica que la rutina tiene sentencias de lectura de datos, como SELECT, pero no de escritura.
- `MODIFIES SQL DATA`: Indica que la rutina contiene sentecias de escritura de datos como por ejemplo, `INSERT` or `DELETE`).

Si indicamos que nuestra sentencia es `NO SQL` o que `READS SQL DATA` no sería necesario indicar `[NOT] DETERMINISTIC`.

Un ejemplo de función que lee datos sería el siguiente:

```sql
DELIMITER $$

CREATE FUNCTION sakila.cuenta_nombres(nombre VARCHAR(50))
READS SQL DATA
RETURNS INT
BEGIN
    DECLARE cuenta INT DEFAULT 0;
    SELECT COUNT(*) FROM actor WHERE first_name = nombre INTO cuenta;
    RETURN cuenta;
END$$

DELIMITER ;
```

Si la invocamos de la siguiente manera:

```sql
SELECT cuenta_nombres("WOODY");
+-------------------------+
| cuenta_nombres("WOODY") |
+-------------------------+
|                       2 |
+-------------------------+
```

### Triggers

Los _triggers_ o _disparadores_ son un tipo de rutina almacenada que estará asociada a dos elementos:

- Una tabla de la base de datos.
- Una acción que modifique los datos de dicha tabla (`INSERT`, `UPDATE` o `DELETE`).

Además de estos elementos también podremos indicar si queremos que nuestro _trigger_ salte antes o después de la acción que lo dispara. Por ejemplo, si tenemos un _trigger_ asociado a una tabla y a la acción `INSERT`, podremos indicar si queremos que el _trigger_ se ejecute antes o después de que se inserten los datos en la tabla.

Durante la ejecución del código del trigger tendremos acceso a los valores nuevos y antiguos (cuando proceda) de los datos que se están modificando. Estos valores se pueden utilizar para realizar operaciones adicionales o para validar los datos antes de que se inserten o actualicen en la tabla.

La sintaxis para crear un _trigger_ es la siguiente:

```txt
CREATE
    [DEFINER = user]
    TRIGGER [IF NOT EXISTS] trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    [trigger_order]
    trigger_body
```

Donde:

- `trigger_time`: Indica si el _trigger_ se ejecuta antes (`BEFORE`) o después (`AFTER`) de la acción que lo dispara. Este parámetro es obligatorio.
- trigger_event: Indica la acción que dispara el _trigger_ (`INSERT`, `UPDATE` o `DELETE`). Este parámetro es obligatorio.

- `trigger_order`: Indica el orden de ejecución del _trigger_ si hay varios _triggers_ asociados a la misma tabla y acción. Puede ser `FOLLOWS` o `PRECEDES`. Este parámetro es opcional.
  - `FOLLOWS nombre_del_trigger_anterior`: Si queremos que el _trigger_ se ejecute después de otro _trigger_.
  - `PRECEDES nombre_del_trigger_siguiente`: Si queremos que el _trigger_ se ejecute antes de otro _trigger_.

Veamos un ejemplo de _trigger_:

```sql
DELIMITER $$

CREATE TRIGGER sakila.test_trigger
BEFORE INSERT ON actor
fOR EACH ROW
BEGIN
    SET NEW.first_name = UPPER(NEW.first_name);
    SET NEW.last_name = UPPER(NEW.last_name);
END$$

DELIMITER ;
```

Este trigger, por ejemplo, se ejecutará antes de que se realice una operación de inserción en la tabla `actor` y convertirá los valores de las columnas `first_name` y `last_name` a mayúsculas. Para ello utilizamos la variable `NEW` que contiene los valores que se están insertando en la tabla.
