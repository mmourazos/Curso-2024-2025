DROP PROCEDURE IF EXISTS Baloncesto.test;

DELIMITER //

CREATE PROCEDURE Baloncesto.test()

BEGIN
  DECLARE gr1, gr2 CHAR(3);

  DECLARE done BOOLEAN DEFAULT 0;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  SELECT "TODO BIEN";
END//

DELIMITER ;
