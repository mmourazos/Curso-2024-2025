# Resultados tarea UD5 - Consultas

## Apartado 1

```text
+--------+--------------+------------+-------+
| código | nombre       | fecha      | cuota |
+--------+--------------+------------+-------+
| B99    | Carlos Rojo  | 2019-08-12 |   100 |
| A14    | Manuel Verde | 2019-05-01 |    65 |
+--------+--------------+------------+-------+
```

## Apartado 2

```text
+--------+--------------+-----------+------------------+
| código | nombre       | comunidad | año de fundación |
+--------+--------------+-----------+------------------+
| 05     | Atenea       | Galicia   |             2019 |
| 02     | Los rebeldes | Murcia    |             2019 |
+--------+--------------+-----------+------------------+
```

## Apartado 3

```text
+--------+--------------------+------------+---------+
| código | nombre             | dificultad | megusta |
+--------+--------------------+------------+---------+
| GW2    | Guild Wars 2.      | baja       |       5 |
| LOL    | League of Legends. | media      |       5 |
| VIK    | Vikings            | media      |       5 |
+--------+--------------------+------------+---------+
```

## Apartado 4

```text
+---------+-----------------+------------+---------+----------+--------------------+
| cdjuego | nombre          | dificultad | megusta | cdequipo | equipo organizador |
+---------+-----------------+------------+---------+----------+--------------------+
| GOE     | Goodgame Empire | alta       |    NULL | 01       | La marmota         |
| MUO     |  MU online      | alta       |    NULL | 04       | Aries              |
+---------+-----------------+------------+---------+----------+--------------------+
```

## Apartado 5

```text
+-----------------+------------+---------+------------------+
| nombre          | dificultad | megusta | código de equipo |
+-----------------+------------+---------+------------------+
| Elvenar         | baja       |       3 | 01               |
| Goodgame Empire | alta       |    NULL | 01               |
| Guild Wars 2.   | baja       |       5 | 01               |
| Vikings         | media      |       5 | 01               |
+-----------------+------------+---------+------------------+
```

## Apartado 6

```text
+-----------------+------------+---------+------------------+---------------+-----------+
| nombre          | dificultad | megusta | código de equipo | nombre equipo | comunidad |
+-----------------+------------+---------+------------------+---------------+-----------+
| Elvenar         | baja       |       3 | 01               | La marmota    | Andalucía |
| Goodgame Empire | alta       |    NULL | 01               | La marmota    | Andalucía |
| Guild Wars 2.   | baja       |       5 | 01               | La marmota    | Andalucía |
| Vikings         | media      |       5 | 01               | La marmota    | Andalucía |
+-----------------+------------+---------+------------------+---------------+-----------+
```

## Apartado 7

```text
+--------+----------------+-----------------+-----------------+--------+
| código | nombre         | código de juego | fecha de inicio | puntos |
+--------+----------------+-----------------+-----------------+--------+
| A14    | Manuel Verde   | VIK             | 2019-05-10      |     25 |
| A14    | Manuel Verde   | FOE             | 2019-03-15      |     35 |
| A22    | Benita Naranja | HAB             | 2019-06-15      |     30 |
| A22    | Benita Naranja | VIK             | 2019-04-15      |     25 |
| A33    | Ismael Rojo    | MUO             | 2019-03-25      |     40 |
| B99    | Carlos Rojo    | FOE             | 2019-09-15      |     10 |
| B99    | Carlos Rojo    | LOL             | 2019-01-15      |     60 |
| C01    | Juan Amarillo  | MUO             | 2019-03-15      |     50 |
| C01    | Juan Amarillo  | VIK             | 2019-04-15      |     25 |
| C01    | Juan Amarillo  | CON             | 2019-02-15      |     60 |
| C02    | Marta Rosa     | CON             | 2019-02-15      |     60 |
| C02    | Marta Rosa     | FOE             | 2019-02-15      |     60 |
| C03    | Alvaro Rojo    | GOE             | 2019-05-10      |     20 |
| C03    | Alvaro Rojo    | GW2             | 2019-02-10      |     20 |
| C04    | Eva Verde      | HAB             | 2019-03-25      |    200 |
| C88    | Javier Blanco  | LOL             | 2019-01-25      |     54 |
| C88    | Javier Blanco  | WOW             | 2019-05-15      |     45 |
+--------+----------------+-----------------+-----------------+--------+
```

## Apartado 8

```text
+--------+-----------------+--------------+---------------------+-----------------------+
| código | n. concursante  | n. equipo    | n. juego            | IFNULL(p.puntos, "0") |
+--------+-----------------+--------------+---------------------+-----------------------+
| A10    | Elena Blanco    | Aries        | sin juego           | 0                     |
| A13    | Javier Marrón   | Atenea       | sin juego           | 0                     |
| A14    | Manuel Verde    | La marmota   | Forge of Empires    | 35                    |
| A14    | Manuel Verde    | La marmota   | Vikings             | 25                    |
| A22    | Benita Naranja  | Aries        | HABBO Hotel         | 30                    |
| A22    | Benita Naranja  | Aries        | Vikings             | 25                    |
| A33    | Ismael Rojo     | La marmota   |  MU online          | 40                    |
| A44    | Elvira Blanco   | Los rebeldes | sin juego           | 0                     |
| B12    | Pedro Azul      | Atenea       | sin juego           | 0                     |
| B22    | Marta Violeta   | La marmota   | sin juego           | 0                     |
| B66    | Sara Verde      | Los rebeldes | sin juego           | 0                     |
| B99    | Carlos Rojo     | Amadeus      | Forge of Empires    | 10                    |
| B99    | Carlos Rojo     | Amadeus      | League of Legends.  | 60                    |
| C01    | Juan Amarillo   | La marmota   | Conflict of Nations | 60                    |
| C01    | Juan Amarillo   | La marmota   |  MU online          | 50                    |
| C01    | Juan Amarillo   | La marmota   | Vikings             | 25                    |
| C02    | Marta Rosa      | La marmota   | Conflict of Nations | 60                    |
| C02    | Marta Rosa      | La marmota   | Forge of Empires    | 60                    |
| C03    | Alvaro Rojo     | La marmota   | Goodgame Empire     | 20                    |
| C03    | Alvaro Rojo     | La marmota   | Guild Wars 2.       | 20                    |
| C04    | Eva Verde       | Los rebeldes | HABBO Hotel         | 200                   |
| C05    | Manolo Amarillo | Los rebeldes | sin juego           | 0                     |
| C88    | Javier Blanco   | Amadeus      | League of Legends.  | 54                    |
| C88    | Javier Blanco   | Amadeus      | World of Warcraft   | 45                    |
| X01    | Isabel Cruz     | NULL         | sin juego           | 0                     |
| X02    | Antonio Bernal  | NULL         | sin juego           | 0                     |
| X03    | Andrés Rojas    | NULL         | sin juego           | 0                     |
+--------+-----------------+--------------+---------------------+-----------------------+
```

## Apartado 9

```text
+--------+----------------+--------------+
| código | nombre         | media puntos |
+--------+----------------+--------------+
| C04    | Eva Verde      |       200.00 |
| C02    | Marta Rosa     |        60.00 |
| C88    | Javier Blanco  |        49.50 |
| C01    | Juan Amarillo  |        45.00 |
| A33    | Ismael Rojo    |        40.00 |
| B99    | Carlos Rojo    |        35.00 |
| A14    | Manuel Verde   |        30.00 |
| A22    | Benita Naranja |        27.50 |
| C03    | Alvaro Rojo    |        20.00 |
+--------+----------------+--------------+
```

## Apartado 10

```text
+-----------------+---------------+--------------+-----------+----------------+
| cd. concursante | nombre        | media puntos | cd. ídolo | nombre ídolo  |
+-----------------+---------------+--------------+-----------+----------------+
| C04             | Eva Verde     |       200.00 | A44       | Elvira Blanco  |
| C02             | Marta Rosa    |        60.00 | A33       | Ismael Rojo    |
| C88             | Javier Blanco |        49.50 | B99       | Carlos Rojo    |
| C01             | Juan Amarillo |        45.00 | A33       | Ismael Rojo    |
| A33             | Ismael Rojo   |        40.00 | A22       | Benita Naranja |
+-----------------+---------------+--------------+-----------+----------------+
```

## Apartado 11

```text
+------------------+---------+------------+------------------------+
| nombre           | megusta | dificultad | número de concursantes |
+------------------+---------+------------+------------------------+
| Forge of Empires |       4 | alta       |                      3 |
| Goodgame Empire  |    NULL | alta       |                      1 |
+------------------+---------+------------+------------------------+
```

## Apartado 12

```text
+--------+--------------+
| código | concursantes |
+--------+--------------+
| FOE    |            3 |
| VIK    |            3 |
| CON    |            2 |
| HAB    |            2 |
| LOL    |            2 |
| MUO    |            2 |
+--------+--------------+
```
