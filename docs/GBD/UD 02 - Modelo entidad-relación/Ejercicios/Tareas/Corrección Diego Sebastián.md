# Corrección de Diego Sebastián

<!-- toc -->

- [Apartado 1](#apartado-1)
- [Apartado 2](#apartado-2)
- [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

- Las relaciones de **Cliente** no están bien. **Cliente** no tiene que relacionarse con **Reparación** si no con **Vehículo** y **Factura**. Un **Cliente** llevará a reparar uno o más **Vehículos** y pagará una o más **Facturas**. A su vez todo **Vehículo** será de un **Cliente** y lo mismo para las **Facturas**.
- La relación entre **Factura** y **Reparación** debería ser uno a uno. Una **Reparación** genera una única **Factura** y una **Factura** lo es de una única **Reparación**.
- En el enunciado se nos dice que una **Factura** tiene un atributo **CodigoCliente** que es clave foránea de **Cliente**. Por lo tanto, la relación entre **Factura** y **Cliente** también debería ser uno a uno.

Hay algún otro error de cardinalidad en las relaciones. Es mejor que compares tu solución con la solución que publicaré en breve.

## Apartado 2

Tu solución es:

- **PEDIDO** (<ins>NumPedido</ins>, FechaPedido, CodProveedor).
- **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
- **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto).
- **PRODUCTO_PEDIDO** (<ins>NumPedido</ins>, CodProducto, Cantidad).

Pero en el enunciado se nos dice que:

> Cada producto lo puede suministrar más de un proveedor.
> Cada pedido incluye varios productos.

Tal como lo tienes, al indicar _CodProveedor_ en la tabla **PEDIDO** estás diciendo que un pedido solo puede ser de un proveedor, y esto no es correcto. Además, en la tabla **PRODUCTO_PEDIDO** deberías incluir el campo _CodProveedor_ para indicar de qué proveedor es cada producto.

La solución correcta sería:

- **PEDIDO** (<ins>NumPedido</ins>, FechaPedido): Representa el pedido.
- **LÍNEA_PEDIDO** (<ins>NumPedido</ins>, CodProducto, CodProveedor, Cantidad): Relaciona los productos con los pedidos y los proveedores y la cantidad solicitada.
- **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto): Almacena la información de cada producto.
- **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor): Almacena la información de cada proveedor.

## Apartado 3

- La relación entre **Plato** y **Producto** es incorrecta ya que dices que un producto sólo puede aparecer en un plato. La cardinalidad correcta sería muchos a muchos.

No sigo corrigiendo este apartado porque el gráfico está cortado.

Si tienes dudas, crees que no he entendido bien algo o que me he equivocado en alguna corrección, no dudes en decírmelo.
