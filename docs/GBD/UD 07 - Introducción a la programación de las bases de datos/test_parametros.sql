DELIMITER $$

CREATE PROCEDURE sakila.test_parametros(IN parametro1 INT, OUT parametro2 VARCHAR(50), INOUT parametro3 INT)
BEGIN
    SELECT CONCAT('El valor de parametro1 es: ', parametro1) AS mensaje1;
    SET parametro2 = "Hola mundo";
    SELECT CONCAT('El valor de parametro3 es: ', parametro3, ' y lo hemos cambiado a ', parametro1) AS mensaje2;
END$$

DELIMITER ;
