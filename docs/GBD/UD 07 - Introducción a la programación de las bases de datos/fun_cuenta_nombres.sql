DELIMITER $$

USE sakila$$

CREATE FUNCTION cuenta_nombres (nombre VARCHAR(45))
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE resultado INT;
    SELECT COUNT(*) FROM actor WHERE first_name = nombre INTO resultado;
    RETURN resultado;
END$$

DELIMITER ;
