# Variables

En MySQL podemos distinguir varios tipos de variables:

* Variables de sistema: Son variables que se utilizan para almacenar información sobre el servidor y su configuración. Se pueden consultar con el comando `SHOW VARIABLES` y se pueden modificar con el comando `SET GLOBAL` o `SET SESSION`.
  * Variables de sesión: Son variables que se aplican a la sesión actual del cliente. Se pueden modificar con el comando `SET SESSION` y se eliminan al cerrar la sesión.
  * Variables globales: Son variables que se aplican a todo el servidor. Se pueden modificar con el comando `SET GLOBAL` y se mantienen hasta que se reinicia el servidor.
* Variables de usuario: Son variables que se utilizan para almacenar información temporal en una sesión. Se pueden crear y modificar con el comando `SET` y se eliminan al cerrar la sesión. Se pueden utilizar en consultas SQL y procedimientos almacenados.
* Variables de rutina o locales: Son variables que se utilizan cuando escribimos una rutina almacenada. Estas variables se declaran con el comando `DECLARE` en el cuerpo de la rutina y se utilizan para almacenar información temporal. Se eliminan al finalizar la rutina.

Las que nos interesarán en este momento serán las variables de usuario y las de las rutinas.

## Establecer una variable de usuario

Para establecer una variable de usuario, se utiliza el comando `SET` seguido del nombre de la variable y su valor. El nombre de la variable debe comenzar con el símbolo `@` y puede contener letras, números y guiones bajos. Por ejemplo:

```sql
SET @my_variable_de_usuario = 10;
```

Esta variable existirá hasta que se cierre la sesión, es decir, hasta que se cierre la conexión con el servidor.

## Declarar una variable de rutina

Para ver cómo declaramos una variable en una rutina usaremos el siguiente procedimiento de ejemplo:

```SQL
DELIMITER $$

DECLARE PROCEDURE mi_procedimiento()
BEGIN
    -- Al comienzo del código deben ir las declaraciones de variables.
    DECLARE mi_variable_de_rutina INT DEFAULT 0;
    -- Seguiríamos con las declaraciones de cursores.
    -- Finalmente tendríamos las declaraciones de los manejadores (handlers).

    SET mi_variable_de_rutina = 10;
    SELECT mi_variable_de_rutina;
END$$

DELIMITER ;
```

Para declarar una variable dentro de la rutina hemos de usar la palabra clave `DECLARE` seguida del nombre de la variable y su tipo de dato. En este caso, hemos declarado una variable llamada `mi_variable_de_rutina` de tipo `INT` y le hemos asignado un valor inicial de 0. Luego, dentro del cuerpo de la rutina, le asignamos el valor 10 y lo mostramos con un `SELECT`.

**IMPORTANTE:** Si vamos a usar variables dentro de una rutina estas han de ser lo primero que declaremos, antes de cualquier otra instrucción. Si no lo hacemos así, MySQL nos dará un error.

Orden de declaraciones en una rutina:

1. Variables de rutina.
2. Condiciones.
3. Cursores.
4. Manejadores (_handlers_).

Las declaraciones han de seguir ese orden y ser las primeras instrucciones dentro del cuerpo de la rutina.
