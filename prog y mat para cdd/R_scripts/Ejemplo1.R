#install.packages("datos") # Solo se hace una vez
library(tidyverse)
library(datos)
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = fabricante))

filter(millas, cilindros == 8)
filter(diamantes, quilate > 3)

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = clase))

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, size = clase))
#> Warning: Using size for a discrete variable is not advised.

