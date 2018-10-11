library(shiny)
library(plotly)
library(tidytext)
library(ggpubr)

ui <- shinyUI(
  navbarPage(
    "Twitter Approval Rate",
      tabPanel(
        "HashTag",
        titlePanel("HashTag"),
        sidebarLayout(
          sidebarPanel(
            width = 3,
            textInput("hashtag", 
                      label = "Search for a Term",
                      value = "Kavanaugh")
          ),
          mainPanel(
            plotOutput("plot"),
            plotOutput("final_plot")
          )
        )
      )
      
        )
      )
    
  
