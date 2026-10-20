matrix1 <- matrix(1:9, nrow=3, ncol=3)

matrix1_filas <- matrix(1:9, nrow=3, ncol=3, byrow= TRUE)

print(matrix1)
print(matrix1_filas)

v1 <- c(1,2,3)
v2 <- c(4,5,6)


(cbind(v1, v2))

(rbind(v1,v2))

(matrix(0, nrow=3, ncol=3))

(diag(3)) # matriz identidad

# determinantes ----

a <-  matrix(c(1,2,3,4), nrow = 2, ncol = 2)
(determinante <- det(a))

# transpuesta ----
(t(a))
a

# operaciones ----

matrix1 <- matrix(1:9, nrow=3, ncol=3, byrow= TRUE)
matrix2 <- matrix(9:18, nrow=3, ncol=3, byrow= TRUE)

(matrix1 + matrix2)


(matrix1 <- matrix(c(2,3,-1,-2,1,2), nrow=2, ncol=3, byrow= TRUE))
(matrix2 <- matrix(c(1,3,2,0,-1,2), nrow=3, ncol=2, byrow= TRUE))

(matrix1 %*% matrix2)

# inversa ----

matrix1 <- matrix(c(4, 7, 2, 6), nrow = 2, ncol = 2, byrow = TRUE)
(solve(matrix1))

# sistema de ecuaciones ----

A <- matrix(c(1, -1, 1, 0, 2, -1, 2, 3, 0), nrow=3, ncol=3, byrow= TRUE)
B <- matrix(c(3,1,4), nrow=3, ncol=1)

(X <- solve(A) %*% B)

