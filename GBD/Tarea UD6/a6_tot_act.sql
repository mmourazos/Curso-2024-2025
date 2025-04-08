DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.TotalActuaciones$$

CREATE FUNCTION TalleresFaber.TotalActuaciones(IdReparacion INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE TotalActuaciones DECIMAL(10,2);

    SELECT SUM(r.Horas * a.Importe) FROM REPARACIONES AS rp 
    INNER JOIN Realizan AS r ON rp.IdReparacion = r.IdReparacion
    INNER JOIN ACTUACIONES AS a ON r.Referencia = a.Referencia
    WHERE rp.IdReparacion = IdReparacion INTO TotalActuaciones;

    RETURN IFNULL(TotalActuaciones, 0);
END$$

DELIMITER ;
