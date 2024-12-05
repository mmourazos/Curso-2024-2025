# Cosas sobre `LOCK TABLES`

En este documento iré incluyendo cosas interesantes que vaya viendo sobre el comportamiento de `LOCK TABLES` en MySQL.

## Bloquear una tabla para lectura y escritura

**No se puede usar el nombre de una tabla más de una vez en la misma sentencia `LOCK TABLES`.** Esto hace que si queremos hacer un _lock_ de escritura y otro de lectura sobre la misma tabla hemos de usar un alias:

```sql
LOCK TABLES tabla1 WRITE, tabla1 AS t READ;
```

## ¿Cómo saber qué tablas están bloqueadas?

Para saber qué tablas están bloqueadas en MySQL podemos ejecutar la siguiente consulta:
```sql
SHOW OPEN TABLES WHERE In_use > 0;
```

El campo `In_use` nos indica cuántos _locks_ (o peticiones de bloqueo) hay sobre la tabla. Si una sesión obtiene un _lock_ **de escritura** sobre una tabla y otra sesión intenta realizar otro _lock_ de escritura, esta segunda sesión se quedará esperando a que la primera libere el _lock_. Si en ese momento ejecutamos la consulta anterior, veremos que la tabla tiene un `In_use` de 2.

## Comportamiento de las transacciones y lock tables

Cosas que pasan cuando se ejecutan ciertas sentencias en MySQL:

* Si ejecutamos un `UNLOCK TABLES` se ejecutará un `COMMIT` automáticamente finalizando la transacción activa. **SóLO SI SE HA USADO ANTES UN `LOCK TABLES`** para bloquear la tabla.
* Si se ejecuta un `START TRANSACTION` se ejecutará un `UNLOCK TABLES` automáticamente.
* Si la variable `autocommit` está a 1, activa u `ON` (valor por defecto), se ejecutará un `COMMIT` con cada operación `INSERT`, `UPDATE` o `DELETE`.
* Si la variable `autocommit` está a 0, desactivada u `OFF`, no se hará un `COMMIT` hasta que se ejecute un `COMMIT` explícitamente.

Visto lo anterior, si queremos bloquear unas tablas y realizar una serie de operaciones **dentro de UNA transacción** debemos seguir los siguientes pasos:

```sql
SET autocommit = 0;
LOCK TABLES tabla1 WRITE, tabla2 READ, ...;
-- Operaciones que queramos hacer dentro de la transacción.
-- Si ejecutamos un UPDATE se iniciará una transacción automáticamente.
-- esta transacción no se cerrará hasta que se ejecute un COMMIT.
COMMIT;
UNLOCK TABLES;
```

Si por el contrario usamos `START TRANSACTION`.

```sql
SET autocommit = 0;
LOCK TABLES tabla1 WRITE, tabla2 READ, ...;
START TRANSACTION; -- Se libera el `LOCK`.
-- Operaciones que queramos hacer dentro de la transacción.
-- Si ejecutamos un UPDATE se iniciará una transacción automáticamente.
-- esta transacción no se cerrará hasta que se ejecute un COMMIT.
COMMIT;
UNLOCK TABLES;
```

Si **no usamos** `autocommit = 0`:

```sql
LOCK TABLES tabla1 WRITE, tabla2 READ, ...;
-- Operaciones que queramos hacer dentro de la transacción.
-- Si ejecutamos un UPDATE se iniciará una transacción automáticamente.
-- Como autocommit está activo se ejecuta un commit al finalizar el UPDATE.
-- El siguiente UPDATE iniciará UNA NUEVA TRANSACCIóN.
-- Y así para cada operación debido a que se ejecutan commits implícitos.
COMMIT;
UNLOCK TABLES;
```

Como podemos ver no lograríamos realizar multiples operaciones en una única transacción.

## Bloquear filas de una tabla

```sql
SELECT * FROM tabla WHERE columna = valor FOR UPDATE;
```
```
