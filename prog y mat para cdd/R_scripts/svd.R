set.seed(123)

m <- 6
n <- 4

(A <- matrix(rnorm(m*n, mean=0, sd=1), nrow=m))

# paso 1 ----
(AtA <- t(A) %*% A)

# paso 2 ----
(eigen_AtA <- eigen(AtA))
(lambda <- eigen_AtA$values)
(v <- eigen_AtA$vectors)
 
# paso 3 ----
(sigma <- sqrt(lambda))
(Sigma <- diag(sigma))

# paso 4 ----
(U <- A %*% v %*% diag(1/sigma))

# paso 5 ----
(A_reconstruida <- U %*% Sigma %*% t(v))
A
(error <- sum((A - A_reconstruida)^2))

# paso 6 ----
svd_A <- svd(A)

(U_svd <- svd_A$u)
(D_svd <- svd_A$d)
(V_svd <- svd_A$v)

# paso 7 ----
(A_v2 <- U_svd %*% diag(D_svd) %*% t(V_svd)) 
(error_v2 <- sum((A - A_v2)^2))

# reconstrucción rango 1 ----
u1 <- U_svd[,1,drop=FALSE]
v1 <- V_svd[,1,drop=FALSE]
sigma1 <- D_svd[1]

(A1 <- sigma1 * u1 %*% t(v1))
(error_rango1 <- sum((A - A1)^2))

# reconstrucción rango k ----
k <- 2
uk <- U_svd[,1:k]
vk <- V_svd[,1:k]
Sigmak <- diag(D_svd[1:k])

(Ak <- uk %*% Sigmak  %*% t(vk))
(error_rangok <- sum((A - Ak)^2))

# varianza explicada ----
total <-  sum(D_svd^2)
var_exp <- D_svd^2 / total * 100
var_cum <- cumsum(var_exp)
data.frame(
  Componente = 1:length(D_svd),
  Varianza = var_exp,
  Acumulada = var_cum
)





