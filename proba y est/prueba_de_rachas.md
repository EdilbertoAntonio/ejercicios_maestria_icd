# ¿Que es la prueba de rachas?

es un método estádisitico no paramétrico que sirve para comprobar si una secuencia de datos ha sido genereda de forma aleatoria e independiente o por el contrario sigue algún patrón.

## ¿Qué es una racha?

Una racha es una subsecuencia ininterrumpida de datos que tienen la misma caracteristica dentro de una secuencia de datos, además está predecida y seguida por datos que son de un tipo diferente.

## Prueba de Rachas de Wald-Wolfowitz

Esta prueba evalua si el número total de rachas observado en una muestra coincide con el número que se esperaria matemáticamente bajo condiciones de pura aleatoriedad.

Está diseñada para secuencias dicotómicas, es decir, para dos tipos de datos (tipo 1 y tipo 2 o tipo A y tipo B, etc), normalmente no tenemos datos de este tipo, por lo que antes de aplicar esta prueba es necesario alguna binarización (transformación) a los datos.

### Binarización por mediana

Es la más recomendado, se empieza por obtener la mediana de la muestra, despues se sigue la siguiente transformación:
* Si $x_i > \tilde{x}$ entonces $x_i$ será del *Tipo 1*
* Si $x_i < \tilde{x}$ entonces $x_i$ será del *Tipo 2*
* Si $x_i = \tilde{x}$ entonces $x_i$ se descarta y se reduce la muestra, es decir, n disminuirá. Para garantizar que las proporciones se desequilibren artificialmente.

### Binarización por media.

De igual fora se realiza igual que por mediana, pero lo malo de esto es que si hay un sesgo en los datos, pues las proporciones de tipo 1 y tipo 2 quedarian altamente desequilibrados. 

### Binarización por diferencias

En lugar de tener un valor de un umbral y que nos diga si es de un tipo u de otro, comparamos cada $x_i$ con su predecesora $x_{i-1}$ y seguirán la transformación:

* Si $x_i - x_{i-1} > 0$ entonces $x_i$ es creciente y será del *Tipo 1*
* Si $x_i - x_{i-1} < 0$ entonces $x_i$ es decreciente y será del *Tipo 2*
* Si $x_i - x_{i-1} = 0$ entonces $x_i$ se descarta y se 

Si se elige este método, hay que tener precacución ya que las diversas ecuaciones que se mostrarán a continuación (esperanza y varianza) ya no serán válidas, por lo que para está exposición, sólo tomaremos ejemplos que sean binarizado por los primeros 2 métodos.

### Ejemplo de binarización por medias:

Los datos son $S = \{14.1,\; 12.5,\; 10.2,\; 9.8,\; 15.3,\; 11.0,\; 16.2\}$ notamos que $n=7$, ordenamos los datos, $S_{ordenados} = \{9.8,\; 10.2,\; 11.0,\; 12.5,\; 14.1,\; 15.3,\; 16.2\}$, por lo tanto la mediana es $\tilde{x} = 12.5$, en este caso los tipos serán catalogados como:
* 1 si $x_i > \tilde{x}$
* 0 si $x_i < \tilde{x}$

por lo que las transformaciones serán:

* $14.1 > 12.5 \rightarrow 1$
* $12.5 = 12.5 \rightarrow $ se descarta
* $10.2 < 12.5 \rightarrow 0$
* $9.8 < 12.5 \rightarrow 0$
* $15.3 > 12.5 \rightarrow 1$
* $11.0 < 12.5 \rightarrow 0$
* $16.2 > 12.5 \rightarrow 1$

Por lo que nuestra nueva secuencia es $S_{dicotomica} = \{1,\; 0,\; 0,\; 1,\; 0,\; 1\}$, por la definición de racha, tenemos que en esta secuencia tendremos $R=5$ rachas, con $n=6$ elementos en total, con 3 elementos del tipo 1 $(n_1=3)$ y con con 3 elementos del tipo 2 $(n_2=3)$

### Desarrollo

Como se vió anteriormente, usaremos la siguiente notación:

* $n_1$: cantidad de elementos del tipo 1
* $n_2$: cantidad de elementos del tipo 2
* $n=n_1+n_2$: cantidad total de elementos
* $R$: el número total de rachas.

Ahora, la prueba establece una prueba de hipotesis, tal como:

* $H_0$: La secuencia es aleatoria e independiente.
* $H_1$: La secuencia no es aleatoria.

Para saber si se rechaza o no $H_0$, nos hacemos la pregunta: ¿Si no se rechaza $H_0$ cuantas rachas esperariamos ver?, por lo tanto se necesita calcular la esperanza y su varianza

Para comenzar con el calculo de $E[R]$, primero definiremos a $I_k$, que es la variable que para cada posición $k$ ve si hay una nueva racha, (con $k$ de 2 a $n$)

$$
I_k = 
   \begin{cases} 
   1, & \text{si una nueva racha comineza en la posicion k}  \\
   0, & \text{en cualquier otro caso}
   \end{cases}
$$

Descrita de otra forma:

$$
I_k = 
   \begin{cases} 
   1, & \text{si }  I_k \neq I_{k-1}\\
   0, & \text{si }  I_k = I_{k-1}
   \end{cases}
$$

Entonces para R, como en $k = 1$ siempre hay una racha, pues se empieza con 1, por lo tanto:

$$
R = 1 + \sum_{k=2}^n I_k
$$

Aplicando la esperanza y sus propiedades:

$$
E[R] = 1 + \sum_{k=2}^n E[I_k]
$$

Para lograr calcular $E[I_k]$, notamos que es la probabilidad de que ocurra una nueva racha en $k$, y esto ocurre cuando $k$ es diferente de $k-1$ y esto pasa en 2 escenarios:

* Cuando $k-1$ es del tipo 1 y $k$ es del tipo 2
* Cuando $k-1$ es del tipo 2 y $k$ es del tipo 1

Por lo que en el primer escenario, tenemos que la probabilidad que en la posición $k-1$ el elemento sea del tipo 1 es la proporción:

$$
P(Pos_{k-1}=\text{Tipo 1})= \frac{n_1}{n}
$$

Ahora como ya ocupamos o avanzamos a la siguiente posición $k$ la muestra disminuye a $n-1$, por lo tanto la probabilidad condicional de que el siguiente elemento (en $k$) sea del tipo 2 es de:

$$
P(Pos_{k}=\text{Tipo 2} | Pos_{k-1}=\text{Tipo 1})= \frac{n_2}{n-1}
$$

Por lo que la probabilidad de que ocurra el primer escenario, debido a que son probabilidades dependendientes es de:

$$
P(\text{Primer Escenario})= \frac{n_1}{n} \cdot \frac{n_2}{n-1} = \frac{n_1 n_2}{n(n-1)}
$$

Para el segundo escenario es de manera similar:

La probabilidad de que en $k-1$ sea del tipo 2: $P(Pos_{k-1}=\text{Tipo 2})= \frac{n_2}{n}$

La probabilidad de que en $k$ sea del tipo 1: $P(Pos_{k}=\text{Tipo 1} | Pos_{k-1}=\text{Tipo 2})= \frac{n_1}{n-1}$

Por lo tanto la probabilidad del segundo escenario es de: $ P(\text{Segundo Escenario})= \frac{n_2}{n} \cdot \frac{n_1}{n-1} = \frac{n_2 n_1}{n(n-1)} $

Finalmente la probabilidad de que exista una nueva racha es de: 

$$
P(I_k=1) = P(\text{Primer Escenario}) + P(\text{Segundo Escenario}) \\
P(I_k=1) = \frac{n_1 n_2}{n(n-1)} +\frac{n_2 n_1}{n(n-1)} \\

P(I_k=1) = \frac{2 n_1 n_2}{n(n-1)} = E[I_k]
$$

Por lo tanto siguiendo:

$$
E[R] = 1 + \sum_{k=2}^n E[I_k]
$$

Notamos que la suma es constante para $n-1$ elementos que tiene, ya que inicia desde 2, entonces:

$$
E[R] = 1 + (n-1)\frac{2 n_1 n_2}{n(n-1)} \\
E[R] = 1 + \frac{2 n_1 n_2}{n} = \mu_R
$$

Para el cálculo de la varianza, sabemos que $R = 1 + \sum_{k=2}^n I_k$, por lo que la varianza sería:

$$
Var(R) = Var(\sum_{k=2}^n I_k)
$$

Como las variables $I_k$ no son independientes, si no que el resultado de $I_k$ depende de $I_{k-1}$, por lo tanto la varianza de la suma de estás variables dependientes, requiere evaluar las varianzas individuales y la covarianza de cada pareja posible, por lo tanto tenemos:

$$
Var(R) = Var(\sum_{k=2}^n I_k) = \sum_{i=2}^n Var(I_i) + 2\sum_{2\leq j<k\leq n} Cov(I_j, I_k) 
$$

Y desarollando se obtiene que:

$$
Var(R) = \frac{2n_1 n_2(2n_1 n_2-n_1-n_2)}{n^2(n-1)} \\
Var(R) = \frac{2n_1 n_2(2n_1 n_2-n)}{n^2(n-1)} = \sigma_R^2
$$

Ahora debido a que al teorema del limite central, nos dice que a medida que la muestra crece, la distribución de probabilidad del número de rachas de aproxima a una distribución normal, por lo que podremos usar el estadístico $Z$, de la siguiente forma:

$$
Z = \frac{R-\mu_R}{\sigma_R}
$$

Por lo que el estadístico Z no sería más que una medida de distancia, para saber a cuantas desviaciones estandar de la media teórica quedó nuestro resultado real. Por lo tanto usaremos una prueba bilateral, es decir, que para un nivel de significancia $\alpha = 0.05$, nuestras regiónes de rechazo es $|Z_{calc}|>Z_{1-\alpha/2}$, es deicr:

* Si $Z_{calc} < -Z_{1-\alpha/2}$ nos está diciendo que hay menos rachas de las esperadas, por lo tanto la secuencia se agrupa demasiado, es decir, hay subsecuencias que duran mucho con mmismo tipo, lo que nos indica tendencias.

* Si $Z_{calc} > Z_{1-\alpha/2}$ nos indica que hay más rachas de los esperado, por lo tanto la secuencia alterna demasiado, es decir, las subsecuencias duran poco con el mismo tipo, lo que nos indica patrón ciclico.

* Si $Z_{calc} < -Z_{1-\alpha/2}$ nos está diciendo que hay menos rachas de las esperadas

* Si $Z_{calc} > Z_{1-\alpha/2}$ nos indica que hay más rachas de los esperado

O bien mediante un valor P, debido a que es una prueba bilateral, tenemos que es $p = 2P(Z>|Z_{calc}|) = 2[1-\Phi(|Z_{calc}|)]$, por lo que si $p<\alpha$ rechazariamos a $H_0$

### Nota

Como $R$ es una variable discreta, es decir, sólo variables enteras positivas, y $Z$ es una variable continua, por lo que al comparar ambos valores se genera un pequeño margen de error, para ajustarlo, se le restará $0.5$ si hay más rachas de lo esperado, es decir, si $R > \mu_R$ y si hay menos rachas de lo esperado se le sumará $0.5$, si $R < \mu_R$, por lo que el estadístico $Z$ con la corrección quedará:

$$
Z = \frac{R-\mu_R-0.5\times sgn(R-\mu_R)}{\sigma_R}
$$