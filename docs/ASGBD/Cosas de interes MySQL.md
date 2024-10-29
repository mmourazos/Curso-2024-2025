# Recopilación de cosas interesantes de MySQL

## Cuentas en MySQL

Las cuentas de los usuarios de MySQL se almacenan en la base de datos `mysql.user`. Esta base de datos los siguientes campos:

* `user`: Nombre del usuario.
* `host`: Host desde el que se puede conectar el usuario.
* `plugin`: Plugin que se va a usar para autenticar al usuario.
* `authentication_string`: Contraseña cifrada del usuario.
* `password_expired`: Indica si la contraseña ha expirado.
* **Un montón de campos de la forma `..._priv` que indican los privilegios que tiene el usuario.**
* Otros campos que no nos interesan.

La clave primaria de esta tabla es la combinación de los campos `user` y `host`. Ninguno de ellos puede ser `NULL` pero sí se admite que sean vacíos (`''`).

No es _**normal**_ que un usuario tenga alguno de estos campos vacíos.


## ¿Cómo se ha creado una tabla?

Para obtener la sentencia `CREATE TABLE` que dio lugar a una tabla en MySQL podemos ejecutar la siguiente consulta:

```sql
SHOW CREATE TABLE nombre_tabla;
```

## No puedo acceder a MySQL como root (Ubuntu)

Si has instalado MySQL en Ubuntu e intentas acceder como root te encontrarás con un problema:

```bash
$ mysql -u root -p
Enter password:
ERROR 1698 (28000): Access denied for user 'root'@'localhost'
```

Aunque hayas introducido el password correcto para el usuarios `root` del sistema.

### ¿Por qué sucede esto?

Si entramos en la base de datos _por las bravas_ `sudo mysql` y consultamos la tabla con la información sobre los usuarios `mysql.user` veremos que tiene dos campos relacionados con la autenticación que nos interesan:

* `authentication_string`: Aquí se almacena la contraseña cifrada.
* `plugin`: Nos indica el plugin que se va a usar para autenticar al usuario.

Si cotilleamos qué valores hay en estos campos para root (además de host):

```sql
SELECT user, host, plugin, authentication_string FROM mysql.user WHERE User='root';
+------+-----------+-------------+-----------------------+
| user | host      | plugin      | authentication_string |
+------+-----------+-------------+-----------------------+
| root | localhost | auth_socket |                       |
+------+-----------+-------------+-----------------------+
1 row in set (0.0010 sec)
```

Como podemos ver hay dos cosas que nos llaman la atención:

* **El campo `authentication_string` está vacío**. Esto significa que no hay contraseña configurada para el usuario `root`.
* **El campo `plugin` tiene el valor `auth_socket`**. Esto significa que el usuario `root` se autentica a través del socket del sistema.

Es decir, el usuario `root` que se usa para acceder desde `localhost` a MySQL será el usuario `root` de sistema Ubuntu.

### ¿Cual es la clave del usuario `root` en Ubuntu?

Ubuntu, por defecto, no tiene una contraseña configurada para el usuario `root`. Lo que hace imposible acceder al sistema como `root`. Esto se hace por seguridad y para fomentar el uso de `sudo`. De esta forma el usuario que creamos durante el proceso de instalación será del grupo de _administradores_ y podrá ejecutar comandos con privilegios de root usando `sudo`.

### Conclusiones

Puesto que, en principio, no se puede hacer login como `root` en un sistema Ubuntu y como para hacer login en MySQL como `root` se usa el usuario del sistema Linux (`auth_socket`) no se puede hacer login en MySQL como `root`.


