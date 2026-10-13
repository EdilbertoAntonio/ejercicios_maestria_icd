#install.packages("tidyverse")
library(tidyverse)
datos_cirrosis <- read_csv("prog y mat para cdd/datos/cirrosis.csv")

head(datos_cirrosis)

datos_cirrosis$Age <- as.integer((datos_cirrosis$Age) / 365)
datos_cirrosis

media_edad <- mean(datos_cirrosis$Age, na.rm = TRUE)
media_edad

mediana_edad <- median(datos_cirrosis$Age, na.rm = TRUE)
mediana_edad

rango_edad <- range(datos_cirrosis$Age, na.rm = TRUE)
rango_edad

rango_edad_1 <- max(datos_cirrosis$Age) - min(datos_cirrosis$Age)
rango_edad_1

varianza_edad <- var(datos_cirrosis$Age, na.rm = TRUE)
varianza_edad

desvest_edad <- sd(datos_cirrosis$Age, na.rm = TRUE)
desvest_edad

cuantiles <- quantile(datos_cirrosis$Age, probs = c(0.25, 0.5, 0.75))
cuantiles

boxplot(datos_cirrosis$Age, na.rm = TRUE)
summary(datos_cirrosis)
#install.packages("moments")
