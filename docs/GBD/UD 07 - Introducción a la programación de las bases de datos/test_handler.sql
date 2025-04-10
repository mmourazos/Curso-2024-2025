DELIMITER $$

DROP PROCEDURE IF EXISTS sakila.test_signal$$

CREATE PROCEDURE sakila.test_signal(IN input INT)
COMMENT "Si input es 1 lanzaremos una señal 01, si es 2, 02, etc."
BEGIN
    -- SQLEXCEPTION atiende a los SQLSTATE que comienzan por 00, 01 o 02.
    -- 00 - Indica que no se ha producido ningún error.
    -- 01 - Indica que se ha producido un error de advertencia.
    -- 02 - Indica un error de tipo NOT FOUND o una excepción SQL
    -- que terminaría la ejecución del bloque de código.
    DECLARE CONTINUE HANDLER FOR 1643
        SELECT "Error handled!" AS "Error message:";
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        SELECT "Exception handled!" AS "Exception message:";
    DECLARE EXIT HANDLER FOR SQLWARNING
        SELECT "Warning handled!" AS "Exception message:";
    -- DECLARE EXIT HANDLER FOR NOT FOUND
    --     SELECT "Not found handled!" AS "Exception message:";

    CASE input
    WHEN 0 THEN
        SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = 'Input value is 0!';
    WHEN 1 THEN
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Input value is 1!';
    WHEN 2 THEN
        SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Input value is 2!';
    WHEN 3 THEN
        SIGNAL SQLSTATE '02200' SET MESSAGE_TEXT = 'Input value is 3!';
    WHEN 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Input value is 4!';
    END CASE;

END$$

DELIMITER ;
