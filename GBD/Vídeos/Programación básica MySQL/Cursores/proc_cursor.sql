DELIMITER $$

DROP PROCEDURE IF EXISTS sakila.proc_cursor$$

CREATE PROCEDURE sakila.proc_cursor()
BEGIN
    -- Declaración de variables.
    -- Variables para almacenar los datos de la consulta.
    DECLARE v_actor_id INT;
    DECLARE v_first_name VARCHAR(45);
    DECLARE v_last_name VARCHAR(45);
    -- Variable para controlar el fin del cursor y del bucle.
    DECLARE fin BOOLEAN DEFAULT False;

    -- Declaración del cursor.
    DECLARE actor_cursor CURSOR FOR
        SELECT actor_id, first_name, last_name
        FROM actor LIMIT 3;

    -- Declaración del manejador para el cursor.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = True;

    -- Apertura del cursor.
    OPEN actor_cursor;

    -- Bucle para recorrer los registros del cursor.
    cursor_loop: LOOP
        -- Recuperar los datos del cursor.
        FETCH actor_cursor INTO v_actor_id, v_first_name, v_last_name;

        -- Comprobamos si hemos llegado al final del cursor.
        IF fin THEN
            -- Si hemos llegado al final, salimos del bucle.
            LEAVE cursor_loop;
        END IF;

        -- Mostramos sus valores en pantalla.
        SELECT CONCAT('ID: ', v_actor_id, ' First Name: ', v_first_name, ' Last Name: ', v_last_name) AS "Info. actor";

    END LOOP cursor_loop;

END$$

DELIMITER ;
