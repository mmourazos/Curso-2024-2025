Hola Rocío.

## Apartado 1

* En el enunciado se nos dice que la **Factura** incluye el atributo _Código\_Cliente_. Esto ya nos indica que ha de haber una relación entre **Factura** y **Cliente** que no reflejas. Podrías _llegar_ al cliente a través de **Reparación** y **Vehículo** pero podría dar problemas si un **Vehículo** cambiase de propietario a lo largo del tiempo. Es decir, podrías tener una factura y no saber a qué cliente hace referencia.
* **Recambios** no puede tener relación N:1 con **Reparaciones** ya que un recambio podrá utilizarse en múltiples reparaciones (**Recambios** no almacena referencias a recambios reales, si no que indica el _stock_ que hay de un tipo de recambio, por lo que se repetirá en distintas reparaciones).
* Tendrías que indicar la cardinalidad en todas las relaciones (hay algunas que las representas con _flechas_ que, entiendo, no se contemplan en el _Crow's foot_).

## Apartado 2

La solución sería empezar por dividir en tres entidades con los atributos relacionados entre si:

* PEDIDO (<ins>NumPedido</ins>, FechaPedido)
* PRODUCTO (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
* PROVEEDOR (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor)

Nos queda sin asinar el atributo _Cantidad_. Para que tenga sentido tendremos que _relacionar_ **PEDIDO** con **PRODUCTO** y así añadiríamos:

* LINEA_PEDIDO (<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad)

## Apartado 3


