# Soluciones Tarea 1 UD 5 - Consultas SQL

## Apartado 1

Crea un listado que incluya: **código, nombre, fecha de inscripción y cuota** de los concursantes masculinos con `cuota_inscri` entre 50 y 100 € (ambos inclusive), año de la `fecha_inscri` 2019 y mes entre marzo y septiembre (también incluidos). Utiliza las funciones `YEAR()` y `MONTH()` para realizar las comparaciones. Ordena el resultado de mayor a menor cuota. El encabezado debe ser "código, jugador, fecha, cuota".

Realiza dos versiones de la consulta:

* Sin usar el operador `BETWEEN`.

```SQL
SELECT cdconcur AS "código", nombre, fecha_inscri AS "fecha", cuota_inscri AS "cuota" FROM concursante
WHERE sexo = "M" AND cuota_inscri >= 50 AND cuota_inscri <= 100 AND YEAR(fecha_inscri) = 2019 AND MONTH(fecha_inscri) >= 3 AND MONTH(fecha_inscri) <= 9
ORDER BY cuota_inscri DESC;
```

* Usando el operador `BETWEEN`.

```SQL
SELECT cdconcur AS "código", nombre, fecha_inscri AS "fecha", cuota_inscri AS "cuota" FROM concursante
WHERE sexo = "M" AND cuota_inscri BETWEEN 50 AND 100 AND YEAR(fecha_inscri) = 2019 AND MONTH(fecha_inscri) BETWEEN 3 AND 9
ORDER BY cuota_inscri DESC;
```

Listado con el código, nombre, fecha de inscripción y cuota de los concursantes masculinos con cuota_inscri entre 50 y 100 euros (icluidos límites), año de inscripción 2019 y mes entre marzo y septiembre (incluidos). Utiliza la función year() y month() para ello. Ordena el resultado de mayor a menor cuota. El encabezado debe ser 'codigo, jugador, fecha, cuota.
Haz dos versiones:
a) Usando BETWEEN donde sea posible  b) Sin usar BETWEEN..
