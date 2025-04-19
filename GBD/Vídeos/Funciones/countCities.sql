DELIMITER $$

CREATE FUNCTION world.countCities (country_name VARCHAR(50))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE city_count INT DEFAULT 0;
    DECLARE country_code CHAR(3);

    SELECT code from world.country AS c WHERE c.Name LIKE concat('%', country_name, '%') INTO country_code;

    SELECT COUNT(*) FROM world.city AS c WHERE c.CountryCode = country_code INTO city_count;

    RETURN city_count;
END$$

DELIMITER ;
