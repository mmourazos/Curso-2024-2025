DELIMITER $$

-- Hemos de indicar alguna base de datos para crear el procedimiento, en este caso la base de datos world.
USE world$$

DROP PROCEDURE IF EXISTS `variables`$$

CREATE PROCEDURE `variables`(IN input INT, OUT output INT)
BEGIN

    DECLARE var_rutina INT DEFAULT 0;

    set var_rutina = "Jijiji";

    set var_rutina = input + 1;
    set output = var_rutina * 2;

END$$

DELIMITER ;
