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
...
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

_En primer lugar cabe destacar que se ha omitido por error el campo `DNI` del cliente. Será necesario incluirlo como parámetro de entrada del procedimiento._
_Hay que tener en cuenta que los kilómetros del vehículo se almacenan en la tabla `REPARACIONES`._
_"Sustitución de las lámparas delanteras" podría considerarse como el valor del campo `Avería` o el campo `Observaciones` de `REPARACIONES`._

Si invocamos el procedimiento con los datos indicados:

```sql
call TalleresFaber.ReparacionClienteNuevo('00011', '0', 'Tomás', 'Gómez Calle', '555', '3131 FGH', 'Renault', 'Scénic', '2009-03-17', 105000, 'Sustitución
lámparas delanteras');
```

Debería de obtener el siguiente resultado:

```txt
+-------------------------------------+
| Aviso: clave duplicada              |
+-------------------------------------+
| El cliente y/o vehículo ya existen. |
+-------------------------------------+
1 row in set (0.0175 sec)

+-------------------------------------+
| Aviso: clave duplicada              |
+-------------------------------------+
| El cliente y/o vehículo ya existen. |
+-------------------------------------+
1 row in set (0.0175 sec)
```

Y comprobando la tabla `REPARACIONES`:

```txt
+--------------+-----------+--------------+-----------+-----------------------------------------------+-------------+----------+---------------------------+
| IdReparacion | Matricula | FechaEntrada | Km        | Avería                                       | FechaSalida | Reparado | Observaciones             |
+--------------+-----------+--------------+-----------+-----------------------------------------------+-------------+----------+---------------------------+
|            1 | 5566 ABC  | 2010-12-30   |  50000.00 | Posible desgaste de la correa de distribución | 2011-01-01  |        1 | Sin observaciones         |
|            2 | 1313 DEF  | 2011-01-01   |  60000.00 | Ruido tubo de escape                          | 2011-01-02  |        1 | Cambiar si es necesario   |
...
|            9 | 1515 DEF  | 2011-01-07   |  45000.00 | Ruido amortiguadores                          | 2011-01-08  |        0 | No acepta presupuesto     |
|           10 | 1212 DEF  | 2011-01-10   |  62300.00 | El radiador pierde agua                       | NULL        |        0 | Pendiente de entrega      |
|           11 | 3131 FGH  | 2025-04-08   | 105000.00 | Sustitución lámparas delanteras               | NULL        |     NULL | NULL                      |
+--------------+-----------+--------------+-----------+-----------------------------------------------+-------------+----------+---------------------------+
11 rows in set (0.0023 sec)
```

Podemos comprobar que se ha añadido la nueva reparación (con `IdReparacionp` 11) a la tabla `REPARACIONES` y que el resto de datos no se han modificado.

## Apartado 6

> Creación de funciones:
>
> 1. Diseña una función que calcule el importe de los recambios sustituidos en una reparación.
> 2. Crea una función que devuelva el importe de las actuaciones que se llevan a cabo en una reparación (para calcular el importe multiplica las horas por el importe de cada actuación). En ambas funciones Pasar como variable el Id de la reparación.
>
> 3. Diseñar una consulta que calcule el importe total (mano de obra y recambios) de las reparaciones que se le hayan realizado al vehículo de matrícula '1313 DEF'.

_Se nos pide crear dos funciones y una consulta. La primera función calculará el importe de los recambios sustituidos en una reparación y la segunda función calculará el importe de las actuaciones que se llevan a cabo en una reparación._

_La consulta que se nos pide calculará el importe total (mano de obra y recambios), se entiende que empleando las funciones que acabamos de crear._

La primera función la llamaremos `TotalRecambios` y a la segunda `TotalActuaciones`.

`TotalRecambios` ha de calcular la **suma** del producto del número de unidades (tabla `Incluye` campo `Unidades`) por el precio de referencia de cada recambio (tabla `RECAMBIOS` campo `PrecioReferencia`).

Una vez completada la función podemos probarla invocándola con el `IdReparacion` 10:

```sql
SELECT TalleresFaber.TotalRecambios(10) AS "Total recambios";
+-----------------+
| Total recambios |
+-----------------+
|           92.90 |
+-----------------+
```

Para comprobar el resultado podemos ejecutar la siguiente consulta:

```sql
SELECT rp.IdReparacion, i.Unidades, rc.PrecioReferencia FROM REPARACIONES AS rp INNER JOIN Incluyen AS i ON rp.IdReparacion = i.IdReparacion INNER JOIN RECAMBIOS AS rc ON i.IdRecambio = rc.IdRecambio WHERE rp.IdReparacion = 10;
```

Que debería devolver el siguiente resultado:

```txt
+--------------+----------+------------------+
| IdReparacion | Unidades | PrecioReferencia |
+--------------+----------+------------------+
|           10 |        2 |             2.00 |
|           10 |        1 |            88.90 |
+--------------+----------+------------------+
```

Si hacemos las cuentas comprobamos que: $2 * 2.00 + 1 * 88.90 = 4.00 + 88.90 = 92.90$.

La segunda función es análoga a la primera pero involucrando a las tablas `REPARACIONES`, `Realizan` y `ACTUACIONES`.

Si invocamos la función con el `IdReparacion` 10:

```sql
select TalleresFaber.TotalActuaciones(10) AS "Total actuaciones";
```

Deberíamos de obtener el siguiente resultado:

```txt
+-------------------+
| Total actuaciones |
+-------------------+
|            309.40 |
+-------------------+
```

De nuevo, para comprobar el resultado podemos ejecutar la siguiente consulta:

```sql
SELECT rp.IdReparacion, r.Horas, a.Importe FROM REPARACIONES AS rp INNER JOIN Realizan AS r ON rp.IdReparacion = r.IdReparacion INNER JOIN ACTUACIONES AS a ON r.Referencia = a.Referencia WHERE rp.IdReparacion = 10;
```

Que nos devolverá el siguiente resultado:

```txt
+--------------+-------+---------+
| IdReparacion | Horas | Importe |
+--------------+-------+---------+
|           10 |  0.20 |   10.00 |
|           10 |  2.50 |  120.50 |
|           10 |  0.30 |   20.50 |
+--------------+-------+---------+
```

Y si realizamos los cálculos:

```sql
select (0.2 * 10 + 2.5 * 120.50 + 0.3 * 20.5) AS "Total actuaciones";
```

Podremos comprobar que los resultados concuerdan:

```txt
+-------------------+
| Total actuaciones |
+-------------------+
|           309.400 |
+-------------------+
```

Finalmente, para calcular el importe total de las reparaciones que se le hayan realizado al vehículo de matrícula `1313 DEF` podremos realizar una consulta que incluya ambas funciones. El resultado debería de ser el siguiente:

Total recambios:

```sql
+-----------------+
| Coste recambios |
+-----------------+
|          210.00 |
|           87.71 |
+-----------------+
```

Total = 210.00 + 87.71 = 297.71.

Total actuaciones:

```txt
+-------------------+
| Coste actuaciones |
+-------------------+
|            450.00 |
|              6.50 |
+-------------------+
```

Total = 450.00 + 6.50 = 456.50.

Sumando ambos resultados: Total recambios + Total actuaciones = 297.71 + 456.50 = 754.21.

Que concuerda con lo obtenido al ejecutar la consulta que se nos pedía:

```sql
+------------------+
| Total reparación |
+------------------+
|           754.21 |
+------------------+
```

## Apartado 7

> Crea una función que reciba como parámetro de entrada el número correspondiente a un mes y devuelva el importe total facturado ese mes. Utiliza para ello las dos funciones obtenidas en la práctica anterior.
>
> NOTAS:
>
> * Por ejemplo para Enero, número del mes 1.
> * Utilizar un cursor para recorrer cada fila de la consulta de los IdReparacion que se obtengan en ese mes.
> * Controla mediante un HANDLER que la consulta haya devuelto alguna fila.

Una vez creada la función podremos probarla con el mes de enero (1):

```sql
select TalleresFaber.FacturadoMes(1) AS total_mes;
```

Y debería devolvernos el siguiente resultado:

```txt
+-----------+
| total_mes |
+-----------+
|   3366.05 |
+-----------+
```

**Nótese que sólo hay reparaciones para el mes de enero.**

**Una forma simple de comprobar los valores internos (mediante `SELECT`) para el código de la función consiste en reescribir la función en forma de procedimiento, ya que en un procedimiento sí podemos utilizar sentencias `SELECT`.**

**Un ejemplo del uso de un _handler_ tal como se nos indica en el enunciado lo podemos encontra [aquí](https://dev.mysql.com/doc/refman/8.4/en/cursors.html).**

## Apartado 8

> Crea un trigger que, antes de insertar una fila en la tabla Incluyen, compruebe si existen unidades en Stock en la tabla RECAMBIOS llevando a cabo las siguientes acciones:
>
> * Si hay suficientes unidades actualiza el Stock restando las unidades que se van a insertar.
> * Si no hay suficientes unidades en Stock cancela la inserción de las unidades.
