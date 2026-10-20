library(tidyverse)
library(datos)

setwd("D:/papeles maestria/ejercicios_maestria_icd/prog y mat para cdd/R_scripts")

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, y = autopista, color = fabricante))

# guardado ----
ggsave(
  filename = "grafico_millas.png",
  plot = get_last_plot(),
  path = NULL,
  width = 15,
  height = 10,
  units = "cm",
  dpi = 300
)

# impresión y asignación

(x <- 9 * 8)

# funciones ----

seq(1, 10)

(y <- seq(1, 10, length.out = 5))
y

# dplyr ----

(dic25 <- filter(vuelos, mes == 12, dia == 25))

filter(vuelos, mes == 11 | mes == 12)

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

arrange(vuelos, anio, mes, dia)

arrange(vuelos, desc(atraso_salida))

# Seleccionar columnas por nombre
select(vuelos, anio, mes, dia)

# Seleccionar todas las columnas entre anio y dia (incluyente)
select(vuelos, anio:dia)

# Seleccionar todas las columnas excepto aquellas entre anio en dia (incluyente)
select(vuelos, -(anio:dia))

rename(vuelos, cola_num = codigo_cola)

vuelos_sml <- select(vuelos,
  anio:dia,
  starts_with("atraso"),
  distancia,
  tiempo_vuelo
)
mutate(vuelos_sml,
  ganancia = atraso_salida - atraso_llegada,
  velocidad = distancia / tiempo_vuelo * 60
)

por_dia <- group_by(vuelos, anio, mes, dia)
summarise(por_dia, atraso = mean(atraso_salida, na.rm = TRUE))

vuelos %>% 
  group_by(anio, mes, dia) %>% 
  summarise(mean = mean(atraso_salida))