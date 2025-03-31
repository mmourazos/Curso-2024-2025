# Introducción a la programación de las bases de datos

Elementos que puede crear un usuario en MySQL:

* Procedimientos almacenados
* Funciones
* Eventos
* Triggers

## Descripción de la programación

## Variables

### Variables globales

### Variables de usuario

Las variables de usuario son variables que se pueden utilizar para guardar datos temporales (como el resultado de una consulta) y pasarlos entre diferentes sentencias SQL. Se definen con el símbolo `@` seguido de caracteres alfanuméricos y los símbolos `.`, `_` y `$`, con una longitud máxima de 64 caracteres. Si necesitamos que incluyan algún otro caracter hemos de indicar el texto entre comillas `""`, `''` o `` ` `` `` ` `` pueden ser de cualquier tipo de datos.

Para definir una variable de usuario hemos de utilizar la sentencia `SET` o `SELECT`.

```sql
SET @nombre_variable = valor;
```

```sql
SELECT @nombre_variable := valor;
```

La variable se puede utilizar en cualquier parte de la consulta, pero no se puede utilizar en la cláusula `WHERE` de una subconsulta.

### Variables locales

Las variables locales son variables que se utilizan dentro de un bloque de código (como un procedimiento almacenado o una función) y sólo son accesibles dentro de ese bloque. Se definen con la sentencia `DECLARE` y deben ser inicializadas antes de ser utilizadas. La sintaxis es la siguiente:

```txt
DECLARE nombre_variable tipo_dato [DEFAULT valor];
## Procedimientos almacenados, funciones, eventos y triggers

En MySQL, estas estructuras permiten encapsular lógica y automatizar tareas dentro de la base de datos:

- **Procedimientos almacenados**: Bloques de código que se almacenan en la base de datos y se ejecutan mediante un nombre específico utilizando `CALL`.
- **Funciones**: Similares a los procedimientos, pero devuelven un valor y se pueden usar en consultas SQL.
- **Eventos**: Tareas programadas que se ejecutan automáticamente en un momento específico o de forma recurrente.
## Procedimientos almacenados, funciones, eventos y triggers

En MySQL, estas estructuras permiten encapsular lógica y automatizar tareas dentro de la base de datos:

- **Procedimientos almacenados**: Bloques de código que se almacenan en la base de datos y se ejecutan mediante un nombre específico utilizando `CALL`.
- **Funciones**: Similares a los procedimientos, pero devuelven un valor y se pueden usar en consultas SQL.
- **Eventos**: Tareas programadas que se ejecutan automáticamente en un momento específico o de forma recurrente.
- **Triggers**: Bloques de código que se ejecutan automáticamente en respuesta a eventos como `INSERT`, `UPDATE` o `DELETE` en una tabla.
- **Triggers**: Bloques de código que se ejecutan automáticamente en respuesta a eventos como `INSERT`, `UPDATE` o `DELETE` en una tabla.
```

Un ejemplo concreto sería el siguiente:

```sql
BEGIN
  DECLARE nombre_variable INT DEFAULT 0;
END
```

En sentencia anterior hemos declarado una variable de nombre `nombre_variable` de tipo entero `INT` y le asignamos un valor inicial de `0`. Esta variable sólo será accesible dentro del bloque `BEGIN ... END` en el que se ha declarado. Si no se asigna un valor inicial, la variable tendrá un valor nulo `NULL` por defecto.

## Estructuras de control

Cuando creamos alguna de las

### Estructura condicional

```sql
```

### Estructura de repetición

```sql
```

#### While

```sql
```

#### Repeatº

```sql
```

#### Loop

```sql
```

###

## Procedimientos almacenados

## Funciones

## Eventos

## Triggers

## Procedimientos almacenados, funciones, eventos y triggers

En MySQL, estas estructuras permiten encapsular lógica y automatizar tareas dentro de la base de datos:

* **Procedimientos almacenados**: Bloques de código que se almacenan en la base de datos y se ejecutan mediante un nombre específico utilizando `CALL`.
* **Funciones**: Similares a los procedimientos, pero devuelven un valor y se pueden usar en consultas SQL.
* **Eventos**: Tareas programadas que se ejecutan automáticamente en un momento específico o de forma recurrente.
* **Triggers**: Bloques de código que se ejecutan automáticamente en respuesta a eventos como `INSERT`, `UPDATE` o `DELETE` en una tabla.
