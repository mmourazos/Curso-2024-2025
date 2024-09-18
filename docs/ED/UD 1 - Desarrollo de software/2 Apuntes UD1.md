# Apuntes de la UD1 - Desarrollo de software

## Ejecución del código fuente

El proceso de creación de una aplicación informática consta de varias fases, entre ellas la escritura del código fuente. Una vez que el código fuente está escrito, es necesario ejecutarlo para que el ordenador realice las operaciones que se han programado.

Atendiendo a la forma en que se ejecuta el código podemos distinguir dos tipos de lenguajes de programación: los lenguajes compilados y los lenguajes interpretados.

- **Lenguajes compilados**: Los lenguajes compilados son aquellos en los que el código fuente se traduce a un lenguaje máquina específico del procesador. El resultado de esta traducción es un archivo ejecutable que contiene el programa en lenguaje máquina. Este archivo se puede ejecutar en cualquier ordenador que tenga el mismo procesador (arquitectura) y el mismo sistema opeativo que el que se utilizó para compilar el programa. Ejemplos de lenguajes compilados son C, C++, Pascal, etc.
- **Lenguajes interpretados**: Los lenguajes interpretados son aquellos en los que el código fuente se traduce a lenguaje máquina en tiempo de ejecución. El programa que se encarga de realizar esta traducción se llama intérprete. El intérprete lee el código fuente, lo traduce a lenguaje máquina y lo ejecuta. Ejemplos de lenguajes interpretados son Python, PHP, JavaScript, etc.

### Lenguajes semicompilados

Existe una tercera categoría de lenguajes de programación que son los lenguajes semicompilados. Estos lenguajes se traducen a un lenguaje intermedio que se ejecuta en una máquina virtual. Ejemplos de lenguajes semicompilados son Java, C#, etc.

En el caso de Java, por ejemplo, el compilador genera código máquina para una máquina virtual Java (Java Virtual Machine - JVM). Este código se ejecuta en la JVM, que es un programa que simula un ordenador virtual. La ventaja de este enfoque es que el código Java es independiente de la plataforma, es decir, se puede ejecutar en cualquier ordenador que tenga una JVM instalada.

### RPL (Run-Print-Loop)

En los lenguajes interpretados es muy común que se hable de RPL. Un RPL es un intérprete que ejecuta el código que escribe el usuario (_run_), muestra el resultado de la ejecución (_print_) y queda a la espera de que el usuario escriba la siguiente instrucción para repetir el proceso (_loop_).

Por ejemplo, en Python, podemos ejecutar un RPL con el comando `python` en la consola:

![RPL de Python](./images/Python RPL.png)
