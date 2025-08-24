# Sobre la configuración de PowerShell

El archivo de configuración de PowerShell es un archivo con extensión `.json`: `powershell.config.json`. Este archivo se encuentra en la ruta indicada por la variable de entorno `$PROFILE`, por lo que para obtener el directorio podemos usar el comando `Split-Path -Parent $PROFILE`.

La ruta suele ser la carpeta `Documents\PowerShell` dentro de la carpeta del usuario.
