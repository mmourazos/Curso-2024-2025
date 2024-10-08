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

## Fichero `pom.xml`

El fichero `pom.xml` es el fichero de configuración de Maven. En este fichero se define la configuración del proyecto, las dependencias, los plugins, etc. A continuación se muestra un ejemplo de un fichero `pom.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>demo</artifactId>
  <version>1.0-SNAPSHOT</version>

  <name>demo</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
      <plugins>
        <!-- clean lifecycle, see https://maven.apache.org/ref/current/maven-core/lifecycles.html#clean_Lifecycle -->
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <!-- default lifecycle, jar packaging: see https://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_jar_packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-jar-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
        <!-- site lifecycle, see https://maven.apache.org/ref/current/maven-core/lifecycles.html#site_Lifecycle -->
        <plugin>
          <artifactId>maven-site-plugin</artifactId>
          <version>3.7.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-project-info-reports-plugin</artifactId>
          <version>3.0.0</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>
```
