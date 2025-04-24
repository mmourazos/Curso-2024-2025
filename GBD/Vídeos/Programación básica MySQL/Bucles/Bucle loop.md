# Bucle `LOOP`

Este es el bucle más básico de todos y el más complicado. Una vez se entienda este los otros dos `WHILE` y `REPEAT` serán más fáciles de entender.

El bucle `LOOP`, en principio, no tiene condición de salida, por lo que se ejecutará indefinidamente. Para salir de él se utiliza la instrucción `LEAVE` o, si estamos dentro de una función, se puede utilizar `RETURN` (cuando aparece una sentencia `RETURN` dentro de una función, esta terminará y devolverá el valor indicado).

```sql
LOOP
    -- Código a ejecutar
END LOOP;
```

Para determinar de qué bucle vamos a salir se utilizará una etiqueta. Esta etiqueta se define justo antes de la palabra `LOOP` y se utiliza para identificar el bucle al que pertenece la instrucción `LEAVE`. La etiqueta es opcional, pero es recomendable utilizarla para evitar confusiones.

```sql
mi_bucle: LOOP
    -- Código a ejecutar
    LEAVE mi_bucle; -- Salimos del bucle
END LOOP mi_bucle;
```

Para ver un ejemplo creemos un procedimiento que imprima los números del 1 al 10. En este caso, utilizaremos una variable de control `i` que se inicializa a 1 y se incrementa en cada iteración del bucle. Cuando `i` alcance el valor 11, saldremos del bucle.

```ksql
DELIMITER $$

CREATE PROCEDURE bucle_loop()
BEGIN
    DECLARE i INT DEFAULT 1; -- Inicializamos la variable de control

    bucle: LOOP
        -- La condición de salida la hemos de escribir nosotros.
        IF i > 10 THEN -- Si i es mayor que 10 salimos del bucle.
            LEAVE bucle;
        END IF;

        SELECT i; -- Imprimimos el valor de i
        SET i = i + 1; -- Incrementamos i
    END LOOP blucle;

END$$

DELIMITER ;
```
