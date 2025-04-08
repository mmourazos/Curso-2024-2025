DELIMITER $$

USE sakila$$

CREATE FUNCTION test_funcion(parametro1 INT, parametro2 INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = parametro1 + parametro2;
    RETURN resultado;
END$$

DELIMITER ;
