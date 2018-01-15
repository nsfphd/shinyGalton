library(shiny)
library(HistData)
data("Galton") 

shinyServer(function(input, output) {
  src_data<-Galton
  
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
      x<-set_long_independent()
      bins<-seq(min(x), max(x), length.out=input$bins+1)
      hist(x, breaks=bins, col="blue", border="white",
           xlab=paste("Histogram of", set_short_independent(), "dataset"))
    })
    set_short_dependent<-reactive({
      if(set_short_independent()==child){
        dependent<-parent
      }
      else{
        dependent<-child
      }
      return(dependent)
    })
    set_long_dependent<-reactive({
      if(set_long_independent()==Galton$child){
        dependent<-Galton$parent
      }
      else{
        dependent<-Galton$child
      }
      return(dependent)
    })
  model<-lm(child~parent, data=Galton)  
 
    output$pred_plot <- renderPlot({

      
      plot(Galton$child, Galton$parent, xlab = "Child's height", 
           ylab = "Parent's height", bty = "n", pch = 16,
           xlim = c(50, 80), ylim = c(50, 80))
      abline(model, col = "red", lwd = 2)
      })
    
   
})
