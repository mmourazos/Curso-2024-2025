# Apuntes de Maven

[TOC]

## Introduction a Maven

Maven es una herramienta de gestión y construcción de proyectos de software en lenguajes basados en Java como Java, Kotlin o Groovy. Maven es una herramienta de código abierto y es una de las más utilizadas en la gestión de proyectos Java.

¿Qué ofrece Maven?

* **Gestión de dependencias**: Maven se encarga de gestionar las dependencias de nuestro proyecto. Maven descarga las dependencias de nuestro proyecto de un repositorio central y las añade a nuestro proyecto.
* **Estructura de directorios**: Maven define una estructura de directorios para nuestros proyectos. Esta estructura es la siguiente:
  * `src/main/java`: aquí se encuentran los ficheros Java de nuestro proyecto.
  * `src/main/resources`: aquí se encuentran los recursos de nuestro proyecto (ficheros de configuración, imágenes, etc.).
  * `src/test/java`: aquí se encuentran los ficheros Java de los tests de nuestro proyecto.
  * `src/test/resources`: aquí se encuentran los recursos de los tests de nuestro proyecto.
* **Permite incluir plugins**: Maven permite incluir plugins que añaden funcionalidades a nuestro proyecto. Por ejemplo, para realizar pruebas unitarias, para generar documentación, para generar informes, etc.

La configuración de un proyecto Maven se realiza en un fichero llamado `pom.xml` (Project Object Model) que se encontrará en el directorio raíz del proyecto. En este fichero se define la configuración del proyecto, las dependencias, los plugins, etc.

## Instalación de Maven

### Linux (Ubuntu)

Para instalar Maven en una distribución Linux lo ideal será hacerlo mediante el gestor de paquetes de la distribución. En el caso de Ubuntu, podemos instalar Maven con el siguiente comando:
```bash
sudo apt install maven
```

### Windows

Para instalar Maven en Windows podemos utilizar varios métodos. Uno de los más sencillos es descargar Maven desde la página oficial de Maven y descomprimir el fichero en un directorio de nuestro sistema. A continuación, añadimos la ruta de Maven al PATH del sistema.

Una forma más fácil de instalar Maven en Windows es utilizar un gestor de paquetes como [Chocolatey](https://chocolatey.org/) (las instrucciones para instalar Chocolatey se encuentran [en su web](https://chocolatey.org/install). Para instalar Maven con Chocolatey ejecutamos el siguiente comando:

```powershell
choco install maven
```

***Nota: para instalar paquetes con Chocolatey necesitamos tener permisos de administrador.***

Otra forma de instalar Maven en Windows es utilizando [Scoop](https://scoop.sh/). Para instalar Maven con Scoop ejecutamos el siguiente comando:

```powershell
scoop install maven
```

