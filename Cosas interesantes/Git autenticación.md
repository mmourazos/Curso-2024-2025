# ¿Cómo autenticarse en Git?

## ¿Cuántas formas hay de autenticarse en Git?

Hay tres formas principales de autenticarse en Git:

1. Username and password with two-factor authentication, or a passkey
2. Personal access token
3. SSH key

1. Usando un token personal o contraseña.
2. Usando una clave SSH.
3. Usar el password de GitHub con 2-factor authentication (2FA).

## Autenticarse en el navegador

Desde marzo de 2023, GitHub recomienda encarecidamente que se habilite una o más formas de autenticación de dos factores.

### Más de una cuenta en GitHub

Si necesitamos tener más de una cuenta en GitHub (cuenta personal y cuenta del trabajo por ejemplo), podemos alternar entre ellas de la siguiente forma:

### Usuario y contraseña

Cuando creamos una cuenta en GitHub 

### Autenticación de dos factores

### _Passkey_

### SAML single sign-on


Con los dos primeros puedes autenticarte sin necesidad de incluir un usuario y contraseña. Para ver cómo está configurado un **repositorio** podemos ejecutar el comando `git config -l` en dicho directorio.

En adelante `ACCOUNT` se refiere a la cuenta de GitHub y `REPO` al repositorio.

### Usando HTTPS con un token personal o una contraseña

La forma estándar de interactuar con un repositorio (remoto) es mediante HTTPS. Para clonar un repositorio usando HTTPS de la siguiente forma:

```powershell
git clone https://github.com/ACCOUNT/REPO
```

Se te pedirá tu usuario y contraseña (la siguiente puede ser tu clave personal de GitHub o un token personal de autenticación).
