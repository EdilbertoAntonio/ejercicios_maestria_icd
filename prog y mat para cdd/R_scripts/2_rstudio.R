library(tidyverse)
library(datos)

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista), color = "blue")

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, 
                           shape = clase, color = fabricante))

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista)) +
  facet_wrap(~ clase, nrow = 2)

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = clase)) +
  facet_grid(traccion ~ cilindros)

ggplot(data = millas) +
  geom_smooth(mapping = aes(x = cilindrada, y = autopista, linetype = traccion))


ggplot(data = millas, mapping = aes(x = cilindrada, y = autopista)) +
  geom_point(mapping = aes(color = clase)) +
  geom_smooth(data = filter(millas, clase == "subcompacto"), se = FALSE)

# transformaciones ----
ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte))

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

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
