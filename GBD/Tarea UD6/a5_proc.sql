DELIMITER $$

DROP PROCEDURE IF EXISTS TalleresFaber.ReparacionClienteNuevo$$

CREATE PROCEDURE TalleresFaber.ReparacionClienteNuevo (
   IN cod_cli VARCHAR(5),
   IN DNI VARCHAR(10),
   IN nombre VARCHAR(25),
   IN apellidos VARCHAR(50),
   IN telefono VARCHAR(9),
   IN matricula VARCHAR(8),
   IN marca VARCHAR(25),
   IN modelo VARCHAR(50),
   IN fecha_matricula DATE,
   IN km_recorridos DECIMAL(8, 2),
   IN averia VARCHAR(200)
)
BEGIN
   -- Declaramos un handler para manejar error de duplicado "1062".
   DECLARE CONTINUE HANDLER FOR 1062 SELECT 'El cliente y/o vehículo ya existen.' AS 'Aviso: clave duplicada';

   INSERT INTO CLIENTES (codcliente, dni, nombre, apellidos, telefono) values (cod_cli, DNI, nombre, apellidos, telefono);
   INSERT INTO VEHICULOS (matricula, marca, modelo, fechamatriculacion) values (matricula, marca, modelo, fecha_matricula);
   
   INSERT INTO REPARACIONES (matricula, fechaentrada, km, avería) values (matricula, DATE(NOW()), km_recorridos, averia);
END$$

DELIMITER ;
