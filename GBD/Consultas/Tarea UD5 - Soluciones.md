# Soluciones Tarea 1 UD 5 - Consultas SQL

## Apartado 1

Crea un listado que incluya: **código, nombre, fecha de inscripción y cuota** de los concursantes masculinos con `cuota_inscri` entre 50 y 100 € (ambos inclusive), año de la `fecha_inscri` 2019 y mes entre marzo y septiembre (también incluidos). Utiliza las funciones `YEAR()` y `MONTH()` para realizar las comparaciones. Ordena el resultado de mayor a menor cuota. El encabezado debe ser "código, jugador, fecha, cuota".

Realiza dos versiones de la consulta:

* Sin usar el operador `BETWEEN`.
* Usando el operador `BETWEEN`.

### Sin `BETWEEN`

```SQL
SELECT cdconcur AS "código", nombre, fecha_inscri AS "fecha", cuota_inscri AS "cuota" FROM concursante
WHERE sexo = "H" AND cuota_inscri >= 50 AND cuota_inscri <= 100 AND YEAR(fecha_inscri) = 2019 AND MONTH(fecha_inscri) >= 3 AND MONTH(fecha_inscri) <= 9
ORDER BY cuota_inscri DESC;
```

### Con `BETWEEN`

```SQL
SELECT cdconcur AS "código", nombre, fecha_inscri AS "fecha", cuota_inscri AS "cuota" FROM concursante
WHERE sexo = "M" AND cuota_inscri BETWEEN 50 AND 100 AND YEAR(fecha_inscri) = 2019 AND MONTH(fecha_inscri) BETWEEN 3 AND 9
ORDER BY cuota_inscri DESC;
```

## Apartado 2

Devuelve un listado con el código, nombre, comunidad y año de fundación de los equipos de concursantes que son de Andalucía, Murcia o Galicia y su año de fundación es el 2019. Ordena por comunidad alfabéticamente.

Redacta dos versiones:

* Usando el operador "IN()" donde sea posible.
* Sin usa "IN()".

### Sin usar `IN()`

```SQL
SELECT cdequipo AS "código", nombre, comunidad, anio_funda AS "año fundación"
WHERE anio_funda = 2019 AND
  (comunidad = "Andalucía" OR comunidad = "Murcia" OR comunidad = "Galicia");
```

### Usando `IN()`

```SQL
SELECT cdequipo AS "código", nombre, comunidad, anio_funda AS "año fundación" FROM equipo
WHERE anio_funda = 2019 AND
  (comunidad IN ("Andalucía", "Murcia", "Galicia"));
```

## Apartado 3

Primero deberemos obtener una consulta que nos devuelva el número de `megusta` máximo de la tabla `juego`.

```SQL
SELECT MAX(megusta) FROM juego;
```

Otra forma sería:

```SQL
SELECT megusta FROM juego ORDER BY megusta DESC LIMIT 1;
```

Incorporando esta consulta como subconsulta en la consulta principal, obtendremos un listado con código, nombre, dificultad y megusta de los juegos con más `megusta`:

```SQL
SELECT cdjuego AS "código", nombre, dificultad, megusta FROM juego WHERE megusta = (SELECT MAX(megusta) FROM juego);
```

## Apartado 4

Obtén un listado de todos los juegos cuyo valor de `megusta` **no es nulo**. Incluye también el nombre del **equipo** que organiza dicho juego.

```SLQ
SELECT *, e.nombre AS "equipo organizador" FROM juego AS j, equipo AS e WHERE j.megusta IS NOT null AND j.cdequipo = e.cdequipo;
```

## Apartado 5

Mostrar los nombres, dificultad, _megusta_ y código de equipo de los juegos organizados por el equipo que ha organizado el juego de nombre `Elvenar`.

```SQL
SELECT nombre, dificultad, megusta, cdequipo AS "código de equipo" FROM juego WHERE cdequipo = (SELECT cdequipo FROM juego WHERE nombre = "Elvenar");
```

## Apartado 6

Haz que la consulta anterior muestre también el **nombre del equipo y la comunidad a la que pertenece**.

```SQL
SELECT j.nombre, dificultad, megusta, j.cdequipo AS "código de equipo", e.nombre AS "nombre equipo", comunidad FROM juego AS j, equipo AS e WHERE j.cdequipo = e.cdequipo AND j.cdequipo = (SELECT cdequipo FROM juego WHERE nombre = "Elvenar");
```

## Apartado 7

Mostrar el código, nombre del concursante, código de juego, fecha de inicio y puntos. Ordenar por código de concursante.

```SQL
SELECT c.cdconcur AS "código", c.nombre, p.cdjuego AS "código de juego", p.fecha_inicio AS "fecha de inicio", p.puntos FROM concursante, partida WHERE c.cdconcur = p.cdconcur ORDER BY c.cdconcur; 
```

## Apartado 8

Muestra el código y nombre del concursante, el nombre de su equipos y nombre de los juegos en los que participa y sus puntos. Los concursantes que no participan también aparecerán mostrando "sin juego" y en puntos un cero.

Una primera aproximación sería la siguiente instrucción:

```SQL
SELECT c.cdconcur AS "código", c.nombre AS "n. concursante", e.nombre AS "n. equipo", j.nombre AS "n. juego", p.puntos FROM concursante AS c LEFT OUTER JOIN participa AS p ON c.cdconcur = p.cdconcur LEFT OUTER JOIN equipo AS e ON c.cdequipo = e.cdequipo LEFT OUTER JOIN juego AS j ON p.cdjuego = j.cdjuego;
```

Donde hemos de usar `LEFT OUTER JOIN` para que no se _ignoren_ los valores de `concursante.cdcondur` que no hagan _match_ con los de `participa.cdconcur`.
Para _renombrar_ los valores nulos hemos de utilizar la _función_ `IFNULL()` a la que se le pasa el nombre del campo y el texto que queremos que se muestre cuando su valor sea `null`.

```SQL
SELECT c.cdconcur AS "código", c.nombre AS "n. concursante", e.nombre AS "n. equipo", IFNULL(j.nombre, "sin juego") AS "n. juego", IFNULL(p.puntos, "0") FROM concursante AS c LEFT OUTER JOIN participa AS p ON c.cdconcur = p.cdconcur LEFT OUTER JOIN equipo AS e ON c.cdequipo = e.cdequipo LEFT OUTER JOIN juego AS j ON p.cdjuego = j.cdjuego;
```

## Apartado 9

Mostrar el código de concursante, nombre y la media de puntos (en los juegos en los que ha participado). Se ha de redondear la media mostrando dos decimales y ordenar de mayor a menor número de puntos.

```SQL
SELECT c.cdcondur AS "código", c.nombre, ROUND(AVG(p.puntos), 2) AS "media puntos" FROM concursante AS c, participa AS p WHERE c.cdconcur = p.cdconcur GROUP BY c.cdconcur ORDER BY "media puntos" DESC;
```

## Apartado 10

Modifica la consulta anterior para que se muestre también el código y nombre del ídolo de cada concursante. Limita el resultado a los 5 concursantes con mayor media.

```SQL
SELECT c.cdcondur AS "código", c.nombre, ROUND(AVG(p.puntos), 2) AS "media puntos" FROM concursante AS c, concursante, participa AS p WHERE c.cdconcur = p.cdconcur GROUP BY c.cdconcur ORDER BY "media puntos" DESC;
```
