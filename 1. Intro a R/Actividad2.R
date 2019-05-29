# Author: Nicole Guzmán Cleto
# MODULO: 1 - Introducción al Lenguaje R
# Script: Asignación 2

"
1. Teniendo un vector x = c(1,2,3,4,5,6,7,8,9,10). ¿Cómo podramos realizar un 'subset' del
mismo, para eliminar los primeros 2 elementos del vector?

R: La forma más fácil de hacerlo, sabiendo cuántos elementos son (10) y cuántos se quieren 
omitir (2) solo debemos ir desde la cantidad que se quiere omitir + 1 ( 2+1 = 3) hasta 
la cantidad de elementos (10).
"

x <- c(1:10)
resultado1 <- x[3:10]
resultado1
"
2. Teniendo un vector x = c(1,2) y otro y = c(3,4), ¿Cómo podramos añadir los vector y
concatenarlos? Es decir, tener un vector (4,6) o (1,2,3,4)

R: Para sumar, se hace una suma con el operador; sin embargo, para concatenar se debe crear
un nuevo vector formado por los vectores que se quieren concatenar.
"

# Añadir (sumar)
x = c(1,2)
y = c(3,4)
z = x + y
z # Print value
 
# concatenar
x = c(1,2)
y = c(3,4)
z = c(x, y)
z # Print value

"
Segunda parte. Trabajando con dataset de mtcars
"
attach(mtcars)
cars = mtcars
detach(mtcars)

"
3. ¿Cómo seleccionaramos la última fila de la columna 'mpg' y 'cyl'? Â¿Y las últimas 5 filas?

R: 
  a. Para seleccionar la última fila, podemos tomar la cantidad de filas existentes 
  (por medio de las dimensiones), seleccionando las columnas que necesitamos ( 'mpg' y 'cyl' ) which 
  b. Para obtener las últimas filas, se parte desde (última - 5) hasta (última) [(última - 5):última]
"

car_dimensions <- dim(cars)
car_row = car_dimensions[1]
car_col = car_dimensions[2]
car_dimensions

#seleccionar la última fila de la columna 'mpg' y 'cyl'
mycols <- c( "mpg","cyl")
result1 <- cars[ car_row , which(names(cars) %in% mycols)]
result1


#Acceder a las últimas 5 filas
last_five_rows <- (car_row-5):car_row
result2 <- cars[ last_five_rows,]
result2

"
4. ¿Cómo añadiras una columna que fuera la divisón de las columnas 'mpg' y 'hp'?

R. Luego de indagar, con la función transform podemos añadir la nueva columna con su valor.
Me pareció bien hacerlo con esta función.
"
cars <- transform(cars, division = mpg / hp)
cars

"
5. ¿Cómo eliminaramos la columna 'drat'?
R. Si le ponemos un valor estático Nulo, esta se estara borrando
"
cars$drat <- NULL # Eliminar la columna "drat"
cars
"
6. ¿Cómo crearamos una nueva columna con el número de marchas en forma escrita 'uno',
'dos', 'tres', 'cuatro', 'cinco' ,'seis'?
R: Utilizando la función 'factor'
"
car_levels = c(1:6)
car_labels = c("uno","dos","tres","cuatro","cinco","seis")
cars$written_gear = factor( cars$gear ,levels = car_levels, labels = car_labels)
cars

"
7. Dibujar una gráfica que muestre la relación entre el consumo de combustible y el tiempo en
recorrer un cuarto de milla

R: Si queremos encontrar la cantidad de combustible que se utiliza recorriendo un 1/4 de milla
  debemos tener en cuenta que en el calculo del mpg, se calcula sobre un galon, siendo 
  Millas/Galon = millas, entonces 1/Millas/Galon = Galon/Millas dandonos el resultado de cuánto
  del galon se consume en cada milla recorrida. Teniendo en cuenta que queremos la relacion con 
  1/4 de la milla y tenemos 1 milla, solo debemos dividir la cantidad entre 4 y 
  tenemos cuánto se consume por cada 1/4 milla, como dice el encabezado.
"

# mpg -> Miles/(US) gallon
# qsec -> 1/4 mile time 
attach(mtcars)
cars <- mtcars
plot( qsec, ( 1/(mpg*4) ),
      main="Combustible vs Tiempo",
      xlab="Tiempo(s)",
      ylab="Galones ",
      pch=20, 
      col="purple")
text( qsec, ( 1/(mpg*4) ), row.names(cars),
     cex=0.6, pos=4, col='red')

detach(mtcars)

"
8. Escribir el Tweet más positivo y más negativo de Donald Trump
  a. El tweet más positivo tuvo el mayor rate
  b. El más negativo tuvo el menor rate
"

library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

# Credenciales
consumer_key <- 'nwSFa41yWcSVWqO3YvCMWynje'
consumer_secret <- 'qEqK8a3kAAtuwP32cgUI8XehG7CVc6C1uzfxxQc66PNM5Bg55s'
access_token <- '260391271-yyQcvPCgpcdR7kDzrO9FNi8q1zRqy95fw20MetUq'
access_secret <- 'ft6BTXP38WlEz57NSjrJxiWoi9gzPSxapUwwqgPUtWxmm'

# Aplicando credenciales 
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret) # Seleccionar 1
tweets <- userTimeline("realDonaldTrump", n=200)
tweets.df <- twListToDF(tweets)

# Limpiar de caracteres, emoticonos y URLs
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)

# Encontrar emociones por cada tweet basado en Syuhzet
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df)

# Obtener score de las emociones
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.negative <- word.df[sent.value == min(sent.value)]

# a
most.positive

# b
most.negative


"
9. ¿Por qué es importante fijar el 'seed' de una ejecución en un script de R?
"
 
# R. Porque los numeros aleatorios generados son los mismos y seguiran siendo los mismos. 
# Es importante utilizarlas cuando se corren simulaciones para que sean reproducibles.

"10. ¿Cómo ejecutamos la ayuda de una función en R? 
"

# R. Utilizando ?nombre_de_la_funcion. Esto abre la documentación de la función.
