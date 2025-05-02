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

### Creación instancias vía MySQL Shell

```mysql
 MySQL  192.168.56.110:3306 ssl  JS > dba.configureInstance();
Configuring MySQL instance at mysql-cluster-01:3306 for use in an InnoDB Cluster...

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
