# Solución de la tarea de la unidad 6

## Apartado 1

> Crea un procedimiento que muestre los vehículos (marca, modelo y color) que no estén reparados y los datos de los clientes y vehículos que han entrado a reparar hoy (en nuestro caso ninguno).

Hemos de crear dos cláusulas select en nuestro procedimiento, una para mostrar los vehículos que no están reparados y otra para mostrar los datos de los clientes y vehículos que han entrado a reparar hoy. Para ello, utilizaremos la siguiente consulta SQL:

```sql
SELECT v.marca, v.modelo, v.color FROM VEHICULOS AS v INNER JOIN REPARACIONES AS r ON v.Matricula = r.Matricula WHERE NOT r.Reparado;
```

La otra sentencia `SELECT` ha de utilizar la función `NOW()` para obtener la fecha de hoy:

```sql
SELECT c.DNI, c.Nombre, c.Apellido, v.Matricula, v.marca, v.modelo FROM CLIENTES AS c INNER JOIN VEHICULOS AS v ON c.CodCliente = v.CodCliente INNER JOIN REPARACIONES AS r ON v.Matricula = r.Matricula WHERE r.FechaEntrada = DATE(NOW());
```

Hemos de usar `DATE()` pues `NOW()` nos devuelve, además de la fecha, la hora y no podríamos hacer la comparación correctamente. `DATE()` extrae la parte de la fecha de un valor de fecha y hora `DATETIME`.

El procedimiento completo quedaría así:

```sql
DELIMITER $$

CREATE PROCEDURE TalleresFaber.a1_proc()
BEGIN
  SELECT v.marca, v.modelo, v.color FROM VEHICULOS AS v INNER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE NOT r.reparado;
  SELECT c.dni, c.nombre, c.apellidos, v.matricula, v.marca, v.modelo FROM VEHICULOS AS v INNER JOIN CLIENTES AS c ON v.codcliente = c.codcliente INNER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE r.fechaentrada = DATE(NOW());

END$$

DELIMITER ;

```

## Apartado 2

> * Realiza un procedimiento que reciba la matrícula de un vehículo y escriba las características del automóvil y el número de reparaciones que ha sufrido ese automóvil, los empleados que han realizado esas reparaciones y los datos de los vehículos de la misma marca.
> * Hacer una llamada al procedimiento creado.

Este procedimiento ha de recibir un dato, la matrícula de un vehículo, por lo que lo declararemos con un parámetro de entrada. El número de reparaciones ha de ser comunicado mediante una variable de salida.

```sql
CREATE PROCEDURE TalleresFaber.a2_proc(IN matricula VARCHAR(8), OUT num_reparaciones INT)
```

El procedimiento completo quedaría como:

```sql
DELIMITER $$

CREATE PROCEDURE TalleresFaber.a2_proc(IN matricula VARCHAR(8), OUT num_rep INT)
BEGIN
  -- Declaramos la variable para guardar la marca del vehículo.
  DECLARE marca VARCHAR(25);

  -- Guardamos la marca porque luego hemos de usarla para mostrar los vehículos de la misma marca.
  SELECT v.marca FROM VEHICULOS AS v WHERE v.matricula = matricula INTO marca;

  -- Primero mostramos los datos del vehículo (no sería necesario mostrar el número de reparaciones, pero lo incluimos para que quede claro que es el mismo vehículo).
  SELECT v.matricula, v.marca, modelo, color, count(idreparacion) AS "num. reparaciones" FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula;

  -- Guardamos el número de reparaciones en la variable de salida.
  SELECT count(idreparacion) FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula INTO num_rep;

  -- Mostramos los empleados que han intervenido en la(s) reparación(es) del vehículo.
  SELECT dni, nombre, apellidos FROM EMPLEADOS AS e INNER JOIN Intervienen AS i ON e.codempleado = i.codempleado
  INNER JOIN REPARACIONES AS r ON i.idreparacion = r.idreparacion WHERE r.matricula = matricula;

  -- Finalmente mostramos los datos de los demás vehículos de la misma marca.
  SELECT v.marca, modelo, color, v.matricula FROM VEHICULOS AS v WHERE v.marca = marca;

END$$

DELIMITER ;
```

## Apartado 3

> Modifica el procedimiento anterior añadiendo un HANDLER que controle que si esa matrícula no está en la base de datos, el resto de instrucciones no se ejecuten.

```sql
DELIMITER $$

CREATE PROCEDURE TalleresFaber.a2_proc(IN matricula VARCHAR(8), OUT num_rep INT)
BEGIN
  -- Declaramos la variable para guardar la marca del vehículo.
  DECLARE marca VARCHAR(25);

  DECLARE EXIT HANDLER FOR NOT FOUND
    SELECT CONCAT('No existe el vehículo con matrícula ', matricula) AS error;

  -- Guardamos la marca porque luego hemos de usarla para mostrar los vehículos de la misma marca.
  SELECT v.marca FROM VEHICULOS AS v WHERE v.matricula = matricula INTO marca;

  -- Primero mostramos los datos del vehículo (no sería necesario mostrar el número de reparaciones, pero lo incluimos para que quede claro que es el mismo vehículo).
  SELECT v.matricula, v.marca, modelo, color, count(idreparacion) AS "num. reparaciones" FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula;

  -- Guardamos el número de reparaciones en la variable de salida.
  SELECT count(idreparacion) FROM VEHICULOS AS v 
  LEFT OUTER JOIN REPARACIONES AS r ON v.matricula = r.matricula WHERE v.matricula = matricula
  GROUP BY v.matricula INTO num_rep;

  -- Mostramos los empleados que han intervenido en la(s) reparación(es) del vehículo.
  SELECT dni, nombre, apellidos FROM EMPLEADOS AS e INNER JOIN Intervienen AS i ON e.codempleado = i.codempleado
  INNER JOIN REPARACIONES AS r ON i.idreparacion = r.idreparacion WHERE r.matricula = matricula;

  -- Finalmente mostramos los datos de los demás vehículos de la misma marca.
  SELECT v.marca, modelo, color, v.matricula FROM VEHICULOS AS v WHERE v.marca = marca;

END$$

DELIMITER ;
```

## Apartado 4

> Crea una función que actualice el estado de las reparaciones que estén finalizadas en una fecha que se indique y que devuelva cuantas reparaciones han finalizado en esa fecha.

```sql
DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.a4_func$$

CREATE FUNCTION TalleresFaber.a4_func(fecha DATE)
RETURNS INT
MODIFIES SQL DATA
BEGIN
  DECLARE finalizadas INT;
  SELECT COUNT(*) FROM REPARACIONES AS r WHERE r.FechaSalida = fecha INTO finalizadas;

  UPDATE REPARACIONES AS r SET Reparado = 1 WHERE r.FechaSalida = fecha;

  RETURN finalizadas;

END$$

DELIMITER ;
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

```sql
DELIMITER $$

DROP PROCEDURE IF EXISTS TalleresFaber.ReparacionClienteNuevo$$

CREATE PROCEDURE TalleresFaber.ReparacionClienteNuevo (
   IN cod_cli VARCHAR(5),
   IN DNI VARCHAR(10),
   IN nombre VARCHAR(25),
   IN apellidos VARCHAR(50),
   IN telefono VARCHAR(9),
   IN matricula VARCHAR(8),
   IN marca VARCHAR(25),
   IN modelo VARCHAR(50),
   IN fecha_matricula DATE,
   IN km_recorridos DECIMAL(8, 2),
   IN averia VARCHAR(200)
)
BEGIN
   -- Declaramos un handler para manejar error de duplicado "1062".
   DECLARE CONTINUE HANDLER FOR 1062 SELECT 'El cliente y/o vehículo ya existen.' AS 'Aviso: clave duplicada';

   INSERT INTO CLIENTES (codcliente, dni, nombre, apellidos, telefono) values (cod_cli, DNI, nombre, apellidos, telefono);
   INSERT INTO VEHICULOS (matricula, marca, modelo, fechamatriculacion) values (matricula, marca, modelo, fecha_matricula);
   
   INSERT INTO REPARACIONES (matricula, fechaentrada, km, avería) values (matricula, DATE(NOW()), km_recorridos, averia);
END$$

DELIMITER ;
```

La sentecia de llamada al procedimiento sería:

```sql
CALL TalleresFaber.ReparacionClienteNuevo('00011', '0', 'Tomás', 'Gómez Calle', '555', '3131 FGH', 'Renault', 'Scénic', '2009-03-17', 105000, 'Sustitución lámparas delanteras');
```

## Apartado 6

> Creación de funciones:
>
> 1. Diseña una función que calcule el importe de los recambios sustituidos en una reparación.
> 2. Crea una función que devuelva el importe de las actuaciones que se llevan a cabo en una reparación (para calcular el importe multiplica las horas por el importe de cada actuación). En ambas funciones Pasar como variable el Id de la reparación.
>
> 3. Diseñar una consulta que calcule el importe total (mano de obra y recambios) de las reparaciones que se le hayan realizado al vehículo de matrícula '1313 DEF'.

### Función `TotalRecambios`

```sql
DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.TotalRecambios$$

CREATE FUNCTION TalleresFaber.TotalRecambios(idReparacion INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE TotalRecambios DECIMAL(10,2);

    SELECT SUM(i.Unidades * rc.PrecioReferencia) FROM REPARACIONES AS rp 
    INNER JOIN Incluyen AS i ON rp.IdReparacion = i.IdReparacion
    INNER JOIN RECAMBIOS AS rc ON i.IdRecambio = rc.IdRecambio
    WHERE rp.IdReparacion = idReparacion INTO TotalRecambios;

    RETURN IFNULL(TotalRecambios, 0);
END$$

DELIMITER ;
```

### Función `TotalActuaciones`

```sql
DELIMITER $$

DROP FUNCTION IF EXISTS TalleresFaber.TotalActuaciones$$

CREATE FUNCTION TalleresFaber.TotalActuaciones(IdReparacion INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE TotalActuaciones DECIMAL(10,2);

    SELECT SUM(r.Horas * a.Importe) FROM REPARACIONES AS rp 
    INNER JOIN Realizan AS r ON rp.IdReparacion = r.IdReparacion
    INNER JOIN ACTUACIONES AS a ON r.Referencia = a.Referencia
    WHERE rp.IdReparacion = IdReparacion INTO TotalActuaciones;

    RETURN IFNULL(TotalActuaciones, 0);
END$$

DELIMITER ;
```

### Consulta total

```sql
SELECT SUM(TotalRecambios(rp.IdReparacion) + TotalActuaciones(rp.IdReparacion)) AS "Importe total" FROM VEHICULOS AS v INNER JOIN REPARACIONES AS rp ON v.Matricula = rp.Matricula WHERE v.Matricula = '1313 DEF';
```

Si queremos que nos muestre el total por reparación:

```sql
SELECT rp.IdReparacion, (TotalRecambios(rp.IdReparacion) + TotalActuaciones(rp.IdReparacion)) AS "Importe total" FROM VEHICULOS AS v INNER JOIN REPARACIONES AS rp ON v.Matricula = rp.Matricula WHERE v.Matricula = '1313 DEF';
```

## Apartado 7
