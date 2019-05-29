# Author: Javier Abascal Carrasco
# Copyright: EOI. PROGRAMA EJECUTIVO DE IA Y DEEP LEARNING -On-line - 
# Class: 2019
# Script: 2. DataFrame y manipulación

#######################################################################
# Estructura de Datos y Data Profiling - Manipulación del DataFrame
#######################################################################
# dataset. La unidad básica de trabajo
attach(mtcars)
?mtcars
x = mtcars
x
is.data.frame(mtcars)

# Exploración de un dataset
dim(mtcars)
colnames(mtcars)
rownames(mtcars)
str(mtcars)
summary(mtcars)
head(mtcars)
tail(mtcars)

# Data Frame por referencia
mtcars # todo el dataframe
mtcars[,1] # acceder a la primera columna
mtcars[,"mpg"] # acceder a la columna "mpg"
mtcars[1:5,] # acceder a las 5 primeras filas
mtcars[1:10,c("hp","drat","vs")] # acceder a las 10 primeras filas de las columnas hp,drat y vs
mtcars$test = 1 # Crear una nueva columna llamada "test" con valor constante 1
mtcars 
mtcars$test <- NULL # Eliminar la columna "test"

# Seleccionar unas columnas específicas
mycols <- c("am","mpg","cyl","carb")
mydata1 <- mtcars[ , which(names(mtcars) %in% mycols)]
mydata1

# Seleccionar todo MENOS unas columnas específicas (síbolo - )
mycols <- c("am","mpg","cyl","carb")
mydata1 <- mtcars[ , - which(names(mtcars) %in% mycols)]
mydata1


# Filtrar un dataset - diferentes ejemplos
subset(mtcars, cyl==4)
subset(mtcars, cyl==4 & gear==4)
subset(mtcars, cyl==4 & gear!=4)
subset(mtcars, cyl==4 | gear==4)
nrow(subset(mtcars, cyl==4 | gear==4))
dim(subset(mtcars, cyl==4 | gear==4))
mtcars[mtcars$cyl==4 & mtcars$gear==4,]
unique(mtcars$cyl)

# Utilizar SQL para filtrar un dataset. Mirar SQL en las lecturas opcionales
install.packages("sqldf")
library(sqldf)
sqldf("select * from mtcars where cyl=4 order by mpg")
sqldf("select * from mtcars where cyl=4 order by mpg", row.names=TRUE)

# Como en casi todos los lenguajes de programación, hay muchas formas
# de hacer lo mismo. Por ejemplo. Imaginemos que queremos añadir una
# columna al dataframe con el nombre de las filas
x = mtcars
# nombre de las filas
rownames(mtcars)

# utilizando R base
x$name = rownames(mtcars)
# utilizando un paquete de R
install.packages("dplyr")
library(dplyr)
??dplyr
x <- dplyr::add_rownames(mtcars, var = "name_dplyr")

# Transponer un data frame
t(mtcars)

# Aplicar una función a todo el data frame
apply(mtcars, 2, mean) # Por columna
apply(mtcars, 1, mean) # Por fila

# Crear una función
filtro_4 <- function(column){
  if(column > 4){
    return(1)
  }
  else {
    return(0)
  }
}

# utilizar una función
filtro_4(10)
filtro_4(3)
# "sapply" Apply a Function over a List or Vector
?sapply
mtcars$filtro_4_cyl <- sapply(mtcars$cyl, FUN=filtro_4) 
mtcars$filtro_4_cyl <- NULL


# building a mapping table to practice merge function
# "am" column means Transmission (0 = automatic, 1 = manual)
trans_code <- c(0,1)
trans_desc <- c("automatic","manual")
trans_mapping <- data.frame(trans_code, trans_desc)
trans_mapping


# Función MERGE
x <- mtcars
# all.x or all.y para "left" or "right" join
y <- merge(x, trans_mapping, by.x=c("am"), by.y=c("trans_code"))
y






