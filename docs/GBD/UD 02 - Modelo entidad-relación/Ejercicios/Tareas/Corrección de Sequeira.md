Hola Antonio.

## Apartado 1

* En la relación **Reparación** y **Empleados** pones que un **Empleado** sólo puede realizar una **Reparación**. Esto no tiene sentido ya que un empleado puede realizar múltiples reparaciones. La relación debería ser N:M.
* En el modelo entidad-relación indicas que la **Factura** está asociada a la **Reparación** pero en relacional no lo reflejas si no que indicas que la relación es con *Vehículo**.

## Apartado 2

* **PRODUCTO PEDIDO** debería ser (CodProducto, NumPedido, Cantidad) ya que el precio del producto se puede almacenar en **PRODUCTO**.

## Apartado 3

* Una **Reserva** puede tener múltiples **Mesas** pero una **Mesa** podrá figurar en distintas **Reservas** (diferentes horas, días, etc.). La relación es N:M.
* Aunque la idea de asociar **Reservas** y **Facturas** con una relación 1:1 no está mal, en el enunciado se indica que la **Factura**, en lugar de con **Reservas** está asociada a cada **Mesa**. Una **Mesa** podrá tener muchas facturas a lo largo del tiempo y toda factura lo será de una única mesa. Cardinalidad N:1.
* En el modelo entidad-relación no indicas la relación entre **Camarero** y **Mesa** pero en el modelo relacional no lo reflejas, no se ve conexión entre **Camarero** y **Mesa**.

Si tienes alguna duda, te parece que no he entendido bin tu solución o me he equivocado, por favor, ponte en contacto conmigo y lo vemos en detalle.
