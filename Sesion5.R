################################
# Modelos Lineales
################################

#install.packages("dummies")
library(dummies)
library(stringr)

caimanes <- data.frame(
  lnLength = c(3.87, 3.61, 4.33, 3.43, 3.81, 3.83, 3.46, 3.76, 3.50, 3.58, 4.19, 3.78, 3.71, 3.73, 3.78), 
  lnWeight = c(4.87, 3.93, 6.46, 3.33, 4.38, 4.70, 3.50, 4.50, 3.58, 3.64, 5.90, 4.43, 4.38, 4.42, 4.25)
  )
  
# inspeccion datos
head(caimanes)

# construccion del modelo
m1 <- lm(lnWeight ~ lnLength, data = caimanes)  
m1

# general plot
?plot
plot(caimanes, pch = 1, cex = 2, col = "blue",  main = "Caimanes")
abline(m1)

# correlacion entre las dos variables
cor(caimanes$lnWeight, caimanes$lnLength)

# predecir nuevos valores
predict.lm(m1, newdata = data.frame(lnLength =  c(4, 4.87, 3)))



################################
# Modelado
################################

#url_datos = "http://www.almhuette-raith.at/apache-log/access.log"

#download.file(url_datos, destfile="data.log")

# Si lo hacemos de todo puede tardar, para ello limitamos a 10000 
#dataset <- read.csv("data.log", sep = " ",  header = FALSE, fill=TRUE, stringsAsFactors = F)
#dataset <- read.csv("data.log", sep = " ",  header = FALSE, fill=TRUE, stringsAsFactors = F, nrows=10000)
#dataset <- read.csv("data.log", sep = " ",  header = FALSE, fill=TRUE, nrows = 5860744)
dataset <- read.csv("data.log", sep = " ",  header = FALSE, fill=TRUE, nrows = 10000)

summary(dataset)

#Arreglamos los campos, como vimos en el tema anterior: tipos de datos
dataset$V7 <- as.factor(dataset$V7);  

dataset$V8 <- as.integer(dataset$V8);

# Arreglamos la petición (campo 6) y filtramos por petición correcta  
l1 <- strsplit(x = as.character(dataset$V6), split = " ");
l1

?do.call
?rbind
qs <- do.call(rbind, l1);  
qs

colnames(qs) <- c("X1","X2","X3");
qs

?cbind
dataset <- cbind(dataset, qs);
table(dataset$X1)

dataset <- dataset[dataset$X1 %in% c("GET", "POST", "PUT", "HEAD", "OPTIONS"), ];  
?droplevels
table(dataset$X1)
dataset <- droplevels(dataset);

# Arreglamos la fecha (campos 1 y 3)
dataset$X1 <- as.factor(dataset$X1);
dataset$X3 <- as.factor(dataset$X3);

# Arreglamos la fecha (campos 4 y 5)
?gsub
dataset$V4 <- gsub("\\[", "", dataset$V4)  
dataset$V5 <- gsub("\\]", "", dataset$V5)

################################
# Clustering K-Means
################################

# Reducimos el conjunto de datos
dataset_reduced <- head(dataset, n = 1000)

# Convierte a numérico los valores categorizados de las columnas X1, X3 y V7
?dummy.data.frame
df <- dummy.data.frame(dataset_reduced, names=c("X1", "X3", "V7"), sep = "_")

# Seleccionamos las columnas para el algoritmo Kmeans
levels(dataset$X1)
cols <- paste("X1", levels(dataset$X1), sep="_")
cols
cols <- c(cols, paste("X3", levels(dataset$X3), sep="_"))  
cols
cols <- c(cols, paste("V7", levels(dataset$V7), sep="_"))
cols

################################
# Ejecutamos el algoritmo Kmeans
################################

# Para Dataframe COMPLETO
#km <- kmeans(dataset[, cols], centers = 3)

km <- kmeans(df[c("X1_GET","X1_HEAD","X1_POST","V7_200","V7_404","V7_500","X3_HTTP/1.0","X3_HTTP/1.1" )], centers = 3)

# Resumen del algoritmo
summary(dataset[km$cluster == 1, c("X1","X3","V7")]) 
summary(dataset[km$cluster == 2, c("X1","X3","V7")]) 
summary(dataset[km$cluster == 3, c("X1","X3","V7")]) 


