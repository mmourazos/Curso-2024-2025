# Vamos a crear un trigger para guardar un histórico de la modificación de los monitores de la
# base de datos gimnasio.

USE gimnasio;

# Creamos la base de datos histórica con DNI y fecha de baja del monitor.

CREATE TABLE hist_monitor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dni CHAR(9),
    fecha_baja DATE
);
