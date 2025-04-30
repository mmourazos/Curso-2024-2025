# Bases de datos distribuidas

En este documento veremos como crear bases de datos distribuidas entre varios servidores MySQL. Se seguirán los ejemplos creados por el profesor Emiliano Gómez Vázquez en su curso de ASGBD.

La única variación consistirá en que, en lugar de utilizar máquinas virtuales MS. Windows 10, utilizaremos máquinas virtuales Linux (Ubuntu Server 24.04) en VirtualBox.

Otro cambio será que, en lugar de utilizar una red NAT para interconectar las máquinas virtuales, utilizaremos una red _host-only_ (_solo-anfitrión_) para que las máquinas puedan verse entre sí y se puedan ver desde el anfitrión. Para disponer además de acceso a Internet (para instalación de paquetes), se añadirá una segunda interfaz de red a cada máquina virtual, que estará conectada a la red NAT.

## Configuración de la red

### Configuración de las máquinas virtuales

Una vez creada cada máquina virtual (y antes de iniciar el sistema operativo), se ha de configurar la red de cada máquina virtual. Para ello, en VirtualBox, seleccionamos la máquina virtual y vamos a `Configuración` -> `Red`. Ahí podremos ver varias pestañas, una por cada interfaz de red. En la primera interfaz de red (adaptador 1) lo dejaremos como está (`NAT`) para que la máquina tenga acceso a Internet. En la segunda interfaz de red (adaptador 2) seleccionaremos `Adaptador de solo-anfitrión`.

### Configuración del sistema operativo

Durante la instalación de [Ubuntu Server 24.04](https://ubuntu.com/download/server), cuando lleguemos a la pantalla `Network configuration`, veremos dos interfaces de red llamados `enp0s3` y `4np0s8`. La primera será la interfaz NAT y no hemos de modificarla. La segunda será la interfaz conectada a la red _host-only_ y tendrá un valor asignado por el servidor DHCP de VirtualBox. En nuestro caso, la IP asignada es `192.168.56.106`. Hemos de apuntar esta IP o bien poner la nuestra propia dentro de dicho segmento de red (192.168.56.0/24).

Cuando lleguemos a la pestaña llamada `SSH configuración` hemos de seleccionar `Instalar servidor OpenSSH` para que podamos conectarnos a la máquina virtual por SSH.

## Configuración de MySQL

### Conexión a la máquina virtual

Una vez finalizada la instalación de Ubuntu Server, nos conectamos a la máquina virtual por SSH desde el anfitrión con el siguiente comando:

```powershell
ssh usuario@192.168.56.101
```

**Substituyendo `usuario` por el nombre de usuario que hayamos puesto durante la instalación y la dirección IP por la que hayamos asignado a la máquina virtual.**

### Instalación de MySQL

Una vez conectados a la máquina virtual hemos de instalar el servidor MySQL. Para ello, primero, actualizaremos los paquetes con los comandos:

```bash
sudo apt update
sudo apt upgrade
```

Una vez finalizados instalaremos el servidor MySQL con el siguiente comando:

```bash
sudo apt install mysql-server
```

### Configuración del Servidor MySQL

A continuación hemos de editar los archivos de configuración de MySQL. Estos archivos se encuentran en la ruta `/etc/mysql/mysql.conf.d/`. El que nos interesa es el archivo `mysqld.cnf`.

Para editar el archivo podemos utilizar el editor de texto `nano` o `vim`.

#### Permitir conexiones remotas

Para que MySQL acepte conexiones remotas hemos de editar el archivo `mysqld.cnf` y cambiar la línea:

```text
bind-address        = 127.0.0.1
mysqlx-bind-address = 127.0.0.1
```

por

```text
bind-address        = 127.0.0.1,192.168.56.101
mysqlx-bind-address = 127.0.0.1,192.168.56.101
```

En lugar de la dirección `192.168.56.101` hemos de poner la dirección IP de la máquina virtual que hemos asignado a la interfaz de red `enp0s8` (la segunda interfaz).

**Nota: Si hemos olvidado la dirección IP de la máquina virtual, podemos consultarla con el comando `hostname -I` que nos mostrará todas las direcciones IP asignadas a la máquina virtual.**

La primera línea `bind-address` indica al servidor MySQL que _escuche_ en la dirección IP `192.168.56.101` para que podemos conectarnos a ella desde el anfitrión (con MySQL Workbench por ejemplo) o desde otras máquinas virtuales.

La segunda línea `mysqlx-bind-address` indica al servidor MySQL que _escuche_ en la dirección IP `192.168.56.101` conexiones de la aplicación [MySQL Shell](https://dev.mysql.com/doc/mysql-shell/8.0/en/) que podemos descargar en [este enlace](<https://dev.mysql.com/downloads/shell/>) o instalar mediante `winget` con el comando de powershell:

```powershell
winget install Oracle.MySQLShell
```

**Estos cambios han de realizarse en todos los servidores que utilicemos en estas prácticas cambiando únicamente las direcciones IP para adecuarlas a la de cada servidor.**

## Caso 1: Replicación de bases de datos _maestro-esclavo_

Para realizar esta práctica hemos de utilizar dos máquinas virtuales con MySQL. En este caso, una de las máquinas será el _maestro_ y la otra será el _esclavo_.

De ahora en adelante diremos que la IP del maestro será la `192.168.56.101` y la del esclavo será la `192.168.56.102`. En el caso de cada alumno estos valores pueden variar como se indicó en la sección anterior. Por lo tanto, en cada caso hemos de sustituir las direcciones IP por las que correspondan a cada máquina virtual.

### Comprobar la configuración

Para asegurarnos de que, una vez instaladas las máquinas virtuales (siguiendo las instrucciones previas), todo funciona correctamente hemos de realizar las siguientes pruebas:

#### Comprobar visibilidad entre máquinas virtuales

Primero comprobaremos la conexión desde el anfitrión a las máquinas virtuales. Para ello, desde el anfitrión, hemos de hacer un `ping` a cada una de las máquinas virtuales. Por ejemplo:

```powershell
ping 192.168.56.101

Haciendo ping a 192.168.56.101 con 32 bytes de datos:
Respuesta desde 192.168.56.101: bytes=32 tiempo<1m TTL=64
Respuesta desde 192.168.56.101: bytes=32 tiempo<1m TTL=64

Estadísticas de ping para 192.168.56.101:
    Paquetes: enviados = 2, recibidos = 2, perdidos = 0
    (0% perdidos),
Tiempos aproximados de ida y vuelta en milisegundos:
    Mínimo = 0ms, Máximo = 0ms, Media = 0ms
Control-C
```

Después comprobaremos que podemos acceder mediante SSH a las máquinas virtuales. Para ello, desde el anfitrión, hemos de escribir el siguiente comando:

```powershell
ssh usuario@192.168.56.101
```

Nos pedirá la contraseña del usuario que hayamos puesto durante la instalación de Ubuntu Server. Si todo ha ido bien, deberíamos ver algo como esto:

```bash
 ssh manuel@192.168.56.104
manuel@192.168.56.104's password:
Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-58-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of mié 30 abr 2025 17:52:05 UTC

  System load:  0.0                Processes:               135
  Usage of /:   44.2% of 11.21GB   Users logged in:         1
  Memory usage: 31%                IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%

 (...)
```

Finalmente comprobaremos que las máquinas virtuales se ven entre sí. Para ello, desde la sesión de SSH de la máquina de IP `192.168.56.101` haremos ping a la máquina `192.168.56.102` y, si todo ba bien, deberíamos ver algo como esto:

```bash
ping 192.168.56.104
PING 192.168.56.104 (192.168.56.104) 56(84) bytes of data.
64 bytes from 192.168.56.104: icmp_seq=1 ttl=64 time=0.207 ms
64 bytes from 192.168.56.104: icmp_seq=2 ttl=64 time=0.816 ms
64 bytes from 192.168.56.104: icmp_seq=3 ttl=64 time=0.333 ms
64 bytes from 192.168.56.104: icmp_seq=4 ttl=64 time=0.388 ms
^C
--- 192.168.56.104 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3124ms
rtt min/avg/max/mdev = 0.207/0.436/0.816/0.228 ms
```

Una vez comprobado el correcto funcionamiento de las máquinas virtuales, hemos de proceder a la configuración del servidor MySQL.

```bash
sudo apt install mysql-server
```

### Configuración del maestro

Como hemos dicho elegiremos como _maestro_ al servidor de IP `192.168.56.101` y hemos de modificar la configuración de MySQL editando el fichero `/etc/mysql/mysql.conf.d/mysqld.cnf` en el que modificaremos un par de líneas a partir de la número 70:

```text
# The following can be used as easy to replay backup logs or for replication.
# note: if you are setting up a replication slave, see README.Debian about
#       other settings you may need to change.
# server-id             = 1
# log_bin                       = /var/log/mysql/mysql-bin.log
# binlog_expire_logs_seconds    = 2592000
max_binlog_size   = 100M
# binlog_do_db          = include_database_name
# binlog_ignore_db      = include_database_name
```

Las líneas que hemos de descomentar son:

```text
# Activar el log binario para la replicación
server-id = 1
# La ruta del log binario
log_bin = /var/log/mysql/mysql-bin.log
# La base de datos que se replicará
binlog_do_db = nombre_base_datos
```

Los valores que hemos modificado indicarán al servidor MySQL lo siguiente:

* `server-id = 1`: Este parámetro le asigna un identificador único al servidor maestro. Este valor ha de ser único en el conjunto de servidores. En este caso le asignamos el valor `1`. Al servidor esclavo le asignaremos el valor `2`. Los valores concretos son irrelevantes, lo importante es que no se repitan.
* `log_bin = /var/log/mysql/mysql-bin.log`: Este parámetro le indica al servidor maestro que **guarde un log binario** en la ruta indicada. Este log binario contendrá todas las operaciones se que realizan en el servidor maestro y permitirá replicarlas en el esclavo. En este caso lo guardaremos en la ruta `/var/log/mysql/` con el nombre `mysql-bin.log`.
* `binlog_do_db = nombre_base_datos`: Este parámetro le indica al servidor maestro que sólo guarde en el log binario las operaciones sobre la base de datos indicada. En este caso hemos de poner el nombre de la base de datos que queramos replicar.

**Si no indicamos una (o varias) base de datos con la opción `binlog_do_db`, se replicarán todas las bases de datos del servidor maestro. Es conveniente indicar únicamente las bases de datos que nos interesen tener replicadas en el esclavo.**

Una vez realizados estos cambios hemos de reiniciar los servidores MySQL con el comando:

```bash
manuel@mysqlc1:~$ sudo systemctl restart mysql.service
```
