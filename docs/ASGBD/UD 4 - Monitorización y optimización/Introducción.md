# Monitorización y optimización

<!-- toc -->

- [Herramientas de monitorización](#herramientas-de-monitorizacion)
  * [Trazas, logs y alertas](#trazas-logs-y-alertas)
    + [Trazas](#trazas)
    + [Logs](#logs)
      - [Tipos de logs](#tipos-de-logs)
      - [¿Cómo activar los logs en mySQL?](#%C2%BFcomo-activar-los-logs-en-mysql)

<!-- tocstop -->

## Herramientas de monitorización

### Trazas, logs y alertas

#### Trazas

#### Logs

##### Tipos de logs

MySQL tienes diversos tipos de logs:

- _Error log_: Registra problemas al inicio, durante el funcionamiento y al cierre del servidor.
- _General query log_: Registra todas las consultas y conexiones al servidor.
- _Binary log_: Registra todas las modificaciones en la base de datos. Es útil para la replicación y recuperación de datos.
- _Relay log_: Registra las modificaciones de datos recibidas desde un servidor de replicación.
- _Slow query log_: Registra las consultas que tardan más de un tiempo determinado (variable `long_query_time`) en ejecutarse.

##### ¿Cómo activar los logs en mySQL?

1. Localizar el fichero de configuración de mySQL (my.cnf o my.ini)
2. Linux: el fichero se encuentra en /etc/my.cnf o /etc/mysql/my.cnf.
3. Windows: el fichero se encuentra en la carpeta de instalación de mySQL.

```txt
# * Logging and Replication
#
# Both location gets rotated by the cronjob.
#
# Log all queries
# Be aware that this log type is a performance killer.
# general_log_file        = /var/log/mysql/query.log
# general_log             = 1
#
# Error log - should be very few entries.
#
log_error = /var/log/mysql/error.log
#
# Here you can see queries with especially long duration
# slow_query_log                = 1
# slow_query_log_file   = /var/log/mysql/mysql-slow.log
# long_query_time = 2
# log-queries-not-using-indexes
#
# The following can be used as easy to replay backup logs or for replication.
# note: if you are setting up a replication slave, see README.Debian about
#       other settings you may need to change.
# server-id             = 1
# log_bin                       = /var/log/mysql/mysql-bin.log
# binlog_expire_logs_seconds    = 2592000
max_binlog_size   = 100M
# binlog_do_db          = include_database_name
# binlog_ignore_db      = include_database_name
#### Alertas

### Parámetros a monitorizar
```
