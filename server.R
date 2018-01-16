library(shiny)
library(HistData)
data("Galton") 

shinyServer(function(input, output) {
    parent_model<-lm(child~parent, data=Galton)
    child_model<-lm(parent~child, data=Galton)
    model<-parent_model
    
    set_short_independent<-reactive({
      value<-input$data
      return(value)
    })
    
    set_long_independent<- reactive({
        switch(set_short_independent(),
           "child"=Galton$child,
           "parent"=Galton$parent)
    })
    
    output$summary<-renderPrint({
      data<-set_long_independent()
      summary(data)
    })
    
    output$hist_plot<-renderPlot({
      dataset<-set_long_independent()
      bins<-seq(min(dataset), max(dataset), length.out=input$bins+1)
      hist(dataset, breaks=bins, col="blue",xlab=paste("Histogram of", 
           set_short_independent(), "dataset"))
    })
    
    set_short_dependent<-reactive({
      if(set_short_independent()=="child"){
        dependent<-"parent"
      }
      else{
        dependent<-"child"
      }
      return(dependent)
    })
    
    set_long_dependent<-reactive({
      if (set_short_independent()=="child"){
        dependent<-Galton$parent
      }
      else{
        dependent<-Galton$child
      }
      return(dependent)
    })

      set_model<- reactive({
          if(set_short_independent()=="child"){
            model<-child_model
          }
        return(model)
        })
    
      set_pred_model<-reactive({
        hgt_input <- input$pred
        if(set_short_independent()=="child"){
          predict(set_model(), newdata = data.frame(child=hgt_input))
        }
        else{
          predict(set_model(), newdata=data.frame(parent=hgt_input))
        }
      })
      
    output$pred_plot <- renderPlot({
      hgt_input <- input$pred
      plot(set_long_dependent(), set_long_independent(), xlab = paste("Outcome: ", set_short_dependent(),"'s height"), 
           ylab = paste("Predictor: ", set_short_independent(),"'s height"), bty = "n", pch = 16,
           xlim = c(60, 80), ylim = c(60, 80))
      abline(set_model(), col = "red", lwd = 2)
      points(hgt_input, set_pred_model(), col = "red", pch = 16, cex = 2)
    })
    
    output$prediction<-renderText({
      paste("Forecasted outcome from selected height:  ", set_pred_model())
    })
    

      
    })
