# recordando R ----

x <- 8
y <- 3

if (x<y){
  print('ejemplo')
} else {
  print('Ejemplo 2')
}
  

cad <- "Matemáticas y Programación para la Ciencia de Datos"
nchar(x = cad)

z <- y+x
print(z)

# tidyverse ----
# lo de arriba  es una forma de crear o simular una celda
# la celda se ejecuta completa con ctrl + alt + t

library(tidyverse)
setwd("D:/papeles maestria/ejercicios_maestria_icd")
datos_cirrosis <- read_csv("prog y mat para cdd/datos/cirrosis.csv")

summary(datos_cirrosis)
