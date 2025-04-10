DELIMITER $$

DROP PROCEDURE IF EXISTS sakila.test_condition$$

CREATE PROCEDURE sakila.test_condition(IN s INT)
BEGIN

    -- Primero declararemos la condición para el error 1046:
    DECLARE error_1046 CONDITION FOR 1046;
    -- También podríamos hacerlo de la siguiente manera:
    DECLARE sqlstate_3D00 CONDITION FOR SQLSTATE '3D000';

    -- Después de las condiciones, declaramos los handlers:
    -- Hander para un error específico de MySQL:
    -- En este ejemplo será 1046 / SQLSTATE '3D000': Base de datos no especificada.
    DECLARE EXIT HANDLER FOR error_1046
        SELECT "Error 1046 capturado." AS "Mensaje de error";
    DECLARE EXIT HANDLER FOR SQLSTATE '3D000'
        SELECT "SQLSTATE '3D000' capturado." AS "Mensaje";
    -- Handler para NO DATA:
    DECLARE EXIT HANDLER FOR NOT FOUND
        SELECT "¡No hay más datos que leer!" AS "Mensaje de NO DATA";
    -- Handler para un error definido por el usuario:
    DECLARE EXIT HANDLER FOR SQLSTATE '45000'
        SELECT "Error definido por el usuario." AS "Mensaje de error definido por el usuario";


    -- Hagamos un CASE para elegir que señal lanzar:
    CASE s
    WHEN 1 THEN
        -- Lanzamos el error SQLSTATE '3D000':
        SIGNAL sqlstate_3D00;
    WHEN 2 THEN
        -- Lanzamos un error de tipo NOT FOUND:
        SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'No hay nada más que leer.';
    WHEN 3 THEN
        -- Lanzamos un error definido por el usuario:
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error definido por el usuario.';
    ELSE
        SELECT "No se ha lanzado ningún error." AS "Mensaje de funcionamiento normal";
    END CASE;

END$$

DELIMITER ;
