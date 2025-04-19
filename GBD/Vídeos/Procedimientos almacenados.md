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

### Sintaxis

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

### Ejemplo de trigger
