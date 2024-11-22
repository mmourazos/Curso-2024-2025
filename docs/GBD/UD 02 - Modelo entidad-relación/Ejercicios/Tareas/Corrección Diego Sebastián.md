# Corrección de Diego Sebastián

<!-- toc -->

* [Apartado 1](#apartado-1)
* [Apartado 2](#apartado-2)
* [Apartado 3](#apartado-3)

<!-- tocstop -->

## Apartado 1

* Las relaciones de **Cliente** no están bien. **Cliente** no tiene que relacionarse con **Reparación** si no con **Vehículo** y **Factura**. Un **Cliente** llevará a reparar uno o más **Vehículos** y pagará una o más **Facturas**. A su vez todo **Vehículo** será de un **Cliente** y lo mismo para las **Facturas**.
* La relación entre **Factura** y **Reparación** debería ser uno a uno. Una **Reparación** genera una única **Factura** y una **Factura** lo es de una única **Reparación**.

Hay algún otro error de cardinalidad en las relaciones. Es mejor que compares tu solución con la solución que publicaré en breve.

## Apartado 2

## Apartado 3
