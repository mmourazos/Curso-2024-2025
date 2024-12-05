# Corrección de Alejandro Fojo

Hola Alejandro.

<!-- toc -->

- [Apartado 1](#apartado-1)
- [Apartado 2](#apartado-2)
- [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

- Faltan entidades **Recambios** y **Actuaciones** y **Facturas**.

Hay bastantes errores y cosas que mejorar por lo que te recomiendo que la compares con la solución que publicaré en breve.

## Apartado 2

Tu solución es:

- **PEDIDO** (<ins>NumPedido</ins>, CodProveedor, FechaPedido)
- **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor)
- **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
- **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad)

Esta solución no es completamente correcta. En el enunciado se nos indica que cada pedido puede tener varios productos. De este modo, tu solución **obliga** a que los productos de un pedido hayan de ser todos de un mismo proveedor (pues incluyes el campo **CodProveedor** en la tabla **PEDIDO**).

La solución correcta sería:

- **PEDIDO** (<ins>NumPedido</ins>, FechaPedido)
- **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor)
- **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
- **DETALLE_PEDIDO** (<ins>NumPedido</ins>, <ins>CodProducto</ins>, Cantidad)

## Apartado 3

De nuevo faltan varias entidades y relaciones. Compárla con la solución que publicaré y si tienes alguna duda, pregunta.

Si hay algo que no he entendido de tu tarea, he cometido algún error o, simplemente, tienes alguna duda, por favor, házmelo saber.
