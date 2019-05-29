# Author: Javier Abascal Carrasco
# Copyright: EOI. PROGRAMA EJECUTIVO DE IA Y DEEP LEARNING -On-line - 
# Class: 2019
# Script: 4. Machine Learning con R (tercera parte)



#  Instalamos las librerías
install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")

# Las cargamos
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

# Credenciales keys para Twitter. Son las credenciales de mi cuenta. Lo ideal sería hacerse una 
# cuenta propia de credencial: https://developer.twitter.com/en/docs/basics/authentication/guides/access-tokens.html
consumer_key <- 'nwSFa41yWcSVWqO3YvCMWynje'
consumer_secret <- 'qEqK8a3kAAtuwP32cgUI8XehG7CVc6C1uzfxxQc66PNM5Bg55s'
access_token <- '260391271-yyQcvPCgpcdR7kDzrO9FNi8q1zRqy95fw20MetUq'
access_secret <- 'ft6BTXP38WlEz57NSjrJxiWoi9gzPSxapUwwqgPUtWxmm'

# Nos autenticamos y buscamos los últimos 2 tweets de Donald Trump.
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret) # Seleccionar 1
tweets <- userTimeline("realDonaldTrump", n=200)

n.tweet <- length(tweets)
tweets.df <- twListToDF(tweets) 

# Visualizamos alguno de los tweets de Donald Trump
head(tweets.df)
head(tweets.df$text)

# Limpiamos los tweets un poco de caracteres, emoticonos y URLs
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)
head(tweets.df2)


# Conseguimos una emoción por cada tweet basado en Syuhzet y su lista de emociones
# anger, anticipation, disgust, fear, joy, sadness, surprise, trust, negative and positive.
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2)

# Ahora utilizamos la función de get_sentiment para obtener un "score" del mismo
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive

# Segregando tweets por su "sentimental score"
positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
neutral.tweets <- word.df[sent.value == 0]

category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
table(category_senti)

# Los visualizamos
category_senti2 <- cbind(tweets.df2,category_senti,sent.value)
head(category_senti2)

