# Creación de procedimientos almacenados

## Creación del procedimiento

Para crear un procedimiento almacenado en MySQL, se utiliza la siguiente sintaxis:

```sql
CREATE PROCEDURE nombre_procedimiento()
COMMENT 'Comentario del procedimiento'
LANGUAGE SQL
SQL SECURITY INVOKER -- O DEFINER. Define con qué identidad se ejecutará el procedimiento, lo explicaremos más adelante.
BEGIN
    -- Cuerpo del procedimiento
END;
```

### Comando `DELIMITER`

Para evitar que se ejecuten las sentencias SQL durante el proceso de definición del procedimiento, se utiliza el comando `DELIMITER` para cambiar el delimitador de sentencias de `;` a otro carácter, por ejemplo `//`.

De este modo el ejemplo anterior quedaría de la siguiente manera:

```sql
DELIMITER // -- Cambiamos el delimitador de sentencias.
CREATE PROCEDURE nombre_procedimiento()
COMMENT 'Comentario del procedimiento'
LANGUAGE SQL
SQL SECURITY INVOKER -- O DEFINER. Define con qué identidad se ejecutará el procedimiento, lo explicaremos más adelante.
BEGIN
    -- Cuerpo del procedimiento
END// -- Usameos el nuevo delimitador // para finalizar la definición del procedimiento.
DELIMITER ; -- Volvemos a establecer el delimitador por defecto.
```

### Sección `COMMENT`

Es opcional y se utiliza para agregar un comentario al procedimiento. Se puede utilizar para describir la funcionalidad del procedimiento.

### Sección `SQL SECURITY`

`SQL SECURITY` es una cláusula que interactua con el valor opcional `DEFINER = 'usuario'@'origen'` que podemos especificar en la definición del procedimiento:

`CREATE DEFINER = 'usuario'@'origen' PROCEDURE nombre_procedimiento()`

Este apartado es importante. Su valor por defecto es `DEFINER`. Es decir, si omitimos esta sección será igual a usar `SQL SECURITY DEFINER`.

Cuando definimos un procedimiento podemos hacer uso de la cláusula `DEFINER = 'usuario'@'origen'`. Si usamos esta cláusula y más adelante establecemos la opción `SQL SECURITY DEFINER`, esto hará que el ejecutor del procedimiento sea el usuario especificado en la cláusula `DEFINER`. Es decir, se ejecutará el procedimiento como si lo hiciera `'usuario'@'origen'`.

| VALOR DE `DEFINER` | VALOR DE `SQL SECURITY` | EJECUTOR DEL PROCEDIMIENTO            |
|--------------------|-------------------------|---------------------------------------|
| Omitido            | Omitido                 | El usuario que creó el procedimiento. |
| Omitido            | `DEFINER`               | El usuario que creó el procedimiento. |
| `DEFINER = 'usuario'@'origen'` | `DEFINER` | `'usuario'@'origen'` |
| Omitido            | `INVOKER`               | El usuario que invoca el procedimiento. |
| `DEFINER = 'usuario'@'origen'` | `INVOKER` | El usuario que invoca el procedimiento. |

En lenguaje llano, si **no especificamos nada** (ni `DEFINER =` ni `SQL SECURITY`), el procedimiento se ejecutará con los permisos del usuario que lo creó. Si **especificamos `SQL SECURITY INVOKER`** se ejecutará como el usuario que lo invoca. Si **especificamos `DEFINER = 'usuario'@'origen'`** y **`SQL SECURITY DEFINER`**, se ejecutará como el usuario especificado en `DEFINER`.

De este modo es importante tener en cuenta quién será el usuario que ejecutará el procedimiento y si queremos asegurarnos de que ejecutará. Es decir, para que el procedimiento pueda ejecutarse han de cumplirse dos condiciones:

* El usuario que ejecuta el procedimiento ha de tener permisos de ejecución `EXECUTE` sobre el procedimiento.
* El usuario que ejecuta el procedimiento ha de tener permisos de ejecución sobre los objetos que se utilizan en el procedimiento (por ejemplo las tablas de las bases de datos a la que acceda).

## Permisos relacionados con procedimientos almacenados

Los permisos relacionados con los procedimientos almacenados son los siguientes:

* `CREATE ROUTINE`: Permite crear procedimientos almacenados y funciones.
* `ALTER ROUTINE`: Permite modificar procedimientos almacenados y funciones.
* `EXECUTE`: Permite ejecutar procedimientos almacenados y funciones.

De este modo podemos tener un usuario que es el encargado de crear los procedimientos almacenados, otro usuario con permisos de acceso o modificación sobre distintas bases de datos (que podemos usar en `DEFINER`) y otro usuario que puede ejecutar los procedimientos almacenados sin que tenga permisos de acceso o modificación sobre las bases de datos.

```sql
DELIMITER //
CREATE DEFINER 'admin'@'localhost' PROCEDURE Cliente.mantenimiento ()
SQL SECURITY DEFINER BEGIN
    -- Cuerpo del procedimiento
END//
DELIMITER ;
```

Supongamos que `'admin@'localhost'` es el usuario que crea el procedimiento y tiene permisos de acceso y modificación sobre las bases de datos.

Si creamos un usuario (`'usuario'@'%'`) **sin permiso sobre ninguna base de datos** pero con permiso de ejecución sobre el procedimiento, podrá ejecutar el procedimiento sin problemas:

`GRANT EXECUTE ON PROCEDURE Cliente.mantenimiento TO 'usuario'@'%';`
