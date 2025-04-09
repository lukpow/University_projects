
library(googleVis)
library(dplyr)
library(tidyr)

filmy=read.csv("movie_metadata.csv")
filmiki=na.omit(filmy)
sovie=filmiki[!duplicated(filmiki),]
sovie<- sovie[!(sovie$color== ""), ]
sovie<- sovie[!(sovie$content_rating== ""), ]
sovie<- sovie[!(sovie$language== ""), ]
sovie$content_rating[sovie$content_rating=="Not Rated"]="Unrated"
sovie$country[sovie$country=="Official site"]="USA"
sovie$country[sovie$country=="New Line"]="USA"
sovie$title_year=as.factor(sovie$title_year)

sovie=sovie[!(sovie$aspect_ratio>10),]
sovie=sovie[!duplicated(sovie$movie_title),]
testvie=sovie[,c("movie_title","title_year","country","language","budget","gross","duration","imdb_score","num_critic_for_reviews","num_user_for_reviews","num_voted_users","content_rating","facenumber_in_poster","aspect_ratio","color","director_name","director_facebook_likes","actor_1_name","actor_1_facebook_likes","actor_2_name","actor_2_facebook_likes","actor_3_name","actor_3_facebook_likes","cast_total_facebook_likes","movie_facebook_likes","genres","plot_keywords","movie_imdb_link")]
america=testvie[(testvie$country=="USA"),]
movie=testvie


srzeczywgkraj=matrix(0,length(unique(movie$country)),length(zmienne_ilosciowe))

for (j in 1:length(zmienne_ilosciowe)){
  for (i in 1:length(sort(unique(movie$country)))){
    srzeczywgkraj[i,j]=mean(movie[,zmienne_ilosciowe[[j]]][movie$country==sort(unique(movie$country))[i]])
}
}
srzeczywgkraj=as.data.frame(srzeczywgkraj)



kraje=sort(unique(movie$country))
srednie=data.frame(srzeczywgkraj,kraje)
srednie$kraje[srednie$kraje=="USA"]="United States"
srednie$kraje[srednie$kraje=="UK"]="United Kingdom"
names(srednie)=names(zmienne_ilosciowe)
names(srednie)[length(srednie)]="Kraj"
srednieinput=srednie%>%select(-Kraj)



w=reactiveVal(sample(1:length(movie$budget),1))
k1=reactiveVal(0)
p=reactiveVal(0)


shinyServer(function(input, output) {

  
  output$plot1 <- renderGvis({
    
    map <- gvisGeoChart(srednie, locationvar = "Kraj", colorvar = input$mapa,options = list(region = "world", displayMode = "regions",colorAxis = "{colors:['#00FFFF','#FF0000']}"))
  })

  
  
  output$dane=renderText({
    film=movie[movie$movie_title==input$wybrane,]
    paste("Kraj produkcji: ", film$country,"\nRok produkcji: ",film$title_year,
          "\nJęzyk w jakim nagrano film: ",film$language,
          "\nBudżet przeznaczony na produkcję filmu: ",film$budget,
          "\nPrzychód brutto z filmu w USA i Kanadzie: ",film$gross,
          "\nCzas trwania filmu (podany w minutach): ",film$duration,
          "\nOcena filmu na IMDb (w skali 1-10): ",film$imdb_score,
          "\nRecenzje krytyków: ",film$num_critic_for_reviews,
          "\nLiczba recenzji użytkowników: ",film$num_user_for_reviews,
          "\nLiczba opinii o filmie: ",film$num_voted_users,
          "\nOgraniczenia wiekowe: ",film$content_rating,
          "\nLiczba widocznych aktorów na plakacie: ",film$facenumber_in_poster,
          "\nRozdzielczość: ", film$aspect_ratio,"\nCzy film został nagrany w kolorze?: ",film$color,
          "\nImię i nazwisko reżysera: ",film$director_name,
          "\nPolubienia profilu na Facebooku reżysera: ",film$director_facebook_likes,
          "\nImię i nazwisko pierwszego aktora: ",film$actor_1_name,"\nPolubienia profilu na Facebooku pierwszego aktora: ",film$actor_1_facebook_likes,
          "\nImię i nazwisko drugiego aktora: ",film$actor_2_name,"\nPolubienia profilu na Facebooku drugiego aktora: ",film$actor_2_facebook_likes,"\nImię i nazwisko trzeciego aktora: ",film$actor_3_name,"\nPolubienia profilu na Facebooku trzeciego aktora: ",film$actor_3_facebook_likes,"\nPolubienia profilu na Facebooku całej obsady: ",film$cast_total_facebook_likes,
          "\nPolubienia profilu na Facebooku filmu: ",film$movie_facebook_likes,
          "\nGatunki: ",film$genres,"\nKluczowe hasła dla danego filmu: ",film$plot_keywords,"\nLink do strony na IMDb: ",film$movie_imdb_link)
          
  })

  
  output$wykres1<- renderPlot({
  
    ggplot(data=movie,aes(x=movie[,input$wykresosx],y=movie[,input$wykresosy],color=factor(movie[,input$faktor])))+geom_point()+labs(title =paste(input$wykresosx," w zależności od ",input$wykresosy),x=paste(input$wykresosx),y=paste(input$wykresosy),color=input$faktor)
  
                         
                                                                                                                                     
  })                                                                                                                                                                                                                                                                    

  output$wykres2<- renderPlot({

    ag= movie %>%
      group_by(!!sym(input$fa)) %>% 
      summarise(mean_value = mean(!!sym(input$il), na.rm = TRUE))
    
    ggplot(data = ag, aes(x = !!sym(input$fa), y = mean_value)) +
      geom_col(fill = "blue", color = "black") +
     labs(title =paste("Średnia wartość",input$il,"względem",input$fa),x =paste(input$fa), 
          y = paste(input$il))+ theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    
    })
  
  
  
  output$damn=renderText({
    paste("Liczba filmów w zbiorze: ",g ,
          "\nLizcba zmiennych: ",length(movie),"\nLiczba zmiennych ilościowych: ",15,
          "\nLiczba zmiennych jakościowych: ",13
    )
  })
  
  output$damni=renderText({
    film=movie[,input$zmil]
    paste("Element minimalny: ",min(film),"\nElement maksymalny",max(film),"\nŚrednia: ",mean(film) ,
          "\nOdchylenie standardowe: ",sd(film),"\nWariancja: ",(sd(film))^2,"\nPierwszy Kwartyl: ",
          quantile(film,c(0.25,0.5,0.75))[1],"\nMediana: ",quantile(film,c(0.25,0.5,0.75))[2],"\nTrzeci Kwartyl: ",quantile(film,c(0.25,0.5,0.75))[3])
    
  })
  
  output$damnj=renderText({
    film=movie[,input$zmij]
    paste("Liczba poziomów: ",length(unique(film)),"\nModa:",names(which.max((table(film)))))
  })
  
  output$cior=renderText({
    w1=movie[,input$z1]
    w2=movie[,input$z2]
    paste("Kowariancja:",cov(w1,w2),"\nKorelacja: ",cor(w1,w2))
  })
  
  
  output$zgad=renderText({
    wq=w()
    film=movie[movie$movie_title==movie$movie_title[wq],]
    paste("Kraj produkcji: ", film$country,"\nRok produkcji: ",film$title_year,
          "\nJęzyk w jakim nagrano film: ",film$language,
          "\nBudżet przeznaczony na produkcję filmu: ",film$budget,
          "\nPrzychód brutto z filmu w USA i Kanadzie: ",film$gross,
          "\nCzas trwania filmu (podany w minutach): ",film$duration,
          "\nOcena filmu na IMDb (w skali 1-10): ",film$imdb_score,
          "\nRecenzje krytyków: ",film$num_critic_for_reviews,
          "\nLiczba recenzji użytkowników: ",film$num_user_for_reviews,
          "\nLiczba opinii o filmie: ",film$num_voted_users,
          "\nOgraniczenia wiekowe: ",film$content_rating,
          "\nLiczba widocznych aktorów na plakacie: ",film$facenumber_in_poster,
          "\nRozdzielczość: ", film$aspect_ratio,"\nCzy film został nagrany w kolorze?: ",film$color,
          "\nImię i nazwisko reżysera: ",film$director_name,
          "\nPolubienia profilu na Facebooku reżysera: ",film$director_facebook_likes,
          "\nImię i nazwisko pierwszego aktora: ",film$actor_1_name,"\nPolubienia profilu na Facebooku pierwszego aktora: ",film$actor_1_facebook_likes,
          "\nImię i nazwisko drugiego aktora: ",film$actor_2_name,"\nPolubienia profilu na Facebooku drugiego aktora: ",film$actor_2_facebook_likes,"\nImię i nazwisko trzeciego aktora: ",film$actor_3_name,"\nPolubienia profilu na Facebooku trzeciego aktora: ",film$actor_3_facebook_likes,"\nPolubienia profilu na Facebooku całej obsady: ",film$cast_total_facebook_likes,
          "\nPolubienia profilu na Facebooku filmu: ",film$movie_facebook_likes,
          "\nGatunki: ",film$genres,"\nKluczowe hasła dla danego filmu: ",film$plot_keywords)
    
  })
    
    observeEvent(input$odp1, {
      ww1=w()
      if (movie$movie_title[ww1]==input$zgad){
        k1(k1()+1)
      }
      else{ p(p()+1)} 
      
      
      
      
      output$feedback <- renderText(paste("Poprawna odpowiedź: ", movie$movie_title[ww1]))
      
      
        w(sample(1:length(movie$budget),1))
        
      
    })
 
    

    
    output$punkty=renderText({
      paste("Odgadniętych: ", k1(),"\nBłędów: ",p())
      
    })
    
    
    
    output$wykres3<- renderPlot({
      
      
      ggplot(data=america,aes(x=america[,"budget"],y=america[,input$oskay],color=factor(america[,input$fak])))+geom_point()+labs(title =paste("Budżet w zależności od ",input$oskay),x="Budżet",y=input$oskay,color=input$fak)
      
                                                                            
      
    })  
    
    
    
    output$budg=renderText({
      film=america[,"budget"]
      paste("Element minimalny: ",min(film),"\nElement maksymalny",max(film),"\nŚrednia: ",mean(film) ,
            "\nOdchylenie standardowe: ",sd(film),"\nWariancja: ",(sd(film))^2,"\nPierwszy Kwartyl: ",
            quantile(film,c(0.25,0.5,0.75))[1],"\nMediana: ",quantile(film,c(0.25,0.5,0.75))[2],"\nTrzeci Kwartyl: ",quantile(film,c(0.25,0.5,0.75))[3])
      
    })
    
    output$ci=renderText({
      w1=america[,"budget"]
      w2=america[,input$sk]
      paste("Kowariancja:",cov(w1,w2),"\nKorelacja: ",cor(w1,w2))
    })
})
