# Cursores

Un cursor es un mecanismo que nos permite encapsular una sentencia `SELECT` y recorrer los resultados de esa sentencia fila por fila. Esto es útil cuando queremos procesar los resultados de una consulta de manera más controlada, como realizar operaciones en cada fila o aplicar lógica adicional.

**NO es recomendable user cursores** si existiesen otras formas de realizar la misma tarea. En su lugar, es preferible utilizar operaciones en bloque o funciones de agregación que puedan manejar múltiples filas a la vez. Los cursores pueden ser más lentos y consumir más recursos, especialmente en grandes conjuntos de datos.

## Sintaxis de un cursor

Los cursores se declaran al igual que las variables, los _handlers_ y las condiciones.

La posición en la que se declaran los cursores es importante. Han de declararse **después de las variables** y **antes de los _handlers_**. Si no se siguen estas reglas, el código no funcionará.

```txt
DECLARE nombre_cursor CURSOR FOR sentencia_select;
```

```SQL
DECLARE cur_actores CURSOR FOR SELECT actor_id, first_name, last_name FROM actor;
```

## Operaciones sobre los cursores

Para usar un cursor se han de utilizar tres sentencias:

* `OPEN`: Abre el cursor y lo prepara para su uso.
* `FETCH`: Recupera la siguiente fila del cursor y la almacena en las variables declaradas. Hemos de usar tantas variables como columnas tenga la sentencia `SELECT` del cursor.
* `CLOSE`: Cierra el cursor y libera los recursos asociados a él. La utilizaremos cuando ya no necesitemos el cursor o cuando hayamos terminado de procesar todas las filas.

## Recorrido de un cursor

Un cursor se suele recorrer utilizando un bucle. Como vimos en el vídeo dedicado a los bucles, estos necesitan una condición de salida. En el caso de los cursores, la condición de salida es que no haya más filas que recuperar. Para ello, utilizaremos un _handler_ para la señal `NOT FOUND` que se activa cuando no hay más filas que recuperar. Este _handler_, como veremos, modificará el valor de una variable que utilizaremos como condición de salida del bucle.

## Ejemplo de un cursor

```SQL
DELIMITER $$

CREATE PROCEDURE sakila.recorrer_actores()
BEGIN
    -- Declaración de variables para los datos que leemos en la consulta.
    DECLARE actor_id INT;
    DECLARE first_name VARCHAR(45);
    DECLARE last_name VARCHAR(45);
    -- Declaramos una variable para la condición de salida del bucle.
    DECLARE fin_cursor BIT DEFAULT False;
    -- Declaramos el cursor.
    DECLARE cur_actores CURSOR FOR SELECT actor_id, first_name, last_name FROM actor LIMIT 10;
    -- Declaramos un _handler_ para la señal NOT FOUND (fin del cursor).
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = True;

    -- Abrimos el cursor.
    OPEN cur_actores;

    -- Escribimos el bucle para recorrer el cursor.
    cursor_loop: LOOP
        FETCH cur_actores INTO actor_id, first_name, last_name;
        SELECT CONCAT('Actor: ', actor_id, ' ', first_name, ' ', last_name) AS Actor;
        IF fin_cursor THEN
            -- Si hemos llegado al final del cursor, salimos del bucle.
            LEAVE cursor_loop;
        END IF;
    END LOOP cursor_loop

    -- Cerramos el cursor.
    CLOSE cur_actores;
END$$

DELIMITER ;
```
