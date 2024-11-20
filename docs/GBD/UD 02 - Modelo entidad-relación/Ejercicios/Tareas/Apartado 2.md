# Ejercicio 1 - Apartado 2

<!-- toc -->

* [Enunciado del segundo apartado](#enunciado-del-segundo-apartado)
* [Solución](#solución)

<!-- tocstop -->

## Enunciado del segundo apartado

Normaliza la siguiente relación hasta 3FN, analizando las dependencias entre los atributos:

PEDIDO (NumPedido, FechaPedido, CodProveedor, NombreProveedor, DirecciónProveedor, CodProducto, NombreProducto, PrecioProducto, Cantidad)

* Recoge los datos de los pedidos a los proveedores.
* Cada producto lo puede suministrar más de un proveedor.
* Cada pedido incluye varios productos.

## Solución

Obviamente hay tres _entidates_ dentro de PEDIDO: **Proveedor**, **Producto** y la propia **Pedido**.

_NombreProveedor_ y _DirecciónProveedor_ dependen de _CodProveedor_ y no de _NumPedido_. A su vez, _NombreProducto_ y _PrecioProducto_ dependen de _CodProducto_ y no de _NumPedido_. Por último _Cantidad_ depende de _NumPedido_ y _CodProducto_.

La forma de pasar a 3FN sería crear cuatro relaciones (tablas) diferentes, una para cada entidad. En este caso, se crearían las siguientes tablas:

* **Proveedor** (CodProveedor, NombreProveedor, DirecciónProveedor).
* **Producto** (CodProducto, NombreProducto, PrecioProducto, CodProveedor).
* **Pedido** (NumPedido, FechaPedido, CodProducto, Cantidad).
* **LineaPedido** (NumPedido, CodProducto, Cantidad).
