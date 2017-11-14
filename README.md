# Adaline

Implementación del algoritmo de Adaline en Matlab.

Para ejecutar el código:

adaline.m necesita estar en la misma carpeta que los datos de entrada ("Train.csv", "Valid.csv", "Test.csv") y los archivos "ValoresParaDesnormalizar.csv" y "Test_original.csv"
(necesarios para desnormalizar los valores de salida y comparar la salida original con la obtenida).
Se pueden especificar los parámetros 'tasa' (tasa de aprendizaje) y 'num_cycles' (número de ciclos).

adeline.m genera 3 archivos de salida:

1. 'errorAdaline.xlsx': los errores de entrenamiento y validación en cada ciclo

2. 'testAdaline.xlsx': la salida esperada y la salida obtenida

3. 'ficheroSalidaAdalina.txt': los pesos finales del modelo, el umbral, y el error de test (normalizado y desnormalizado)
