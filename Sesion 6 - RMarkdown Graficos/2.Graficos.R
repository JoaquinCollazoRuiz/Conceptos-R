# Activamos la libreria ggplot2 para poder utilizar los datos 'mpg' (en este caso)
# adem�s de la parte gr�fica.
library(ggplot2) 

# Carga de datos de coches
data(mpg)
?str
str(mpg)
mpg


# QPLOT
# http://www.sthda.com/english/wiki/qplot-quick-plot-with-ggplot2-r-software-and-data-visualization

?qplot

#Gr�fico de dispersi�n / de puntos
qplot(x=displ, y=hwy, data=mpg)

# A�adimos est�tica / colores
qplot(x=displ, y=hwy, data=mpg, color =drv)

# A�adimos elementos geom�tricos (linea de puntos de forma suavizada)
qplot(x=displ, y=hwy, data=mpg, geom=c("point","smooth"))


# A�adimos elementos est�tica + geom�tricos 
# (diferencias por color + linear model smooth por cada color )
qplot(x=displ, y=hwy, data=mpg, color =drv) + geom_smooth(method = "lm")

# Histogramas (con color)
qplot(x = hwy, data = mpg, fill = drv)

# Facets, divis�n de m�ltiples gr�ficas
qplot(x=displ, y=hwy, data=mpg, facets = .~drv) # por Columnas
qplot(x=displ, y=hwy, data=mpg, facets = drv~.,) # por filas

qplot(x = hwy, data = mpg, facets = drv~., binwidth=2)

# Histograma de densidad (a�ade funciones de densidad)
qplot(x = hwy, data = mpg, geom = "density")
qplot(x = hwy, data = mpg, geom = "density", color=drv) # Graf densidad por cada elemento de drv


# GGPLOT
# http://sape.inf.usi.ch/quick-reference/ggplot2/
# GGplot permite indicar los elementos de datos, transformaci�n y est�tica que 
# describen el gr�fico

install.packages('ggplot2')
library(ggplot2)

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_line()
ggplot(data=mpg, aes(x=displ, color=class))+geom_histogram()

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_point()+geom_line()

ggplot(data=mpg, aes(x=displ, y=hwy, color=class))+geom_line()

