DELIMITER $$

-- USE sakila$$

DROP PROCEDURE IF EXISTS sakila.test_proc1$$

CREATE PROCEDURE sakila.test_proc1(IN entrada INT)
BEGIN
    CASE 
        WHEN entrada = 1 THEN
            SELECT 'uno' AS resultado;
        WHEN entrada = 3 THEN
            SELECT 'tres' AS resultado;
        WHEN entrada >= 2 THEN
            SELECT 'mayor que dos' AS resultado;
        ELSE
            SELECT 'otro' AS resultado;
    END CASE;

END$$

DELIMITER ;
