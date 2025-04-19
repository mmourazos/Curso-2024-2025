DELIMITER $$

-- A partir de esto punto $$ equivale a ;
CREATE PROCEDURE sakila.prueba_1()
BEGIN
    SELECT * FROM actor LILMIT 10;
END$$

DELIMITER ;
