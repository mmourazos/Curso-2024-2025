# Apuntes de Git

## ¿Qué es Git?

### ¿Qué es un sistema de control de versiones?

Un sistema de control de versiones (VCS: Version Control System) es un sistema que registra los cambios en un conjunto de archivos (un proyecto) en forma de instantáneas a lo largo del tiempo. Estas instantáneas nos permiten conocer quién ha realizado un cambio, cuándo se ha realizado y qué se ha cambiado. Si necesitamos retroceder a una versión anterior de un fichero o de un proyecto completo, podemos hacerlo.

Aunque los VCS son muy utilizados en el desarrollo de software, también se pueden utilizar en otros ámbitos, como el diseño gráfico, la redacción de documentos, etc.

## Utilidad de GIT

GIT es un sistema de control de versiones distribuido. Permite llevar un control de los cambios en los ficheros de un proyecto.

## Características de GIT


* Git es un sistema de control de versiones distribuido de manera que no tiene un único punto de fallo.
  * Cada usuario tiene una copia local **completa** del repositorio.
* Git es Open Source y gratuito.
* Está diseñado para manejar proyectos de cualquier tamaño con rapidez y eficiencia.
* Casi todas las operaciones son locales.
  * No es necesario estar conectado para trabajar.
* Git *siempre* añade datos. Nunca los borra.
  * Esto es importante porque si borramos algo por error, siempre podemos recuperarlo. **Y si lo *subimos* por error, no siempre podemos borrarlo** (al menos fácilmente).


**Tres estados de GIT**

* Modificado (*modified*): hemos cambiado un fichero pero no lo hemos guardado en la base de datos.
* Preparado (*staged*): hemos marcado un fichero modificado en su versión actual para que vaya en la próxima instantánea (*commit*).
* Confirmado (*committed*): hemos guardado los cambios (de los ficheros previamente marcados, *staged*) en la base de datos.

**Tres áreas de GIT**

* Directorio de trabajo (*working directory*): donde se encuentran los archivos de nuestro proyecto.
* Área de preparación (*staging area*): donde se encuentran los archivos marcados para la próxima instantánea (*commit*).
* Directorio Git (*Git directory*): donde GIT guarda los metadatos y la base de datos de los cambios.Aquí se encuentra la historia del proyecto.

**Flujo de trabajo básico en GIT**

1. Realizamos cambios en los archivos de nuestro proyecto.
2. Selecciones los archivos que queremos incluir (*staged*) en la siguiente instantánea (*commit*).
3. Realizamos el *commit* para salvar los cambios en forma de una instantánea.

### Ramas en Git (Branches)

Las ramas en Git son simplemente apuntadores móviles a uno de los *commits*. Por defecto, cuando creamos un nuevo proyecto, se crea una rama principal llamada `master`. Al crear una nueva rama, se crea un nuevo apuntador que podemos mover a cualquier *commit*. Esto nos permite trabajar en paralelo en diferentes funcionalidades o versiones de nuestro proyecto.

La rama en uso se llama `HEAD`. Cuando creamos un nuevo *commit*, `HEAD` se mueve al nuevo *commit*. Si cambiamos de rama, `HEAD` se mueve a la nueva rama.

El comando para crear una nueva rama es `git branch nombre_rama`. Para cambiar de rama, usamos `git checkout nombre_rama`. Es común combinar estos dos comandos en uno solo: `git checkout -b nombre_rama` que crea una nueva rama y se cambia a ella.

Desde la versión 2.23 de Git, se recomienda usar `git switch` en lugar de `git checkout` para cambiar de rama.

#### Fusionar ramas (Merge)

La fusión de ramas es el proceso de combinar dos ramas en una sola. Para fusionar una rama con la rama actual, usamos el comando `git merge nombre_rama`. Si hay conflictos, debemos resolverlos manualmente.

## Instalación de GIT

## Configuración de GIT

## Comandos básicos de GIT

## GUIs de GIT

### [Lazygit](https://github.com/jesseduffield/lazygit)


