DROP PROCEDURE IF EXISTS Baloncesto.TAREAUD3;
delimiter #

CREATE DEFINER='limitado'@'localhost' PROCEDURE Baloncesto.TAREAUD3()
SQL SECURITY DEFINER
BEGIN

  DECLARE gr1, gr2 CHAR(3);
  DECLARE pt1, pt2 INT;

  DECLARE jugador_grupo CURSOR FOR
  SELECT c.grupo, SUM(j.tantos_marcados) AS suma FROM Baloncesto.jugadores AS j, Baloncesto.clases AS c
  WHERE j.clase = c.codigo GROUP BY j.clase ORDER BY suma DESC;

  OPEN jugador_grupo;
  -- Tomamos el primer valor del cursor.
  FETCH jugador_grupo INTO gr1, pt1;
  -- Tomamos el siguiente valor del cursor.
  FETCH jugador_grupo INTO gr2, pt2;
  
  CLOSE jugador_grupo;

  -- Añadimos 2 a la puntuación de la clase para el grupo gr1.
  -- UPDATE clases SET puntuacion = puntuacion + 2 WHERE codigo = gr1;

  -- Añadimos 1 a la puntuación de la clase para el grupo gr2.
  -- UPDATE clases SET puntuacion = puntuacion + 1 WHERE codigo = gr2;
 
  SELECT gr1 AS "grupo 1", pt1 AS "puntos 1";
  SELECT gr2 AS "grupo 2", pt2 AS "puntos 2";

END #

delimiter ;
