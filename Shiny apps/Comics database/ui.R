library(shiny)
library(shinydashboard)

header <- dashboardHeader(title="Komiksy",titleWidth = 300)


#######
sidebar <- dashboardSidebar( width=600,
                             


                       
selectInput("title", "Seria:", choices =dm$title),


uiOutput("qwe")


)



#######
body <- dashboardBody(
  
  fluidRow(
    box(width = 12, title = "Informacje o zeszycie:",
        
          
          
          textOutput("rok"),
          textOutput("misioc"),
          textOutput("cena"),
          textOutput("war"),
          textOutput("lstron"),
          textOutput("zapowiedz")
    )
  ),
  fluidRow(
    box(width = 12, title = "Okładka",
        uiOutput("okladka") 
    )
  )

  
)

#
dashboardPage(header, sidebar, body)
#
