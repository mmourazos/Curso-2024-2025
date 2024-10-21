# Apuntes de Maven

[TOC]

## Introduction a Maven

Maven es una herramienta de gestión y construcción de proyectos de software en lenguajes basados en Java como Java, Kotlin o Groovy. Maven es una herramienta de código abierto y es una de las más utilizadas en la gestión de proyectos Java.

¿Qué ofrece Maven?

- **Gestión de dependencias**: Maven se encarga de gestionar las dependencias de nuestro proyecto. Maven descarga las dependencias de nuestro proyecto de un repositorio central y las añade a nuestro proyecto.
- **Estructura de directorios**: Maven define una estructura de directorios para nuestros proyectos. Esta estructura es la siguiente:
  - `src/main/java`: aquí se encuentran los ficheros Java de nuestro proyecto.
  - `src/main/resources`: aquí se encuentran los recursos de nuestro proyecto (ficheros de configuración, imágenes, etc.).
  - `src/test/java`: aquí se encuentran los ficheros Java de los tests de nuestro proyecto.
  - `src/test/resources`: aquí se encuentran los recursos de los tests de nuestro proyecto.
- **Permite incluir plugins**: Maven permite incluir plugins que añaden funcionalidades a nuestro proyecto. Por ejemplo, para realizar pruebas unitarias, para generar documentación, para generar informes, etc.

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

**_Nota: para instalar paquetes con Chocolatey necesitamos tener permisos de administrador._**

Otra forma de instalar Maven en Windows es utilizando [Scoop](https://scoop.sh/). Para instalar Maven con Scoop ejecutamos el siguiente comando:

```powershell
scoop install maven
```

## Fichero `pom.xml`

El fichero `pom.xml` es el fichero de configuración de Maven. En este fichero se define la configuración del proyecto así como los plugins y dependencias necesarias para construir el proyecto.

Un ejemplo de un fichero `pom.xml` es el siguiente:

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

### Sección de identificación del proyecto

En todo fichero `pom.xml` es necesario definir la sección de identificación del proyecto. Esta sección se compone de los siguientes elementos:

- `groupId`: identificador del grupo al que pertenece el proyecto. Por ejemplo `gal.edu.xunta`. **No** es necesario que siga la notación de _puntos_ o de paquetes de Java (aunque se considera una buena práctica).
- `artifactId`: identificador del proyecto. Normalmente coincide con el nombre con el que se conocerá el proyecto. Este identificador es, en combinación con el `groupId`, la clave que identifica de forma única un proyecto respecto a todos los demás.
- `version`: versión del proyecto.

### _Packaging_ del proyecto

El empaquetado del proyecto se indica mediante la etiqueta `<packaging>`. Los valores más comunes son `jar`, `war` y `pom`. Por defecto, si no se indica nada, el valor de `packaging` es `jar`. Este valor afectará a las acciones que Maven realizará sobre el proyecto.

### Sección `properties`

En esta sección se le puede pasar información a Maven sobre nuestro proyecto. Por ejemplo, si deseamos que Maven utilice una versión concreta de Java, podemos indicarlo en esta sección. En el ejemplo anterior, se indica que se utilizará Java 23.

```xml
<properties>
  <maven.compiler.source>23</maven.compiler.source>
  <maven.compiler.target>23</maven.compiler.target>
</properties>
```

En esta sección también podemos establecer nuestros propios valores que podrán ser usados más adelante en el fichero `pom.xml`.o por parte de los plugins.

### Sección `dependencies`

Es uno de los elementos fundamentales de un fichero `pom.xml`. En esta sección se definen las dependencias del proyecto. Cada dependencia se define mediante la etiqueta `<dependency>` y se compone de los siguientes elementos:

- `groupId`, `artifactId` y `version`: identifican la dependencia.
- `scope`: indica el alcance de la dependencia, es decir, en qué contexto será necesaria. Algunos valores comunes son:
  - `compile` (el valor por defecto): la dependencia será necesaria para poder construir el proyecto.
  - `test`: la dependencia sólo será necesaria cuando se deseen realizar tests.

Hay más opciones: `type`, `classifier`, `optional`, etc. Pero las más comunes son las que se han mencionado.

### Sección `build`

Esta es la sección dedicada a indicar cómo se debe construir el proyecto. En esta sección se pueden definir los plugins que se utilizarán para construir el proyecto.

#### Sección plugins

Los plugins son elementos que añaden funcionalidades a Maven, principalmente para compilar y probar el proyecto pero también para generar documentación, informes, etc. Los plugins se definen dentro de la etiqueta `<plugins>` y cada plugin se define mediante la etiqueta `<plugin>`.

## Creación de un proyecto Maven

## _Archetypes_

Un arquetipo es una plantilla de proyecto que se utiliza para crear un nuevo proyecto. Maven incluye varios arquetipos que podemos utilizar para crear un nuevo proyecto. Para listar los arquetipos disponibles en Maven ejecutamos el siguiente comando:

```bash
mvn archetype:generate
```

Los arquetipos disponibles se encuentran en el repositorio central de Maven. Podemos buscar arquetipos en el repositorio central de Maven en la siguiente dirección: [https://repo.maven.apache.org/maven2/archetype-catalog.xml](https://repo.maven.apache.org/maven2/archetype-catalog.xml).
