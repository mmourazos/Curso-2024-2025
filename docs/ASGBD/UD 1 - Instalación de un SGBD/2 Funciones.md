# Funciones del SGBD

Las funciones principales de un SGBD son:

* **Definición de datos**: Se encarga de definir la estructura de los datos y las relaciones entre ellos. Se define mediante un lenguaje de definición de datos (DDL).
* **Gestión del almacenamiento**: Controla cómo se almacenan los datos en ficheros del sistema de archivos para que el acceso a los datos sea eficiente.
* **Manipulación de datos**: Permite la inserción, modificación y eliminación de los datos almacenados en la base de datos. Se realiza mediante un lenguaje de manipulación de datos (DML).
* **Control de la concurrencia**: Gestiona el acceso concurrente a los datos para evitar problemas de consistencia.
* **Control de la integridad**: Garantiza que los datos almacenados en la base de datos cumplan con las reglas de integridad definidas.
* **Control de la seguridad**: Se encarga de controlar el acceso a los datos y proteger la información sensible.

## Definición de datos

Un SGBD permite definir las estructuras de datos y las relaciones entre ellas mediante un lenguaje de definición de datos (DDL). La definición de estas estructuras y relaciones se representa mediante metadatos que se almacenan en el diccionario de datos del SGBD.

Las instrucciones del lenguaje SQL que se utilizan para definir las estructuras de datos son: `CREATE`, `ALTER` y `DROP`.

## Manipulación de datos

También permite la manipulación de los datos almacenados en la base de datos mediante un lenguaje de manipulación de datos (DML). Las instrucciones del lenguaje SQL que se utilizan para manipular los datos son: `SELECT`, `INSERT`, `UPDATE` y `DELETE`.

## Control de la concurrencia

En la mayoría de los sistemas de información, varios usuarios acceden a la base de datos de forma simultánea y realizan operaciones de lectura y escritura sobre los mismos datos.
El SGBD debe asegurar que dichos accesos concurrentes no provoquen problemas de consistencia. Para ello, se utilizan técnicas de control de la concurrencia como bloqueos y transacciones.

## Control de la integridad

Las relaciones entre los datos, contenidas en el diccionario de datos, deben cumplirse en todo momento para garantizar la integridad de los mismos. El SGBD se encarga de esto mediante la aplicación de restricciones.

## Control de la seguridad

Un SGBD debe garantizar la seguridad de los datos almacenados en la base de datos. Para ello, se utilizan mecanismos de autenticación y autorización que permiten controlar quién puede acceder a los datos y qué operaciones puede realizar sobre ellos. También se utilizan técnicas de cifrado para proteger la información sensible.

Esto se puede hacer a nivel de permisos de usuario, roles, perfiles, etc.

En resumen, un SGBD es una herramienta que permite gestionar de forma eficiente y segura la información almacenada en una base de datos. Proporciona funciones para definir, manipular, controlar y proteger los datos, facilitando así su acceso y uso por parte de los usuarios.