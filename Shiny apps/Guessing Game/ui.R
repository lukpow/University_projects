library(shiny)
library(shinydashboard)

header <- dashboardHeader(title="Kiedy to było?", titleWidth=300)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Strona główna", tabName = "Strona_główna", icon = icon("home")),
    menuItem("Poziom normalny", tabName = "lata", icon = icon("chart-bar")),
    menuItem("Poziom Trudny", tabName = "dni", icon = icon("chart-bar"))
  )
)
  
body <- dashboardBody(
    tabItems(
      tabItem(tabName = "Strona_główna",
              h1("Kiedy to było?"),
              h3("Gra inspirowana: https://guess-the-year.davjhan.com/game")
              ),
      tabItem(tabName = "lata",
              h3(textOutput("wydarzenie1")),
              fluidRow(box(sliderInput("dist",
                          "Rok:",
                          min = 1901, max = 2000,value=1901,sep = ""),
              width=12),actionButton("odp1", "Zatwierdź")),
              
              h3("Statystyki"),
              fluidRow(
                box(textOutput("zycko1")),
                box(textOutput("punkty1"))),
                box(textOutput("feedback1"))
              
      ),
      tabItem(tabName = "dni",
              h3(textOutput("wydarzenie2")),
              fluidRow(box(sliderInput("rok",
                                       "Rok:",
                                       min = 1901, max = 2000,value=1901,sep = ""),
                           width=12),
                       box(sliderInput("miesiac",
                                       "Miesiąc:",
                                       min = 1, max = 12,value=1,sep = ""),
                           width=12),
                       box(uiOutput("dzionek")),
                       actionButton("odp2", "Zatwierdź")),
              h2("Statystyki"),
              fluidRow(
                box(textOutput("zycko2")),
                box(textOutput("punkty2"))),
              box(textOutput("feedback2"))
              
      )
       
    )
)

dashboardPage(header, sidebar, body,skin="purple")