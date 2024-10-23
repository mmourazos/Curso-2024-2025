# Vistas

## ¿Qué es una vista?

Una vista es una consulta almacenada que devuelve un conjunto de resultados al ser invocada. Funciona como una tabla virtual que contiene datos de una o más tablas. Las vistas se utilizan para restringir el acceso a los datos de una tabla, mostrando sólo los datos que el usuario tiene permiso para ver. Además, las vistas permiten a los usuarios ver los datos de una manera más sencilla y organizada.

## Crear una vista

Para crear una vista en 

## Modificar una vista

## Permisos de vista

Podemos garantizar que una vista sólo sea accesible por un usuario concreto, o por un grupo de usuarios, mediante la asignación de permisos. Para ello, debemos escribir el comando:

```sql
VIEWS ON <vista> TO <usuario>;
```
```
