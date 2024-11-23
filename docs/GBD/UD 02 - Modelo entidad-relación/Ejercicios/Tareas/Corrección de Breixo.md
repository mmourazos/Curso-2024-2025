# Corrección de Breixo

Hola Breixo.

<!-- toc -->

- [Apartado 1](#apartado-1)
- [Apartado 2](#apartado-2)
- [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

- La entidad **EMPLEADO** debe tener una relación con **REPARACIóN** ya que se nos dice que en una **REPARACIóN** puede participar varios **EMPLEADOS**. También se nos dice que las **ACTUACIONES** serán realizadas por **EMPLEADOS**, por lo que también deberían de estar relacionados.
- Una **FACTURA** lo es de una única **REPARACIóN** por lo que debería relacionarse 1:1.
- Lo mismo entre **FACTURA** y **CLIENTE**.
- Tampoco se relaciona **REPARACIóN** con **VEHÍCULO**.

## Apartado 2

Está bien.

## Apartado 3

- La **FACTURA** no se relaciona con **RESERVAS**. Sería lógico pero en el enunciado se nos dice que la factura se _genera_ a partir de una **MESA**.
- Algo parecido sucede entre **MESA** y **PLATO**, ya que se indica que una mesa _pedirá_ varios platos.
- La relación que representas entre **PLATO** e **INGREDIENTE** no es correcta ya que, además de que una plato pueda incluir varios ingredientes, un mismo ingrediente puede estar en diferentes platos.

Por lo demás bastante bien. Compárala con la solución que publicaré y si tienes alguna duda, pregunta.

Si hay algo que no he entendido de tu tarea, he cometido algún error o, simplemente, tienes alguna duda, por favor, házmelo saber.
