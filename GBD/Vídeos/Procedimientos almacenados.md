# Procedimientos almacenados

## Introducción a procedimientos almacenados

* Mecanismo para guardar en la base de datos un conjunto de instrucciones SQL que se pueden ejecutar posteriormente.
* Ventajas frente a los _scripts_.
* Tipos de procedimientos almacenados:
  * Procedimientos.
    * Invocados directamente por el usuario.
    * Se pueden invocar desde otros procedimientos.
    * Parámetros de entrada y salida.
  * Funciones.
    * Invocadas desde una consulta SQL.
    * Devuelven un valor.
    * Parámetros sólo de entrada.
  * Eventos.
    * Se ejecutan automáticamente en un momento determinado.
    * Ejecución periódica o en un momento concreto.
  * Triggers.
    * Se ejecutan automáticamente al realizar una operación de modificación sobre una tabla.
      * `INSERT`, `UPDATE` o `DELETE`.
    * Se pueden invocar _antes_ o _después_ de la operación.

## Procedimientos y funciones

* Elementos comunes:
  * Parámetros.
  * `DEFINER`.
  * `SQL SECURITY`.

### Sintaxis de un procedimiento o función

#### Procedimiento

```SQL
CREATE [DEFINER = user] PROCEDURE [IF NOT EXISTS] nombre_procedimiento
  [ ([IN | OUT | INOUT] parametro1 tipo1, parametro2 tipo2, ...) ]
  [ SQL SECURITY { DEFINER | INVOKER } ]
  [ COMMENT 'texto explicativo']
  [[NOT] DETERMINISTIC]
  [{ CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }]
  [SQL SECURITY {DEFINER | INVOKER}]
  [ cuerpo de la rutina]
```

#### Función

```SQL
CREATE [DEFINER = user] FUNCTION [IF NOT EXISTS] nombre_funcion
  (parametro1 tipo1, parametro2 tipo2, ...)
  RETURNS tipo_retorno
  [ SQL SECURITY { DEFINER | INVOKER } ]
  [ COMMENT 'texto explicativo']
  [[NOT] DETERMINISTIC]
  [{ CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }]
  [SQL SECURITY {DEFINER | INVOKER}]
  [ cuerpo de la rutina]
```

Donde el _cuerpo de la rutina_ puede ser un bloque de código SQL contenido entre las sentencias `BEGIN` y `END`, o **una única sentencia SQL**.

### `DEFINER` y `SQL SECURITY`

Cuando estamos indicando qué usuario será el _propietario_ del procedimiento o función. Éste usuario recibirá automáticamente los privilegios necesarios para ejecutar el procedimiento o modificarlo.

Que un usuario tenga derecho a ejecutar un procedimiento o una función no significa que tenga derecho a ejecutar las sentencias SQL que contiene. Para ello, el usuario debe tener los privilegios necesarios para ejecutar esas sentencias.

### Ejemplo de procedimiento

* Ejemplo básico.
* Añadir parámetros.
* Definer y SQL security.

#### Ejemplo básico

```SQL
DELIMITER $$

CREATE PROCEDURE sakila.actor_list()
BEGIN
  SELECT actor_id, first_name, last_name, last_update
  FROM actor
  ORDER BY last_name, first_name;
END$$

DELIMITER ;
```

### Ejemplo de función

## Triggers

Lo que diferencia a los _triggers_ de los procedimientos y funciones es que no se invocan explícitamente, sino que se ejecutan automáticamente al realizar una operación de modificación sobre una tabla. Recordemos que las operaciones de modificación son `INSERT`, `UPDATE` o `DELETE`. A la hora de crear un _trigger_ se ha de especificar el momento en que se ejecutará, esto es, antes o después de que se ejecute la instrucción de modificación sobre la tabla.

Cuando creamos un _trigger_ hemos de indicar:

* La tabla sobre la que se va a crear el _trigger_.
* La operación que lo va a invocar (`INSERT`, `UPDATE` o `DELETE`).
* El momento en que se va a ejecutar el _trigger_ (`BEFORE` o `AFTER`).

### Sintaxis de un trigger

```text
CREATE [DEFINER = user] TRIGGER [IF NOT EXISTS] nombre_trigger
  {BEFORE | AFTER} {INSERT | UPDATE | DELETE}
  ON nombre_tabla FOR EACH ROW
  [ [FOLLOWS | PRECEDES] trigger_name ]
  trigger_body
```

### Variables `NEW` y `OLD`

`NEW.nombre_del_campo`
`OLD.nombre_del_campo`

¿Dónde se pueden usar?

* `INSERT`: Sólo tenemos la variable `NEW`.
* `UPDATE`: Ambas variables. New hará referencia al nuevo valor y Old al antiguo (andes de la modificación).
* `DELETE`: Sólo tenemos la variable `OLD`.

### Ejemplo de trigger

Creemos un _trigger_ que se ejecute antes de insertar un nuevo registro (_row_) en la tabla `Country` de la base de datos `world`. El _trigger_ se encargará de asegurarse de que el campo `Name` comience con una letra mayúscula seguido de letras minúsculas. Para ello crearemos una función que se encargue de modificar dicha cadena de texto.

```SQL
CREATE FUNCTION Capitalize (str VARCHAR(255))
  RETURN CONCAT(UPPER(SUBSTRING(str, 1, 1)), LOWER(SUBSTRING(str, 2)));
```

"hola" -> "Hola"

Esta función concatena dos _subcadenas_ de texto. La primera es la primera letra de la cadena original convertida a mayúscula y la segunda es el resto de la cadena convertida a minúscula.

```SQL
CREATE TRIGGER Capitalize_Country_Name
BEFORE INSERT ON Country
    NEW.Name := Capitalize(NEW.Name);
```

Como podemos ver, el _trigger_ se ejecuta **antes de insertar** un nuevo registro en la tabla `Country`. La variable `NEW` hace referencia al nuevo registro que se va a insertar. En este caso, el _trigger_ se encarga de modificar el campo `Name` del nuevo registro para que comience con una letra mayúscula y el resto de letras sean minúsculas. Una vez ejecutado el _trigger_, el nuevo registro se insertará en la tabla `Country` con el campo `Name` modificado.
