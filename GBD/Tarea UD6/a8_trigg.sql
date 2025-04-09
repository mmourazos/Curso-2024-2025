DELIMITER $$

DROP TRIGGER IF EXISTS TalleresFaber.CheckStock$$

CREATE TRIGGER TalleresFaber.CheckStock
BEFORE INSERT ON Incluyen
FOR EACH ROW
BEGIN
    DECLARE Stock INT;

    SELECT r.Stock FROM RECAMBIOS AS r where IdRecambio = NEW.IdRecambio INTO Stock;

    IF Stock < NEW.Unidades THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock para el recambio';
    END IF;
   
    UPDATE RECAMBIOS SET Stock = Stock - NEW.Unidades WHERE IdRecambio = NEW.IdRecambio;

END$$
    
DELIMITER ;
