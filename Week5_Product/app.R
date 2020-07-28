library(shiny); library(tm); library(RWeka); library(dplyr); library(magrittr); library(e1071); library(stringi)

load("Bayes.RData")

    ui <- fluidPage(
        textInput("predictor", "Insert two words and let me predict the next one for you!!", "Type here"),
        verbatimTextOutput("predict")
    )

    server <- function(input, output) {
        prediction <- function(x) {
            string <- x # Input test variable
            split <- strsplit(string, split = " " )# split it into separate words
            factor <- factor(unlist(split), levels=uni_levels)# encode as a factor using the same levels
            df <- data.frame(X1 = factor[1], X2 = factor[2])# transform to data frame
            pred <- predict(Bayes, df)# estimate using the model
            pred <- as.character(pred)
        return(pred)}
        output$predict <- renderText({prediction(input$predictor)})
    }
    shinyApp(ui, server)
