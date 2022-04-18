#Estructura de datos

#Vector/array
v1 <- c(5,11,13,17,23)

#Matriz
?matrix
m1 <- matrix(1:12, ncol = 3, nrow = 4)

#Mostrar la 2 fila
m1[2,]
#Mostrar la 1 y 2 fila
m1[c(1,2),]
#Mostrar lo que se encuentra entre la 1 y la 4 fila
m1[c(1:4),]

#Mostrar la 1 columna
m1[,1]


d1 <- data.frame(
    Columna1 = c(1,3,5,7,9),
    Columna2 = c("a","b","c","d","e"),
    Columna3 = c(T,F,F,T,T),
    stringsAsFactors = FALSE)

d1
d1$Columna2
d1[d1$Columna1 == 9 | d1$Columna3 == FALSE]



#LISTAS
list <- list(
  Elemento1=c(1,2,3),
  Elemento2=c("a","b","c"),
  Elemento3=TRUE
)

list$Elemento1
list[2]
list[[2]][[1]]

#BUSCAR ENTRE ESTRUCTURAS
5 %in% c(1,2,3,4,5)