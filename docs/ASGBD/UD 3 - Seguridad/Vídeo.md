# Vídeo sobre rutinas almacenadas

## Rutinas almacenadas

## Bloques de código

## Tipos de rutinas almacenadas

### Procedimientos almacenados

### Funciones almacenadas

La sintaxis para definir una función es la siguiente:

```text
CREATE
    [DEFINER = user]
    FUNCTION [IF NOT EXISTS] function_name ([func_parameter type[,...]])
    RETURNS type
    [ COMMENT 'string'
    | LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER } ]
       routine_body
```

### Diferencias entre procedimientos y funciones almacenadas

Los procedimientos almacenados pueden tener parámetros de entrada, salida o entrada y salida **pero no devuelven valores**. Las funciones almacenadas **siempre** devuelven un valor.

### Aspectos comunes de procedimientos y funciones almacenadas

#### _Characteristics_

Es un elemento opcional de la definición de una rutina almacenada que se utiliza para especificar las características de la rutina almacenada. Las características de una rutina almacenada son las siguientes:

```text
characteristic: {
  COMMENT 'string'
  | LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }
```

##### Security / definer

### Eventos

### Triggers
