DELIMITER $$

CREATE FUNCTION world.get_country_name(country_code CHAR(3))
RETURNS VARCHAR(52)
READS SQL DATA
BEGIN
  RETURN (SELECT Name FROM country WHERE Code = country_code);
END$$

DELIMITER ;
