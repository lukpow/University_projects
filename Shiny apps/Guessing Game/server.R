pro=read.csv("proto.csv",header=TRUE,sep = ",")
qq=as.Date(pro[,2], format="%d/%m/%Y")
h1=reactiveVal(100)
h2=reactiveVal(as.numeric(as.Date("2000/12/31")-as.Date("1901/1/1")))
k1=reactiveVal(0)
k2=reactiveVal(0)
w1=reactiveVal(sample(1:length(qq),1))
w2=reactiveVal(sample(1:length(qq),1))

wydarzenie1 <- reactive({
  pro[w1(), 1]
})

wydarzenie2 <- reactive({
  pro[w2(), 1]
})

shinyServer(function(input, output) {
  
  
  
  output$wydarzenie1 <- renderText({wydarzenie1()})
  
  output$punkty1 <- renderText({paste("Punkty: ", k1())})
  
  output$zycko1 <- renderText({paste("Żyćko: ", h1())})
  
  observeEvent(input$odp1, {
    ww1=w1()
    dr=as.numeric(format(qq[ww1],"%Y"))
    ru=as.numeric(input$dist)
    output$feedback1 <- renderText(paste("Poprawny rok: ", format(qq[ww1],"%Y")))
    h1(h1()-abs(dr-ru))
    if (h1() < 0){
      h1(0)
      showModal(modalDialog(
        title = "Koniec",
        paste("Wynik:", k1())))
      }
    else{
      k1(k1()+1)
      w1(sample(1:length(qq),1))
     
    }
    })
  
  output$wydarzenie2 <- renderText({wydarzenie2()})
  
  output$punkty2 <- renderText({paste("Punkty: ", k2())})
  
  output$zycko2 <- renderText({paste("Żyćko: ", h2())})
  
  observeEvent(input$odp2, {
    ww2=w2()
    dr=as.numeric(qq[ww2]-as.Date(paste(input$rok,input$miesiac,input$dzien,sep="-")))
    output$feedback2 <- renderText(paste("Poprawna data: ", qq[ww2]))
    h2(h2()-abs(dr))
    if (h2() < 0){
      h2(0)
      showModal(modalDialog(
        title = "Koniec",
        paste("Wynik: ", k2())))
    }
    else{
      k2(k2()+1)
      w2(sample(1:length(qq),1))
      
    }
  })
  
  misioc=reactive({
    m=input$miesiac
    if (m==2) {
        return(przest(input$rok))
    } else if (m %in% c(4, 6, 9, 11)) {
      return(30)
    } else {
      return(31)
    }
  })
  
  
  output$dzionek=renderUI({
    sliderInput("dzien", "Dzień:", 
                min = 1, 
                max = misioc(), 
                value = 1,
                sep = "")
  })
  
 
})
