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
                      paired parent/child height datasets, along with a graph
                      representing the relationship between the two and predicted 
                      outcome heights based on input."),
               tags$br()
               ),
      radioButtons("data", "Choose parent or child data for graphing and prediction:",
                   c("Parent" = "parent",
                     "Child" = "child")),
      br(),
      
       sliderInput("bins",
                   "Number of bins:",
                   min = 8,
                   max = 20,
                   value = 10),
      numericInput("pred", "Height (in inches) to predict from:", value=60, 
                   min=60, max=75, step=0.1)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Summary data and histogram for selected dataset",
                 plotOutput("hist_plot"),
                 verbatimTextOutput("summary")),
        tabPanel("Predictions from selected dataset",
                 plotOutput("pred_plot"),
                 verbatimTextOutput("prediction")))
    )
)
))
