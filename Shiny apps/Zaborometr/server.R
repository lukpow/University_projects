library(googleVis)
library(datasets)
library(grDevices)
library(shiny)
library(shinydashboard)

zal=read.csv("C:/Users/jj/Downloads/population_by_region_combined_en.csv")
egz=read.csv("C:/Users/jj/Documents/egz8.csv")
biblioteki=read.csv("C:/Users/jj/Downloads/libraries in Poland.csv")
#WOJ=c("Dolnoslaskie","Kujawsko-pomorskie","Lubelskie","Lubuskie","Lodzkie","Malopolskie","Mazowieckie","Opolskie","Podkarpackie","Podlaskie","Pomorskie","Slaskie","Swietokrzyskie","Warminsko-mazurskie","Wielkopolskie","Zachodniopomorskie")
#biblioteki=data.frame(Voivodeship,biblioteki)
#bzp=biblioteki[-c(3,5,6,7,9,10,13),]
#bzr=biblioteki[-c(1,2,4,6,8,9,11,12,14,15,16),]
zabory <- data.frame(
  V = c("Dolnoslaskie","Kujawsko-pomorskie","Lubelskie","Lubuskie","Lodzkie","Malopolskie","Mazowieckie","Opolskie","Podkarpackie","Podlaskie","Pomorskie","Slaskie","Swietokrzyskie","Warminsko-mazurskie","Wielkopolskie","Zachodniopomorskie"),
  xol=c(0,0,1,0,1,0.5,1,0,0.5,1,0,0,1,0,0,0)
)
#zaboryp=zabory[-c(3,5,6,7,9,10,13),]
#zaboryr=zabory[-c(1,2,4,6,8,9,11,12,14,15,16),]

shinyServer(function(input, output) {
  
  output$plot2 <- renderGvis({
    gvisGeoChart(data=zabory,"V",colorvar="xol",options=list(region="PL",displayMode="regions",resolution="provinces",width=1000, height=600,colorAxis = "{colors:['#00FFFF','#FF0000']}"))
  })
 
  output$werdykt=renderPrint({
    kolz("xol",zabory)
  })
  
  output$plot1 <- renderGvis({
    
    gvisGeoChart(data=biblioteki,"Voivodeship",input$select,options=list(region="PL",displayMode="regions",resolution="provinces",width=1000, height=600,colorAxis = "{colors:['#00FFFF','#FF0000']}"))
  })
 
  output$plot3 <- renderGvis({
    
    gvisGeoChart(data=egz,"Wojewodztwo",input$select,options=list(region="PL",displayMode="regions",resolution="provinces",width=1000, height=600,colorAxis = "{colors:['#00FFFF','#FF0000']}"))
  })
  observeEvent(input$P1, {
    output$text <- renderPrint({
     kolz(input$select,biblioteki)
    })
    })
  
  observeEvent(input$P2, {
    output$text2 <- renderPrint({
      kolz(input$select,egz)
    })
  })
    
  observeEvent(input$P3, {
    output$text3 <- renderPrint({
      kolz(input$select,zal)
    })
  })
    
  output$plot4 <- renderGvis({
    
    gvisGeoChart(data=zal,"province",input$select,options=list(region="PL",displayMode="regions",resolution="provinces",width=1000, height=600,colorAxis = "{colors:['#00FFFF','#FF0000']}"))
  })
  
})
