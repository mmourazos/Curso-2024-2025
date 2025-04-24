DELIMITER $$

DROP PROCEDURE IF EXISTS world.bucle_repeat$$

CREATE PROCEDURE IF NOT EXISTS world.bucle_repeat(IN repeticiones INT)
BEGIN
    -- Inicializamos la variable de control.
    DECLARE iteracion INT DEFAULT 0;

    -- Repetimos el bloque de código al menos una vez.
    -- REPEAT
    --     -- Imprimimos el valor de la variable de control.
    --     SELECT iteracion AS 'Iteración';
    --
    --     -- Incrementamos la variable de control.
    --     -- Así nos aseguramos que el bucle no se ejecute indefinidamente
    --     SET iteracion = iteracion + 1;
    -- UNTIL iteracion >= repeticiones END REPEAT;

    SELECT 'Repeat con bucle LOOP.';

    l1: LOOP
        SELECT iteracion AS 'Iteración';
        SET iteracion = iteracion + 1;
        IF iteracion >= repeticiones THEN
            LEAVE l1;
        END IF;
    END LOOP l1;

END$$

DELIMITER ;
