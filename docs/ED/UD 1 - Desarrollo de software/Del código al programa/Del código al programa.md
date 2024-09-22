# Del código al programa

En esta sección vamos a ver el proceso que hay desde la escritura de código en un lenguaje de programación (código fuente) hasta la ejecución del mismo en el sistema operativo (código objeto).

## Código compilado

En primer lugar veremos varios ejemplos de lenguajes cuyo código se compila: C, Go y Rust. Los ejemplos los haremos en línea de comandos y el código simplemente imprimirá los números del 1 al 10. No es la intención de esta sección enseñar a programar en estos lenguajes si no mostrar el proceso de compilación y ejecución de un programa por lo que no te preocupes si no entiendes el código.

### C

Para realizar el proceso de codificación y compilación en C (y en el resto de los lenguajes) lo primero que hemos de hacer es crear un fichero de texto plano (sin formato) con la extensión `.c`. En este ejemplo lo llamaré `ejemplo_c.c`. El contenido del fichero será el siguiente:

```c
#include <stdio.h>

funcion main() {
    for (int i = 1; i <= 10; i++) {
        printf("%d\n", i);
    }
}
```

A continuación hemos de compilar el fichero. Para ello abrimos una terminal y nos movemos a la carpeta donde se encuentra el fichero. Una vez allí ejecutamos el siguiente comando:

```bash
cc cuenta.c -o cuenta
```

Es muy probable que esto no funcione ya que no es común que dispongamos de un compilador de C en nuestro sistema. En el caso de que no tengamos un compilador de C podemos instalarlo ejecutando el siguiente comando:

#### Ubuntu Linux

```bash
sudo apt install build-essential
```

#### Windows

```bash
winget install --id=GNU.GCC
```

O usando el sistema de paquetes [scoop](https://scoop.sh/):

```bash
scoop install gcc
```

### Go

El caso de Go es muy similar al de C pero con la diferencia de que Go es un lenguaje más moderno y con ciertas peculariedades. Para crear una aplicación Go hemos de crear un _módulo_ de Go (Go no permite que nuestro código ande suelto por el monte, ha de pertenecer a un módulo). Para ello hemos de crear un directorio y crear un módulo dentro del mismo:

```bash
mkdir ejemplo_go
cd ejemplo_go
go mod init cuenta
```

Con estos comandos hemos creado un módulo de Go llamado `cuenta` dentro de la carpeta `ejemplo_go`.

Para compilar el código Go y obtener un ejecutable hemos de crear un fichero de con extensión `.go` dentro de dicho directorio y con el siguiente contenido:

```go
func main() {
    for i := 1; i <= 10; i++ {
        fmt.Println(i)
    }
}
```

Finalmente para compilar el fichero ejecutamos el siguiente comando:

```bash
go build .
```

Y como resultado de este proceso obtendremos un ejecutable llamado `cuenta.exe` que podemos ejecutar.

### Rust

### Caso especial: Lenguajes que compilan a _bytecode_

Antes de hablar de el caso especial de estos lenguajes necesitamos entender qué es _bytecode_.

_Bytecode_, **código intermedio** o **código portable** es un _conjunto de instrucciones_ diseñado para ser ejecutado por un **intérprete software**. Es decir, cuando un programa compila a _bytecode_ lo que hace generar un código escrito mediante un _conjunto especial de instrucciones_ que **no serán para el procesador del ordenador** si no para ese **intérprete software**. Será ese intérprete el que haga de intermediario entre el _bytecode_ y el sistema operativo para ejecutar las instrucciones.

Tres ejemplos de lenguajes que _compilan a bytecode_ son Java, Kotlin y C#. Los dos primeros generan _bytecode_ para la máquina virtual de java (JVM) mientras que C# lo hace para CLR (Common Language Runtime) de .NET.

A continuación veremos ejemplos de estos lenguajes. Una vez más lo haremos en línea de comandos para que se vea el proceso de compilación y ejecución de los programas y no se vea oculto por un IDE.

#### Ejemplo de Java

Para crear un programa en Java hemos de crear un fichero con extensión `.java` y con el siguiente contenido:

```java
public static void main(String[] args) {
    for (int i = 1; i <= 10; i++) {
        System.out.println(i);
    }
}
```

#### Ejemplo de Kotlin

#### Ejemplo de C\#

```

```

```

```
