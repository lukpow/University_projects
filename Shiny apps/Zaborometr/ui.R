

######
header <- dashboardHeader(title="Zaborometr", titleWidth=300)


#######
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Strona główna", tabName = "Strona_główna", icon = icon("home")),
    menuItem("Zabory", tabName = "Zabory", icon = icon("chart-bar")),
    menuItem("Mapy bibliotek", tabName = "Mapy_bibliotek", icon = icon("chart-bar")),
    menuItem("Wyniki egzaminu ósmoklasisty", tabName = "egz", icon = icon("chart-bar")),
    menuItem("Populacja 2021", tabName = "pol", icon = icon("chart-bar"))
  )
)

                 

#######
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Strona_główna",
            h1("Zaborometr"),
            fluidRow(box(widh=35,tags$img(src = "https://i.redd.it/wjcgfn1iju171.png", height = "300px", width = "300px")))
    ),
    
    tabItem(tabName = "Zabory",
            fluidRow(
              box(width=11, htmlOutput("plot2")),
              box(width=11, htmlOutput("werdykt"))
              )
            ),
    
    tabItem(tabName = "Mapy_bibliotek",
    fluidRow(  
            box(width=11,selectInput("select", label = h3("Wybierz zmienna"), 
                                     choices = list("Liczba bibliotek" = "Number.of.libraries","Liczba bibliotekarzy"="Number.of.librarians","Liczba książek"="Amount.of.books","Liczba czytelników"="Number.of.readers","Liczba wypożyczeń"="Number.of.loans","Biblioteki z dostosowaniami dla osób niepełnosprawnych"="Facility.adapted.to.the.needs.of.people.with.disabilities","Liczba bibliotek z dostosowaniami dla osób niepełnosprawnych przy wejściu"="Facility.adapted.to.the.needs.of.people.with.disabilities..entrance.","Liczba bibliotek z dostosowaniami dla osób niepełnosprawnych wewnątrz obiektu"="Facility.adapted.to.the.needs.of.people.with.disabilities..inside.the.building."), 
                                     selected = "Number.of.libraries"),
                actionButton("P1", "Werdykt")),        
        
  ),
  fluidRow(
    box(width=11, htmlOutput("plot1")),
  box(textOutput("text"))
)
    ),
tabItem(tabName = "egz",
        fluidRow(  
          box(width=11,selectInput("select", label = h3("Wybierz zmienna"), 
                                   choices = list("Matematyka" = "matematyka","Język angielski"="język.angielski","Język niemiecki"="język.niemiecki","Język polski"="język.polski","Język rosyjski"="język.rosyjski"), 
                                   selected = "matematyka"),
              actionButton("P2", "Werdykt")),        
          
        ),
        fluidRow(
          box(width=11, htmlOutput("plot3")),
          box(textOutput("text2"))
        )
),
tabItem(tabName = "pol",
        fluidRow(  
          box(width=11,selectInput("select", label = h3("Wybierz zmienna"), 
                                   choices = list("Wszyscy" = "overall.overall","mężczyźni"="overall.man","kobiety"="overall.woman","Dzieci w wieku 0-4 lat"="X0.4.overall"), 
                                   selected = "overall.overall"),
              actionButton("P3", "Werdykt")),        
          
        ),
        fluidRow(
          box(width=11, htmlOutput("plot4")),
          box(textOutput("text3"))
        )
)
)
)
#
dashboardPage(header, sidebar, body,skin="red")
#



