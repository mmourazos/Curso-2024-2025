DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_if(IN input_value INT,  OUT output_value INT)
READS SQL DATA
BEGIN

    SELECT COUNT(*) FROM actor INTO output_value;

    IF output_value > input_value THEN
        SELECT CONCAT('The number of actors (', output_value, ') is greater than the limit (', input_value, ').') AS message;
    ELSE
        SELECT 'The number of actors is within the limit.' AS message;
    END IF;

END$$

DELIMITER ;

