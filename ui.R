library(shiny)

shinyUI(fluidPage(

  titlePanel("Titanic Survival: Age, Sex and Class"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput('ageCutOff', 'Age Cut of For Survival Classsification:', 
                   20, min = 5, max = 50, step = 1),    
      sliderInput("bins",
                  "Bin width:",
                  min = 1,
                  max = 10,
                  value = 2)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      h3('Age cut off used'),
      verbatimTextOutput("ageCutOff"),
      h3('Accuracy of Prediction with Age Cut Off'),
      verbatimTextOutput("prediction_accuracy")
    )
  )
))
