# Resultados esperados para la tarea de la unidad 6

## Apartado 1

> Crea un procedimiento que muestre los vehículos (marca, modelo y color) que no estén reparados y los datos de los clientes y vehículos que han entrado a reparar hoy. (En nuestro caso ninguno).

_Lo que se indica en el enunciado es que hay dos consultas. La primera para mostrar los datos que se indican de los vehcílos que no están reparados y la segunda para mostrar los datos de los clientes y vehículos que han entrado a reparar hoy. En este caso, como se indica en el enunciado, no hay vehículos que hayan entrado a reparar hoy._

```txt
+---------+--------+---------------+
| marca   | modelo | color         |
+---------+--------+---------------+
| Renault | Clio   | Gris perla    |
| Citroen | C4     | Azul Turquesa |
+---------+--------+---------------+
2 rows in set (0.0010 sec)
```

## Apartado 2

> * Realiza un procedimiento que reciba la matrícula de un vehículo y escriba las características del automóvil y el número de reparaciones que ha sufrido ese automóvil, los empleados que han realizado esas reparaciones y los datos de los vehículos de la misma marca.
> * Hacer una llamada al procedimiento creado.

_Este apartado indica que creemos un procedimiento y a continuación lo invoquemos._

* _En un primer select se pueden mostrar los datos del vehículo._
* _**Se espera que el número de reparaciones se devuelva en un parámetro de salida del procedimiento.**_
* _En un segundo select se pueden mostrar los datos de los empleados que han realizado esas reparaciones._
* _En un tercer select se pueden mostrar los datos de los vehículos de la misma marca._

Suponiendo que llamemos al procedimiento `a2_proc` y lo invoquemos con la matrícula `1313 DEF`:

```sql
call TalleresFaber.a2_proc('1313 DEF', @num_rep);
```

Obtendríamos el siguiente resultado:

```txt
+-----------+-------+--------+-------+-------------------+
| matricula | marca | modelo | color | num. reparaciones |
+-----------+-------+--------+-------+-------------------+
| 1313 DEF  | Seat  | Ibiza  | Gris  |                 2 |
+-----------+-------+--------+-------+-------------------+
1 row in set (0.0013 sec)

+-----------+---------+-----------+
| dni       | nombre  | apellidos |
+-----------+---------+-----------+
| 76543210B | Joaquín | Ruiz Díaz |
| 54321098D | Javier  | Vegar Cos |
| 54321098D | Javier  | Vegar Cos |
+-----------+---------+-----------+
3 rows in set (0.0013 sec)

+-------+--------+-------+-----------+
| marca | modelo | color | matricula |
+-------+--------+-------+-----------+
| Seat  | Ibiza  | Gris  | 1313 DEF  |
| Seat  | Leon   | Rojo  | 1616 DEF  |
| Seat  | León   | Rojo  | 4455 ABC  |
+-------+--------+-------+-----------+
3 rows in set (0.0013 sec)

Query OK, 0 rows affected (0.0008 sec)
```

Para comprobar el valor del parámetro de salida, se puede hacer un `SELECT`:

```txt
SELECT @num_rep;
+----------+
| @num_rep |
+----------+
|        2 |
+----------+
1 row in set (0.0006 sec)
```

Para un coche sin reparaciones (matrícula: )
Este es sólo un posible resultado, variaciones sobre el mismo sería válidas.

```sql
call TalleresFaber.a2_proc('2233 ABC', @num_rep);
```

```txt
+-----------+-------+--------+-----------------+-------------------+
| matricula | marca | modelo | color           | num. reparaciones |
+-----------+-------+--------+-----------------+-------------------+
| 2233 ABC  | Ford  | Mondeo | Gris metalizado |                 0 |
+-----------+-------+--------+-----------------+-------------------+
1 row in set (0.0009 sec)

Empty set (0.0009 sec)

+-------+--------+-----------------+-----------+
| marca | modelo | color           | matricula |
+-------+--------+-----------------+-----------+
| Ford  | Mondeo | Gris metalizado | 2233 ABC  |
+-------+--------+-----------------+-----------+
1 row in set (0.0009 sec)

Query OK, 0 rows affected (0.0009 sec)
```

Y el valor del parámetro de salida sería:

```txt
SELECT @num_rep;
+----------+
| @num_rep |
+----------+
|        0 |
+----------+
1 row in set (0.0005 sec)
```

## Apartado 3

> Modifica el procedimiento anterior añadiendo un HANDLER que controle que si esa matrícula no está en la base de datos, el resto de instrucciones no se ejecuten.

**NOTA: Para que salte el `NOT FOUND` / `SQLSTATE '02000` ha de realizarse una consulta que guarde el resultado en una variable (por ejemplo que guarde la marca del vehículo con la matrícula indicada).**

Un select _normal_ no disparará un `SQLSTATE '02000'` aún que no devuelva resultados.

Un posible resultado sería:

```sql
CALL TalleresFaber.a3_proc('0000 XXX', @num_rep);
```

```txt
+--------------------------------------------------------+
| Error                                                  |
+--------------------------------------------------------+
| No se ha encontrado el vehículo con matrícula 0000 XXX |
+--------------------------------------------------------+
1 row in set (0.0011 sec)
```

## Apartado 4

> Crea una función que actualice el estado de las reparaciones que estén finalizadas en una fecha que se indique y que devuelva cuantas reparaciones han finalizado en esa fecha.

_En este apartado se nos pide que indiquemos una fecha. Hemos de comprobar si hay reparaciones con `FechaSalida` igual a esa fecha, ese será el valor a devolver._

_Para las reparaciones cuya `FechaSalida` sea igual a la fecha indicada, se ha de actualizar el campo `Reparado` a `1`._

La función que se nos pide crear es `NOT DETERMINISTIC` ya que no se puede garantizar que el resultado sea el mismo cada vez que se ejecute.

MySQL no nos permitirá crear una función `NOT DETERMINISTIC` por lo que tendremos varias alternativas:

* _Mentir_ y decir que es `DETERMINISTIC`.
* Modificar el valor de la variable global `log_bin_trust_function_creators` de `0` a `1`.

Si optamos por la segunda opción hemos de usar la siguiente sentencia:

```sql
set global log_bin_trust_function_creators = 1;
```

Se nos indica que debemos mirar esta variable en el error que nos da MySQL al intentar crear la función.

Para más información sobre dicha variable se puede consultar [log_bin_trust_function_creators](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_log_bin_trust_function_creators).

Para analizar el resultado de la función deberíamos comprobar los valores de `FechaSalida` y `Reparado` de las reparaciones antes y después de ejecutar la función.

Antes:

```txt
+-------------+----------+
| fechasalida | reparado |
+-------------+----------+
| 2011-01-01  |        1 |
| 2011-01-02  |        1 |
| 2011-01-03  |        1 |
| 2011-01-04  |        1 |
| 2011-01-06  |        1 |
| 2011-01-04  |        1 |
| 2011-01-04  |        1 |
| 2011-01-07  |        1 |
| 2011-01-08  |        0 |
| NULL        |        0 |
+-------------+----------+
```

```sql
SELECT TalleresFaber.a4_func('2011-01-01') AS Reparados;
```

Nos dará el siguiente resultado:

```txt
+-----------+
| Reparados |
+-----------+
|         1 |
+-----------+
1 row in set (0.0010 sec)
```

Y no habrá cambiado nada en la tabla `REPARACIONES` ya que su valor de `Reparado` ya era `1`.

```txt
+-------------+----------+
| fechasalida | reparado |
+-------------+----------+
| 2011-01-01  |        1 |
| 2011-01-02  |        1 |
| 2011-01-03  |        1 |
| 2011-01-04  |        1 |
| 2011-01-06  |        1 |
| 2011-01-04  |        1 |
| 2011-01-04  |        1 |
| 2011-01-07  |        1 |
| 2011-01-08  |        0 |
| NULL        |        0 |
+-------------+----------+
```

Si invocamos la función con la fecha `2011-01-08`:

```sql
SELECT TalleresFaber.a4_func('2011-01-08') AS Reparados;
```

Obtendremos el siguiente resultado:

```txt
+-----------+
| Reparados |
+-----------+
|         1 |
+-----------+
1 row in set (0.0160 sec)
```

Y esta vez sí se habrá actualizado el valor de `Reparado` a `1` para la fecha `2011-01-08`.

```txt
| 2011-01-07  |        1 |
| 2011-01-08  |        1 |
| NULL        |        0 |
+-------------+----------+
```

## Apartado 5

> Crea un procedimiento para dar de alta una nueva reparación para un vehículo y un cliente que no tenemos registrado. Llama al procedimiento ReparacionClienteNuevo.
>
> Incluye un HANDLER que controle que si insertamos un cliente y/o un vehículo que ya existen, el resto de sentencias continúen ejecutándose, y se añade como mínimo la nueva reparación.
>
> Para probar el procedimiento toma como referencia los datos siguientes: (tomados de un ejercicio de la unidad anterior)
>
> Un cliente nuevo nos ha traído su vehículo al taller el día 03/03/2020. En recepción se registran los siguientes datos:
>
> * Del cliente.- Código: 00011, Nombre y apellidos: Tomás Gómez Calle, Teléfono: 22334455.
> * Del vehículo.- Matrícula: 3131 FGH, Modelo: Renault Scénic, matriculado el 17/03/2009, 105.000 km.
> * De la reparación.- Sustitución de las lámparas delanteras.
