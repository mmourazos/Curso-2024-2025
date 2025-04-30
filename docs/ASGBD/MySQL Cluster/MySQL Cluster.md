# MySQL Cluster

Como crear un cluster MySQL en un servidor Linux (Ubuntu Server 22.04) con 3 nodos (1 nodo de gestión y 2 nodos de datos).

Crearemos tres máquinas virtuales en MySQL:

* Nombre: `mysqlc1`, `mysqlc2` y `mysqlc3`.
* IPs: `192.168.56.104`, `192.168.56.105` y `192.168.56.106`.

Hemos de utilizar MySQL Shell para crear y configurar el cluster:

Lo instalamos ne la máquina windows (anfitrión) usando [Scoop](https://scoop.sh): `scoop install mysql-shell`.

Hemos de instalar también MySQL Router, que es un proxy para MySQL Cluster. Lo instalamos en la máquina `mysqlc1` (nodo de gestión) con el siguiente comando:

```bash
# Descargamos el paquete de MySQL Router:
wget 
