from pynytimes import NYTAPI
import os
from dotenv import load_dotenv

load_dotenv() # permitimos cargar la llave de la api
api_key = os.getenv("NYT_API_KEY")

nyt = NYTAPI(api_key, parse_dates=True)

ai_articles = nyt.article_search(query="Artificial Intelligence", results=1)

print(len(ai_articles))