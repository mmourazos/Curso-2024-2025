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

* La **Factura** debería tener una relación con **Mesas** ya que se nos indica en el enunciado que la **Factura** tiene el atributo **Número Mesa**. Esto nos indica que una factura se asocia a una mesa. Hemos de tener en cuenta que **Número Mesa** **no es la clave primaria** de mesa. Se nos indica que la clave primaria está compuesta por _Cod. Comedor_ y _Número Mesa_.
* Una **Factura** estará asociada a uno o más **Platos** pero los **Platos** también aparecerán en múltiples facturas. Por tanto, la relación entre **Factura** y **Plato** es N:M. Es decir, un **Plato** puede estar en múltiples facturas y una **Factura** puede tener múltiples platos.
* No representas la relación que hay entre **Camarero** y **Mesa**. Se nos dice que una **Mesa** tiene asignado un único **Camarero** (y un camarero atiende a una o más mesas).
