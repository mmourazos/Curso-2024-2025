DROP DATABASE IF EXISTS test_replicacion;

CREATE DATABASE test_replicacion;

CREATE TABLE test_replicacion.usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO test_replicacion.usuario (nombre, email) VALUES
('Juan', 'juan@sinmiendo.ltd'),
('Manuel', 'mourazos@iessanclemente.net'),
('MySQL', 'server@replica.com');
