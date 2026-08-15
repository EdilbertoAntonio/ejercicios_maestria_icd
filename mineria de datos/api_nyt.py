from pynytimes import NYTAPI
import os
from dotenv import load_dotenv
import time
from collections import Counter

load_dotenv() # permitimos cargar la llave de la api
api_key = os.getenv("NYT_API_KEY")

nyt = NYTAPI(api_key, parse_dates=True)

def obtener_articulos(tema, num_peticiones):
    todos_articulos = []

    for peticion in range(num_peticiones):
        articulos = nyt.article_search(query=tema) # cada peticion nos da 10 articulos
        todos_articulos.extend(articulos) 
        print(f'peticion {peticion} del tema: {tema}')
        if peticion < num_peticiones - 1:
            time.sleep(12) # para realizar 5 peticiones por minuto

    return todos_articulos

def extraccion_texto(lista_articulos):
    texto = ''

    for articulo in lista_articulos:
        abstract = articulo.get('abstract','')
        lead = articulo.get('lead_paragraph','')
        snippet = articulo.get('snippet','')
        texto = texto + f'{abstract} {lead} {snippet}'

    return texto

def limpieza(texto):
    texto = texto.lower().replace('U.S.', 'USA')
    palabras = texto.replace('.', ' ').replace(":"," ").split() 
    conteo = dict(Counter(palabras))

    return conteo

def word_dist(texto1, texto2):
    dist1 = limpieza(texto1)
    dist2 = limpieza(texto2)

    todas_palabras = set(dist1.keys()).union(set(dist2.keys()))

    total_1 = sum(dist1.values())
    total_2 = sum(dist2.values())

    freq_rel_1 = {palabra: (dist1.get(palabra, 0) / total_1) for palabra in todas_palabras}
    freq_rel_2 = {palabra: (dist2.get(palabra, 0) / total_2) for palabra in todas_palabras}

    variational_dist = sum(abs(freq_rel_1[palabra] - freq_rel_2[palabra]) for palabra in todas_palabras)

    return variational_dist

articulos_finanzas = obtener_articulos('Finances', 10)
texto_finanzas = extraccion_texto(articulos_finanzas)

articulos_inmigracion = obtener_articulos('Immgration', 10)
texto_inmigracion = extraccion_texto(articulos_inmigracion)

distancia = word_dist(texto_finanzas, texto_inmigracion)
print(distancia)

# articulos_ai = nyt.article_search(query="Artificial Intelligence", results=100)
# articulos_finanzas = nyt.article_search(query="Finances", results=100)
# articulos_inmigracion = nyt.article_search(query="Immigration", results=50)
# print(extraccion_texto(prueba))
# print(extraccion_texto(articulos_finanzas))
# print(len(articulos_ai))
# print(articulos_ai[3])

# help(nyt.article_search())