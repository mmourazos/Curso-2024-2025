	DELIMITER $$

DROP PROCEDURE IF EXISTS TalleresFaber.PFacturadoMes$$

CREATE PROCEDURE TalleresFaber.PFacturadoMes(IN mes INT, OUT TotalFacturado DECIMAL(10,2))
BEGIN
    DECLARE fin INT DEFAULT FALSE;
    DECLARE IdReparacion INT;

    DECLARE reparaciones_mes CURSOR FOR SELECT r.IdReparacion FROM REPARACIONES AS r WHERE MONTH(FechaSalida) = mes;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Fin = 1;

    SELECT mes AS "Mes";

    OPEN reparaciones_mes;

    cursor_loop: LOOP 
        FETCH NEXT FROM reparaciones_mes INTO IdReparacion;
        SELECT IdReparacion as "Id reparacion";
        SET TotalFacturado = TotalFacturado + (TotalRecambios(IdReparacion) + TotalActuaciones(IdReparacion));
        IF fin THEN
            LEAVE cursor_loop;
        END IF;
    END LOOP cursor_loop;

    CLOSE reparaciones_mes;

END$$

DELIMITER ;
