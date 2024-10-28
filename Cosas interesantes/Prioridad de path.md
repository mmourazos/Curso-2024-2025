# Modificar la prioridad de PATH en Windows

En un equipo Windows hay dos variables de entorno: las de usuario y las del sistema. La primera afecta solo al usuario que la tiene configurada, mientras que la segunda afecta a todos los usuarios del sistema.

Si existe una variable de usuario y una del sistema con el mismo nombre, la variable del sistema tiene prioridad.

Esto es un problema con aplicaciones instaladas mediante `scoop` que están además instaladas (otra versión) en el sistema Windows (por parte de los administradores del sistema).

Para solucionarlo se puede modificar el profile de la consola (PowerShell, CMD, etc.). Para hacerlo en PowerShell hay que modificar el archivo `$PROFILE` (`\\sarela\profes$\mourazos\Mis documentos\PowerShell\Microsoft.PowerShell_profile.ps1`) y añadir la siguiente línea:

```powershell
$env:PATH = [Environment]::GetEnvironmentVariable("Path", "User") + ';' + [Environment]::GetEnvironmentVariable("Path", "Machine")
```
```
