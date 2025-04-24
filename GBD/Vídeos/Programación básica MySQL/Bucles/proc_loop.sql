DELIMITER $$

DROP PROCEDURE IF EXISTS world.proc_loop $$

CREATE PROCEDURE IF NOT EXISTS world.proc_loop (IN p_limit INT)
bloque: BEGIN

    DECLARE contador INT DEFAULT 0;

    bucle: LOOP 
        SELECT contador AS 'Contador';
        set contador = contador + 2;
        -- Condición de terminación: Cuando contador alcance el valor de p_limit
        if contador >= p_limit THEN
            LEAVE bucle;
            -- Si quisiésemos salir del bloque total, usaríamos LEAVE bloque;
        END IF;
    END LOOP;

    SELECT 'Fin del bucle' AS 'Estado';

END$$

DROP FUNCTION IF EXISTS world.func_loop $$

CREATE FUNCTION IF NOT EXISTS world.func_loop(p_limit INT)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE contador INT DEFAULT 0;
    DECLARE acumulador INT DEFAULT 0;

    bucle: LOOP 
        set contador = contador + 2;
        set acumulador = acumulador + contador;

        -- Condición de terminación: Cuando contador alcance el valor de p_limit
        if contador >= p_limit THEN
            RETURN acumulador;
            -- Si quisiésemos salir del bloque total, usaríamos LEAVE bloque;
        END IF;
    END LOOP;

END $$


DELIMITER ;
