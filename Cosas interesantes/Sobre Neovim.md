# Cosas de Neovim

## Markdown

### Markdown-preview

Markdown-preview casi siempre me termina dando problemas. Para asegurarnos de que se instale hemos de:

1. Ir al directorio de instalación `$env:LOCALAPPDATA/nvim-data/lazy/markdown-preview.nvim/app/`.
2. Dentro de dicho directorio ejecutar el siguiente comando:

   ```bash
   yarn install
   ```

### Linting

Para hacer linting de los archivos de Markdown lazyvim utiliza `markdownlint-cli2`. Por defecto avisa de las línes que exceden los 80 caracteres. Para cambiarlo hay que modificar el archivo `.markdownlint-cli2.json` que se encuentra en el directorio del usuario. El código que hemos de escribir para desactivar dicho aviso será:

```json
{
  "config": {
    "line-length": false
  }
}
```

### Substitución de texto (buscar y reemplazar)

Para substituir texto en un archivo pasaremos al modo comando y escribiremos:

```vim
%s/antiguo/nuevo/g
```

* `%` Indica que el **rango** sobre el que realizamos la sustitución es todo el archivo.
* `<linea_inicio>,<linea_fin>%s/antiguo/nuevo/g` Indica que el **rango** sobre el que realizamos la sustitución es de la línea `linea_inicio` a la línea `linea_fin`.

Pero hay atajos para indicar la linea en la que estamos `.` y para indicar la última línea del archivo `$`. Para indicar la primera línea del archivo no hay atajo, pero podemos escribir `1`.

Si queremos indicar que queremos hacer el reemplazo en las 10 líneas siguientes a la línea en la que estamos, podemos escribir `.,+10`; para indicar las 2 líneas anteriores escribiríamos `.,-2`, etc.
