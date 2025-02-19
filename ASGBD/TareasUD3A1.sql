DELIMITER //

DROP PROCEDURE IF EXISTS Baloncesto.TareaUD3A1;

CREATE PROCEDURE Baloncesto.TareaUD3A1()

BEGIN
  DECLARE gr,
  DECLARE gr1,
  DECLARE gr2 CHAR(3);

  DECLARE pt,
  DECLARE pt1,
  DECLARE pt2 INT;

  DECLARE iteration INT DEFAULT 0;

  DECLARE cur_jug_grupo CURSOR FOR
  SELECT c.grupo, SUM(j.tantos_marcados) AS suma FROM Baloncesto.jugadores AS j, Baloncesto.clases AS c
  WHERE j.clase = c.codigo GROUP BY j.clase ORDER BY suma DESC;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur_jug_grupo;

  SELECT "Antes de entrar en el loop.";

  cursor_loop: LOOP
    SELECT "dentro del lool";
    SET iteration = iteration + 1;
    IF done THEN
      LEAVE cursor_loop;
    END IF;

    FETCH cur_jug_grupo INTO gr, pt;
    SELECT gr AS "grupo", pt AS "puntos";

    IF ITERATION = 1 THEN
      SET gr1 = gr;
      SET pt1 = pt;
    ELSEIF ITERATION = 2 THEN
      SET gr2 = gr;
      SET pt2 = pt;
    END IF;

  END LOOP cursor_loop;

  CLOSE cur_jug_grupo;

END//

DELIMITER ;
