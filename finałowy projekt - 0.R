filmy=read.csv("C:/Users/jj/Documents/ekonom/movie_metadata.csv")
filmiki=na.omit(filmy)
sovie=filmiki[!duplicated(filmiki),]
sovie<- sovie[!(sovie$color== ""), ]
sovie<- sovie[!(sovie$content_rating== ""), ]
sovie<- sovie[!(sovie$language== ""), ]
sovie$content_rating[sovie$content_rating=="Not Rated"]="Unrated"
sovie$country[sovie$country=="Official site"]="USA"
sovie$title_year=as.factor(sovie$title_year)
#ktowie=sovie[(sovie$country=="USA"),]
#sovie=sovie[!(sovie$content_rating=="M"),]
sovie=sovie[!(sovie$aspect_ratio>10),]
sovie=sovie[!duplicated(sovie$movie_title),]

movie=sovie


library(googleVis)
library(dplyr)
