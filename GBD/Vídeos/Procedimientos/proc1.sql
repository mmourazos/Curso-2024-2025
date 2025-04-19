DELIMITER $$

CREATE PROCEDURE sakila.proc1(IN nombre VARCHAR(50), OUT count INT)
BEGIN
    SELECT COUNT(*) FROM sakila.actor WHERE first_name = nombre INTO count;
END$$

DELIMITER ;
