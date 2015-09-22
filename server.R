library(shiny) 

houseBudget <- function(area="City Center", surface_min=30,surface_max=100, rooms=2, type="Flat") 
{
  data<-read.csv('housedata.csv')
  prediction<-c(150,200) ;  price_min<-0 ;  price_max<-0
  pred_data<- subset(data,(Area==area) &(Type %in% type)&(Surface >=surface_min) & (Surface <= surface_max),select=c(Price, Psqm))
  price_min<- mean(pred_data$Price) - sd(pred_data$Price)/2
  price_max<- mean(pred_data$Price) +  sd(pred_data$Price)/2
  
  #return list of boundaries as well as data for plotting
 prediction <- list(round(price_min), round(price_max), pred_data$Price)
}

shinyServer(
  function(input, output) {
    output$area <- renderText({input$area})
    thistype <- reactive({input$type})
    output$area <-thistype
    output$rooms <- renderText({input$rooms})
    output$surface <- renderText({input$surface})
    output$commsurface <- renderText({paste("Your range in terms of habitable space is ",input$surface[1], "to ",  input$surface[2]) })
    output$commarea <- renderText({c("You are looking in ",input$area, "for the following types of assets : "  )})
  
    #Call prediction function
    pred_data <- reactive({houseBudget(area= input$area,surface_min=as.integer(input$surface[1]), surface_max=as.integer(input$surface[2]), rooms= as.integer(input$rooms), type= input$type)})
   
    output$pred_range <-renderText({ paste(" Your estimated budget ranges from", pred_data()[[1]] , " to ", pred_data()[[2]], " EUR" ) })

    # Plot the distribution of prices and guidelines
    output$HistChart<- renderPlot({
      hist(pred_data()[[3]]/1000, col="wheat", border="wheat3", prob=TRUE, breaks=27, main= "Price Distribution", xlab="Price in K EUR")
      lines (density(pred_data()[[3]]/1000), col="red", lwd=4, lty=3)  
      abline(v=pred_data()[[2]]/1000, col="red", lwd=4)
      abline(v=pred_data()[[1]]/1000, col="red", lwd=4)
                                   })
  
  } )