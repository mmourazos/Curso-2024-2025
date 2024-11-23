# Corrección de Steven

Hola Steven.

## Apartado 1

Está bastante bien. Hay un par de cosas que se pueden mejorar.

* Si te fijas en el enunciado se nos dice que **Factura** incluye entre sus atributos _CodioCliente_. Esto quiere decir que también debería tener una relación (1:1) con **Cliente**.

## Apartado 2

Tu solución es:

* **PRODUCTO**(<ins>CodProducto_</ins>, NombreProducto, PrecioProducto).
* **PROVEEDOR**(<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PEDIDO**(<ins>NumPedido</ins>, FechaPedido, CodProveedor).
* **DETALLE_PEDIDO**(<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad).

Pero en el enunciado se nos indica que:

> Cada producto lo puede suministrar más de un proveedor.
> Cada pedido incluye varios productos.

No podemos guardar _CodProveedor_ en el **PEDIDO** porque se nos dice explicitamente que un pedido estará compuesto de varios productos. Tal como lo tienes _exiges_ que todos los productos de un pedido hayan de ser de un único proveedor.

La solución correcta podría ser:

* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProdcuto).
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido).
* **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProducto</ins>, <ins>CodProveedor</ins>, Cantidad)

## Apartado 3

No me incluyes el diagrama del apartado 3. Si ha habido algún problema al subir la tarea indícamelo y miramos de corregirlo.

Si crees que no he entendido correctamente tu solución, me he equivocado en algo o simplemente tienes alguna duda sobre la solución, por favor no dudes en ponerte en contacto conmigo.
