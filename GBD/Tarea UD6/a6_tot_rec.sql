DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.TotalRecambios$$

CREATE FUNCTION TalleresFaber.TotalRecambios(idReparacion INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE TotalRecambios DECIMAL(10,2);

    SELECT SUM(i.Unidades * rc.PrecioReferencia) FROM REPARACIONES AS rp 
    INNER JOIN Incluyen AS i ON rp.IdReparacion = i.IdReparacion
    INNER JOIN RECAMBIOS AS rc ON i.IdRecambio = rc.IdRecambio
    WHERE rp.IdReparacion = idReparacion INTO TotalRecambios;

    RETURN IFNULL(TotalRecambios, 0);
END$$

DELIMITER ;
