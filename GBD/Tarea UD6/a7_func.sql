DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.FacturadoMes$$

CREATE FUNCTION TalleresFaber.FacturadoMes(mes INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE fin INT DEFAULT FALSE;
    DECLARE TotalFacturado DECIMAL(10,2) DEFAULT 0;
    DECLARE IdReparacion INT;

    DECLARE reparaciones_mes CURSOR FOR SELECT r.IdReparacion FROM REPARACIONES AS r WHERE MONTH(FechaSalida) = mes;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Fin = 1;

    OPEN reparaciones_mes;

    cursor_loop: LOOP 
        FETCH reparaciones_mes INTO IdReparacion;
        
        SET TotalFacturado = TotalFacturado + (TotalRecambios(IdReparacion) + TotalActuaciones(IdReparacion));
        IF fin THEN
            LEAVE cursor_loop;
        END IF;
    END LOOP cursor_loop;

    CLOSE reparaciones_mes;

    RETURN TotalFacturado;
END$$

DELIMITER ;
