# Ejercicio 1 - Apartado 2

<!-- toc -->

* [Enunciado del segundo apartado](#enunciado-del-segundo-apartado)
* [Solución](#solución)
  * [Paso a 1FN](#paso-a-1fn)
  * [Paso a 2FN](#paso-a-2fn)
  * [Paso a 3FN](#paso-a-3fn)

<!-- tocstop -->

## Enunciado del segundo apartado

Normaliza la siguiente relación hasta 3FN, analizando las dependencias entre los atributos:

PEDIDO (NumPedido, FechaPedido, CodProveedor, NombreProveedor, DirecciónProveedor, CodProducto, NombreProducto, PrecioProducto, Cantidad)

* Recoge los datos de los pedidos a los proveedores.
* Cada producto lo puede suministrar más de un proveedor.
* Cada pedido incluye varios productos.

## Solución

### Paso a 1FN

Podemos ver que en la tabla:

Según lo indicado en la teoría:

> _Una tabla está en Primera Forma Normal (1FN) sí, y sólo sí, todos los atributos de la misma contienen valores atómicos, es decir, que cada atributo debe contener un único valor del dominio._

Veamos ahora la tabla:

PEDIDO (NumPedido, FechaPedido, CodProveedor, NombreProveedor, DirecciónProveedor, CodProducto, NombreProducto, PrecioProducto, Cantidad)

Podríamos interpretar que la dirección es un atributo compuesto o atómico. Si lo tomamos como compuesto simplemente habría que descomponerlo en sus elementos y ya estaría en 1FN.

_**OJO**: La clave primaria aquí sería la combinación de TODOS los campos de la tabla. Ya que se nos indica que cada pedido incluye varios productos y cada producto puede ser suministrado por más de un proveedor._

### Paso a 2FN

Volviendo a los apuntes:

> Una tabla está en segunda forma normal o 2FN cuando está en 1FN y además todos los atributos que no forman parte de la clave principal tienen dependencia funcional completa de la clave y no de parte de ella.
> Es obvio que una tabla que esté en 1FN y cuya clave esté compuesta por un único atributo, estará en 2FN.

En nuestra tabla en la que (en este momento) la clave primara es la combinación de todo lo anterior no se cumple:

* _FechaPedido_ depende únicamente de _NumPedido_.
* _NombreProveedor_ y _DirecciónProveedor_ dependen de _CodProveedor_.
* _NombreProducto_ y _PrecioProducto_ dependen de _CodProducto_.
* Cantidad depende de _NumPedido_ y _CodProducto_.

Así que habría que dividir la tabla en varias tablas:

* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido).
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto).
* **LINEA_PEDIDO** (<ins>NumPedido</ins>, CodProducto, CodProveedor, Cantidad).

**Nota:** Hemos de incluir _CodProveedor_ en _LINEA_PEDIDO_ porque un producto puede ser suministrado por varios proveedores y podría cambiar en cada pedido.

### Paso a 3FN

Según los apuntes:

> Una tabla o relación está en tercera forma normal o 3FN si está en 2FN y no existen atributos que no pertenezcan a la clave primaria que puedan ser conocidos mediante otro atributo que no forme parte de la clave primaria. Es decir, que no existan dependencias funcionales transitivas.

En este punto no hay dependencias transitivas. La tabla ya está en 3FN.

Si en el enunciado se nos hubiera indicado que un producto sólo puede ser suministrado por un proveedor y partimos de:

* **PEDIDO** (<ins>NumPedido</ins>, FechaPedido).
* **PROVEEDOR** (<ins>CodProveedor</ins>, NombreProveedor, DirecciónProveedor).
* **PRODUCTO** (<ins>CodProducto</ins>, NombreProducto, PrecioProducto).
* **LINEA_PEDIDO** (<ins>NumPedido</ins>, CodProducto, CodProveedor, Cantidad).

Podemos ver que en línea pedido _CodProveedor_ depende de _CodProducto_ y no de _NumPedido_ (una _dependencia funcional transitiva_). Habría que dividir la tabla en otras dos:

* **LINEA_PEDIDO** (<ins>NumPedido</ins>, CodProducto, Cantidad).
* **PROVEEDOR_PRODUCTO** (<ins>CodProducto</ins>, CodProveedor).
