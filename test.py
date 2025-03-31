from typing import DefaultDict


def strToDic(s):
    i = 0
    d = {}
    for char in s:
        if d.get(char, None):
            d[char] = d[char] + 1
        else:
            d.update({char: 1})
    return d


def isAnagram(s: str, t: str) -> bool:
    return strToDic(s) == strToDic(t)


s = "Hola mundo"
t = "mundo Hola"


def getIndexesSum(nums, target):
    checked = {}

    for idx in range(len(nums)):
        dif = target - nums[idx]
        print(f"dif = {dif}\n")
        if checked.get(dif, False):
            return [checked[dif], idx]
        else:
            checked.update({nums[idx]: idx})
            print(f"checked = {checked}\n")


nums = [-3, 4, 3, 6]
target = 0

print(getIndexesSum(nums, target))


def topKFrequent(nums: list[int], k: int) -> list[int]:
    dictNums = {}

    for num in nums:
        if dictNums.get(num, False):
            dictNums[num] = dictNums[num] + 1
        else:
            dictNums.update({num: 1})

    frecList = list(dictNums.items())
    frecList.sort(key=lambda x: x[1], reverse=True)
    rlist = list(map(lambda x: x[0], frecList))

    return rlist[0:k]


def topKFrequentBucket(nums: list[int], k: int) -> list[int]:
    count = {}

    frecList = [[] for i in range(len(nums) + 1)]

    for num in nums:
        count[num] = 1 + count.get(num, 0)

    for num, cnt in count.items():
        frecList[cnt].append(num)
        print(f"frecList = {frecList}.\n")

    res = []
    for i in range(len(frecList) - 1, -1, -1):
        for num in frecList[i]:
            res.append(num)
            if len(res) == k:
                return res
    return res


def encode(words: list[str]) -> str:
    # Necesito indicar un separador para las palabras.
    # Insertar como separador la longitud de la siguiente palabra.
    encodedWord = ""

    for word in words:
        encodedWord += str(len(word)) + word

    return encodedWord


def decode(encodedWord: str) -> list[str]:
    words = []

    for i in range(len(encodedWord)):
        wordLength = int(encodedWord[i])
        words.append(encodedWord[i + 1 : i + wordLength + 1])
        i += wordLength
    return words


def productExceptSelf(nums: list[int]) -> list[int]:
    output = [i for i in range(0, len(nums))]
    pref = [i for i in range(0, len(nums))]
    suff = [i for i in range(0, len(nums))]

    suff[len(nums) - 1] = 1
    suff[len(nums) - 2] = nums[len(nums) - 1]
    for i in range(len(nums) - 3, -1, -1):
        suff[i] = suff[i + 1] * nums[i + 1]

    pref[0] = 1
    pref[1] = nums[0]
    for i in range(2, len(nums)):
        pref[i] = pref[i - 1] * nums[i - 1]

    output[0] = suff[0]
    output[len(nums) - 1] = pref[len(nums) - 1]
    for i in range(1, len(nums) - 1):
        output[i] = pref[i] * suff[i]
    return output


# This function will check if the value is "the next" in a sequence.
# If it is, it will update the dictionary with the new last value of the sequence.
def isNextValue(numDict: dict[int, int], num: int) -> bool:
    for start, last in numDict.items():
        if num == last + 1:
            numDict[start] = num
            return True
    return False


def longestConsecutive(nums: list[int]) -> int:
    # Primera idea: crear un mapa con los elementos encontrados que pueden ser comienzo de secuencia y
    # continuar dichas secuencia o iniciar otras nuevas si encontramos elementos no compatibles.
    #
    # 1, 2, 5, 6, 8.

    # Ordenar la lista:
    nums.sort()

    numDict = {}

    for num in nums:
        if not isNextValue(numDict, num):
            # If this number doesn't fit in an existing sequence, it will be the start of a new one.
            numDict[num] = num

    # Once all numbers are processed, we can calculate the longest sequence.
    longestSecuence = 0
    for start, last in numDict.items():
        if last - start + 1 > longestSecuence:
            longestSecuence = last - start + 1

    return longestSecuence


sec = [6, 5, 3, 4, 2, 34, 4, 5, 3, 2, 1, -1]

print(f"{longestConsecutive(sec)}.\n")


class Solution:
    def normalizeString(self, s: str) -> str:
        outString = s.upper()
        outString = outString.replace(" ", "")

        return outString

    def validPalindrome(self, s: str) -> bool:
        i = 0
        j = len(s) - 1

        while i < j:
            if not s[i].isalnum():
                i += 1
                continue
            if not s[j].isalnum():
                j -= 1
                continue

            if s[i].upper() != s[j].upper():
                return False
            i += 1
            j -= 1
        return True


sol = Solution()

p1 = "Dabale arroz a la zorra el abad"

print(f"{sol.validPalindrome(p1)}.")

p2 = "La razón de la sinrazón"

print(f"{sol.validPalindrome(p2)}.")

p3 = "Madam, in Eden, I'm Adam"

print(f"{sol.validPalindrome(p3)}.")


class Sol2:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        nums.sort()

        solution = []
        idx = 0

        for idx, value in enumerate(nums):
            # Si llegamos a un valor positivo, no tiene sentido seguir buscando.
            if value > 0:
                break
            # Saltamos valores repetidos hasta encontrar uno nuevo.
            if idx > 0 and value == nums[idx - 1]:
                continue

            target = -nums[idx]
            start = idx + 1
            solution = self.findTwo(
                nums,
                target,
                start,
            )
            # Si no se encuentra una solución, se pasa al siguiente número.
            if len(solution) == 0:
                idx += 1
                continue
            # Si se ha encontrado una solución, se añade al conjunto de soluciones.
            # (En forma de tupla pues no se pueden añadir listas a un conjunto.)
            # (De esta forma evitamos duplicados.)
            solution.append(idx)
            solutions.add(tuple(solution))
            # Se incrementa el índice para buscar más soluciones.
            start += 1
            # Buscar más soluciones con el mismo número.
            while len(solution) != 0:
                # Reducimos el rango de búsqueda pues si no siempre devolverá la misma solución.
                solution = self.findTwo(nums, target, start)
                if len(solution) == 0:
                    break
                solution.append(nums[idx])
                solutions.add(tuple(solution))
                start += 1
            idx += 1

        return list(map(lambda item: list(item), solutions))

    def findTwo(self, nums: list[int], target: int, desp: int) -> list[int]:
        print(f"Buscando en {nums[desp:]} (desp: {desp}), target: {target}.")
        solution = []
        lIdx = targetIdx + 1
        rIdx = len(nums) - 1

        for idx1 in range(desp, len(nums)):
            for idx2 in range(idx1 + 1, len(nums)):
                if nums[idx1] + nums[idx2] == target:
                    print(
                        f"checking [{idx1}] = {nums[idx1]} and [{idx2}] = {nums[idx2]}."
                    )
                    solution = [nums[idx1], nums[idx2]]
                    return solution

        return solution


nums = [-5, 1, 2, 3, 4, 5]
target = 7

s2 = Sol2()
print(f"nums: {nums}, sums: {s2.threeSum(nums)}.")
