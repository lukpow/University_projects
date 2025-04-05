library(shiny)
library(shinydashboard)
library(ggplot2)
######
header <- dashboardHeader(title="IMDB", titleWidth=300)


#######
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Strona główna", tabName = "Strona_główna", icon = icon("home")),
    menuItem("Katalog filmów", tabName = "przeglad", icon = icon("film")),
    menuItem("Charakterystyki liczbowe", tabName = "cl", icon = icon("calculator")),
    menuItem("Mapy", tabName = "Mapy", icon = icon("map")),
    menuItem("Wykresy", tabName = "Wykresy", icon = icon("chart-line")),
    menuItem("Histogramy", tabName = "hist", icon = icon("chart-bar")),
    menuItem("Bonus", tabName = "bonus", icon = icon("question")),
    menuItem("USA",tabName="ameryka",icon=icon("flag-usa"))
    )
  
)

#######
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Strona_główna",
            h1("Analiza danych z IMDB"),
            fluidRow(box(widh=12,tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/6/69/IMDB_Logo_2016.svg", height = "300px", width = "300px")))
    ),
    
    tabItem(tabName = "przeglad",
            box(width=11,selectInput("wybrane", label = h3("Wybierz film"), 
                                     choices=sort(movie$movie_title), 
                                     selected = "The Dark Knight Rises 
")),
            
            
            
            box(width = 12, title = "Dane o filmie:",
              
                
                verbatimTextOutput("dane")
            )
                ),
    
    tabItem(tabName = "cl",
           fluidRow( box(h1("Charakterystyki liczbowe danych: ")),
            box(h2("Charakterystyki całego zbioru: "),
            verbatimTextOutput("damn")),
            box(h2("Charakterystyki poszczególnych zmiennych ilościowych: "),
            selectInput("zmil", label = h3("Wybierz zmienną ilościową:"), 
                        choices=zmienne_ilosciowe, 
                        selected = "gross"),
            verbatimTextOutput("damni")),
            box(h2("Charakterystyki poszczególnych zmiennych jakościowych:"),
            selectInput("zmij", label = h3("Wybierz zmienną jakościową:"), 
                        choices=zmienne_jakosciowe, 
                        selected = "color"),
            verbatimTextOutput("damnj")),
            box(h2("Kowariancja i korelacja dla dwóch wybranych zmiennych ilościowych: "),
            selectInput("z1", label = h3("Pierwsza zmienna:"), 
                        choices=zmienne_ilosciowe, 
                        selected = "gross"),
            
            selectInput("z2", label = h3("Wybierz drugą zmienną:"), 
                        choices=zmienne_ilosciowe, 
                        selected = "gross"),
            verbatimTextOutput("cior")
            ))
            
            )  ,
        
            
    
    tabItem(tabName = "Mapy",
            fluidRow(box(width=11,selectInput("mapa", label = h3("Wybierz zmienną:"), 
                                              choices=names(srednieinput),selected = "gross")),
              box(width=11, htmlOutput("plot1"))
              )
            ),
    tabItem(tabName = "Wykresy",
            fluidRow(box(width=11,selectInput("wykresosx", label = h3("Zmienna na osi x:"), 
                                     choices=zmienne_ilosciowe,selected = "duration")),
            box(width=11,selectInput("wykresosy", label = h3("Zmienna na osi y:"), 
                                    choices=zmienne_ilosciowe,selected = "gross")),
       
            box(selectInput("faktor", label = h3("Wybierz zmienną jakościową:"), 
                        choices=zmienne_j, 
                        selected = "color")),
            box(plotOutput("wykres1"),width=12)  
    
            )
       ),
    tabItem(tabName="hist",
         fluidRow( box(selectInput("fa", label = h3("Wybierz zmienną jakościową:"), 
                            choices=zmienne_j, 
                            selected = "color")),
            box(selectInput("il", label = h3("Wybierz zmienną ilościową:"), 
                        choices=zmienne_ilosciowe, 
                        selected = "gross")),
            box(plotOutput("wykres2"),width = "1800px", height = "600px") ) ),  
            
            
          
    tabItem(tabName = "bonus",
            h1("Zgadywanka"),
            fluidRow(
             box(width=11,selectInput("zgad", label = h3("Który to film?"), 
                                      choices=movie$movie_title, 
                                      selected = "Avatar"))
            ),
            
            fluidRow(verbatimTextOutput("zgad") ),
            
            actionButton("odp1", "Zatwierdź"),
    fluidRow(box(verbatimTextOutput("feedback")),textOutput("punkty"))
            
            
            
    ),
    
    tabItem(tabName="ameryka",
            h1("Budżet ale tylko dla USA"),
            
    
  
            fluidRow(
                     box(h2("Charakterystyki liczbowe dla budżetu: "),
                         verbatimTextOutput("budg")),
                     
            
                     box(h2("Kowariancja i korelacja dla budżetu i wybranej innej zmiennej: "),
                         selectInput("sk", label = h3("Zmienna:"), 
                                     choices=zmienne_ilosciowe, 
                                     selected = "gross"),
                         
      
                         verbatimTextOutput("ci")),
                      box(h2("Wykres dla budżetu:")),
                      
                     box(width=11,selectInput("oskay", label = h3("Zmienna na osi y:"), 
                                              choices=zmienne_ilosciowe,selected = "gross")),
                     
                     box(selectInput("fak", label = h3("Wybierz zmienną jakościową:"), 
                                     choices=zmienne_j, 
                                     selected = "color")),
                     box(plotOutput("wykres3"),width=12)  
              
              
              

            
    
    
    )
    )
    )
)
#
dashboardPage(header, sidebar, body,skin="yellow")
#



