
# Introducción a las bases de datos

[TOC]

## Sistema de información

Un sistema de información es un conjunto de elementos que interactúan entre sí con el fin de apoyar las actividades de una empresa o negocio. Estos elementos pueden ser:

* Personas.
* Datos.
* Actividades
* Recursos materiales.

Estos elementos interactúan entre sí para procesar información y generar conocimiento, es decir, información más elaborada que ayuda a la toma de decisiones.

### Sistema de información informático

Un sistema de información informático es un subconjunto de los sistemas de información generales. Un **SI** informático estará formado por:

* Hardware: Todos los dispositivos físicos que forman el sistema como servidores, ordenadores, redes, etc.
* Software: La aplicaciones que se utilizan para procesar y gestionar la información.
* Datos: La información relevante y útil que será gestionada por el sistema.
* Personas: Usuarios y administradores que interactúan con el sistema.
* Procesos: Conjunto de actividades que se realizan para recoger, almacenar, procesar y distribuir la información.

### Sistema de información empresarial

Un sistema de información empresarial es aquél que ayuda a gestionar y **automatizar los procesos de una empresa**, **mejorar su eficiencia** y facilitar la **toma de decisiones**.

Algunos ejemplos de sistemas de información empresarial son:

* Sistemas ERP (Enterprise Resource Planning): Son aplicaciones integradas que gestionan y automatizan los procesos de negocio de una empresa abarcando áreas como la producción, logística, inventario, ventas, contabilidad, etc.
  * Ejemplo: SAP ERP, SAGE, Oracle ERP Cloud, Odoo (proyecto de código abierto), Microsoft Dynamics, etc.
* Sistemas CRM (Customer Relationship Management): Son aplicaciones que gestionan la relación con los clientes de una empresa, almacenando información sobre ellos y sus interacciones con la empresa para mejorar la atención al cliente, la efectividad de las ventas y el marketing.
  * Ejemplo: Salesforce, HubSpot, Zoho CRM, etc.
* Sistemas SCM (Supply Chain Management): Son aplicaciones que gestionan la cadena de suministro de una empresa, desde la adquisición de materias primas hasta la entrega de productos al cliente final.
  * Ejemplo: Oracle SCM Cloud, SAP SCM, Manhattan Associates, etc.

Estos sistemas son críticos para el funcionamiento de muchas empresas y su elección e implantación debe ser cuidadosamente planificada y ejecutada.

## Los ficheros de información

### Fichero informático

Todos los sistemas informáticos necesitan de un sistema **no volátil** de almacenamiento de la información. Este almacenamiento se conoce como **memoria externa** y nos permite almacenar la información para recuperarla más tarde.

Para poder acceder de manera eficiente a esta información, ésta ha de organizarse de manera estructurada. Es decir, hemos de darle una **estructura** a los datos. El elemento básico de almacenamiento de la información es el **fichero**.

#### Fichero o archivo

Se define fichero como un conjunto de información relacionada tratada como una unidad y organizada de manera estructurada. Los ficheros se componen de **registros** y **campos**.

* **Registros lógicos**: Son *bloques* que contienen información relativa a un mismo elemento u *objeto*. Por ejemplo, cada registro de un fichero de clientes contendría la información de un cliente.
* **Campos**: Son los *elementos* que componen un registro. Por ejemplo, en el fichero de clientes, los campos podrían ser el nombre, apellidos, dirección, teléfono, etc.

#### Limitaciones de los ficheros tradicionales

Los ficheros antes mencionados presentan una serie de limitaciones que dificultan su gestión y mantenimiento:

* **Redundancia de datos**: La misma información se repite en varios ficheros.
* **Dificultad para acceder a la información**: No se pueden realizar consultas complejas.
* Pueden encontrarse los mismos datos en **distintos formatos**.
* **inconsistencias**. Varios usuarios modificando simultáneamente un mismo fichero pueden llevar a inconsistencias.
* **Seguridad**: No se pueden establecer permisos de acceso a nivel de campo.
* **Integridad**: Ya que nada limita que, por ejemplo, una fecha de nacimiento sea anterior a la fecha de contratación, o que un empleado no tenga un departamento asignado.

#### Conclusiones

Para solventar estas limitaciones se han desarrollado los sistemas de **Bases de Datos**, que permiten gestionar grandes volúmenes de información de manera eficiente y segura.

## Bases de datos

### Definición

Una base de datos es un conjunto de datos **relacionados entre sí**, **organizados de manera estructurada** y **sin redundancias innecesarias o perjudiciales**. Se caracterizan por:

* Servir a una o más aplicaciones: Distintas aplicaciones les *pedirán** los datos a la BD.
* Sirven de intermediario entre los datos y las aplicaciones. Las aplicaciones no tienen por qué saber cómo o dónde están guardados los datos, de esa tarea se encarga la base de datos.

### Objetivos de una base de datos

* Minimizar la **redundancia de los datos**. Es decir, que no exista la misma información en varios lugares.
* Asegurar la **integridad** y **consistencia** de los datos. Que los datos sean correctos y coherentes.
* Facilitar el **acceso eficiente y seguro** a los datos. Permitir realizar consultas complejas, limitar el acceso y evitar pérdida accidental de datos.

### Arquitectura de una base de datos

Los usuarios de una BD deben tener una visión **lo más abstracta posible** de los datos almacenados en ella. Es decir, el usuario no ha de saber cómo están estructurados los datos. Para ello, se definen tres niveles de abstracción:

* **Nivel físico**: Define cómo se almacenan los datos en el disco. La BD tendrá un **esquema interno** que describe los ficheros que guardan la información, registros, campos, tipos de datos, índices, etc.
* **Nivel conceptual**: Define cuales son los datos que están almacenados en la BD y qué **relaciones** existen entre ellos. La BD tendrá un **esquema conceptual** que describe las tablas, campos, relaciones, etc. En este nivel **no se tiene en cuenta la organización física ni los métodos de acceso a los ficheros**.
* **Nivel de vista**: Es el nivel más cercano al usuario. Define cómo ve el usuario la información almacenada en la BD. La BD tendrá uno o, los más habitual, varios **esquemas externos** que describe las vistas que tiene cada usuario de la BD.

### Tipos de bases de datos

#### Según el modelo de datos

##### Base de datos relacionales

Son las bases de datos tradicionales. Utilizan tablas para representar los datos y sus **relaciones**.

Ejemplos de bases de datos relacionales son **MySQL**, **PostgreSQL**, **Oracle**, **SQL Server**, etc.

##### Bases de datos NoSQL (Not Only SQL)

Son más modernas y flexibles que las relacionales. No utilizan tablas, sino que almacenan los datos en **documentos** (MongoDB), **columnas** (Cassandra), **gráficos** o **clave-valor** (CouchDB).

Son las bases de datos más populares en el campo de **Big Data** donde se manejan grandes volúmenes de datos no estructurados.

#### Según la localización de los datos

##### Bases de datos centralizadas

Los datos se encuentran en un único servidor.

##### Bases de datos distribuidas

Los datos se encuentran en varios servidores conectados en red. Son más escalables y tolerantes a fallos.

Como ejemplos podemos citar Google Spanner, Amazon DynamoDB, Cassandra, etc.

##### Bases de datos en la nube

Almacenan los datos en servidores remotos a los que se accede a través de Internet. Son muy utilizadas en aplicaciones web y móviles.

Algunos ejemplos son **Amazon RDS**, **Google Cloud SQL**, **Microsoft Azure SQL Database**, etc.

## Sistemas gestores de bases de datos

### Definición de SGDB

En SGBD es un **conjunto de programas** que permiten **definir**, **crear** y **manipular** una base de datos. Entre sus funciones se encuentran:

* Creación, actualización y borrado de datos.
* Mantenimiento de la integridad y seguridad de los datos.
* Gestión de transacciones y concurrencia.

### Componentes de un SGBD

#### Gestor de la BD

Es el conjunto de programas que se encargan de garantizar la privacidad, seguridad, integridad y acceso concurrente a los datos.

El gestor proporciona una interfaz entre:

* Los datos almacenados.
* Los programas que manejan esos datos.
* Los usuarios que acceden a los datos.

Cualquier operación sobre la BD se realiza a través del gestor de la BD.

#### Diccionario de datos

Consiste en **una o más BD** donde se almacena la descripción de los datos.

Debe contener todo lo que cualquier usuario pueda quere saber sobre la BD, como por ejemplo:

* Los nombres de las bases de datos almacenadas y sus objetos (esquemas, tablas, vistas, usuarios, etc.).
* Las restricciones sobre los datos.
* Las descripciones de los inicios de sesión.
* Las autorizaciones de los usuarios de cada BD.

#### Administrador de la BD

Se trata de la **persona o grupo** responsable de la seguridad y el control de los datos. Tiene el control centralizado de los datos y de los programas que pueden acceder a ellos. El administrador usa el gestor para realizar estas tareas.

#### Lenguajes

El SGBD ha de proporcionar lenguajes para definir y manipular los datos almacenados en la BD. Dichos lenguajes los usaran los administradores y los usuarios.

Los lenguajes del gestor son los siguientes:

* Lenguaje de definición de datos (DDL *Data Definition Language*) y permite:
  * Crear los objetos de la BD.
  * Modificar la estructura de los objetos.
  * Borrar los objetos.
* Lenguaje de manipulación de datos (DML *Data Manipulation Language*) y permite:
  * Insertar datos.
  * Modificar datos.
  * Borrar datos.
  * Consultar datos.
* Lenguaje de control de datos (DCL *Data Control Language*) y se usa para controlar el acceso a los datos, definiendo privilegios y permisos. De esta tarea se encargan los administradores (DBA).
* Lenguaje de procesamiento de transacciones (TPL *Transaction Processing Language*) y se usa para controlar el *acceso concurrente* a los datos.

Los lenguajes de las BBDD tienen una gramática sencilla y fácil de entender por los usuarios no expertos.

Los SGBD pueden procesas peticiones en DDL, DML o DCT formuladas en programas escritos en diversos lenguajes de programación como C, PHP, Java, Python, etc.

## *Big Data*, análisis de datos e inteligencia de negocio

El conjunto de tecnologías que denominamos **Big Data** es gestionar y analizar grandes volúmenes de datos, que no pueden ser tratados con las tecnologías tradicionales de bases de datos. Su objetivo es extraer conocimiento de esos datos para:

* Tomar decisiones más informadas y basadas en datos.
* Identificar tendencias y patrones de mercado para ajustar las estrategias de negocio.
* Mejorar la eficiencia y la productividad de la empresa.
* Personalizar productos y servicios para los clientes.

En el entorno actual, cada vez más competitivo y globalizado, las empresas necesitan ser capaces de gestionar y analizar grandes volúmenes de datos para poder competir en el mercado.

### *BIG DATA*

Cuando hablamos de *Big Data* estamos haciendo referencia a que estos sistemas trabajan con colecciones **extremadamente grandes** de datos de gran complejidad. Además del tamaño de los datos los resultados de su análisis han de ser rápidos, a veces en tiempo real. Esto es imposible o muy difícil de lograr utilizando sistemas de BBDD tradicionales.

Para lograr lo anteriormente expuesto los sistemas de *Big Data* han de ser capaces de:

* **Volumen:** Gestionar grandes volúmenes de datos que pueden provenir de fuentes diversas: redes sociales, sensores, dispositivos de IoT, transacciones comerciales, etc.
* **Velocidad:** Procesar esos datos de manera **rápida** y **eficiente**.
* **Variedad:** El hecho de que los datos procedan de fuentes heterogéneas hace que estos puedan tener formatos diversos. La información puede obtenerse como datos estructurados, semi-estructurados o no estructurados. Incluyendo estos últimos, datos de texto, imágenes, audio, vídeo, etc.

### Tecnologías y herramientas de Big Data

* **Hadoop:** Este un *framework* de software, de código abierto, permite el procesamiento distribuido de grandes volúmenes de datos en *clusters* de ordenadores. Es una de las tecnologías más utilizadas en el campo del *Big Data*.
* **Spark:** Es un sistema de computación en memoria que permite el procesamiento de datos en tiempo real. Es muy utilizado en aplicaciones de análisis de datos y *machine learning*.
* **NoSQL:** Las bases de datos NoSQL son una alternativa a las bases de datos relacionales que permiten almacenar y gestionar grandes volúmenes de datos **no estructurados**. MongoDB, Cassandra, CouchDB, son ejemplos de bases de datos NoSQL.
* **Kafka:** Es una plataforma de *streaming* distribuido que permite la publicación y suscripción a *streams* de datos en tiempo real.

### Análisis de datos

El análisis de datos es el proceso de inspeccionar, limpiar, transformar y modelar datos con el objetivo de descubrir información útil, llegar a conclusiones y apoyar la toma de decisiones.

#### Herramientas de análisis de datos

Para el análisis de datos se utilizarán distintas técnicas estadísticas y de inteligencia artificial. Algunas de las herramientas más utilizadas son:

* **Python**: Este lenguaje de programación dispone de librerías de análisis de datos muy eficientes como Pandas, NumPy, Matplotlib, etc.
* **Julia**: Es un lenguaje de programación de alto nivel, orientado al cálculo científico y al análisis de datos. Su velocidad de ejecución es comparable a la de C.
* **R**: Es un lenguaje de programación y entorno de software para análisis estadístico y gráfico. Es muy utilizado en el ámbito de la investigación y la ciencia de datos.
* **Tableau**: Es una herramienta de visualización de datos que permite crear gráficos interactivos y *dashboards*.

El mundo del *Big Data* y el análisis de datos es un campo en constante evolución en el que se están desarrollando continuamente nuevas tecnologías y herramientas para gestionar y analizar grandes volúmenes de datos.

### Inteligencia de negocio (BI)

El término **inteligencia de negocio** (*Business Intelligence*, BI) se refiere al uso de tecnologías, aplicaciones y prácticas para la recopilación, integración, análisis y presentación de la información empresarial. El objetivo de la inteligencia de negocio es ayudar a las empresas a tomar decisiones más informadas y basadas en datos. Incluye la creatión de *dashboards*, informe y la realización de análisis predictivos.

#### Herramientas de BI

Tablaeu, Power BI, QlikView, MicroStrategy, son algunas de las herramientas más utilizadas en el campo de la inteligencia de negocio. Estas herramientas permiten a las empresas visualizar y analizar sus datos de manera sencilla y eficiente, facilitando la toma de decisiones y la identificación de tendencias y patrones de mercado.

## Otros sistemas de almacenamiento de información

### Formatos de almacenamiento de datos

#### XML

XLM (*eXtensible Markup Language*) es un lenguaje de marcado que permite almacenar datos de manera jerárquica. Es muy utilizado en la web para intercambiar información entre aplicaciones.

#### JSON

JSON (*JavaScript Object Notation*) es un formato de intercambio de datos ligero y fácil de leer. Es muy utilizado en aplicaciones web y APIs para transmitir datos entre el servidor y el cliente. Su sintaxis es más compacta que la de XML y es más fácil de leer y escribir.

### Servicio de directorio

Un **servicio de directorio** es una o más aplicaciones que almacenan y organizan la información sobre los objetos de una red, como usuarios, grupos, impresoras, etc. Los servicios de directorio permiten a los usuarios buscar y acceder a la información de manera rápida y eficiente.

Ejemplos de servicios de directorio son:

* Open LDAP.
* Microsoft Active Directory.
* Apple Open Directory.
