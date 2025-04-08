DELIMITER $$

CREATE PROCEDURE TalleresFaber.a3_proc(IN matricula VARCHAR(8), OUT num_rep INT)
BEGIN
  -- Declaramos la variable para guardar la marca del vehículo.
  DECLARE marca VARCHAR(25);

  DECLARE EXIT HANDLER FOR NOT FOUND
     SELECT CONCAT('No se ha encontrado el vehículo con matrícula ', matricula) AS 'Error';
  
  SELECT v.marca FROM VEHICULOS AS v WHERE v.matricula = matricula INTO marca;

  SELECT v.matricula, v.marca, modelo, color, count(idreparacion) AS "num. reparaciones" FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula;

  SELECT count(idreparacion) FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula INTO num_rep;

  SELECT dni, nombre, apellidos FROM EMPLEADOS AS e INNER JOIN Intervienen AS i ON e.codempleado = i.codempleado
  INNER JOIN REPARACIONES AS r ON i.idreparacion = r.idreparacion WHERE r.matricula = matricula;

  SELECT v.marca, modelo, color, v.matricula FROM VEHICULOS AS v WHERE v.marca = marca;

END$$

DELIMITER ;
