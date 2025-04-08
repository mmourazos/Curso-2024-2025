DELIMITER $$

CREATE PROCEDURE TalleresFaber.a1_procv2(IN date DATE)
BEGIN
  SELECT v.marca, v.modelo, v.color FROM VEHICULOS AS v INNER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE NOT r.reparado;
  SELECT c.dni, c.nombre, c.apellidos, v.matricula, v.marca, v.modelo FROM VEHICULOS AS v INNER JOIN CLIENTES AS c ON v.codcliente = c.codcliente INNER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE r.fechaentrada = date;

END$$

DELIMITER ;
