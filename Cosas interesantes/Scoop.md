# Notas sobre Scoop

## Instalación de aplicaciones

Cada vez que se instala una aplicación nueva Scoop **no borra** la versión anterior, sino que la mantiene en una carpeta aparte. Esto permite tener varias versiones de una misma aplicación instaladas y cambiar entre ellas fácilmente. Para *limpiar* las versiones antiguas y liberar espacio en disco, se puede usar el comando:

```powershell
scoop cleanup
```
