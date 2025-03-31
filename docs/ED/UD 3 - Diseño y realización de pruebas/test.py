class Solution:
    # Complejidad en tiempo O(n)
    # Como máximo se recorre el array dos veces.
    # Complejidad en espacio O(1)
    def trap(self, heights: list[int]) -> int:
        tempArea = 0
        area = 0
        currentHeight = 0
        consolidationPoint = 0

        for i in range(len(heights) - 1):
            currentHeight = max(currentHeight, heights[i])

            # Encontramos tope a nuestra derecha y "guardamos" el agua estimada.
            if currentHeight <= heights[i + 1]:
                # Consolidamos volumen de agua.
                area += tempArea
                # Marcamos el último punto de consolidación.
                consolidationPoint = i + 1
                tempArea = 0
            else:
                tempArea += currentHeight - heights[i + 1]

        # Si nos quedó agua estimada puede haber algo más que guardar.
        if tempArea > 0:
            # Esa agua embalsada estará en el área desde el final hasta el
            # último punto de consolidación.
            currentHeight = 0
            tempArea = 0
            # Recalculamos en una segunda pasada desde el final hasta
            # el último punto de consolidación.
            for i in range(len(heights) - 1, consolidationPoint, -1):
                currentHeight = max(currentHeight, heights[i])
                if currentHeight <= heights[i - 1]:
                    area += tempArea
                    tempArea = 0
                else:
                    tempArea += currentHeight - heights[i - 1]

        return area
