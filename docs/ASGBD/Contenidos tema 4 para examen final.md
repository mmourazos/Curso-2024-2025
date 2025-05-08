# Relación de los contenidos de la UD 4 que se incluyen en el examen final

## Optimización de memoria y espacio en disco

## Consultas

Pasos que se ejecutan al realizar una consulta:

1. **Parseo**: Se analiza la consulta SQL y se comprueba su sintaxis. Se genera un árbol de sintaxis que representa la consulta.
2. Procesamiento: Se comprueba que la consulta es válida (existen las tablas, columnas, etc.). Se generan los planes de ejecución y se selecciona el más eficiente.  
3. Optimización: Se optimiza la consulta para mejorar su rendimiento.

### Optimización de consultas

#### `slow_query_log`

Para activar el registro de consultas lentas, se puede utilizar la siguiente instrucción SQL:

```sql
SET GLOBAL slow_query_log = 'ON';
```

### Explain

## Gestión de índices

### `OPTIMIZE TABLE`

### `ANALIZE TABLE`
