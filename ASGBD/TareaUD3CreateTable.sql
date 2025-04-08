CREATE TABLE IF NOT EXISTS Baloncesto.HCO_CAPITANES (
  id INT AUTO_INCREMENT,
  nomantc VARCHAR(20) NOT NULL,
  appantc VARCHAR(20) NOT NULL,
  nomactc VARCHAR(20) NOT NULL,
  appactc VARCHAR(20) NOT NULL,
  clase CHAR(3) NOT NULL,
  fecambio DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (clase) REFERENCES Baloncesto.clases(codigo)
);

