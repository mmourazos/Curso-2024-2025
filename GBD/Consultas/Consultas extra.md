# Consultas más complejas

## Consultas con IF

En MySQL disponemos de la función `IF` con la que podemos comprobar una condición y devolver un valor u otro en función de si se cumple o no.

Por ejemplo, si queremos contar el número de juegos en los que participa un concursante y mostrar 0 para los concursantes que no participan en ningún juego, podemos hacerlo con la siguiente consulta:

```SQL
SELECT c.cdconcur, 
```




