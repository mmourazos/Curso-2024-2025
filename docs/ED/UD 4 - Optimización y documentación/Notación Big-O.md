# Notación Big-O

<!-- toc -->

- [¿Qué es la notación Big-O?](#qué-es-la-notación-big-o)
- [Forma de expresar la notación Big-O](#forma-de-expresar-la-notación-big-o)
- [Ejemplos](#ejemplos)
  - [Constante $O(1)$](#constante-o1)
  - [Lineal $O(n)$](#lineal-on)
  - [Cuadrático $O(n^2)$](#cuadrático-on2)

<!-- tocstop -->

## ¿Qué es la notación Big-O?

La notación Big-O es una forma de expresar la complejidad de un algoritmo. Representa la relación entre el tiempo que tarda en ejecutarse un algoritmo respecto al tamaño de la entrada.

Lo normal es que el tiempo que tarda un algoritmo crezca según lo hace el tamaño de la entrada. Este crecimiento puede ser lineal, cuadrático, logarítmico, exponencial, etc. La notación Big-O nos permite clasificar los algoritmos en función de cómo crece el tiempo de ejecución respecto al tamaño de la entrada.

## Forma de expresar la notación Big-O

La notación Big-O se expresa como:

| Crecimiento | notación x-y | Notación Big-O |
| ----------- | ------------- | -------------- |
| Constante | y = constante | O(1) |
| Lineal     | y = x          | O(n)           |
| Cuadrático  | y = x^2^        | O(n^2^)         |
| Logarítmico | y = log(n)      | O(log n)       |
| Exponencial | y         | O(2^n^)        |

## Ejemplos

### Constante $O(1)$

Un ejemplo de algoritmo de velocidad constante es de eliminar un elemento de un extremo de un array, o insertar o eliminar un elemento de una lista enlazada.

### Lineal $O(n)$

El algoritmo de búsqueda de un elemento en un array es lineal, ya que en el peor de los casos tendrá que recorrer todos los elementos del array.

```python
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

def buscar_elemento(arr, elemento):
    for i in range(len(arr)):
        if arr[i] == elemento:
            return i
    return -1
```

### Cuadrático $O(n^2)$

El ejemplo típico de algoritmos de complejidad cuadrática son aquellos que tiene bucles anidados. Aunque puede darse el caso de que un bucle anidado no sea siempre cuadrático.

```pytho
