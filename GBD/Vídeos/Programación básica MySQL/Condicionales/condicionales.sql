DELIMITER $$

USE world$$

DROP PROCEDURE IF EXISTS condicionales$$

-- Ejemplo de IF con un procedimiento.
CREATE PROCEDURE condicionales(IN valor INT)
BEGIN

    IF valor >= 0 THEN
        SELECT 'El valor es positivo.' AS resultado;
    ELSE 
        SELECT 'El valor es negativo.' AS resultado;
    END IF;

END$$

-- Ejemplo de CASE con una función.
DROP FUNCTION IF EXISTS condicionales$$

CREATE FUNCTION condicionales(valor INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    CASE valor
    WHEN 0 THEN
        RETURN 'El valor es cero.';
    WHEN 1 THEN 
        RETURN 'El valor es uno.';
    WHEN 2 THEN 
        RETURN 'El valor es dos.';
    ELSE 
        RETURN 'El valor no es ni cero ni uno ni dos.';
    END CASE;
END$$

DELIMITER ;
