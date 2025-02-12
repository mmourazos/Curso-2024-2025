# Sobre la tarea de la Unidad 3

## Duda de Borja

Estoy realizando la tarea de la unidad 3 y me surgen varias dudas sobre como resolverlo y como se solventarían los errores encontrados en las pruebas funcionales. Por ejemplo en este caso al desconocer el saldo (simplemente al ejecutar sale que hay saldo 0 sin haber algo que nos permita saber o establecer un saldo) los valores limites deben ser entre 0,01 al ser valores reales y saldo-0.01, pero nose si esto se pondría así realmente.

>**Tal como está escrito el código tienes varias opciones para establecer un saldo inicial:**
>
>* Acceder directamente a la propiedad `dSaldo`.
>* Añadir un constructor que permita establecer el saldo inicial.
>* Crear un método *setter* para la propiedad `dSaldo`.
>* Usar el método `ingresar` para establecer el saldo inicial.
>
>```java
>CCuenta cuenta = new CCuenta();
>cuenta.dSaldo = 100;
>
>// O bien:
>public CCuenta(double saldo) {
>   dSaldo = saldo;
>}
>
>// O bien:
>public void setSaldo(double saldo) {
>    dSaldo = saldo;
>}
>
>// O bien:
>cuenta.ingresar(100);
> ```

Y después me surge la duda de como se resuelve un error encontrado en las pruebas funcionales si no miramos el código y no se corrige en él.

> La idea, con las pruebas funcionales, es que **para establecer** las pruebas **no necesitas conocer el código** (ya que queremos comprobar que cumplen su función independientemente del código que hayamos escrito). **Para resolver los errores**, encontrados mediante las pruebas, **sí necesitas conocer el código**. Las pruebas son una herramienta para detectar errores y verificar que dichos errores han sido corregidos.

Si ponemos un valor válido no retira del saldo porque no está implementado en el código, entonces como se resuelve?

> Se implementa en el código. Puedes modificar el código.

Si no te importa te pego aqui parte de lo te tengo de la prueba funcional y me puedes decir si no voy desencaminado? O si es posible subir otro ejemplo de las pruebas de la caja negra que al no poder asistir a las tutorías por trabajo no me ha quedado claro.

**Parte de mi solución:**

Para empezar ejecutamos la aplicación y comprobamos las distintas salidas.

* Comienza sin dar un saldo inicial, supuestamente en 0 pero no sabemos si es cierto o no. Es posible que haya una cantidad de saldo que no se haya implementado, habiendo la posibilidad de que sea negativo y no tiene salida ninguna.
* Tras querer retirar 0, nos da un mensaje que no sería el correcto, ya que nos dice “Que no se puede retirar una cantidad negativa”
* Hay varios ingresos dejándonos el saldo en 600 y cuando queremos retirar 50, no devuelve el saldo restante esperado, sino que devuelve la misma cantidad. Por lo que no es correcta esa salida.

Determinar las clases de equivalencia:

Vamos a separarlo por “posibles” y “no posibles”..

Posibles:

* Retirar una cantidad > 0 < Saldo Disponible. Retira una cantidad pedida dentro del saldo disponible.
* Retirar cantidad = Saldo Disponible. Retira todo el saldo disponible

**No posibles:**

* Retirar cantidad <= 0. No se permite retirar una cantidad negativa.
* Retirar cantidad > Saldo Disponible. No se puede retirar más saldo del disponible

Determinar análisis de valores límite:

* Retirar cantidad = Saldo Disponible

Único valor válido es el “Saldo Disponible” (ejemplo saldo de 500, entonces sería 500)

* Caso de cantidad > 0 < Saldo

> Lo veo bien pero creo que el 0 también se podría considerar un valor límite. En este caso, el saldo restante debería de ser igual al saldo inicial.

Valores entre 0,01 y saldo – 0,01 (ejemplo saldo es 500, pues sería 499,99)
Valores no válidos: Menores de 0 o mayores de Saldo disponible (-0,01,500,01)

Disculpa el textazo...
Muchas gracias
Borja M
