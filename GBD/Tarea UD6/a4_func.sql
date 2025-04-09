DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.a4_func$$

CREATE FUNCTION TalleresFaber.a4_func(fecha DATE)
RETURNS INT
MODIFIES SQL DATA
BEGIN
  DECLARE finalizadas INT;
  SELECT COUNT(*) FROM REPARACIONES AS r WHERE r.fechasalida = fecha INTO finalizadas;

  UPDATE REPARACIONES AS r SET reparado = 1 WHERE r.fechasalida = fecha;

  RETURN finalizadas;

END$$

DELIMITER ;
