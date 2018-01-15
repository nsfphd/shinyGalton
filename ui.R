library(shiny)
data("Galton")

shinyUI(fluidPage(
  # Application title
  titlePanel("Galton height distributions"),
  
  sidebarLayout(
    sidebarPanel(
      tags$div(class="header", checked=NA,
               tags$p("This application will provide basic information about 
                      the distribution and summary statistics for the Galton 
                      paired parent/child height datasets."),
               tags$br()
               ),
      radioButtons("data", "Choose parent or child data for histogram:",
                   c("Parent" = "parent",
                     "Child" = "child")),
      br(),
      
       sliderInput("bins",
                   "Number of bins:",
                   min = 10,
                   max = 50,
                   value = 20)
    ),
    mainPanel(
      plotOutput("hist_plot"),
      verbatimTextOutput("summary"))
    )
)
)
