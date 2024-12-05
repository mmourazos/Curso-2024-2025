# Corrección de Edgar

Hola Edgar.

<!-- toc -->

* [Apartado 1](#apartado-1)
* [Apartado 2](#apartado-2)
* [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

* **Facturas** debería de relacionarse con **Reparación** y **Clientes** ambos siendo relaciones uno a uno.

Por lo demás está bastante bien.

## Apartado 2

Le veo un problema, no hay forma de saber el proveedor de un producto. En el texto indicas que tu solución es:

* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DireccionProveedor)
* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido)
* **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad)

En este caso no podemos saber qué proveedor ha suministrado el producto.

Luego en el diagrama muestras la siguiente solución:

* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DireccionProveedor)
* **PEDIDO** (<ins>NumPedido</ins>, CodProveedor, FechaPedido)
* **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad)

Esta solución tampoco es correcta ya que en el enunciado se indica que en un pedido pueden haber productos de diferentes. Y si lo dejas así, sólo podrían ser del mismo proveedor.

La solución correcta sería:

* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DireccionProveedor)
* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido)
* **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProveedor</ins>, <ins>CodProducto</ins>, Cantidad)

Ahora sólo podrían ser del mismo proveedor.

## Apartado 3

* La relación entre **MESAS** y **COMEDOR** no puede ser 1:1, ya que se dice que un comedor tendrá varias mesas.
* La relación entre **Facturas** y **Mesas** tampoco está bien ya que la **Factura** tiene que ser de una mesa pero una mesa tendrá muchas facturas (a lo largo del tiempo).
* La relación entre **Platos** y **Productos** no puede ser 1:1 ya que esto significaría que un plato sólo podría estar compuesto de un producto y que un producto solo se podría usar en un plato. La relación debería ser M:N.

Por lo demás bastante bien.

Si crees que no entendido bien algo de tu ejercicio, he cometido algún error o simplemente tienes alguna duda ponte en contacto conmigo y lo resolvemos.
