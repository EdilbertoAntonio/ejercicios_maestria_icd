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

# Izquierda
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, alpha = clase, color = clase))

# Derecha
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, shape = clase, color = fabricante))

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista), color = "blue")

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = clase)) +
  facet_wrap(~ clase, nrow = 2)


ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = clase)) +
  facet_grid(traccion ~ cilindros)

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista))

# derecha
ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))

# x
ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista, linetype = traccion, color = traccion))

ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))

ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista, group = traccion))

# lo mismo que la gráfica 'x' que puse arriba
ggplot(data = millas) +
  geom_smooth(
    mapping = aes(x = cilindrada, y = autopista, color = traccion),
    show.legend = FALSE
  )

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista)) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista))
# lo mismo que la gráfica de arriba
ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point() +
  geom_smooth()


ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping = aes(color = clase)) +
  geom_smooth()
 
# transformaciones ----
ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte))
# otra forma de hacerlo
ggplot(data = diamantes) +
  stat_count(mapping = aes(x = corte))

demo <- tribble(
  ~corte,     ~freq,
  "Regular",   1610,
  "Bueno",     4906,
  "Muy Bueno", 12082,
  "Premium",   13791,
  "Ideal",     21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = corte, y = freq), stat = "identity")

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, y = after_stat(prop), group = 1))

ggplot(data = diamantes) +
  stat_summary(
    mapping = aes(x = corte, y = profundidad),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, colour = corte)) # contorno de las barras

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, fill = corte)) # ya toda las barras las colorea

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, fill = claridad))

ggplot(data = diamantes, mapping = aes(x = corte, fill = claridad)) +
  geom_bar(alpha = 1 / 5, position = "identity")

ggplot(data = diamantes, mapping = aes(x = corte, colour = claridad)) +
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, fill = claridad), position = "fill")

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte, fill = claridad), position = "dodge")

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista), position = "jitter")

# install.packages("mapas")
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

ggplot(data = millas, mapping = aes(x = clase, y = autopista)) +
  geom_boxplot()
# intercambio de coordenadas x a y y de y a x
ggplot(data = millas, mapping = aes(x = clase, y = autopista)) +
  geom_boxplot() +
  coord_flip()

bar <- ggplot(data = diamantes) +
  geom_bar(
    mapping = aes(x = corte, fill = corte),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip() # ya el gráfico está en bar
bar + coord_polar() # como ya está en bar la grafica en polar
