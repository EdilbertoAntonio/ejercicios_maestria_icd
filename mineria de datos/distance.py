import pandas as pd
import numpy as np
datos = pd.read_csv("D:/papeles maestria/primer semestre/mineria de datos/ExportedData.csv")

# vemos que columnas tiene nuestro archivo
datos.head()

# tomamos sólo las columnas de interes
datos = datos[['Acceleration - resultant (m/s²) Run 1',
            'Acceleration - resultant (m/s²) Run 2',
            'Acceleration - resultant (m/s²) Run 3' ]]

# renombramos para que sea más comodo
nombres = {'Acceleration - resultant (m/s²) Run 1':'run_1',
        'Acceleration - resultant (m/s²) Run 2':'run_2',
        'Acceleration - resultant (m/s²) Run 3':'run_3'}

datos = datos[nombres.keys()].rename(columns=nombres)

# notamos que hay columnas con datos faltantes, lo que puede provocar errores, por lo que se eliminaran
# aseguramos que todas las columnas tengan al menos un valor
datos = datos.dropna() 

# realizamos una función para obtener las distancias Lp
def distancias_lp(col_1:pd.Series, col_2:pd.Series)->list:
    diferencia_abs = abs(col_1-col_2)
    d_L_3 = np.cbrt((diferencia_abs**(3)).sum())
    d_L_2 = np.sqrt((diferencia_abs**(2)).sum())
    d_L_1 = diferencia_abs.sum()
    d_L_inf = diferencia_abs.max()
    return [float(d_L_3), float(d_L_2), float(d_L_1), float(d_L_inf)]

# realizamos una función para obtener la distancia coseno
def distancia_coseno(col_1:pd.Series, col_2:pd.Series)->float:
    producto_punto = (col_1*col_2).sum()
    magnitud_1 = np.sqrt((col_1**2).sum())
    magnitud_2 = np.sqrt((col_2**2).sum())
    d_cos = 1 - (producto_punto/(magnitud_1*magnitud_2))
    return float(d_cos)

# calculamos en una sola lista todas las distancias entre los 3 vectores
distancias_1_2 = distancias_lp(datos['run_1'], datos['run_2']) + [distancia_coseno(datos['run_1'], datos['run_2'])]
distancias_1_3 = distancias_lp(datos['run_1'], datos['run_3']) + [distancia_coseno(datos['run_1'], datos['run_3'])]
distancias_2_3 = distancias_lp(datos['run_2'], datos['run_3']) + [distancia_coseno(datos['run_2'], datos['run_3'])]

# colocamos nuestros resultados en un dataframe
resultados = pd.DataFrame({'distancias_1_2': distancias_1_2,
                        'distancias_1_3': distancias_1_3,
                        'distancias_2_3': distancias_2_3})

resultados.index = ['dist_L3', 'dist_L2', 'dist_L1', 'dist_L_inf', 'dist_coseno']

print(resultados)

# print(d12_L_inf)
# print(distancias_lp(datos['run_1'], datos['run_2']))

# dif_r12 = abs(datos['run_1']-datos['run_2'])
# d12_L_3 = np.cbrt((dif_r12**(3)).sum())
# d12_L_2 = np.sqrt((dif_r12**(2)).sum())
# d12_L_1 = dif_r12.sum()
# d12_L_inf = dif_r12.max()

# # distancia coseno
# producto_punto_12 = (datos['run_1']*datos['run_2']).sum()
# magnitud_r1 = np.sqrt((datos['run_1']**2).sum())
# magnitud_r2 = np.sqrt((datos['run_2']**2).sum())
# d12_cos = 1- (producto_punto_12/(magnitud_r1*magnitud_r2))