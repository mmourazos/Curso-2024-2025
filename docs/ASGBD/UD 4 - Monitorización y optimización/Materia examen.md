# Materia para el examen final

## Ejecución de consultas

Desde que escribimos una consulta en la consola de MySQL hasta que se ejecuta, el motor de MySQL realiza una serie de pasos para ejecutar la consulta. Estos pasos son:

1. Envío de la consulta al servidor MySQL.
2. El servidor recibe la consulta y comprueba la _caché de consultas_ para ver si ya ha sido ejecutada anteriormente y, si el resultado se encuentra en la caché, lo devolverá directamente; si no, se procederá al siguiente paso.
3. El servidor MySQL analiza la consulta para verificar su sintaxis. Si la consulta es sintácticamente correcta, se procederá al siguiente paso; si no, se devolverá un error y se termina el proceso.
4. El motor de ejecución (InnoDB o MyISAM) recibe la consulta y la optimiza generando un _plan de ejecución de la consulta_. Esto es: se decide cómo se ejecutará la consulta, qué índices se utilizarán, etc.
5. El motor ejecuta el plan llamando al motor de almacenamiento y devuelve el resultado al cliente.

Visto lo anterior podemos decir que hay tres pasos fundamentales en la ejecución de una consulta:

* **Análisis**: Comprobar que la consulta es sintácticamente correcta.
* **Procesamiento**: Se comprueba la validez de la consulta más allá de la sintaxis. Se comprueba que los objetos de la consulta existen y que el usuario tiene permisos para acceder a ellos.
* **Optimización**: Si los pasos anteriores se resuelven satisfactoriamente el optimizador generará un plan de ejecución para la consulta. El optimizador ha de conocer el coste de cada operación, de este modo podrá tomar decisiones para reducir el coste de la consulta, como decidir no utilizar un índice si considera que el coste de utilizarlo es mayor que el coste de recorrer la tabla completa, etc.

### `slow_query_log`

El `slow_query_log` es un log que registra las consultas que tardan más de un tiempo determinado (variable `long_query_time`) en ejecutarse y que consten de cierto número de filas (variable `min_examined_row_limit`). Este log es útil para identificar consultas candidatas a ser optimizadas.

Este fichero de log se encuentra en la ruta indicada por la variable `slow_query_log_file` y, por defecto, se encuentra en `/var/log/mysql/mysql-slow.log` en Linux y `C:\ProgramData\mysql\MySQL Server 8.0\Data\`.

Para activar el log de consultas lentas hay que añadir las siguientes líneas al fichero de configuración de MySQL:

```txt
slow_query_log = 1
```

Si el servidor MySQL detecta una consulta que tarda más de `long_query_time` segundos en ejecutarse, la registra en el log de consultas lentas. Si queremos cambiar el tiempo simplemente hemos de incluir la siguiente línea en el fichero de configuración:

```txt
long_query_time = 0.025
```

De esta forma estaríamos indicando que las consultas que tarden más de 0.025 segundos en ejecutarse se registren en el log de consultas lentas.

El formato de cada entrada del log es el siguiente:

```txt
# Time: DATE_TIME
# User@Host: DB_USER[DB_USER] @ localhost []  Id: QUERY_ID
# Query_time: QUERY_TIME Lock_time: LOCK_TIME Rows_sent: ROWS_SENT Rows_examined: ROWS_EXAMINED
SET timestamp=TIMESTAMP;
SQL_QUERY
```

Un ejemplo concreto de entrada del log puede ser similar a la siguiente:

```txt
# User@Host: DB_USER[DB_USER] @ localhost []  Id: 3207186
# Query_time: 2.868424  Lock_time: 0.000343 Rows_sent: 100  Rows_examined: 172784
SET timestamp=1741281356;
SELECT * FROM ...
```

Analizar _a mano_ el log de consultas lentas puede ser tedioso, por lo que existen herramientas que nos ayudan a analizarlo. Una de estas herramientas es el comando `mysqldumpslow`, que permite analizar el log de consultas lentas y generar un resumen de las consultas que más tiempo tardan en ejecutarse. El comando `mysqldumpslow` tiene la siguiente sintaxis:

```bash
mysqldumpslow [opciones] [fichero_log]
```

## Herramientas de gestión de índices

### Optimización de consultas

### Diagnóstico de consultas `EXPLAIN`

## Gestión de índices

### `OPTIMIZE` y `ANALYZE TABLE`
