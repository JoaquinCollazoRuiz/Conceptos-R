# Activamos la libreria ggplot2 para poder utilizar los datos 'mpg' (en este caso)
# además de la parte gráfica.
library(ggplot2) 

# Carga de datos de coches
data(mpg)
?str
str(mpg)
mpg


# QPLOT
# http://www.sthda.com/english/wiki/qplot-quick-plot-with-ggplot2-r-software-and-data-visualization

?qplot

#Gráfico de dispersión / de puntos
qplot(x=displ, y=hwy, data=mpg)

# Añadimos estética / colores
qplot(x=displ, y=hwy, data=mpg, color =drv)

# Añadimos elementos geométricos (linea de puntos de forma suavizada)
qplot(x=displ, y=hwy, data=mpg, geom=c("point","smooth"))


# Añadimos elementos estética + geométricos 
# (diferencias por color + linear model smooth por cada color )
qplot(x=displ, y=hwy, data=mpg, color =drv) + geom_smooth(method = "lm")

# Histogramas (con color)
qplot(x = hwy, data = mpg, fill = drv)

# Facets, divisón de múltiples gráficas
qplot(x=displ, y=hwy, data=mpg, facets = .~drv) # por Columnas
qplot(x=displ, y=hwy, data=mpg, facets = drv~.,) # por filas

qplot(x = hwy, data = mpg, facets = drv~., binwidth=2)

# Histograma de densidad (añade funciones de densidad)
qplot(x = hwy, data = mpg, geom = "density")
qplot(x = hwy, data = mpg, geom = "density", color=drv) # Graf densidad por cada elemento de drv


# GGPLOT
# http://sape.inf.usi.ch/quick-reference/ggplot2/
# GGplot permite indicar los elementos de datos, transformación y estética que 
# describen el gráfico

install.packages('ggplot2')
library(ggplot2)

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_line()
ggplot(data=mpg, aes(x=displ, color=class))+geom_histogram()

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_point()+geom_line()

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_line()

