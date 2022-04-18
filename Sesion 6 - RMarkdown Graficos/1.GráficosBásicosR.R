# Libreria Grafica de R básica
# R-base describe el gráfico añadiendo capas de elementos sobre el lienzo.

download.file("https://github.com/humbertcostas/courses/raw/master/0
4_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv",
              "avgpm25.csv")
pollution <- read.csv("avgpm25.csv", 
                      colClasses = c("numeric","character", "factor", "numeric", "numeric"))
head(pollution, n = 2)
summary(pollution)
summary(pollution$pm25)

# Exploración rápida de UNA dimensión

# Boxplot con linea horizontal
boxplot(pollution$pm25, col = "blue")
?boxplot
abline(h = 12)

# Histograma con observaciones y 50 divisiones
hist(pollution$pm25, col = "green", breaks = 50)
?rug
rug(pollution$pm25)
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

# Gráfica de barras
barplot(table(pollution$region),col = "wheat", main = "Obs. Region")

# Gráfica tipo Pie
library(MASS);
pie(table(pollution$region))


# Exploración rápida de DOS dimensiones

# Multiple Boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

# Multiple Histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

# Gráficos de dispersion con color
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

# Dispersión multiple
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"),plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"),plot(latitude, pm25, main = "East"))

?par
par(mfrow = c(1, 1))
# Ejemplo
library(datasets)
data(cars)
with(cars, plot(speed, dist))
abline(h = 60)
legend("topleft","some points", pch = 1)



# LATTICE

library(lattice)
state.x77
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))



# GGPLOT2

library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)



# VARIOS

# Histograma
data(airquality)
hist(airquality$Ozone)

# Dispersión
data(airquality)
with(airquality, plot(Wind, Ozone))

# Boxplot
data(airquality)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone")

# Barplot
barplot(height = c(10,5,3,6,12))

#Gráfica básica con título
data(airquality)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")

#Gráfica básica con título y puntos de colores
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

#Gráfica básica con ... muchos extras!
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c( "May", "Other Months"))

#Múltiples gráficos
par(mfrow = c(1, 2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})

# Gráficos en Dispositivos

# Abre un dispositivo PDF
pdf(file = "myplot.pdf")                 
# Crea el gráfico y lo envia al dispositivo (no se ve)
data(faithful)
with(faithful, plot(eruptions, waiting)) # se crea la capa principal
title(main = "Old Faithful Geyser data") # capas extras
dev.off()                                # se cierra el dispositivo
# ya se puede ver 'myplot.pdf' con el gráfico
# Existen múltiples tipos de dispositivos
# png(filename = "myplot.png")
# jpeg(filename = "myplot.jpg")
# Y más...gif...

# Paletas de colores
paleta <- colorRamp(c("red", "blue"))
paleta(0)
paleta(1)
paleta(0.5)
paleta(seq(0, 1, len = 10))

paleta <- colorRampPalette(c("red", "yellow"))
paleta(2)
paleta(10)

# RColorBrewer es un paquete que contiene diferentes paletas de colores (secuenciales, divergentes y cualitativas)
library(RColorBrewer)
cols <- brewer.pal(5, "BuGn")
cols
pal <- colorRampPalette(cols)

data(volcano)
image(volcano, col = pal(20))

# Incluso se pueden usar transparencias rgb(R,G,B,Transparencia)
par(mfrow = c(1, 2))
with(airquality, {
plot(Wind, Ozone, pch = 19)
plot(Solar.R, Ozone, col = rgb(0,0,0,0.2), pch = 19)
})


