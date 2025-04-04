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
