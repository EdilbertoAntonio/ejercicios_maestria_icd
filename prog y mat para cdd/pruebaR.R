x <- 8
y <- 3

if (x < y) {
  print("ejemplo")
} else {
  print("Ejemplo 2")
}
## ctrl + shift + s para correr todo el archivo en VScode
n <- 1
while (n <= 5) {
  print(paste("El contador es:", n))
  n <- n + 1
}

contador <- 1

repeat { # se repite al menos una vez
  print(paste("Iteración número:", contador))

  if (contador >= 5) {
    break  # Sale del bucle cuando el contador llega a 5
  }

  contador <- contador + 1  # Incrementamos el valor
}


mate <- c(39,43,21,64,57,47,28,75,34,52)

calculo <- c(65,78,52,82,92,89,73,98,56,75)

plot(mate,calculo, col= "red",pch=16,lwd=3, abline(lm(calculo~mate),col="blue",lwd=3))

?plot
?setwd
x = 3


library(ggplot2)
mtcars
ggplot(mtcars, aes(x=hp, y= mpg, color=factor(cyl)))+
geom_point(size=5)