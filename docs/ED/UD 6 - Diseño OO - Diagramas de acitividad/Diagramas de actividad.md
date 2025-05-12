# Diagramas de comportamiento

<!-- toc -->

- [Diagramas de casos de uso](#diagramas-de-casos-de-uso)
    * [Elementos de un diagrama de casos de uso](#elementos-de-un-diagrama-de-casos-de-uso)
        + [Actor](#actor)
        + [Caso de uso](#caso-de-uso)
        + [Relaciones](#relaciones)
- [Diagramas de interacción](#diagramas-de-interaccion)
    * [Diagramas de secuencia](#diagramas-de-secuencia)
        + [Elementos de un diagrama de secuencia](#elementos-de-un-diagrama-de-secuencia)
    * [Diagramas de comunicación](#diagramas-de-comunicacion)
        + [Elementos de un diagrama de comunicación](#elementos-de-un-diagrama-de-comunicacion)
- [Diagramas de estados](#diagramas-de-estados)
    * [Elementos de un diagrama de estados](#elementos-de-un-diagrama-de-estados)
- [Diagramas de actividad](#diagramas-de-actividad)
    * [Elementos de un diagrama de actividad](#elementos-de-un-diagrama-de-actividad)

<!-- tocstop -->

A diferencia de los diagramas estructurales, que muestran las relaciones entre los elementos estáticos del modelo, los diagramas de comportamiento muestran cómo interactúan esos elementos a lo largo del tiempo. Los diagramas de comportamiento son útiles para modelar la lógica de negocio y los procesos dentro del sistema.

Nos permiten visualizar, especificar, construir y documentar los aspectos dinámicos de un sistema: el flujo de mensajes, los estados por los que pasa un objeto, la interacción de un sujeto con el sistema, etc.

Hay cuatro tipos de diagramas de comportamiento:

- Diagramas de casos de uso: Muestran las relaciones entre los _actores_ (usuarios del sistema) y las acciones que pueden realizar en el sistema: los casos de uso.
- Diagramas de interacción: Estos se subdividen en dos tipos: diagramas de secuencia y diagramas de colaboración.
  - Los diagramas de secuencia muestran cómo los objetos interactúan entre sí **a lo largo del tiempo** mediante intercambio de mensajes.
  - Los diagramas de comunicación se centran, también en el intercambio de mensajes, pero en este caso se centran en la organización o estructura de los objetos que participan en la interacción.
- Diagramas de estados: Ilustran como un elemento, generalmente un objeto, se pueden cambiar a distintos estados a lo largo de su ciclo de vida. Los estados son los diferentes modos en los que un objeto puede estar en un momento dado.
- Diagramas de actividad: Representan los procesos del negocio a alto nivel. También pueden utilizarse para modelar la lógica compleja o procesos en paralelo dentro del sistema.

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

- Está fuera de los límites del sistema.
- Un mismo actor puede participar en varios casos de uso.
- En un caso de uso puede participar más de un actor.
- Los actores son el punto de inicio de los casos de uso.
- Los actores principales figurarán el la parte superior del diagrama y los secundarios en la parte inferior.

Un diagrama básico de casos de uso tendrá el siguiente aspecto:

![Diagrama básico de caso de uso](./imagenes/casos_de_uso.svg)

En el diagrama anterior podemos ver un actor (cliente) que interactúa con el sistema invocando (relación de asociación) un caso de uso (Realizar pedido).

#### Caso de uso

Un caso de uso describe una funcionalidad o comportamiento del sistema desde el punto de vista del actor. Es una secuencia de acciones que el sistema lleva a cabo para proporcionar un resultado observable al actor. Un caso de uso puede incluir varios pasos y puede involucrar la interacción con otros casos de uso.

Se representan por medio de un óvalo dentro del cual se nombran mediante un verbo en infinitivo seguido de un sustantivo. Por ejemplo: "Registrar usuario", "Buscar producto", "Realizar compra".

Los casos de uso se suelen representar de forma descendiente situando los más importantes en la parte superior.
La acción correspondiente al caso de uso no puede ni excesivamente genérica ni demasiado específica.

#### Relaciones

Una relación indica una acción o flujo de información. Pueden ser de varios tipos:

- Asociación: Indica una **invocación** desde un actor o un caso de uso a otro caso de uso.
  - Se representa mediante una línea continua entre el actor y el caso de uso o entre dos casos de uso.
- Inclusión: Se produce entre dos casos de uso e indica que **uno de ellos necesita al otro** para realizar su función. Es decir, la funcionalidad de un caso de uso **necesita** del otro para poder llevarse a cabo.
  - Se representa mediante una línea discontinua con una flecha que apunta al caso de uso incluido y la etiqueta `<<include>>`.
- Extensión: Se produce entre dos casos de uso e indica que **uno de ellos amplía la funcionalidad del otro**. Es decir el primer caso de uso **no depende** del segundo para realizar su función pero el segundo puede **opcionalmente** añadir aspectos a la funcionalidad del primero.
  - Se representa mediante una línea discontinua con una flecha que apunta al caso de uso base y la etiqueta `<<extend>>`.
- Generalización: Se produce entre un **caso de uso padre y un caso de uso hijo**. El **hijo hereda la funcionalidad del padre y puede añadirle más funcionalidades**. El padre es una _generalización_ del hijo y el hijo una _especialización_ del padre. De este modo, podríamos substituir el caso padre por el hijo y no variaría el comportamiento del sistema.
  - Se representa mediante una línea continua con una flecha que apunta al caso de uso padre.

Un ejemplo de asociación:

![Ejemplo de asociación](./imagenes/casos_de_uso.svg)

Un ejemplo de inclusión:

![Ejemplo de inclusión](./imagenes/casos_de_uso_include.svg)

Un ejemplo de extensión:

![Ejemplo de extensión](./imagenes/casos_de_uso_extend.svg)

Un ejemplo de generalización:

![ejemplo de generalización](./imagenes/casos_de_uso_generalizacion.svg)

## Diagramas de interacción

Los diagramas de interacción muestran cómo los objetos interactúan entre sí a lo largo del tiempo mediante el intercambio de mensajes. Estos diagramas son útiles para modelar la lógica de negocio y los procesos dentro del sistema.

Permiten visualizar el sistema como un conjunto de eventos ordenados en el tiempo. Los diagramas de interacción se dividen en cuatro tipos:

- **Diagramas de secuencia**: Muestran cómo los objetos interactúan entre sí a lo largo del tiempo mediante el intercambio de mensajes. Se centran en el orden temporal de los mensajes.
- Diagramas de colaboración / comunicación: Representan las relaciones e interacciones entre distintos objetos de software. Enfatizan los aspectos estructurales más que el flujo de los mensajes. Se centran más en la secuencia de mensajes intercambiados entre los objetos que en la cronología. Se centran en la organización o estructura de los objetos que participan en la interacción.
- Diagramas de tiempo: Representan en una línea temporal los cambios que se producen en uno o varios objetos, respondiendo a los eventos que se producen en el sistema. El conjunto del diagrama ilustra el comportamiento del sistema y como los objetos interactúan entre sí.
- Diagramas globales de interacciones: El diagrama global de interacciones ofrece una vista de alto nivel de un modelo de interacción. El diagrama actúa como una vista global del flujo de control entre las distintas interacciones, además del flujo de actividad entre los distintos diagramas.

### Diagramas de secuencia

Son los diagramas más utilizados para representar la interacción entre objetos. Se centran en el orden temporal de los mensajes intercambiados entre los objetos. Los diagramas de secuencia son útiles para modelar la lógica de negocio y los procesos dentro del sistema.

#### Elementos de un diagrama de secuencia

Los elementos de un diagrama de secuencia serán:

- Participantes: Representan los objetos o actores que participan en la interacción. Se representan mediante el símbolo de actor previamente viso o rectángulos en la parte superior del diagrama.
  - Actor: Normalmente inicia la interacción y se situará a la izquierda del diagrama.
  - Objeto: Se corresponde con la instancia de una clase. Se representa mediante un rectángulo con el nombre del objeto seguido de dos puntos y el nombre de su clase. Por ejemplo: `cliente_vip: Cliente`.
- Línea de vida: Representa la existencia de un objeto a lo largo del tiempo. Se representa mediante una línea vertical que desciende desde el participante. La línea de vida comienza cuando el objeto se crea y termina cuando se destruye. El transcurso del tiempo se representa de arriba a abajo.
- Activaciones: Representan el tiempo en el que un objeto está activo realizando alguna operación. Se representan mediante un rectángulo vertical que se sitúa sobre la línea de vida del objeto. La activación comienza cuando el objeto recibe un mensaje y termina cuando el objeto envía un mensaje o se destruye.
- Mensajes: Representan la comunicación entre los participantes. Se representan mediante flechas que van de un participante a otro. Los mensajes se numeran para indicar el orden en que se envían. Pueden ser de cuatro tipos:
  - Sincrónicos (el remitente espera una respuesta). Se representan mediante una flecha sólida. La respuesta se representa mediante una línea discontinua que vuelve al remitente.
  - Asíncronos (el remitente no espera una respuesta). Se representan con una punta de flecha abierta.
  - De creación: Indican la creación o _instanciación_ de un objeto. Se representan mediante una flecha discontinua con una punta de flecha abierta que termina en el rectángulo del objeto creado. Opcionalmente tienen la etiqueta `create`.
  - De destrucción: Indican la destrucción de un objeto. Se representan como un mensaje normal que opcionalmente tiene la etiqueta `destroy`.

Un ejemplo de diagrama de secuencia sería el siguiente:

```mermaid
sequenceDiagram
    actor Cliente
    create participant Pedido
    participant Producto

    Cliente-->>Pedido: Crear pedido
    Cliente->>+Pedido: Añadir producto
    Pedido->>+Producto: Añadir producto
    Producto-->>-Pedido: Producto añadido
    Pedido-->>-Cliente: Producto añadido
    Pedido->>Cliente: Solicitar confirmación
    destroy Pedido
    Cliente-->>Pedido: Pedido confirmado
```

Como en casi todos los diagramas no todas las herramientas contemplan todos los elementos. En este caso, mermaid no contempla la notación destrucción de objetos con la `X` al final de la línea de vida, simplemente hace desaparecer el objeto.

### Diagramas de comunicación

Un diagrama de comunicación se puede considerar como una variante de un diagrama de secuencia. En lugar de centrarse en el orden temporal de los mensajes, se centra en la organización o estructura de los objetos que participan en la interacción. Los diagramas de comunicación son útiles para modelar la lógica de negocio y los procesos dentro del sistema.

Algunas aplicaciones de modelado de diagramas UML permiten generar diagramas de comunicación a partir de diagramas de secuencia. Esto es útil para obtener una vista diferente de la misma interacción.

#### Elementos de un diagrama de comunicación

Un diagrama de comunicación tiene los mismos elementos que un diagrama de secuencia pero con una representación diferente:

- Participantes: Se representan mediante rectángulos con el nombre del objeto seguido de dos puntos y el nombre de su clase.
- Comunicación: Cuando existe una comunicación entre dos participantes se dibuja una conexión entre ellos mediante una línea.
- Mensajes: Se representan mediante flechas, dibujadas sobre la línea de comunicación, que van de un participante a otro. Los mensajes se numeran para indicar el orden en que se envían.
No se representan los mensajes de respuesta.
- Línea de vida: No se representa en este diagrama.

![Imagen diagrama de comunicación](C:\Users\asinc\Documents\Trabajo\IES San Clemente\Curso-2024-2025\docs\ED\UD 6 - Diseño OO - Diagramas de acitividad\imagenes\diagrama_secuencia.drawio.svg)

## Diagramas de estados

Estos diagramas sirven para mostrar los diferentes estados por los que puede pasar un objeto a lo largo de su ciclo de vida en respuesta a diferentes eventos. Un estado es una condición o situación en la que se encuentra un objeto en un momento dado.

Los diagramas de estado siempre representan a un único objeto.

### Elementos de un diagrama de estados

Un diagrama de estado tiene los siguientes elementos:

- Estados: Se representan mediante rectángulos redondeados. Un estado ha de tener un nombre y puede tener tres _compartimentos_: Uno para el **nombre**, otro para **el valor de los atributos** en dicho estado y otro para las **acciones que se llevan a cabo al entrar o salir** del estado. Ha también dos estados especiales:
  - Estado inicial: Representa el estado en el que comienza el objeto. Se representa mediante un círculo pequeño y negro.
  - Estado final: Representa el estado final del objeto. Se representa mediante un círculo negro rodeado de un circulo hueco.
- Transiciones: Representan la relación entre dos estados. Se muestran mediante una linea continua y se indica cual es el estado inicial y el siguiente mediante una flecha. Se acompañan de un texto con el nombre del evento que provoca la transición y opcionalmente puede ir acompañado de una serie de parámetros:
  - Argumentos: Los parámetros con los que se _invoca_ el evento (o método).
  - Condición de guarda: Una condición que ha de cumplirse para que se lleve a cabo la transición.
  - Acción: La acción que se ejecutaría cuando se efectúa la transición.

Un ejemplo de diagrama de estados de un ascensor podría ser el siguiente:

![Imagen de diagrama de estados](C:\Users\asinc\Documents\Trabajo\IES San Clemente\Curso-2024-2025\docs\ED\UD 6 - Diseño OO - Diagramas de acitividad\imagenes\Diagrama_estados.svg)

## Diagramas de actividad

Constituyen una variante de los diagramas de estados en la que los estados representarán la ejecución de determinadas acciones o actividades. Las transiciones sólo se disparan cuando se finaliza la ejecución de las acciones correspondientes a cada estado.

La diferencia entre un estado y una actividad consiste en que el primero es atómico y describe una situación mientras que la segunda es un proceso que puede llevar un tiempo en completarse.

### Elementos de un diagrama de actividad

Los elementos de un diagrama de actividad son:

- Actividad / acción: Pueden indicar una acción o un conjunto de acciones. Es decir, una acción general podría dividirse en varias acciones más específicas. Se representan mediante un rectángulo redondeado con el nombre de la actividad dentro.
- Transición: Representa el paso de una actividad a otra. Se representa mediante una flecha que conecta dos actividades indicando el orden de ejecución.
- Bifurcación / branching: representa una decisión que puede llevar a dos o más caminos. Se representa mediante un rombo. Siempre habrá una condición de guarda que indica el camino a seguir.
- Divisiones / uniones: Representan la posibilidad de ejecutar varias actividades en paralelo. Se representan mediante una línea horizontal que divide el diagrama en dos o más partes. Dentro de cada parte se podrán dibujar dos o más sub-diagramas de actividad que se estarían ejecutando simultáneamente. La unión se representa mediante una línea horizontal que une dos o más actividades en paralelo.

Diagrama que muestra el procesado de un pedido:

```mermaid
stateDiagram-v2
state fork_state <<fork>>
[*] --> RecibirPedido
RecibirPedido --> fork_state
fork_state --> GenerarCorreo
fork_state --> AsignarEncargado
GenerarCorreo --> EnviarCorreo
state join_state <<join>>
EnviarCorreo --> join_state
AsignarEncargado --> join_state
join_state --> ProcesarPedido
ProcesarPedido --> [*]
```



