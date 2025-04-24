# Bucles `WHILE` y `REPEAT`

Estos bucles cumplen la misma función que un bucle `LOOP` pero nos facilitan su escritura ya que la condición de salida forma parte de la definición del bucle. La diferencia entre ambos es que el bucle `WHILE` evalúa la condición **antes de ejecutar** el bloque de código, mientras que el bucle `REPEAT` lo hace **después**. Por lo tanto, el bucle `REPEAT` siempre ejecutará al menos una vez el bloque de código.

## Bucle `WHILE`

La sintaxis del bucle `WHILE` es la siguiente:

```text
[etiqueta:] WHILE condición DO
    -- Código a ejecutar
END WHILE [etiqueta];
```

Donde _condición_ es la condición que se evalúa antes de ejecutar el bloque de código. Mientras (`WHILE`) la condición es verdadera, se ejecuta el bloque de código. Si es falsa, se sale del bucle.

Si la condición no cambia dentro del bloque de código, el bucle se ejecutará indefinidamente. Por lo tanto, es importante asegurarse de que la condición cambie en algún momento para evitar un bucle infinito.

Por último, si la condición es falsa antes de comenzar el bucle, el bloque de código no se ejecutará en absoluto.

Un ejemplo de bucle `WHILE` sería el siguiente:

```sql
DELIMITER $$

DROP PROCEDURE IF EXISTS world.bucle_while$$

CREATE PROCEDURE IF NOT EXISTS world.bucle_while(IN repeticiones INT)
BEGIN
    -- Inicializamos la variable de control.
    DECLARE iteracion INT DEFAULT 0;

    WHILE iteracion < repeticiones DO
        -- Imprimimos el valor de la variable de control.
        SELECT iteracion AS 'Iteración';

        -- Incrementamos la variable de control.
        -- Así nos aseguramos que el bucle no se ejecute indefinidamente
        SET iteracion = iteracion + 1;
    END WHILE;

END$$

DELIMITER ;
```

Si llamamos al procedimiento `bucle_while` con el valor 5, se ejecutará 5 veces y mostrará los números del 0 al 4:

```
call world.bucle_while(5) \G
*************************** 1. row ***************************
Iteración: 0
1 row in set (0.0008 sec)

*************************** 1. row ***************************
Iteración: 1
1 row in set (0.0008 sec)

*************************** 1. row ***************************
Iteración: 2
1 row in set (0.0008 sec)

*************************** 1. row ***************************
Iteración: 3
1 row in set (0.0008 sec)

*************************** 1. row ***************************
Iteración: 4
1 row in set (0.0008 sec)

Query OK, 0 rows affected (0.0008 sec)text
```
