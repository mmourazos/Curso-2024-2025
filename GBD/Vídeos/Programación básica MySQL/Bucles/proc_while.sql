DELIMITER $$

DROP PROCEDURE IF EXISTS world.bucle_while$$

CREATE PROCEDURE IF NOT EXISTS world.bucle_while(IN repeticiones INT)
BEGIN
    -- Inicializamos la variable de control.
    DECLARE iteracion INT DEFAULT 0;

    WHILE iteracion < repeticiones DO
        -- Imprimimos el valor de la variable de control.
        SELECT iteracion AS 'Iteración';

        -- Incrementamos la variable de control.
        -- Así nos aseguramos que el bucle no se ejecute indefinidamente
        SET iteracion = iteracion + 1;
    END WHILE;


    SELECT 'Fin del bucle' AS 'Fin del bucle';

END$$

DELIMITER ;
