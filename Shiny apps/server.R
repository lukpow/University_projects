library(dplyr)
library(tidyr)
komiks=read.csv("C:/Users/jj/Documents/comics_data.csv")
dcmarvel=komiks[(komiks$pub_name=="DC Comics" | komiks$pub_name=="Marvel Comics"),]

dcmarvel2=dcmarvel %>% select(-X, -pub_id,-title_link,-issue_link,-characters,-pub_titles_total,-pub_issues_total)

dcmarvel2=dcmarvel2 %>% 
  mutate(cover_date=stringr::str_replace(cover_date, "\\'", ""))



dcmarvel2=separate(dcmarvel2, col=cover_date, into=c("miesiac", "rok"), sep = " ")

dcmarvel2 =dcmarvel2%>%
  mutate(rok=ifelse(rok<25,paste0("20", rok),paste0("19",rok)))

dcmarvel2=dcmarvel2 %>%
  mutate(rok = ifelse(is.na(rok), miesiac,rok ))



dcmarvel2=dcmarvel2%>%
  mutate(cover_link=paste0("https://comicbookrealm.com",cover_link))

dcmarvel2=dcmarvel2 %>% 
  mutate(cover_price =stringr::str_replace(cover_price, "\\,", ""))
dcmarvel2=dcmarvel2 %>% 
  mutate(current_value =stringr::str_replace(current_value, "\\,", ""))

dcmarvel2=dcmarvel2 %>% 
  mutate(cover_price =as.numeric(stringr::str_replace(cover_price, "\\$", "")))

dcmarvel2=dcmarvel2 %>% 
  mutate(current_value =as.numeric(stringr::str_replace(current_value, "\\$", "")))

rt=lm(pages~cover_price,dcmarvel2)
ww=floor(predict(rt,dcmarvel2))
dcmarvel2=dcmarvel2%>%
  mutate(wq=ww)

dcmarvel2=dcmarvel2 %>%
  mutate(pages = ifelse(is.na(pages), wq,pages ))

dcmarvel2=dcmarvel2%>%select(-wq)


dcmarvel2=dcmarvel2 %>%
  mutate(cover_price = ifelse(is.na(cover_price), current_value,cover_price ))



dm=dcmarvel2 %>%
  group_by(title) %>%
  nest(-title,-pub_name)
dm[[3]][[63]]$current_value[7]=3000000








shinyServer(function(input, output) {
  zbior=reactive({
    seria=dm[dm$title == input$title, ]$data
    seria[[1]][seria[[1]]$issue == input$issue, ]
  })
  
  output$qwe=renderUI({
    seria=dm[dm$title == input$title, ]$data
    issues=seria[[1]]$issue
    selectInput("issue", "Zeszyt:", choices = issues)
  })
  
  output$okladka=renderUI({
    strona=zbior()$cover_link[1]
    tags$img(src =strona, height = "300px", width = "200px")
  })
  

  

  output$rok=renderText({
    paste("Rok wydania:", zbior()$rok[1])
  })
  
  output$misioc=renderText({
    paste("Miesiąc wydania:", zbior()$miesiac[1])
  })
  
  output$cena= renderText({
    paste("Cena okładkowa:", ifelse(is.na(zbior()$cover_price[1]), "Brak danych", paste0("$", zbior()$cover_price[1])))
  })
  
  output$war=renderText({
    paste("Obecna wartość:", ifelse(is.na(zbior()$current_value[1]), "Brak danych", paste0("$", zbior()$current_value[1])))
  })
  
  output$lstron=renderText({
    paste("Liczba stron:", ifelse(is.na(zbior()$pages[1]), "Brak danych", zbior()$pages[1]))
  })
  
  output$zapowiedz=renderText({
    paste("Czy zapowiedź była dostępna?", ifelse(zbior()$preview[1]=="Available", "Tak", "Nie"))
  })
  
   
})