DROP PROCEDURE IF EXISTS Baloncesto.TAREAUD3_A1;

DELIMITER # -- Establecemos un valor de delimitador distinto al punto y coma para poder incluirlos en el cuerpo del procedimiento. En este caso, usaremos el símbolo "#".

CREATE DEFINER='limitado'@'localhost' PROCEDURE Baloncesto.TAREAUD3_A1()
SQL SECURITY DEFINER
-- Puesto que lo vamos a ejecutar como el usuario 'limitado'@'localhost', debemos asegurarnos de que tiene los permisos necesarios para:
-- * Ejecutar el procedimiento: GRANT EXECUTE ON PROCEDURE Baloncesto.TAREAUD3 TO 'limitado'@'localhost'.
-- * Consultar las tablas necesarias: 
--   * GRANT SELECT ON Baloncesto.jugadores TO 'limitado'@'localhost'; y GRANT SELECT ON Baloncesto.clases TO 'limitado'@'localhost';.
--   * O bien simplemente: GRANT SELECT ON Baloncesto.* TO 'limitado'@'localhost`;

BEGIN

  -- Declaramos las variables que vamos a utilizar:
  DECLARE gr1, gr2 VARCHAR(20); -- Para almacenar los nombre de los grupos "Clases.grupo".
  DECLARE pt1, pt2 INT; -- Para almacenar la suma de las puntuaciones "Jugadores.tantos_marcados".

  -- Declaramos un cursor que nos devolverá los nombres de los grupos y la suma de los puntos de los jugadores de cada grupo.
  DECLARE jugador_grupo CURSOR FOR
  SELECT c.grupo, SUM(j.tantos_marcados) AS suma FROM Baloncesto.jugadores AS j, Baloncesto.clases AS c
  WHERE j.clase = c.codigo GROUP BY j.clase ORDER BY suma DESC;

  -- Ahora accederemos únicamente a los dos primeros valores del cursor.
  OPEN jugador_grupo; -- Abrimos el cursor y hemos de cerrarlo al finalizar.
  -- Tomamos el primer valor del cursor.
  -- Fetch hace que el cursor avance al siguiente valor.
  FETCH jugador_grupo INTO gr1, pt1;
  -- Tomamos el siguiente valor del cursor.
  FETCH jugador_grupo INTO gr2, pt2;
  
  CLOSE jugador_grupo; -- Cerramos el cursor.

  -- Añadimos 2 a la puntuación de la clase para el grupo gr1.
  UPDATE clases SET puntuacion = puntuacion + 2 WHERE grupo = gr1;

  -- Añadimos 1 a la puntuación de la clase para el grupo gr2.
  UPDATE clases SET puntuacion = puntuacion + 1 WHERE grupo = gr2;
 
  SELECT gr1 AS "grupo 1", pt1 AS "puntos 1";
  SELECT gr2 AS "grupo 2", pt2 AS "puntos 2";

END
#

DELIMITER ; -- Restauramos el delimitador por defecto.
