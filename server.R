library(shiny)
library(ggplot2)
library(caret)

read_titanic_survival <- function() {
    train_file <- "train.csv"
    col_types <- c(
        "integer", # PassengerId
        "factor",  # Survived
        "factor",  # Pclass
        "character", # Name
        "factor", # Sex
        "numeric", # Age
        "integer", # SibSp
        "integer", # Parch
        "character", # Ticket
        "numeric", # Fare
        "character", # Cabin
        "factor" # Embarked
    )
    missing_values <- c("NA", "")
    read.csv(train_file, na.strings=missing_values, colClasses=col_types)
}


predict_survival <- function(ageCutOff) {
    prediction_age <- survival$Age < ageCutOff
    prediction_age[ which(is.na(prediction_age)) ] <- FALSE # predict no survival when age is not available
    prediction_age <- as.factor(as.integer(prediction_age))
    res <- confusionMatrix(prediction_age, survival$Survived)
    res$overall[1]
}

survival <- read_titanic_survival()

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
      
      ggplot(survival, aes(Age)) + 
          geom_bar(aes(fill = Survived), binwidth = input$bins) +  
          facet_wrap(~Sex+Pclass, nrow = 2, scales = "free_y") + 
          geom_vline(xintercept = input$ageCutOff) +
          ggtitle("Age as the Survival Factor") 

  })
  
  output$ageCutOff <- renderPrint({input$ageCutOff})
  output$prediction_accuracy <- renderPrint(
      predict_survival(input$ageCutOff))
})
