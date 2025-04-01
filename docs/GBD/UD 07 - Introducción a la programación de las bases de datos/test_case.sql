DELIMITER $$

USE sakila$$

CREATE PROCEDURE test_case(IN input INT)
READS SQL DATA
BEGIN

    CASE WHEN input < 0 THEN
        SELECT 'Negative number';
    WHEN input = 0 THEN
        SELECT 'Zero';
    WHEN input > 0 AND input < 10 THEN
        SELECT 'Single digit positive number';
    WHEN input >= 10 AND input < 100 THEN
        SELECT 'Double digit positive number';
    ELSE
        SELECT 'Large positive number';
    END CASE;

    CASE input
        WHEN 1 THEN
            SELECT 'Case 1';
        WHEN 2 THEN
            SELECT 'Case 2';
        ELSE
            SELECT 'Default case';
    END CASE;

END$$

DELIMITER ;
