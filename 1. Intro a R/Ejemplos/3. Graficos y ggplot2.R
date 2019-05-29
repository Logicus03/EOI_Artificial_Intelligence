# Author: Javier Abascal Carrasco
# Copyright: EOI. PROGRAMA EJECUTIVO DE IA Y DEEP LEARNING -On-line - 
# Class: 2019
# Script: 3. Gráficos y ggplot2

#######################################################################
# Gráficas básicas
#######################################################################
# IMPORTANTE! Si los márgenes de la región de "Plots" es demasiado pequeña, 
# Rstudio puede dar un error al intentar dibujajr la gráfica
attach(mtcars)
plot(wt, mpg, main="Mileage vs. Car Weight",
     xlab="Weigth", ylab="Mileage",
     pch=18, col="blue")

text(wt, mpg, row.names(mtcars),
     cex=0.6, pos=4, col="red")

opar <- par(no.readonly=TRUE)
# FIG definition
# A numerical vector of the form c(x1, x2, y1, y2) which gives the (NDC) 
# coordinates of the figure region in the display region of the device. 
# If you set this, unlike S, you start a new plot, so to add to an 
# existing plot use new = TRUE as well
par(fig=c(0, 0.8, 0, 0.8))
plot(mtcars$wt, mtcars$mpg,
     xlab="Miles Per Gallon",
     ylab="Car Weight")

par(fig=c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$wt, horizontal=TRUE, axes=FALSE)

par(fig=c(0.65, 1, 0, 0.8), new=TRUE)
boxplot(mtcars$mpg, axes=FALSE)

mtext("Enhanced Scatterplot", side=3, outer=TRUE, line=-3)
par(opar)


#######################################################################
# Gráficas con ggplot2
#######################################################################
library(ggplot2)
# Si ya tenemos el objeto mtcars, lo eliminamos con rm(mtcars) y lo volvemos a cargar
attach(mtcars)
# Creamos factores con diferentes niveles para gear,am,cyl
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears"))
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual"))
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl"))

# Kernel density estimation plots por mpg
# Wikipedia: https://en.wikipedia.org/wiki/Kernel_density_estimation
# "Intenta estimar su función de probabilidad/densidad"
# Agrupados por número de engranajes
qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5),
      main="Distribution of Gas Milage", xlab="Miles Per Gallon",
      ylab="Density")

# Boxplots de mpg por número de cilindros
# Los puntos de las observaciones están sobrepuestos
qplot(cyl, mpg, data=mtcars, geom=c("boxplot", "jitter"),
      fill=cyl, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

# Regresión lineal de mpg por peso(wt) para el número de cilindros 
qplot(y=wt, x=mpg, col=factor(gear), data=mtcars,
      main="Regression of MPG on Weight",
      xlab="Weight", ylab="Miles per Gallon") +
  stat_smooth(method=lm, formula=y~x)




