DELIMITER $$

CREATE PROCEDURE sakila.test_loop(IN input INT)
BEGIN
    DECLARE iteration INT DEFAULT 0;

    etiqueta: LOOP


        IF iteration = 10 THEN
            LEAVE etiqueta;
        END IF;

    END LOOP etiqueta;

END$$

DELIMITER ;
