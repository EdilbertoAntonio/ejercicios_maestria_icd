from collections import Counter
import numpy as np
import string

"string.punctuation returns all these symbols in a string -> !#&%...."

text1 = 'Hello there'
text2 = 'hello my name is'

def word_distribution(text):
    word = text.lower()

    for a in string.punctuation:
        word = word.replace(a,"")

    word = word.split()
    counts = Counter(word)
    total = sum(counts.values())
    # distribution = {}
    # for words, count in counts.items():
    #     distribution[words] = count/total
    distribution = {words:(count/total) for words, count in counts.items()}

    return distribution

print(word_distribution(text1))