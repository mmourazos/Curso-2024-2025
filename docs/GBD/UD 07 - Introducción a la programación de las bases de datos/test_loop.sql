DELIMITER $$

CREATE PROCEDURE test_loop(IN input INT)
BEGIN

    etiqueta: LOOP

        DECLARE iteration INT DEFAULT 0;

        IF iteration = 10 THEN
            LEAVE etiqueta;
        END IF;

    END LOOP etiqueta;

END$$

DELIMITER ;
