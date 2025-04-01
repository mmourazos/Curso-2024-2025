# Introducción a la programación de las bases de datos

Elementos que puede crear un usuario en MySQL:

* Procedimientos almacenados
* Funciones
* Eventos
* Triggers

## Descripción de la programación

## Variables

### Variables globales

### Variables de usuario

Las variables de usuario son variables que se pueden utilizar para guardar datos temporales (como el resultado de una consulta) y pasarlos entre diferentes sentencias SQL. Se definen con el símbolo `@` seguido de caracteres alfanuméricos y los símbolos `.`, `_` y `$`, con una longitud máxima de 64 caracteres. Si necesitamos que incluyan algún otro carácter hemos de indicar el texto entre comillas `""`, `''` o `` ` `` `` ` `` pueden ser de cualquier tipo de datos.

Para definir una variable de usuario hemos de utilizar la sentencia `SET` o `SELECT`.

```sql
SET @nombre_variable = valor;
```

```sql
SELECT @nombre_variable := valor;
```

La variable se puede utilizar en cualquier parte de la consulta, pero no se puede utilizar en la cláusula `WHERE` de una subconsulta.

### Variables locales

Las variables locales son variables que se utilizan dentro de un bloque de código (como un procedimiento almacenado o una función) y sólo son accesibles dentro de ese bloque. Se definen con la sentencia `DECLARE` y deben ser inicializadas antes de ser utilizadas. La sintaxis es la siguiente:

```txt
DECLARE nombre_variable tipo_dato [DEFAULT valor];
```

```sql
BEGIN
  DECLARE nombre_variable INT DEFAULT 0;
END
```

En sentencia anterior hemos declarado una variable de nombre `nombre_variable` de tipo entero `INT` y le asignamos un valor inicial de `0`. Esta variable sólo será accesible dentro del bloque `BEGIN ... END` en el que se ha declarado. Si no se asigna un valor inicial, la variable tendrá un valor nulo `NULL` por defecto.

## Sentencias compuestas

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
ESLIF resultados = limit THEN
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

Más adelante veremos en detalle la creación de procedimientos almacenados por lo que no explicaremos el significado de cada una de las partes de la sentencia.

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

* `WHILE`
* `REPEAT`
* `LOOP`

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

Compo se puede intuir por la estructura del código escrito, el bucle `WHILE` se ejecuta mientras (_while_) la condición `iteration < input` sea verdadera. En cambio, el bucle `REPEAT` se ejecuta al menos una vez y luego evalúa la condición `iteration >= input` y se seguirá ejecutando hasta (_until_) que la condición sea verdadera. Podríamos decir que si queremos transformar un bucle _while_ en un bucle _repeat_ deberíamos _invertir_ la condición de terminación.

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

CREATE PROCEDURE test_loop(IN input INT)
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
DECLARE cursor_name CURSOR FOR select_statement
```

Un ejemplo más concreto dentro de un procedimiento almacenado sería el siguiente:

```sql
DELI$MITER $$

USE sakila$$

CREATE PROCEDURE test_cursor()
BEGIN

    -- Declaramos unas variables para almacenar los valores de ciertas columnas.
    DECLARE done INT DEFAULT FALSE;
    DECLARE actor_id INT;
    DECLARE actor_name VARCHAR(255);

    -- Declaramos el cursor.
    DECLARE actor_cursor CURSOR FOR SELECT actor_id, first_name FROM actor;

    -- Declarar el manejador para cerrar el cursor. Este manejador detectará si
    -- se procude un error de `NOT FOUND` (cuando no hay más filas que leer) y,
    -- como respuesta establecerá la variable `done` a `TRUE` (que se utilizará
    -- para decidir si salir del bucle o no).
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

## Procedimientos almacenados, funciones, eventos y triggers

En $MySQL, estas estructuras permiten encapsular lógica y automatizar tareas dentro de la base de datos:

* **Procedimientos almacenados**: Bloques de código que se almacenan en la base de datos y se ejecutan mediante un nombre específico utilizando `CALL`.
* **Funciones**: Similares a los procedimientos, pero devuelven un valor y se pueden usar en consultas SQL. Se invocan con la sentencia `SELECT` o dentro de otras funciones o procedimientos.
* **Eventos**: Tareas programadas que se ejecutan automáticamente en un momento específico o de forma recurrente.
* **Triggers**: Bloques de código que se ejecutan automáticamente en respuesta a eventos como `INSERT`, `UPDATE` o `DELETE` en una tabla.

### Procedimientos almacenados

Para declarar un procedimiento almacenado utilizamos la sentencia `CREATE PROCEDURE`. La sintaxis es la siguiente:

```txt
CREATE
    [DEFINER = user]
    PROCEDURE [IF NOT EXISTS] sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body
```

A continuación iremos viendo cada una de las partes de la sentencia:

* `DEFINER`:
* `proc_parameter`: Aquí especificamos los parámetros de entrada y salida del procedimiento.
* `characteristic`: Aquí especificamos las características del procedimiento como `CONTAINS SQL`, `NO SQL`, `READS SQL DATA`, `MODIFIES SQL DATA`, etc. Las características más importantes serán las que indican si el procedimiento lee o modifica datos de la base de datos.

#### `DEFINER`

#### Parámetros de entrada y salida

```sql
CREATE PROCEDURE mi_procedimiento (IN parametro1 INT, OUT parametro2 VARCHAR(50))
```

#### Características

Des esta forma estaremos indicando que el procedimiento `mi_procedimiento` tiene un parámetro de entrada `parametro1` de tipo entero y un parámetro de salida `parametro2` de tipo cadena de caracteres con una longitud máxima de 50 caracteres.

### Funciones

### Eventos

### Triggers
