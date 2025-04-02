# Vídeo sobre rutinas almacenadas

## Rutinas almacenadas

¿Qué es una rutina almacenada?

Una rutina almacenada es un conjunto de instrucciones SQL que se almacenan en la base de datos y se pueden ejecutar como una unidad. Las rutinas almacenadas pueden ser procedimientos o funciones, y se utilizan para encapsular lógica de negocio, realizar cálculos complejos o simplificar tareas repetitivas.

## Bloques de código

Un bloque de código es una unidad de código que se puede ejecutar como una sola instrucción. En MySQL, los bloques de código se utilizan para definir rutinas almacenadas, como procedimientos y funciones. Un bloque de código puede contener declaraciones SQL, variables, estructuras de control y otros elementos.

Los bloques de código se definen utilizando la siguiente sintaxis:

```txt
BEGIN
    -- Declaraciones SQL y otras instrucciones
END;
```

## Tipos de rutinas almacenadas

Hay cuatro tipos de rutinas almacenadas en MySQL:

* Procedimientos
* Funciones
* Eventos
* Triggers

A continuación veremos su utilidad y en qué se diferencian.

### Procedimientos almacenados

Un procedimiento encapsula una serie de instrucciones SQL que se pueden ejecutar como una unidad. Los procedimientos almacenados son útiles para realizar tareas repetitivas, como la inserción de datos en varias tablas o la actualización de registros.

Podremos pasar información a un procedimiento mediante el uso de parámetros. Un parámetro es una variable que se utiliza para pasar información entre el procedimiento y el llamador. Los parámetros se definen en la declaración del procedimiento y se pueden utilizar dentro del bloque de código del procedimiento.

```sql
CREATE PROCEDURE nombre_procedimiento (IN parametro1 INT, OUT parametro2 INT)
```

Los parámetros pueden ser de entrada (`IN`), salida (`OUT`) o de entrada y salida (`INOUT`). Los parámetros de entrada permiten pasar valores al procedimiento, mientras que los parámetros de salida permiten _devolver_ valores al llamador. Los parámetros de entrada y salida permiten tanto pasar como devolver valores.

**TODO: Hay que probar el siguiente ejemplo en MySQL**

```sql
DELIMITER $$ CREATE PROCEDURE nombre_procedimiento (IN parametro1 INT, OUT parametro2 INT)

BEGIN
    -- Código del procedimiento
    SET parametro2 = parametro1 * 2;
END$$

DELIMITER ;

CALL nombre_procedimiento(5, @resultado);

SELECT @resultado;
-- Resultado tendrá el valor 10.
```

La sintaxis para definir un procedimiento es la siguiente:

```txt
CREATE
    [DEFINER = user]
    PROCEDURE [IF NOT EXISTS] sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body
```

Donde `proc_parameter` es el parámetro de entrada, salida o entrada y salida y cuya sintaxis sería:

```txt
proc_parameter:
    [ IN | OUT | INOUT ] param_name type
```

A su vez `type` puede ser uno de los tipos de datos soportados por MySQL, como `INT`, `VARCHAR`, `DATE`, etc.

Un ejemplo de procedimiento almacenado sería el siguiente:

**TODO: Hay que probar el siguiente ejemplo en MySQL**

```sql
CREATE PROCEDURE saludo(IN nombre VARCHAR(20), OUT saludo VARCHAR(50))

BEGIN
    SET saludo = CONCAT('¡Hola, ', nombre, '!');
END;

CALL saludo('Juan', @mensaje);

SELECT @mensaje;
-- Debería devolver: ¡Hola, Juan!
```

Lua característica `characteristic` es opcional y se utiliza para especificar las características del procedimiento almacenado. Entre ellas se encuentran:

* `COMMENT`: Permite añadir un comentario descriptivo sobre el procedimiento que se podrá consultar posteriormente (`SHOW CREATE PROCEDURE` y `SHOW CREATE FUNCTION`).
* `[NOT] DETERMINISTIC`: Una rutina se considera determinista si siempre devuelve el mismo resultado para los mismos valores de entrada. Si no es determinista, se puede utilizar la palabra clave `NOT DETERMINISTIC`. Por defecto, las rutinas son no deterministas.
* `CONTAINS SQL`: Indica que la rutina **no** contiene instrucciones SQL de lectura o modificación de datos. Esto significa que la rutina no realiza ninguna operación que afecte a los datos en las tablas de la base de datos.
* `READS SQL DATA`: Indica que la rutina **solo** contiene instrucciones SQL de lectura de datos. Esto significa que la rutina puede realizar operaciones de selección (`SELECT`) en las tablas de la base de datos, pero no puede modificar los datos.
* `MODIFIES SQL DATA`: Indica que la rutina **contiene** instrucciones SQL de modificación de datos. Esto significa que la rutina puede realizar operaciones de inserción (`INSERT`), actualización (`UPDATE`) o eliminación (`DELETE`) en las tablas de la base de datos.
* `NO SQL`: Indica que la rutina no contiene ninguna instrucción SQL.
C

#### SQL Security

Finalmente vermemos la cláusula `SQL SECURITY`, que se utiliza para especificar el contexto de seguridad en el que se ejecuta la rutina almacenada. Esta cláusula puede tener dos valores: `DEFINER` o `INVOKER`. La cláusula `SQL SECURITY` determina qué privilegios se utilizan al ejecutar la rutina.

Cuando indicamos `SQL SECURITY DEFINER`, la rutina se ejecuta con los privilegios del usuario que la creó. Esto significa que la rutina puede acceder a los objetos de la base de datos a los que puede acceder su creado y realizar las mismas operaciones sobre ellos que el creado. Si el usuario que llama a la rutina no tiene privilegios para acceder a esos objetos, la rutina aún podrá ejecutarse con éxito.

Obviamente el usuario que llama a la rutina deberá tener privilegios para ejecutar la rutina.

Por otro lado, si indicamos `SQL SECURITY INVOKER`, la rutina se ejecuta con los privilegios del usuario que la llama. Esto significa que la rutina solo podrá acceder a los objetos de la base de datos a los que el usuario que llama tiene acceso. Si el usuario no tiene privilegios para acceder a esos objetos, la rutina no podrá ejecutarse.

##### CALL

Para invocar a un procedimiento almacenado se utiliza la instrucción `CALL` seguida del nombre del procedimiento y los parámetros que se le pasan. La sintaxis es la siguiente:

```sql
CALL procedure_name([parameter1, parameter2,...]);
```

### Funciones almacenadas

La principal diferencia entre una función y un procedimiento almacenado es que una función **siempre** devuelve un valor, mientras que un procedimiento **nunca** lo hace. Las funciones se utilizan para realizar cálculos o transformaciones de datos y pueden ser utilizadas en expresiones SQL.

Cuando decimos que un procedimiento no devuelve un valor nos referimos que, al invocar un procedimiento no se puede substituir por el valor de retono. Para _extrader_ un valor de un procedimiento hemos de declarar un parámetro de salida o entrada y salida y usar una variable para almacenar el resultado.

Una función, conceptualmente, se substituye por el valor de retorno. Por ejemplo, si tenemos una función que suma dos números, podemos utilizarla en una consulta SQL como si fuera un valor.

```sql
SELECT suma(2, 3);
```

Al ejecutar la sentencia anterior, se invoca a la función pasándole los parámetros `2` y `3`, y el resultado de la función se sustituye por el valor de retorno, que en este caso debería ser `5`.

La sintaxis para definir una función es la siguiente:

```text
CREATE
    [DEFINER = user]
    FUNCTION [IF NOT EXISTS] function_name ([func_parameter type[,...]])
    RETURNS type
    [ COMMENT 'string'
    | LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER } ]
       routine_body
```

### Diferencias entre procedimientos y funciones almacenadas

Los procedimientos almacenados pueden tener parámetros de entrada, salida o entrada y salida **pero no devuelven valores**. Las funciones almacenadas **siempre** devuelven un valor.

### Aspectos comunes de procedimientos y funciones almacenadas

#### _Characteristics_

Es un elemento opcional de la definición de una rutina almacenada que se utiliza para especificar las características de la rutina almacenada. Las características de una rutina almacenada son las siguientes:

```text
characteristic: {
  COMMENT 'string'
  | LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }
```

##### Security / definer

### Eventos

### Triggers
