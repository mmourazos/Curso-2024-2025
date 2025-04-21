DELIMITER $$

CREATE FUNCTION IF NOT EXISTS world.Capitalize(string varchar(255))
RETURNS varchar(255)
DETERMINISTIC
    RETURN CONCAT(UPPER(SUBSTRING(string, 1, 1)), LOWER(SUBSTRING(string, 2)))$$

DROP TRIGGER IF EXISTS world.trigg1$$

CREATE TRIGGER world.trigg1
BEFORE INSERT ON world.city
FOR EACH ROW
BEGIN
    SET NEW.Name = Capitalize(NEW.Name);
    SET NEW.CountryCode = UPPER(NEW.CountryCode);
    SET NEW.District = Capitalize(NEW.District);
END$$

DROP TRIGGER IF EXISTS world.trigg2$$

CREATE TRIGGER world.trigg2
BEFORE DELETE ON world.city
FOR EACH ROW
BEGIN
    IF OLD.District = 'Galicia' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar una ciudad de Galicia';
    END IF;
END$$

DELIMITER ;
