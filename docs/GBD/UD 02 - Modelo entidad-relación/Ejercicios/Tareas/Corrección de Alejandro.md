# Corrección de Alejandro

Hola Alejandro, a continuación te comento lo que he visto al corregir tu tarea.

<!-- toc -->

- [Apartado 1](#apartado-1)
- [Apartado 2](#apartado-2)
- [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

- En tu diagrama muestras que la relación entre **Cliente** y **Vehículo** es de **uno a uno**. En realidad la relación debería de ser de **uno a muchos**, ya que un cliente puede tener varios vehículos.
- En la relación entre **Vehículo** y **Reparación** pones que cada vehículo sólo puede tener una reparación, pero que una reparación lo puede ser de múltiples vehículos. Esto es al revés. Un **Vehículo** puede ser reparado varias veces (a lo largo de su vida) y una reparación hace referencia siempre a un único vehículo.
- Con respecto a las relaciones de **Factura**, muestras correctamente que ha una relación **uno a uno** entre factura y reparación, pero también debería aparecer otra relación  **uno a uno** entre **Factura** y **Cliente**, ya que una factura (se nos dice en el enunciado) tiene un atributo que es clave foránea para **Cliente** _CodigoCliente_.

Por lo demás lo veo bastante bien. Deberías, en todo caso, echarle un ojo a la solución propuesta (que publicaré en breve) y compararla con la tuya para ver si hay algo que se te ha pasado.

## Apartado 2

La solución que propones es:

1. **PEDIDO** (<ins>NumPedido</ins>, FechaPedido, CodProveedor): Representa el pedido y el proveedor asociado.
2. **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor): Almacena la información de cada proveedor.
3. **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto): Almacena la información de cada producto.
4. **PRODUCTO_PEDIDO** (<ins>NumPedido</ins>, CodProducto, Cantidad): Relaciona los productos con los pedidos y la cantidad solicitada.

Si te fijas se nos dice en el enunciado que:

> Cada producto lo puede suministrar más de un proveedor.
> Cada pedido incluye varios productos.

En tu tabla **PEDIDO** incluyes el atributo **CodProveedor**. Esto es incorrecto ya que un pedido puede tener varios productos y cada producto puede ser suministrado por más de un proveedor.

La solución correcta sería:

- **PEDIDO** (<ins>NumPedido</ins>, FechaPedido): Representa el pedido.
- **PRODUCTO_PEDIDO** (<ins>NumPedido</ins>, CodProducto, CodProveedor, Cantidad): Relaciona los productos con los pedidos y la cantidad solicitada.

## Apartado 3

- En la relación entre **Reserva** y **Mesa** indicas que una reserva lo será de un sola mesa, y que una mesa solo puede tener una reserva. Esto es incorrecto ya que se indica esplícitamente en el enunciado que una reserva puede ser de varias mesas y una mesa aparecerá en distintas reservas a lo largo del tiempo. Tal como lo tienes tu estarías diciendo que si una mesa aparece en una reserva **nunca** podría volver a usarse (en otras).
- No reflejas la relación entre **Camarero** y **Mesa** (una mesa tendrá asignado un único camarero).
- Tampoco muestras la relación entre **Factura** y **Mesa** y **Plato** y **Mesa**. En el enunciado se nos dice que una mesa puede tener varias facturas y que un plato puede ser servido en varias mesas.
- La cardinalidad de la relación entre **Plato** y **Producto** es incorrecta. Un **Plato** puede estar compuesto por varios productos y **un producto podrá aparecer en distintos platos**. Será M:N, muchos a muchos.

Te recomendaría que compruebes la solución propuesta (que publicaré en breve), y que las compares con la tuya. Si tienes dudas, crees que no he entendido bien algo o que me he equivocado en alguna corrección, no dudes en decírmelo.
