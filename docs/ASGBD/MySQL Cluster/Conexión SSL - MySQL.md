# Conexiones Seguras SSL - MySQL

<!-- toc -->

- [Conexión desde los clientes](#conexion-desde-los-clientes)
- [Copiar ficheros de certificados y claves del cliente](#copiar-ficheros-de-certificados-y-claves-del-cliente)
    * [Copia en Linux](#copia-en-linux)
    * [Copia en Windows](#copia-en-windows)
- [Conexión con MySQL Shell](#conexion-con-mysql-shell)
- [Creación manual de los certificados y claves](#creacion-manual-de-los-certificados-y-claves)
    * [Linux](#linux)
    * [Windows](#windows)

<!-- tocstop -->

Para poder utilizar conexiones seguras MySQL necesita disponer de ciertos ficheros de certificados y claves para establecer conexiones cifradas ([SSL](https://es.wikipedia.org/wiki/Seguridad_de_la_capa_de_transporte)). Cuando arranca un servidor MySQL que se ha compilado con la opción de OpenSSL (la versiones por defecto para Ubuntu y Windows la incluyen)  éste comprobará si existen los ficheros de certificados y claves **dentro del directorio de datos** y, si no es así, generará el mismo estos ficheros automáticamente.

Los directorios de datos de MySQL son:

- En Linux: `/var/lib/mysql`.
- En Windows: `%PROGRAMDATA%\MySQL\MySQL Server 8.0\Data`. La el valor por defecto de la variable de entorno `%PROGRAMDATA%` normalmente es `C:\ProgramData`.

En este caso, los ficheros generados son los siguientes:

- `ca.pem`: Certificado de la autoridad de certificación (CA).
- `ca-key.pem`: Clave privada de la autoridad de certificación (CA).
- `client-cert.pem`: Certificado del cliente.
- `client-key.pem`: Clave privada del cliente.
- `server-cert.pem`: Certificado del servidor.
- `server-key.pem`: Clave privada del servidor.
- `private_key.pem`: Clave privada del servidor (encriptada).
- `public_key.pem`: Clave pública del servidor.

Estos certificados son _autofirmados_, lo que no es demasiado seguro. Lo ideal sería usar un certificado firmado por una autoridad de certificación (CA) de confianza. En este caso, el cliente y el servidor deben tener el certificado de la CA para poder establecer la conexión segura.

En el fichero de configuración del servidor MySQL (en Linux: `/etc/mysql/my.cnf` o `/etc/mysql/mysql.conf.d/mysld.cnf`; en Windows `C:\ProgramData\MySQL\MySQL Server 8.0\my.ini`) se pueden especificar los ficheros de certificados y claves a usar.

```text
# Identifica el certificado de la entidad certificadora (CA).
ssl-ca=ca.pem
# Indetifica el certificado de clave pública.
ssl-cert=server-cert.pem
# Indetifica la clave privada del servidor.
ssl-key=server-key.pem
```

A continuación podemos especificar también el protocolo a usar en la conexión cifrada. En este caso, el protocolo TLSv1.2. Para ello, añadimos la siguiente línea al fichero de configuración:

```text
tls_version=TLSv1.2
```

El protocolo TLSv1.2 es más seguro que las versiones anteriores y es el recomendado para conexiones seguras.

Una vez realizados estos cambios debemos reiniciar el servidor MySQL para que los cambios surtan efecto.

En Ubuntu Linux:

```bash
sudo systemctl restart mysql.service
```

Podremos comprobar el estado del servicio con:

```bash
sudo systemctl status mysql.service
```

En Windows (en una terminal de PowerShell con permisos de administrador):

```powershell
sc stop mysql80
sc start mysql80
```

Podremos comprobar su estado con:

```powershell
sc query mysql80
```

## Conexión desde los clientes

Los certificados y claves del cliente se generan en el mismo directorio que los del servidor (`/var/lib/mysql` o `%PROGRAMDATA%\MySQL\MySQL Server 8.0\Data`). Este directorio sólo es accesible por el usuario de sistema `mysql` (en Linux) que es el que ejecuta el servidor MySQL por lo que los cientes, en principio, no tendrán acceso a estos ficheros. Para que los clientes puedan acceder a estos ficheros hemos de, o bien distribuirlos a los equipos de los distintos clientes, o bin colocarlos en una partición accesible para los mismos. En cualquier caso deben de guardarse en un directorio que sea leíble (pero no escribible) por el cliente. Además, es recomendable usar un canal seguro para distribuir los ficheros y asegurarse de que no han sido manipulados durante el tránsito (como por ejemplo, un canal SSH).

## Copiar ficheros de certificados y claves del cliente

Por simplicidad, en lugar de la opción de montar un partición compartida hemos decidido distribuir los ficheros al cliente. Para ello hemos de copiarlos a un directorio accesible por el cliente. En este caso, los ficheros se copiarán al directorio `/mysql/ssl` del cliente.

Los ficheros de certificados y claves del cliente son:

- `ca.pem`: Certificado de la autoridad de certificación (CA), común a servidor y cliente.
- `client-cert.pem`: Certificado del cliente.
- `client-key.pem`: Clave privada del cliente.

Para copiarlos de forma segura podemos utilizar el comando `scp` de la siguiente forma:

### Copia en Linux

Esto hemos de hacerlo desde el host donde se encuentran los archivos de certificados y claves del cliente. Estos archivos se encuentran en el servidor MySQL que los ha generado (`192.168.56.101`).

**Desde el server:**

```bash
sudo su -
# De ahora en adelante estamos en una shell de root.
mkdir -p /mysql/ssl
scp manuel@192.168.56.101:/var/lib/mysql/ca.pem /mysql/ssl
scp manuel@192.168.56.101:/var/lib/mysql/client-cert.pem /mysql/ssl
scp manuel@192.168.56.101:/var/lib/mysql/client-key.pem /mysql/ssl
# Ahora cambiamos los permisos del directorio para que no se puedan modificar.
chmod a+r-w /mysql/ssl
### Instalar
```

### Copia en Windows

Desde windows se puede utilizar el mismo comando `scp` pero es necesario tener instalado el cliente SSH. En este caso, se puede usar el cliente de OpenSSH que viene incluido en Windows 10 y versiones posteriores.

## Conexión con MySQL Shell

Para realizar la conexión segura con el servidor MySQL desde el cliente, utilizaremos el cliente de línea de comandos `mysqlsh` (MySQL Shell). Este cliente es una herramienta avanzada que permite interactuar con MySQL de forma más eficiente que el cliente de línea de comandos tradicional.

Hemos de utilizar las opciones de mysqlsh para especificar los ficheros de certificados y claves a usar. Para ello, utilizaremos las opciones `--ssl-ca`, `--ssl-cert` y `--ssl-key` de la siguiente forma (suponiendo que hemos copiado los ficheros a `/mysql/ssl`):

```bash
mysqlsh 'admin'a@'192.168.56.1 23' --ssl-ca=/mysql/ssl/ca.pem --ssl-cert=/mysql/ssl/client-cert.pem --ssl-key=/mysql/ssl/client-key.pem
```

O en windows:

```powershell
mysqlsh 'admin'a@'192.168.56.1 23' --ssl-ca=c:/mysql/ssl/ca.pem --ssl-cert=c:/mysql/ssl/client-cert.pem --ssl-key=c:/mysql/ssl/client-key.pem
```

## Creación manual de los certificados y claves

En la documentación oficial de MySQL se explica como crear los certificados y claves manualmente en el siguiente enlace: [8.3.3.2 Creating SSL Certificates and Keys Using openssl](https://dev.mysql.com/doc/refman/8.4/en/creating-ssl-files-using-openssl.html#creating-ssl-files-using-openssl-unix-command-line).

En dicha página encontramos la secuencia de comandos para generar los archivos necesarios en Linux. Los incluyo aquí para facilitar su consulta:

### Linux

```bash
# Create clean environment
rm -rf newcerts
mkdir newcerts && cd newcerts

# Create CA certificate
openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 3600 \
        -key ca-key.pem -out ca.pem

# Create server certificate, remove passphrase, and sign it
# server-cert.pem = public key, server-key.pem = private key
openssl req -newkey rsa:2048 -days 3600 \
        -nodes -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
openssl x509 -req -in server-req.pem -days 3600 \
        -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# Create client certificate, remove passphrase, and sign it
# client-cert.pem = public key, client-key.pem = private key
openssl req -newkey rsa:2048 -days 3600 \
        -nodes -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
openssl x509 -req -in client-req.pem -days 3600 \
        -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem
```

Los certificados y claves se generarán en el directorio `newcerts`. A continuación habría que moverlos al directorio de datos del servidor MySQL (`/var/lib/mysql`)m y cambiar los permisos para que sólo el usuario `mysql` pueda acceder a ellos, moverlos a otra ruta e indicarla en las opciones `ssl-ca`, `ssl-cert` y `ssl-key` del archivo de configuración del servidor MySQL (`/etc/mysql/my.cnf` o `/etc/mysql/mysql.conf.d/mysqld.cnf`).

Suponiendo que hayamos guardado los archivos en `/mysql/certs/` deberíamos añadir las siguientes líneas en el archivo de configuración del servidor MySQL:

```text
ssl-ca=/mysql/cets/ca.pem
ssl-cert=/mysql/certs/server-cert.pem
ssl-key=/mysql/certs/server-key.pem
```

Si los hemos copiado a `/var/lib/mysql` no es necesario especificar la ruta completa, sólo el nombre del archivo.

```text
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
```

### Windows

Hemos de instalar OpenSSL en Windows. Para ello, podemos descargar el instalador de OpenSSL desde la página oficial de [Shining Light Productions](https://slproweb.com/products/Win32OpenSSL.htm) o bien usar el instalador de windows `winget install ShiningLight.OpenSSL.Ligh`.

Una vez instalado OpenSSL hemos de añadir la ruta al `path` del sistema o acceder directamente al ejecutable `C:\Program Files\OpenSSL-Win64\bin\openssl.exe`.

Finalmente podemos abrir una terminal de PowerShell y ejecutar los siguientes comandos para crear los certificados y claves:

```powershell
# Create clean environment
rm -r -fo newcerts
mkdir newcerts
cd newcerts

# Create CA certificate
openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem

# Create server certificate, remove passphrase, and sign it
# server-cert.pem = public key, server-key.pem = private key
openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
openssl x509 -req -in server-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# Create client certificate, remove passphrase, and sign it
# client-cert.pem = public key, client-key.pem = private key
openssl req -newkey rsa:2048 -days 3600 -nodes -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
openssl x509 -req -in client-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem
```
