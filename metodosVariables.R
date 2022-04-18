#METODOS QUE PUEDO APLICAR A VARIABLES

b <- 1:10
b

d <- seq(1,10, by=0.5)
d

e <- rep(1:2, times=3)
e

f <- rep(1:2, each=3)
f

#Eliminar la variable f
rm(f)

class(b)
is.numeric(b)