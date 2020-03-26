
par(ask=T)
#pdf(file="C:/2019/boundary/itc.pdf") 
#install.packages("reshape2",dependencies = TRUE)
#install.packages("nlme",dependencies = TRUE)
#install.packages("psych",dependencies = TRUE)
#install.packages("cluster",dependencies = TRUE)
#install.packages("dplyr",dependencies = TRUE)
#install.packages("plyr",dependencies = TRUE)
library(reshape2)
 library(nlme)
 library(ggplot2)
 library(cluster)
 library(plyr)
 library(dplyr)
 library(stringr)


setwd("rgtvlt67/
rgtvlt-gmail.com")

volume_sed_stand_SP_join <- read.csv("itcvolbndry.csv",stringsAsFactors=FALSE)
library(shiny)

list.species <- unique(volume_sed_stand_SP_join$Species)
list.stands <- na.omit(unique(volume_sed_stand_SP_join$POLY_ID))


ui <- fluidPage(
  titlePanel("ITC Grade and Tree Species Volume Percentage"),
  sidebarLayout(
    sidebarPanel(

        selectInput("standInput", label = h3("Select Stands"), 
              choices = list.stands, 
              multiple = TRUE),

    selectInput("productInput", label = h3("Select Product"), 
                  choices = c("Large Sawlog", "Small Sawlog","Stud"),
                  multiple = TRUE),
   
      



selectInput("speciesInput", label = h3("Select Species"), 
             choices = list.species, 
              multiple = TRUE)

    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      tableOutput("results")
    )
  )
)


server <- function(input, output) {





 data_user <- reactive({
 subset(volume_sed_stand_SP_join,volume_sed_stand_SP_join$Species %in% input$speciesInput & volume_sed_stand_SP_join$POLY_ID %in% input$standInput & volume_sed_stand_SP_join$Product %in% input$productInput)

    })

  output$coolplot <- renderPlot(

 ggplot(data = data_user(), aes(x = Product, y = percentage,fill = Species))  + 
    geom_bar(stat = "identity") 

)
}


shinyApp(ui = ui, server = server)



