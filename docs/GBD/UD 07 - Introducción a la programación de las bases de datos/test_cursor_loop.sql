DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_cursor()
READS SQL DATA

BEGIN
    -- Declaramos unas variables para almacenar los valores de ciertas columnas.
    DECLARE done TINYINT(1) DEFAULT FALSE;
    DECLARE id SMALLINT UNSIGNED;
    DECLARE name VARCHAR(45);

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
        FETCH actor_cursor INTO id, name;

        -- Si en la sentencia anterior no se ha podido obtener una fila habrá 
        -- saltado el error `NOT FOUND`, y el manejador habrá establecido la
        -- variable `done` a `TRUE`.
        IF done THEN
            -- Utilizamos una sentencia `LEAVE` para salir del bucle.
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Actor ID: ', id, ', Actor Name: ', name) AS "Actor info";
    END LOOP;

    -- Cerrar el cursor
    CLOSE actor_cursor;

END$$
