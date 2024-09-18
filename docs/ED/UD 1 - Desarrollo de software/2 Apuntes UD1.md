# Apuntes de la UD1 - Desarrollo de software

## Fases del desarrollo de software

### Análisis

Tambien se le conoce como **análisis de requisitos**. En esta fase se recopilan los requisitos del sistema, es decir, se identifican las necesidades que debe satisfacer el software que se va a desarrollar. Los requisitos pueden ser funcionales (lo que el sistema debe hacer) o no funcionales (cómo debe hacerlo). Por ejemplo, un requisito funcional podría ser que el sistema permita a los usuarios registrarse y un requisito no funcional podría ser que el sistema sea fácil de usar.

Esta es una de las fase más importantes del desarrollo de software, ya que si no se recopilan correctamente los requisitos, el software resultante no cumplirá con las expectativas del cliente. Si se comete un error en esta fase, es muy costoso corregirlo en fases posteriores del desarrollo. Esto se traduce en pérdidas de tiempo y dinero.

### Diseño

En esta fase se definen la arquitectura del sistema y los componentes que lo forman. El objetivo es transformar los requisitos recopilados en la fase de análisis en un diseño detallado que permita la implementación del sistema.

Se selecciona la tecnología que se va a utilizar para desarrollar el sistema: lenguaje de programación, base de datos, entorno de desarrollo, etc.

A partir de ahí se definen las estructuras de datos, los algoritmos y las interfaces de usuario que se van a utilizar en el sistema, las entidades y las relaciones, etc.

### Implementación / codificación

En esta fase se escribe el código fuente del sistema. El código fuente es el conjunto de instrucciones que le indican al ordenador qué operaciones debe realizar. El código fuente se escribe en un lenguaje de programación, ya seleccionado en la fase de diseño, y se guarda en archivos de texto plano. Dependiendo del proyecto podrían utilizarse varios lenguajes de programación.

Es en esta fase donde se usará un IDE (Entorno de Desarrollo Integrado) para escribir el código fuente, compilarlo y ejecutarlo. Un IDE es una herramienta que facilita el desarrollo de software, ya que proporciona un editor de texto, un compilador, un depurador, etc.

### Compilación

En esta fase obtenemos un programa ejecutable a partir del código fuente generado en la fase de codificación. Para ello, el código fuente se traduce a lenguaje máquina específico del procesador. El resultado de esta traducción es un archivo ejecutable que contiene el programa en lenguaje máquina. Este archivo se puede ejecutar en cualquier ordenador que tenga el mismo procesador (arquitectura) y el mismo sistema operativo que el que se utilizó para compilar el programa.

Veamos esto en algo más de detalle.

#### Ejecución del código fuente

Una vez tenemos el código fuente escrito es necesario ejecutarlo para que el ordenador realice las operaciones que se han programado.

Atendiendo a la forma en que se ejecuta el código podemos distinguir dos tipos de lenguajes de programación: los lenguajes compilados y los lenguajes interpretados.

- **Lenguajes compilados**: Los lenguajes compilados son aquellos en los que el código fuente se traduce a un lenguaje máquina específico del procesador. El resultado de esta traducción es un archivo ejecutable que contiene el programa en lenguaje máquina. Este archivo se puede ejecutar en cualquier ordenador que tenga el mismo procesador (arquitectura) y el mismo sistema operativo que el que se utilizó para compilar el programa. Ejemplos de lenguajes compilados son C, C++, Pascal, etc.
- **Lenguajes interpretados**: Los lenguajes interpretados son aquellos en los que el código fuente se traduce (*interpreta*) a lenguaje máquina en tiempo de ejecución. El programa que se encarga de realizar esta traducción se llama intérprete. El intérprete lee el código fuente, lo traduce a lenguaje máquina y lo ejecuta. Ejemplos de lenguajes interpretados son Python, PHP, JavaScript, etc.

#### Lenguajes semicompilados

Existe una tercera categoría de lenguajes de programación que son los lenguajes semicompilados. Estos lenguajes son compilados en el sentido de que generan código máquina, pero no para una máquina real, sino para una máquina virtual.

En el caso de Java, por ejemplo, el compilador genera código máquina para la máquina virtual de Java (Java Virtual Machine - JVM). Este código se ejecuta en la JVM, que es un programa que simula un ordenador virtual. La ventaja de este enfoque es que el código Java es independiente de la plataforma, es decir, se puede ejecutar en cualquier ordenador que tenga una JVM instalada.

#### RPL (Run-Print-Loop)

En los lenguajes interpretados es muy común que se hable de RPL. Un RPL es un intérprete que ejecuta el código que escribe el usuario (*run*), muestra el resultado de la ejecución (*print*) y queda a la espera de que el usuario escriba la siguiente instrucción para repetir el proceso (*loop*).

Por ejemplo, en Python, podemos ejecutar un RPL con el comando `python` en la consola:

![RPL de Python](./images/Python-RPL.png)

### Pruebas

### Explotación

### Mantenimiento

### Documentación
