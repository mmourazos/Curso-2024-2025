# Corrección

<!-- toc -->

* [Apartado 1](#apartado-1)
* [Apartado 2](#apartado-2)

<!-- tocstop -->

Hola Roberto.

## Apartado 1

* En el enunciado se indica que la **Reparación** se realiza sobre un único **Vehículo**. Esto puede verse por varios motivos: es lógico que lo que se repare en el taller sean los vehículos y además se nos indica que _matrícula_ es una atributo de **Reparación** (clave foránea de **Vehículo**). Tu no lo reflejas.
* Indicas que los **Empleados** realizan las **Facturas** pero no se nos dice esto en el enunciado. Añades los atributos (claves foráneas) _cod. empleado_, _cod reparación_, y _cod cliente_ sin reflejar las relaciones. En la solución correcta **Factura** está relacionada con **Cliente** (un cliente tendrá una o más facturas y cada factura lo será de un único cliente) y con **Reparación** (toda reparación generará una única factura y toda factura lo será de una única reparación).
* En el enunciado se indica que una **Reparación** estará compuestas de múltiples **Actuaciones** por lo que deberían estar relacionadas y en tu diagrama no se puede apreciar.

## Apartado 2

La solución correcta sería la siguiente:

* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto).
* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido).
* **LINEA PEDIDO** (<ins>NumPedido</ins>, <ins>CodProveedor</ins>, <ins>CodProducto</ins>, Cantidad)

Es "sencillo" pero bastante largo de explicar, lo explicaré con detalle en la solución (que publicaré en breve). Si quieres que te lo explique antes podemos hacerlo en una tutoría (dime cuanto de venga bien y lo vemos).

## Apartado 3

* **EMPLEADO** se puede _especializar_ en tres tipos: **CAMARERO**, *COCINERO** y **ADMINISTRATIVO**. En tu diagrama no se refleja este hecho.
* La relación entre **MESA** y **FACTURA** no es correcta. Una **FACTURA** lo será de una única **MESA** y una **MESA** (a lo largo del tiempo) tendrá múltiples **FACTURAS**.
* Algo parecido pasa con **RESERVA** y **MESA**. Se nos dice que una reserva puede abarcar varias mesas. Del mismo modo una **MESA** irá apareciendo en distintas **RESERVAS** a lo largo del tiempo.

Po lo demás lo veo correcto.

Si ves que no he interpretado correctamente tus diagramas o que he cometido algún error no dudes en decírmelo, ponemos y día y lo vemos en detalle. Lo mismo si tienes cualquier otra duda sobre esta tarea.
