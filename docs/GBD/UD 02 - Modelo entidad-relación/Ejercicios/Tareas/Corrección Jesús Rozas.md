# Corrección Jesús Rozas

<!-- toc -->

* [Apartado 1](#apartado-1)
* [Apartado 2](#apartado-2)
* [Apartado 3](#apartado-3)

<!-- tocstop -->

Hola Jesús.

## Apartado 1

* La relación entre **Clientes** y **Vehículos** y **Facturas** están invertidas. Tal como lo tienes escrito estás diciendo que N clientes tienen un vehículo y lo mismo con las facturas. Tienes que indicar el número en el lado opuesto.
* La relación entre **Reparaciones** y **Vehículos** no está bien. Una reparación se realiza sobre un único vehículo aunque un vehículo puede tener varias reparaciones.
* La relación entre **Reparaciones** y **Facturas** no está bien. Una **Reparación** genera una única **Factura** y una **Factura** lo es de una única **Reparación**.

Hay varios errores del mismo tipo, cardinalidades de las relaciones.

## Apartado 2

Este apartado no está bien. La idea es aplicar sucesivamente las transformaciones a 1FN, 2FN y 3FN añadiendo las tablas que hagan falta. Mostraré el proceso en detalle en la solución que publicaré. El resultado ha de ser:

* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto).
* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido).
* **LINEA PEDIDO** (<ins>NumPedido</ins>, <ins>CodProveedor</ins>, <ins>CodProducto</ins>, Cantidad).

## Apartado 3

* La relación entre **Reservas** y **Mesas** no está bien. La cardinalidad correcta es muchos a muchos ya que una reserva puede incluir varias mesas pero también es cierto que una mesa irá apareciendo en distintas reservas a lo largo del tiempo.
* La relación entre **Mesas** y **Camareros** debería ser de muchos a uno. Ya que se nos dice que una mesa tiene asignado un único camarero. La otra opción sería indicar que un camarero puede atender distintas mesas en distintos días, pero no se nos indica.
* También dices que una **Mesa** puede tener varios **Comedores** y que un comedor puede tener cero o una mesa.

Hay más errores del mismo tipo. Es mejor que compares tu solución con la solución que publicaré en breve.

Si ves que no he interpretado correctamente tus diagramas o que he cometido algún error no dudes en decírmelo, ponemos y día y lo vemos en detalle. Lo mismo si tienes cualquier otra duda sobre esta tarea.
