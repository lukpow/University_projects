g=length(movie$movie_title)

movie$aspect_ratio=as.numeric(movie$aspect_ratio)
zmienne_w_tym_zbiorze=list("Tytuł filmu"="movie_title","Kraj produkcji"="country","Rok produkcji"="title_year","Budżet"="budget","Przychód brutto"="gross","Czas trwania"="duration","Ocena na IMDb"="imdb_score","Język"="language",
                           "Recenzje krytyków"="num_critic_for_reviews",
                           "Recenzje użytkowników"="num_user_for_reviews",
                           "Liczba opinii o filmie"="num_voted_users",
                           "Ograniczenia wiekowe"="content_rating",
                           "Liczba aktorów na plakacie"="facenumber_in_poster",
                           "Rozdzielczość"="aspect_ratio","Kolor"="color",
                           "Reżyser"="director_name",
                           "Polubienia na Facebooku reżysera"="director_facebook_likes",
                           "Pierwszy aktor"="actor_1_name","Polubienia na Facebooku pierwszego aktora"="actor_1_facebook_likes",
                           "Drugi aktor"="actor_2_name","Polubienia na Facebooku drugiego aktora"="actor_2_facebook_likes","Trzeci aktor"="actor_3_name","Polubienia na Facebooku trzeciego aktora"="actor_3_facebook_likes","Polubienia na Facebooku całej obsady"="cast_total_facebook_likes",
                           "Polubienia na Facebooku filmu"="movie_facebook_likes",
                           "Gatunki"="genres","Kluczowe hasła"="plot_keywords","Link do strony na IMDb"="movie_imdb_link")

zmienne_jakosciowe=list("Tytuł filmu"="movie_title","Kraj produkcji"="country","Rok produkcji"="title_year",
                        "Język"="language","Ograniczenia wiekowe"="content_rating","Kolor"="color","Reżyser"="director_name",
                        "Pierwszy aktor"="actor_1_name","Drugi aktor"="actor_2_name","Trzeci aktor"="actor_3_name","Gatunki"="genres","Kluczowe hasła"="plot_keywords","Link do strony na IMDb"="movie_imdb_link")
zmienne_j=list("Kraj produkcji"="country","Rok produkcji"="title_year",
"Język"="language","Ograniczenia wiekowe"="content_rating","Kolor"="color")
zmienne_ilosciowe <- zmienne_w_tym_zbiorze[setdiff(names(zmienne_w_tym_zbiorze), names(zmienne_jakosciowe))]

zmienne_k <- zmienne_w_tym_zbiorze[names(zmienne_w_tym_zbiorze) != "Tytuł filmu"]
zmienne_k=zmienne_k[names(zmienne_k)!="Link do strony na IMDb"]




