DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_while_repeat(IN input INT)
READS SQL DATA
BEGIN

    DECLARE iteration INT DEFAULT 0;

    SELECT 'Bucle while:';
    WHILE iteration < input DO
        SELECT 'Iteration: ', iteration;
        SET iteration = iteration + 1;
    END WHILE;

    SET iteration = 0;
    SELECT 'Bucle repeat:';
    REPEAT
        SELECT 'Iteration: ', iteration;
        SET iteration = iteration + 1;
    UNTIL iteration >= input
    END REPEAT;

END$$

DELIMITER ;
