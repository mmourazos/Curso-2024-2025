USE TalleresFaber;

DROP TABLE IF EXISTS PedidoRecambios;

CREATE TABLE PedidoRecambios (
    IdRecambio VARCHAR(10) NOT NULL,
    Descripcion VARCHAR(100) DEFAULT NULL,
    Stock SMALLINT DEFAULT NULL,
    PRIMARY KEY (IdRecambio)
);
