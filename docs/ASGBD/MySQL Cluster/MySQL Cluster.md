# MySQL Cluster

En este documento exploraremos cómo crear y configurar un clúster básico MySQL InnoDB Cluster utilizando MySQL Shell. Un clúster de MySQL InnoDB es un conjunto de instancias de MySQL que trabajan juntas para proporcionar alta disponibilidad y escalabilidad. En este ejemplo, crearemos un clúster con tres nodos: un nodo de administración y dos nodos de datos.

Este ejemplo se realizará utilizando Docker para crear los nodos de MySQL. Asegúrate de tener Docker instalado y en funcionamiento en tu máquina.

## Cluster con máquinas virtuales

### Cambiar direcciones IP

Para cambiar direcciones IP después de la instalación de Ubuntu Server tendremos que editar el archivo `/etc/netplan/50-cloud-init.yaml` y modificar el interfaz que nos interese (`enp0s8`).

Las direcciones IP que se utilizarán serán las siguientes:

* Nodo administrador _mysql-cluster-01_ : `192.168.56.101`.
* Nodo 1 del cluster _mysql-cluster-02_: `192.168.56.110`.
* Nodo 2 del cluster _mysql-cluster-03_: `192.168.56.120`.
* Nodo 3 del cluster _mysql-cluster-04_: `192.168.56.130`.

La configuración de las máquinas virtuales será idéntica:

* Adaptador 1: NAT (valor por defecto).
* Adaptador 2: Solo anfitrión (Host-only). Si no lo cambiamos la dirección de red será `192.168.56.0/24`.

### Instalación de MySQL Shell en el nodo administrador

Aclaremos primero dos puntos para que los siguientes pasos tengan sentido:

* **¿Por qué no instalamos MySQL Shell?:** Necesitamos instalar MySQL Shell porque es la herramienta que utilizaremos para crear y administrar el clúster de MySQL InnoDB. MySQL Shell soporta tres _modos_ de funcionamiento: SQL, JavaScript y Python. En este caso, utilizaremos el modo JavaScript para crear el clúster.
* **Ok ¿Por qué no instalamos la versión de los repositorios de Ubuntu?:** La versión de los repositorios de Ubuntu **no soporta JavaScript**. Es por ese motivo que hemos de instalar la versión de los repositorios de MySQL APT. La versión de los repositorios de MySQL APT soporta JavaScript y es la recomendada para trabajar con MySQL InnoDB Cluster.

Para instalar MySQL Shell (lo necesitaremos para crear el cluster) en el nodo administrador, hemos de realizar los siguientes pasos:

* Descargar el paquete de configuración de [MySQL APT](https://dev.mysql.com/get/mysql-apt-config_0.8.34-1_all.deb): `wget https://dev.mysql.com/get/mysql-apt-config_0.8.34-1_all.deb`.
* Instalar el paquete de configuración: `sudo apt install ./mysql-apt-config_0.8.34-1_all.deb`.
* Actualizar la lista de paquetes de los nuevos repositorios: `sudo apt update`.
* Instalar MySQL Shell: `sudo apt install mysql-shell`.

En este punto disponemos de una versión de MySQL Shell que sporta JavaScript y que nos permitirá crear el clúster de MySQL InnoDB.

### Creación instancias vía MySQL Shell

Para crear una instancia de MySQL InnoDB Cluster hemos de disponer de un servidor MySQL en funcionamiento. Podremos crear una máquina virtual con un servidor MySQL como hemos visto a lo largo de este curso.

Una vez dispongamos de una máquina virtual con MySQL podremos conectarnos a ella utilizando MySQL Shell desde la máquina administrador. Para ello, hemos de utilizar el siguiente comando:

```bash
mysqlsh admin@192.168.56.102 --js
```

La opción `--js` indica que queremos utilizar el modo JavaScript de MySQL Shell.

Obviamente hemos de disponer de un usuario `'admin'@'%'` con los privilegios necesarios (la creación de un usuario `'admin'@'%'` con privilegios de superusuario se ha visto en prácticas previas).

La IP que hemos puesto habrá que adecuarla a nuestro caso concreto.

#### Creación de los usuarios del cluster

Tres tipos de usuarios:

* Una cuenta de configuración del Cluster InnoDB que se usará para configurar las instancias de los servidores cluster.
* Una o más cuentas de administración del Cluster InnoDB para los administradores que se encargarán de la gestión de las instancias del servidor cluster una vez creado.
* Una o más cuentas de MySQL Router para que las instancias de MySQL Router puedan conectarse al cluster.

Todas estas cuentas deben de existir en todos los servidores miembros del cluster con el mismo nombre de usuario y contraseña.

##### Cuenta de configuración del servidor del Cluster InnoDB

Esta cuenta se utilizará para crear y configurar los servidores miembros del cluster. Cada servidor miembro tendrá sólo una cuenta de configuración. Deberá de utilizarse el mismo nombre de usuario y contraseña en cada servidor.

Por motivos de seguridad se recomienda esta cuenta de configuración utilizando un comando `dba.configureInstance()` con la opción `clusterAdmin`. Si se especifica la contraseña de forma interactiva, no es necesario especificar la opción `clusterAdminPassword`. La cuenta de configuración del servidor del cluster InnoDB ha de crearse en cada servidor que se va a añadir al cluster, tanto en el servidor al que nos conectamos para crear el cluster como en los servidores que se añaden posteriormente.

El comando `dba.configureInstance()` confiere automáticamente los permisos necesarios para realizar la configuración del cluster. Si por el contrario deseamos crear de manera manual esta cuenta deberemos seguir los pasos indicados en [Configuración manual de las cuentas de administración del cluster](https://dev.mysql.com/doc/mysql-shell/8.0/en/innodb-cluster-user-accounts.html#admin-api-configuring-users).

**Nota: Como se indicó antes hay que crear la misma cuenta en cada servidor. Contrariamente a lo que podría parecer, el comando `dba.configureInstance()` no se replica en todos los nodos del cluster. Hemos de repetir el proceso a mano para cada uno.**

##### Cuentas de administrador del Cluster InnoDB

Estas cuentas se pueden usar para administrar un cluster InnoDB después de haber completado el proceso de configuración. Se puede configurar más de una cuenta de administrador. Cada cuenta debe existir en cada servidor miembro del cluster InnoDB con el mismo nombre de usuario y contraseña.

Para crear una cuenta de administrador del cluster InnoDB, se puede usar el comando `dba.createAdminAccount()` después de haber añadido todas las instancias al cluster. Este comando crea una cuenta de administrador con el nombre de usuario y la contraseña que se especifiquen, y le otorga todos los privilegios necesarios. El comando `dba.createAdminAccount()` será escrito al _log binario_ por lo que se replica en todos los nodos del cluster creando, de este modo, la cuenta también en ellos.

##### Cuenta(s) de MySQL Router

Estas cuentas serán empleadas por el Router MySQL para conectarse a las instancias del cluster. Cada cuenta debe existir en cada miembro, como siempre, con el mismo usuario y contraseña. El procedimiento para crear una cuenta de MySQL Router es el mismo que para una cuenta de administrador del cluster InnoDB, pero utilizando el comando `cluster.setupRouterAccount()`. Para instrucciones sobre cómo crear o actualizar una cuenta de MySQL Router, ver [Configuración de la cuenta de usuario de MySQL Router](https://dev.mysql.com/doc/mysql-shell/8.0/en/configuring-router-user.html).

These accounts are used by MySQL Router to connect to server instances in an InnoDB Cluster. You can set up more than one of them. Each account must exist on every member server in an InnoDB Cluster with the same user name and password. The process to create a MySQL Router account is the same as for an InnoDB Cluster administrator account, but using a cluster.setupRouterAccount() command. For instructions to create or upgrade a MySQL Router account, see Section 6.10.2, “Configuring the MySQL Router User”.

Para crear una instancia de MySQL InnoDB Cluster hemos de utilizar el siguiente comando:

```javascript
dba.createCluster();
```

```mysql
 MySQL  192.168.56.110:3306 ssl  JS > dba.configureInstance();
Configuring MySQL instance at mysql-cluster-01:3306 for use in an InnoDB Cluster...
                                    s
This instance reports its own address as mysql-cluster-01:3306
Clients and other cluster members will communicate with it through this address by default. If this is not correct, the report_host MySQL system variable should be changed.

applierWorkerThreads will be set to the default value of 4.

NOTE: Some configuration options need to be fixed:
+----------------------------------------+---------------+----------------+--------------------------------------------------+
| Variable                               | Current Value | Required Value | Note                                             |
+----------------------------------------+---------------+----------------+--------------------------------------------------+
| binlog_transaction_dependency_tracking | COMMIT_ORDER  | WRITESET       | Update the server variable                       |
| enforce_gtid_consistency               | OFF           | ON             | Update read-only variable and restart the server |
| gtid_mode                              | OFF           | ON             | Update read-only variable and restart the server |
| server_id                              | 1             | <unique ID>    | Update read-only variable and restart the server |
+----------------------------------------+---------------+----------------+--------------------------------------------------+

Some variables need to be changed, but cannot be done dynamically on the server.
```

## Cluster con imágenes Docker

La imagen de Docker utilizada en este ejemplo es `mysql/mysql-server:8.0`, que es la imagen oficial de MySQL Server 8.0. Puedes encontrar más información sobre esta imagen en el [Docker Hub](https://hub.docker.com/r/mysql/mysql-server).

## Instalación de Docker

La forma más fácil de instalar Docker es utilizando [Docker Desktop]().

## Creación de los Nodos de MySQL

Necesitaremos un total de 4 contenedores de Docker: un nodo de administración y tres nodos de datos. Para crear estos contenedores, utilizaremos el siguiente comando:
