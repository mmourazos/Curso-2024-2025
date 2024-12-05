# Lanzar programas

¿Cómo lanzar aplicaciones en Windows con variables de entorno que sólo les afecten a ellas?

El comando de PowerShell que podemos utilizar es `Start-Process`:

```powershell
Start-Process nvim -ArgumentList $args -WorkingDirectory $PWD -Environment @{NVIM_APPNAME='nvim/nvim-lazy'} -NoNewWindow -Wait
```
