from pynytimes import NYTAPI
import os
from dotenv import load_dotenv
import time
from collections import Counter
import datetime as dt
import string
import numpy as np

# la api key se obtuvo mediante el registro en el portal de NYT
# y se guardo en un archivo .env
load_dotenv() # nos permite cargar la llave de la api
api_key = os.getenv("NYT_API_KEY")

nyt = NYTAPI(api_key, parse_dates=True)

def obtener_articulos(tema, num_peticiones):
    todos_articulos = []
    fecha_fin = dt.datetime.now()

    for peticion in range(num_peticiones):
        fecha_inicio = fecha_fin - dt.timedelta(days=30)
        # en total tendremos num_peticiones*10 articulos, ya que cada peticion trae 10 articulos
        articulos = nyt.article_search(
                        query=tema, 
                        # usamos dates para buscar articulos en fechas diferentes en cada peticion
                        # asi tendremos diversos articulos 
                        dates={ 
                            'begin': fecha_inicio,
                            'end': fecha_fin
                        }) # cada peticion nos da 10 articulos
        todos_articulos.extend(articulos) 
        print(f'peticion {peticion} del tema: {tema}') # para saber si sigue haciendo las peticiones

        fecha_fin = fecha_inicio

        time.sleep(12) # para realizar 5 peticiones por minuto, debido a que la API tiene esa limitacion

    return todos_articulos

def extraccion_texto(lista_articulos):
    texto = ''
    # de la información que la api nos da sólo nos interesa lo siguiente
    # el abstract, lead_paragraph, y snippet ya que son textos relacionados al articulo
    # ya que por temas de autor no nos da el articulo completo
    # por lo que unimos varios articulos para tener un texto lo más extenso posible
    for articulo in lista_articulos:
        abstract = articulo.get('abstract','') 
        lead = articulo.get('lead_paragraph','')
        snippet = articulo.get('snippet','')
        texto = texto + f' {abstract} {lead} {snippet} '

    return texto

def limpieza(texto):
    texto = texto.lower().replace('U.S.', 'USA').replace('A.I.', 'AI')
    for a in string.punctuation:
        texto = texto.replace(a,"")
    palabras = texto.split() 
    conteo = dict(Counter(palabras))

    return conteo

def word_dist(texto1, texto2):
    dist1 = limpieza(texto1)
    dist2 = limpieza(texto2)

    todas_palabras = sorted(set(dist1.keys()).union(set(dist2.keys())))

    total_1 = sum(dist1.values())
    total_2 = sum(dist2.values())

    freq_rel_1 = {palabra: (dist1.get(palabra, 0) / total_1) for palabra in todas_palabras}
    freq_rel_2 = {palabra: (dist2.get(palabra, 0) / total_2) for palabra in todas_palabras}

    return freq_rel_1, freq_rel_2

def kl(p,q):
    mask = p>0 # true or false
    return np.sum(p[mask]*np.log(p[mask]/q[mask]))

def js(p,q):
    M = (p+q)/2
    return 0.5*(kl(p,M)) + 0.5*(kl(q,M))

# tema_1 = 'Finances'
tema_1 = 'Politics'
articulos_tema_1 = obtener_articulos(tema_1, 10)
texto_1 = extraccion_texto(articulos_tema_1)

# tema_2 = 'Immigration'
tema_2 = 'Science'
articulos_tema_2 = obtener_articulos(tema_2, 10)
texto_2 = extraccion_texto(articulos_tema_2)

freq1, freq2 = word_dist(texto_1, texto_2)

dist1 = np.array([prob for prob in freq1.values()])
dist2 = np.array([prob for prob in freq2.values()])

print(js(dist1,dist2))

