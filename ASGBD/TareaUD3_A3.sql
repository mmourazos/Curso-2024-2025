CREATE TABLE IF NOT EXISTS Baloncesto.HCO_CAPITANES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomantc VARCHAR(20) NOT NULL,
    apeantc VARCHAR(20) NOT NULL,
    nomactc VARCHAR(20) NOT NULL,
    apeactc VARCHAR(20) NOT NULL,
    clase CHAR(3) NOT NULL REFERENCES Baloncesto.clases(codigo),
    fecambio DATE NOT NULL
);

DELIMITER //
USE Baloncesto//
CREATE TRIGGER IF NOT EXISTS triggerTUD3
    BEFORE UPDATE ON clases FOR EACH ROW
    BEGIN
      DECLARE oc_nom VARCHAR(20);
      DECLARE oc_ape VARCHAR(20);
      DECLARE nc_nom VARCHAR(20);
      DECLARE nc_ape VARCHAR(20);

      IF OLD.capitan != NEW.capitan THEN

        SELECT j.nombre, j.apellido INTO oc_nom, oc_ape FROM jugadores as j WHERE j.codalumno = OLD.capitan;
        SELECT j.nombre, j.apellido INTO nc_nom, nc_ape FROM jugadores as j WHERE j.codalumno = NEW.capitan;

        INSERT INTO Baloncesto.HCO_CAPITANES (nomantc, apeantc, nomactc, apeactc, clase, fecambio) VALUES (oc_nom, oc_ape, nc_nom, nc_ape, OLD.codigo, CURRENT_DATE());
      END IF;
    END//

DELIMITER ;
