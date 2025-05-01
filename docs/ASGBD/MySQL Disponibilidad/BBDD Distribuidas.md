# Bases de datos distribuidas

En este documento veremos como crear bases de datos distribuidas entre varios servidores MySQL. Se seguirán los ejemplos creados por el profesor Emiliano Gómez Vázquez en su curso de ASGBD.

La única variación consistirá en que, en lugar de utilizar máquinas virtuales MS. Windows 10, utilizaremos máquinas virtuales Linux (Ubuntu Server 24.04) en VirtualBox.

Otro cambio será que, en lugar de utilizar una _red NAT_ para interconectar las máquinas virtuales, utilizaremos dos interfaces de red (o adaptadores) para cada máquina virtual. El primero será el que viene configurado por defecto en VirtualBox, _NAT_ que nos permitirá tener conexión a Internet desde las máquinas virtuales. El segundo adaptador será de tipo _host-only_ (_solo-anfitrión_) y permitirá que las máquinas virtuales se _vean entre sí y vean al anfitrión_. Des este modo tendremos acceso a Internet y podremos conectarnos a las máquinas virtuales desde el anfitrión y entre ellas.

## Configuración de la red

### Configuración de las máquinas virtuales

Una vez creada cada máquina virtual (y antes de iniciar el sistema operativo), se ha de configurar la red de cada máquina virtual.

### Configuración de red (VirtualBox)

En VirtualBox, seleccionamos la máquina virtual y vamos a `Configuración` -> `Red`. Ahí podremos ver varias pestañas, una por cada adaptador de red. En la primera interfaz de red (adaptador 1) lo dejaremos como está (`NAT`) para que la máquina tenga acceso a Internet. En la segunda interfaz de red (adaptador 2) seleccionaremos `Adaptador de solo-anfitrión`.

### Configuración del sistema operativo

El siguiente paso de configuración se realizará durante la instalación del sistema operativo.

#### Configuración de la red (Ubuntu Server)

Durante la instalación de [Ubuntu Server 24.04](https://ubuntu.com/download/server), cuando lleguemos a la pantalla `Network configuration`, veremos dos interfaces de red llamados `enp0s3` y `4np0s8`. La primera será la interfaz NAT y no hemos de modificarla. La segunda será la interfaz conectada a la red _host-only_ y tendrá un valor asignado por el servidor DHCP de VirtualBox. En nuestro ejemplo, la IP asignada es `192.168.56.101`. Hemos de apuntar esta IP o bien poner la nuestra propia dentro de dicho segmento de red (192.168.56.0/24).

#### Configuración de SSH

Configurando el servicio SSH podremos conectarnos a la máquina virtual desde un terminal de la máquina anfitrión, lo que nos facilitará la realización de los siguientes pasos de configuración.

Cuando lleguemos a la pantalla de instalación con el título `SSH configuration` simplemente hemos de seleccionar `Instalar servidor OpenSSH` para que podamos conectarnos a la máquina virtual por SSH.

## Configuración de MySQL

### Conexión a la máquina virtual

Una vez finalizada la instalación de Ubuntu Server y reiniciada la máquina virtual, nos conectamos a ella por SSH desde el anfitrión con el siguiente comando:

```powershell
ssh usuario@192.168.56.101
```

**Substituyendo `usuario` por el nombre de usuario que hayamos puesto durante la instalación y la dirección IP por la que hayamos asignado a la máquina virtual.**

### Instalación de MySQL

Una vez conectados a la máquina virtual (vía SSH o desde la propia máquina) hemos de instalar el servidor MySQL. Para ello, primero actualizaremos los paquetes con los comandos:

```bash
sudo apt update
sudo apt upgrade
```

Una vez finalizada la actualización instalaremos el servidor MySQL con el siguiente comando:

```bash
sudo apt install mysql-server
```

### Configuración del Servidor MySQL

En este punto ya tenemos instalado y en funcionamiento una servidor MySQL. Por defecto este servidor **sólo acepta conexiones locales**. Esto significa que no podremos conectarnos a él desde el anfitrión o desde otras máquinas virtuales.

A continuación hemos de editar los archivos de configuración de MySQL. Estos archivos se encuentran en la ruta `/etc/mysql/mysql.conf.d/mysqld.cnf`.

Para editar el archivo podemos utilizar el editor de texto `nano` o `vim`.

#### Permitir conexiones remotas

Una vez conectados a la máquina virtual mediante SSH hemos de editar el archivo `/etc/mysql/mysql.conf.d/mysqld.cnf` para que MySQL acepte conexiones remotas. Para ellos hemos de modificar las siguientes líneas y cambiarlas de:

```text
bind-address        = 127.0.0.1
mysqlx-bind-address = 127.0.0.1
```

A:

```text
bind-address        = 127.0.0.1,192.168.56.101
mysqlx-bind-address = 127.0.0.1,192.168.56.101
```

En lugar de la dirección `192.168.56.101` hemos de poner la dirección IP de la máquina virtual que hemos asignado a la interfaz de red `enp0s8` (la segunda interfaz).

**Nota: Si hemos olvidado la dirección IP de la máquina virtual, podemos consultarla con el comando `hostname -I` que nos mostrará todas las direcciones IP asignadas a la máquina virtual.**

```bash
$ hostname -I
10.0.2.15 192.168.56.110 fd17:625c:f037:2:a00:27ff:fef7:f8f3
```

La dirección que nos interesa es la segunda: `192.168.56.101`. La primera es la de la red NAT y la tercera es la dirección IPv6.

Una vez realizado cualquier cambio en la configuración del servidor MySQL, hemos de reiniciar el servicio para que los cambios surtan efecto. Para ello, utilizamos el siguiente comando:

```bash
sudo systemctl restart mysql.service
```

**¿Qué hemos hecho?**

Los cambios que hemos realizado en la configuración del servidor tendrán las siguientes consecuencias:

* La primera línea: `bind-address=127.0.0.1,192.168.56.101` indica al servidor MySQL que acepte conexiones locales (`127.0.0.1` o interfaz de _loopback_) y _escuche_ también en la interfaz de red con dirección IP `192.168.56.101` (`enp0s8`) para que podemos conectarnos a ella desde el anfitrión (con MySQL Workbench por ejemplo) o desde otras máquinas virtuales.
* La segunda línea `mysqlx-bind-address=127.0.0.1,192.168.56.101` indica al servidor MySQL lo mismo que en el caso anterior pero para conexiones de la aplicación [MySQL Shell](https://dev.mysql.com/doc/mysql-shell/8.0/en/) que podemos descargar en [este enlace](<https://dev.mysql.com/downloads/shell/>) o instalar mediante `winget` con el comando de powershell:

```powershell
winget install Oracle.MySQLShell
```

[MySQL Shell]() es una aplicación de línea de comandos que nos permitirá ejecutar scripts, escribir sentencias SQL, etc. en cualquier servidor NMySQL. No es imprescindible para la práctica pero nos hará la vida más fácil a la hora de realizar consultas y operaciones en el servidor MySQL.

### Creación de usuario administrador de MySQL

Aunque ya hemos configurado el servidor MySQL para que acepte conexiones remotas, aún no podremos conectarnos al mismo de manera remota. Esto se debe a que no disponemos de ningún usuario que se pueda conectar en remoto.

Para solventar esto, hemos de conectarnos a la máquina virtual Linux y crear un usuario con los privilegios necesarios siguiendo los siguientes pasos:

1. Nos conectamos a la máquina virtual con el siguiente comando: `ssh usuario@192.168.56.101`.
2. Accedemos a la consola de MySQL con el siguiente comando: `sudo mysql`.

Una vez dentro de la consola de MySQL como administradores procedemos a escribir la sentencia SQL para crear el usuario:

```SQL
CREATE USER 'admin'@'%' IDENTIFIED BY '123abc..';
```

Y la sentencia para asignarle privilegios:

```SQL
GRANT ALL PRIVILEGES ON *.* TO 'admin'@' WITH GRANT OPTION;
```

Ahora el usuario `admin` podrá conectarse al servidor de manera remota (`%`) y además tendrá todos los privilegios sobre todas las bases de datos (`*.*`) y podrá asignar privilegios a otros usuarios (`WITH GRANT OPTION`).
**Estos cambios han de realizarse en todos los servidores que utilicemos en estas prácticas cambiando únicamente las direcciones IP para adecuarlas a la de cada servidor.**
  
### Comprobar la configuración

Para asegurarnos de que, una vez instaladas las máquinas virtuales (siguiendo las instrucciones previas), todo funciona correctamente hemos de realizar las siguientes pruebas:

#### Comprobar visibilidad entre máquinas virtuales

Antes de continuar sería conveniente comprobar que las máquinas virtuales se ven entre sí y que el anfitrión puede verlas. También sería interesante asegurarnos de que podemos establecer conexiones SSH.

##### Comprobar conexión SSH

Después comprobaremos que podemos acceder mediante SSH a las máquinas virtuales. Para ello, desde un terminal del anfitrión como [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701?hl=es-ES&gl=ES), utilizando preferiblemente Powershell, hemos de escribir el siguiente comando:

```powershell
ssh usuario@192.168.56.101
```

De nuevo Substituyendo `usuario` por el nombre de usuario que hayamos puesto durante la instalación y `192.168.56.101` por la IP de la máquina virtual que hayamos asignado a la interfaz de red `enp0s8`.

Nos pedirá la contraseña del usuario que hayamos puesto durante la instalación de Ubuntu Server. Si todo ha ido bien, deberíamos ver algo como esto:

```bash
> ssh manuel@192.168.56.102
manuel@192.168.56.102's password:
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

##### Visibilidad enter los equipos

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

No haremos la comprobación desde la máquina virtual al anfitrión porque, dependiendo de la configuración del firewall de Windows este podría rechazar el paquete de _ping_ y no sería un error de la máquina virtual y todo funcionaría correctamente.

Hemos de comprobar también que las máquinas virtuales se ven entre sí. Para ello, desde la sesión de SSH de la máquina de IP `192.168.56.101` haremos ping a la máquina `192.168.56.102` y, si todo va bien, deberíamos ver algo como esto:

```powershell
ssh usuario@192.168.56.101
```

Una vez dentro de la máquina virtual, haremos un `ping` a la otra máquina virtual:

```bash
ping 192.168.56.102
PING 192.168.56.102 (192.168.56.102) 56(84) bytes of data.
64 bytes from 192.168.56.102: icmp_seq=1 ttl=64 time=0.207 ms
64 bytes from 192.168.56.102: icmp_seq=2 ttl=64 time=0.816 ms
64 bytes from 192.168.56.102: icmp_seq=3 ttl=64 time=0.333 ms
64 bytes from 192.168.56.102: icmp_seq=4 ttl=64 time=0.388 ms
^C
--- 192.168.56.102 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3124ms
rtt min/avg/max/mdev = 0.207/0.436/0.816/0.228 ms
```

Como podemos ver, la máquina `192.168.56.102` responde a los paquetes de _ping_ enviados desde la máquina `192.168.56.101` y todo estaría funcionando correctamente.

Una vez comprobado el correcto funcionamiento de las máquinas virtuales, hemos de proceder a la configuración del servidor MySQL.

```bash
sudo apt install mysql-server
```

## Caso 1: Replicación de bases de datos _maestro-esclavo_ (_source-replica_)

Para realizar esta práctica hemos de utilizar dos máquinas virtuales con MySQL. En este caso, una de las máquinas será el _maestro_ y la otra será el _esclavo_. En MySQL y por motivos culturales se está cambiando los nombres de _master_ y _slave_ (maestro, esclavo) por `source` y `replica` (fuente y réplica). Si a lo largo del documento utilizamos fuente y réplica se entiende que se corresponden con los de maestro y esclavo respectivamente.

De ahora en adelante diremos que la IP del maestro será la `192.168.56.101` y la del esclavo será la `192.168.56.102`. En el caso de cada alumno estos valores pueden variar como se indicó en la sección anterior. Por lo tanto, en cada caso hemos de sustituir las direcciones IP por las que correspondan a cada máquina virtual.

### Objetivo

Si realizamos este ejemplo de manera correcta, lo que lograremos es que los cambios que realicemos en una base de datos específica del servidor _maestro_ (`test_replicacion`) se replicarán automáticamente en el servidor _esclavo_. Para lograr esto, como de costumbre, tendremos que realizar una serie de pasos tanto en el servidor maestro como en el esclavo.

### Configuración del maestro

Como hemos dicho elegiremos como _maestro_ al servidor de IP `192.168.56.101` y hemos de modificar la configuración de MySQL editando de nuevo el fichero `/etc/mysql/mysql.conf.d/mysqld.cnf`. Para editar este fichero des la línea de comandos podremos utilizar los editores `Nano` o `vim` como administradores:

```bash
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

O bien:

```bash
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
```

Las líneas que hemos de modificar se encuentran en la línea 70 del fichero _(con vim saltaremos a la linea escribiendo `:70` y con nano lo haremos con la combinación de teclas `Ctrl + /` y escribiendo el número de línea al que queremos ir.)_. En cualquier caso nos encontraremos con un bloque de texto similar al siguiente:

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

Las líneas que comienzan con `#` son comentarios y no se ejecutan. Para activar estas líneas hemos de eliminar el símbolo `#` del principio de cada línea. En nuestro caso, las líneas que hemos de descomentar son:

```text
# Activar el log binario para la replicación
server-id = 1
# La ruta del log binario
log_bin = /var/log/mysql/mysql-bin.log
# La base de datos que se replicará
binlog_do_db = test_replicacion
```

**¿Qué hemos hecho?**

Los valores que hemos modificado indicarán al servidor MySQL lo siguiente:

* `server-id = 1`: Este parámetro le asigna un identificador único al servidor maestro o _source_. Este valor ha de ser único en el conjunto de servidores. En este caso le asignamos el valor `1`. Al servidor esclavo le asignaremos el valor `2`. _Los valores concretos son irrelevantes, lo importante es que no se repitan._
* `log_bin = /var/log/mysql/mysql-bin.log`: Este parámetro le indica al servidor maestro que **guarde un log binario** en la ruta indicada. Este log binario contendrá todas las operaciones se que realizan en el servidor maestro y permitirá replicarlas en el esclavo. En este caso lo guardará en la ruta `/var/log/mysql/` con el nombre `mysql-bin.log`.
* `binlog_do_db = test_replicacion`: Este parámetro le indica al servidor maestro que sólo guarde en el log binario las operaciones sobre la base de datos indicada. En este caso hemos de poner el nombre de la base de datos que queramos replicar que será `test_replicacion` en el ejemplo.

**Si no indicamos una (o varias) base de datos con la opción `binlog_do_db`, se replicarán todas las bases de datos del servidor maestro. Es conveniente indicar únicamente las bases de datos que nos interesen tener replicadas en el esclavo.**

Una vez realizados estos cambios hemos de reiniciar los servidores MySQL con el comando:

```bash
manuel@mysqlc1:~$ sudo systemctl restart mysql.service
```

#### Obtención de la información del maestro

Necesitamos obtener un par de datos sobre el fichero de log binario que utilizaremos en la configuración del esclavo. Para ello, desde la consola de MySQL ejecutamos el siguiente comando:

```SQL
SHOW MASTER STATUS;
+------------------+----------+------------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB     | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+------------------+------------------+-------------------+
| mysql-bin.000001 |     5102 | test_replicacion |                  |                   |
+------------------+----------+------------------+------------------+-------------------+
1 row in set (0.0013 sec)
```

Los valores que nos interesan son:

* _File_: `mysql-bin.000001` (el nombre del fichero de log binario).
* _Position_: `5102` (la posición del log binario).

_El número de posición será distinto en cada caso y no ha de coincidir con el de este ejemplo._

#### Creación de usuario para la réplica

Finalmente hemos de crear un usuario en el maestro que utilizará el esclavo para conectarse a él y obtener la información necesaria para la replicación. Para ello, desde la consola de MySQL Shell (o MySQL Workbench) ejecutamos el siguiente comando:

```SQL
CREATE USER 'replicador'@'%'
```

### Configuración del esclavo

Para configurar el servidor esclavo hemos, en primer lugar, de modificar también el fichero de configuración `/etc/mysql/mysql.conf.d/mysqld.cnf`. En este caso la única línea que hemos de modificar será:

```text
server-id = 2
```

Estableciendo un número distinto al del maestro. En este caso le asignamos el valor `2`.

A continuación hemos de reiniciar el servidor MySQL de la máquina esclava para que los cambios surtan efecto:

```bash
sudo systemctl restart mysql.service
```

A continuación hemos de conectarnos a la consola de MySQL del servidor esclavo. Puesto que ya habríamos configurado el servidor para que acepte conexiones remotas y creado el usuario `'admin'@'%'` podremos conectarnos al servidor utilizando MySQL Workbench o desde la línea de comandos mediante MySQL Shell.

En nuestro ejemplo utilizaremos MySQL Shell. Para ello, desde la máquina anfitrión, abrimos una terminal y escribimos el siguiente comando:

```powershell
mysqlsh admin@192.168.56.102
```

Se nos pedirá la clave que hayamos introducido al crear el usuario `admin` y una vez dentro deberíamos de ver algo como esto:

```text
 MySQL  192.168.56.102:33060+ ssl  SQL >
```

Para activar este servidor como réplica (_slave_), en la consola de MySQL Shell, hemos de ejecutar el siguiente comando:

```SQL
CHANGE MASTER TO
MASTER_HOST='192.168.2.101',
MASTER_USER='replicador',
MASTER_PASSWORD='replica123',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=5102;
```
