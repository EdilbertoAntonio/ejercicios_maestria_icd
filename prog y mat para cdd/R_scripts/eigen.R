(a <- matrix(c(-81, 16, -420, 83), nrow=2, ncol=2, byrow= TRUE))
eigen_a <- eigen(a)
(valores_a <- eigen_a$values)
(vectores_a <- eigen_a$vectors)

(b <- matrix(c(2, -1, 5, -2), nrow=2, ncol=2, byrow= TRUE))
eigen_b <- eigen(b)
(valores_b <- eigen_b$values)
(vectores_b <- eigen_b$vectors)

(c <- matrix(c(-62, -20, 192, 62), nrow=2, ncol=2, byrow= TRUE))
eigen_c <- eigen(c)
(valores_c <- eigen_c$values)
(vectores_c <- eigen_c$vectors)

(d <- matrix(c(-2, 5, 0, 5, -2, 0, 0, 0, 1), nrow=3, ncol=3, byrow= TRUE))
eigen_d <- eigen(d)

(valores_d <- eigen_d$values)
(vectores_d <- eigen_d$vectors)







