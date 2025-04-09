DELIMITER $$

DROP TRIGGER IF EXISTS TalleresFaber.SalvaRecambios$$

CREATE TRIGGER TalleresFaber.SalvaRecambios
AFTER UPDATE ON RECAMBIOS
FOR EACH ROW
BEGIN
    IF NEW.Stock < 4 THEN
        INSERT INTO PedidoRecambios (IdRecambio, Descripcion, Stock)
        VALUES (NEW.IdRecambio, NEW.Descripcion, NEW.Stock);
    END IF;
END$$

DELIMITER ;
