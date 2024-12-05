Hola Brahim.

## Apartado 1

* Un **Vehículo** podrá tener una o más **Reparaciones** (piensa que a lo largo de tiempo se puede llevar el mismo coche al mismo taller). Por otro lado cada **Reparación** se realiza sobre un único **Vehículo**. La relación será 1:N.
* El **EstadoFinal** no es necesario que se indice como una entidad, puede ser un atributo de la relación **Reparación**. **Reparado** y **No reparado** no pueden ser entidades. Piensa que las entidades **tienen que tener atributos**. Y si algo no tiene atributos (y que lo hagan _único_ o _distinguible del resto_) no puede ser una entidad.

## Apartado 2

El apartado 2 está mal ya que no se pide que realices un diagrama si no que se normalice hasta 3FN. La solución sería:

* **PEDIDO** (<in>NumPedido</in>, FechaPedido, CodProveedor)
* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto)
* **PEDIDO_PRODUCTO** (NumPedido, CodProducto, Cantidad)
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor)

## Apartado 3

* Creaste entidades de las que hay datos asociados: Restaurante, Clientes, Funciones.
  * Restaurante: Como sólo hay uno no tiene mucho sentido crear una entidad para guardar la información del mismo. Es como si en la base de datos de una biblioteca creas una tabla para guardar los datos de la biblioteca (Nombre, dirección, etc.), no es necesario.
  * Clientes: No se nos indica en ningún lado que deseemos guardar información del cliente, más allá del nombre de la persona que ha echo la reserva. Piensa que cuando vas a un restaurante no te piden tus datos y no los guardan.
  * Funciones: No se que atributos tendría esta entidad (no los  indicas) pero no creo que sea necesaria. Si hay que crear una especialización simplemente lo indicas con la sintaxis propia de Chen.
  * Comidas: No le has puesto atributos por lo que no se cual era tu intención al crearla. Como regla general, si creas una entidad que no tiene atributos claro, lo más probable es que no sea necesaria.
* No he visto que en el enunciado se indique que un **Camarero** pueda ser o no supervisor de otros **Camareros**.

Respecto al diagrama. Si decides hacer un diagrama siguiendo el estilo de Chen no deberías de poner recuadros con los atributos, si no ponerlos en los famosos globos. Se eliges un estilo procura seguirlo lo más fiel que puedas o, si no te es posible india el por qué.

Aunque te haya indicado varios fallos quiero que quede claro que, si quitamos las entidades que no son necesarias el resto está bastante bien definido.
