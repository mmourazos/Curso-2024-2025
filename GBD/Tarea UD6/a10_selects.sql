SELECT CONCAT_WS(',', Apellidos, Nombre) AS NombreCompleto, AS Ciudad FROM CLILENTES;

SELECT DATA_FORMAT(FechaAlta, '%d/%m/%Y') AS 'Fecha contrato', SUBSTRING_INDEX(Direccion, ', ', -1) AS 'Ciudad' FROM EMPLEADOS;
