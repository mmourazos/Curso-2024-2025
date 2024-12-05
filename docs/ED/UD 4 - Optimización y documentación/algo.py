arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

def buscar_elemento(arr, elemento):
    for i in range(len(arr)):
        if arr[i] == elemento:
            return i
    return -1

print(buscar_elemento(arr, 5))
