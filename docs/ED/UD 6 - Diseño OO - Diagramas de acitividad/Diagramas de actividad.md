# Diagramas de comportamiento

A diferencia de los diagramas estructurales, que muestran las relaciones entre los elementos estáticos del modelo, los diagramas de comportamiento muestran cómo interactúan esos elementos a lo largo del tiempo. Los diagramas de comportamiento son útiles para modelar la lógica de negocio y los procesos dentro del sistema.

Nos permiten visualizar, especificar, construir y documentar los aspectos dinámicos de un sistema: el flujo de mensajes, los estados por los que pasa un objeto, la interacción de un sujeto con el sistema, etc.

Hay cuatro tipos de diagramas de comportamiento:

* Diagramas de casos de uso: Muestran las relaciones entre los _actores_ (usuarios del sistema) y las acciones que pueden realizar en el sistema: los casos de uso.
* Diagramas de interacción: Estos se subdividen en dos tipos: diagramas de secuencia y diagramas de colaboración.
  * Los diagramas de secuencia muestran cómo los objetos interactúan entre sí **a lo largo del tiempo** mediante intercambio de mensajes.
  * Los diagramas de comunicación se centran, también en el intercambio de mensajes, pero en este caso se centran en la organización o estructura de los objetos que participan en la interacción.
* Diagramas de estados: Ilustran como un elemento, generalmente un objeto, se pueden cambiar a distintos estados a lo largo de su ciclo de vida. Los estados son los diferentes modos en los que un objeto puede estar en un momento dado.
* Diagramas de actividad: Representan los procesos del negocio a alto nivel. También pueden utilizarse para modelar la lógica compleja o procesos en paralelo dentro del sistema.

En este tema daremos más importancia a los diagramas de **casos de uso** y **de secuencia**.

## Diagramas de casos de uso

Los diagramas de casos de uso se centran en el punto de vista del usuario. Representan las distintas funcionalidades que ofrece el sistema a los usuarios (actores). Estas funcionalidades, a fin de cuentas, se llevarán a cabo en forma de  interacciones entre el actor y la aplicación.

Estos diagramas son especialmente útiles para determinar las funcionalidades que tiene que desempeñar el sistemas y, de esta forma, ayudar a definir los requisitos del mismo (**fase de captura de requisitos**). Se utilizarán, por lo tanto, en la fase de análisis del sistema y para comunicarse entre el cliente y el analista.

Un diagrama de casos de uso ha de decir **qué** comportamiento se espera de manera comprensible par el cliente (no informático) sin utilizar tecnicismos pero no del **cómo**.

### Elementos de un diagrama de casos de uso

Los elementos del diagramas de casos de uso serán: **actor**, **caso de uso** y **relaciones**.

#### Actor

El actor representa un _rol_ o papel desempeñado por un elemento ajeno al sistema. Este elemento puede ser un usuario, un sistema o un dispositivo que interactúe con el sistema. El actor interactúa con el sistema para llevar a cabo una tarea o función específica.

Sus característica fundamentales son:

* Está fuera de los límites del sistema.
* Un mismo actor puede participar en varios casos de uso.
* En un caso de uso puede participar más de un actor.
* Los actores son el punto de inicio de los casos de uso.
* Los actores principales figurarán el la parte superior del diagrama y los secundarios en la parte inferior.

TODO: Icono de actor.

#### Caso de uso

Un caso de uso describe una funcionalidad o comportamiento del sistema desde el punto de vista del actor. Es una secuencia de acciones que el sistema lleva a cabo para proporcionar un resultado observable al actor. Un caso de uso puede incluir varios pasos y puede involucrar la interacción con otros casos de uso.

Por este motivo se nombran mediante un verbo en infinitivo seguido de un sustantivo. Por ejemplo: "Registrar usuario", "Buscar producto", "Realizar compra".

Los casos de uso se suelen representar de forma descendiente situando los más importantes en la parte superior.
La acción correspondiente al caso de uso no puede ni excesivamente genérica ni demasiado específica.

TODO: Icono de caso de uso.

#### Relaciones

Una relación indica una acción o flujo de información. Pueden ser de varios tipos:

* Asociación: Indica una invocación desde un actor o un caso de uso a otro caso de uso.
  * Se representa mediante una línea continua entre el actor y el caso de uso o entre dos casos de uso.
* Inclusión: Se produce entre dos casos de uso e indica que uno de ellos necesita al otro para realizar su función. Es decir, tiene la funcionalidad del otro como parte integrante de su comportamiento.
  * Se representa mediante una línea discontinua con una flecha que apunta al caso de uso incluido y la etiqueta `<<include>>`.
* Extensión: Se produce entre dos casos de uso e indica que uno de ellos amplía la funcionalidad del otro. Es decir el primer caso de uso **no depende** del segundo para realizar su función pero el segundo puede **opcionalmente** añadir aspectos a la funcionalidad del primero.
  * Se representa mediante una línea discontinua con una flecha que apunta al caso de uso base y la etiqueta `<<extend>>`.
* Generalización: Se produce entre un caso de uso padre y un caso de uso hijo. El hijo hereda la funcionalidad del padre y puede añadirle más funcionalidades. El padre es una _generalización_ del hijo y el hijo una _especialización_ del padre. De este modo, podríamos substituir el caso padre por el hijo y no variaría el comportamiento del sistema.
  * Se representa mediante una línea continua con una flecha que apunta al caso de uso padre.

Un ejemplo de asociación:



Un ejemplo de extensión:

Un ejemplo de generalización:

## Diagramas de interacción

## Diagramas de estados

## Diagramas de actividad
