# Author: Javier Abascal Carrasco
# Copyright: EOI. PROGRAMA EJECUTIVO DE IA Y DEEP LEARNING -On-line - 
# Class: 2019
# Script: 1. Primeros pasos con R

#######################################################################
# Información básica
#######################################################################

# las almohadillas sirven para escribir comentarios. Estos no son ejecutados en la consola
# Atajos de teclado fundamentales
# - Ctrl + Enter --> Ejecuta la linea actual
# - Ctrl + 1 --> Te desplaza a la región de "Source". Donde se editan archivos
# - Ctrl + 2 --> Te desplaza a la región de "Console". Donde se ejecutan instrucciones
# - Tab --> Sirve para autocompletar código, funciones y variables
# - ?nombre_de_la_funcion --> Abre la documentación de la función dentro de RStudio
# - [Dentro de la región "Console"] flecha hacia arriba, --> Escribe el código ejecutado anteriormente
# - Hoy en día "<-" es igual a "=" salvo para argumentos de las funciones
# - Para caracteres " (dobles comillas) es lo mismo que ' (comillas simple)


#######################################################################
# Primeros Pasos con R
#######################################################################
# Ver y fijar el "Working Directory" - directorio de trabajo (cada uno tendrá el suyo personal)
# Atención a la dirección de las BARRAS!!!! 
# Hay que cambiarlo a donde queramos trabajar
getwd()
setwd("C:/Users/Javie/Documents/1. Trabajo_Universidad/EOI/Rep. Dominicana/Contenidos/R/R_Code")
getwd()

# Información general sobre la sesión. Útil para saber los paquetes cargados
sessionInfo() 

# Installar un paquete en R
install.packages("ggplot2")
# Cargar un paquete a la sesión de trabajo actual de R
library(ggplot2)
??ggplot2

# Creamos unos datos ficticios y vemos las operaciones básicas
a <- "Hello World"
a
a = "Hello World"
a
x <- c(1,2,3,4)
x
x + x
c(x,x)
x[1]
x[1:3]
rm(x)
x
x = c(1,2,3,4)

length(x)
?length
class(x)
str(x)

# factores (para ahorrar memoria)
x = factor(c(1,2,3,1,2,3,3,3,3),levels = c(1,2,3), 
           labels = c("uno","dos","tres"))
x
x[1]

# Creación de una matriz
x <- matrix(data=c(1,2,3,4,5,6), nrow=2, ncol=3)

# Operaciones sobre matrices (o vectores también. Elemento a elemento)
sqrt(x)
x^6
x = x^6

# Generación de una distribución

# IMPORTANTE !!!!
# Fija la semilla de la ejecución aleatoria. Esto nos permite reproducir
# el experimento.
set.seed(3) 
x = rnorm(400, mean=50) #sd can be specified if needed (use hist to visualise dist)
y = rnorm(400, mean=100)
# Representar los datos en un "Scatter plot"
# IMPORTANTE! Si los márgenes de la región de "Plots" es demasiado pequeña, 
# Rstudio puede dar un error al intentar dibujajr la gráfica
plot(x,y)

# Guardar la imagen en un pdf
pdf("figureTest.pdf")
plot(x,y,col="green")
dev.off()


