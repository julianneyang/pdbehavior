#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

rotarod <- read.csv("Analysis_Files/ASO/ASO Rotarod - Rotarod.csv",header=TRUE)
rotarod$SLC_Genotype <- factor(rotarod$SLC_Genotype)
rotarod$ASO_Tg<- factor(rotarod$ASO_Tg)
rotarod$Day<- factor(rotarod$Day)
days <- c(rotarod$Day)
#rotarod %>% ggplot(aes(Genotype, Average_Latency, colour = Genotype)) + geom_violin()

library(shiny)
library(ggplot2)
library(viridis)
library(cowplot)

ui <- fluidPage(
  titlePanel("ASO Rotarod"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x_var",
                  label = "Select X Variable",
                  choices = names(rotarod),
                  selected = "ASO_Tg"),
      selectInput(inputId = "y_var",
                  label = "Select Y Variable",
                  choices = names(rotarod),
                  selected = "Average_Latency"),
      selectInput(inputId = "facet_var",
                  label = "Facet by Variable",
                  choices = names(rotarod),
                  selected = "SLC_Genotype"),
      selectInput(inputId = "fill_var",
                  label = "Fill by Variable",
                  choices = names(rotarod),
                  selected = "ASO_Tg"),
      selectInput(inputId = "color_var",
                  label = "Color by Variable",
                  choices = c(names(rotarod)),
                  selected = "ASO_Tg"),
      #selectInput(inputId = "filter_var",
                  #label = "Filter by Day",
                  #choices = c(names(rotarod)),
                  #selected = "Day"),
      #selectInput(inputId = "level_var",
                  #label = "Level of Filter_var",
                  #choices = days,
                  #selected = "")
    ),
    mainPanel(
      plotOutput(outputId = "boxplot")
    )
  )
)

server <- function(input, output) {

  #rotarod$SLC_Genotype <- factor(rotarod$SLC_Genotype, levels = c("WT", "HET", "MUT"))
  #rotarod$Day <- factor(rotarod$Day, levels = c("One", "Two", "Three"))
  output$boxplot <- renderPlot({
    if (input$facet_var == "") {
      ggplot(rotarod, aes_string(x = input$x_var, y = input$y_var,
                                 fill = input$fill_var, color=input$color_var)) + 
        geom_boxplot(alpha=0.25)+ 
        geom_point(position = position_jitterdodge(), aes(color = get(input$color_var))) +
        #geom_line(aes(group = MouseID,color=Genotype),size=1)+
        scale_fill_viridis_d()+
        theme_cowplot(16) +
        theme(legend.position = "top")+
        facet_wrap(as.formula(paste("~", input$facet_var)))
    } else {
      #selected <- reactive(rotarod %>% filter(input$filter_var == input$level_var))
      ggplot(rotarod, aes_string(x = input$x_var, y = input$y_var,
                                 fill = input$fill_var, color=input$color_var)) + 
        geom_boxplot(alpha=0.25)+ 
        geom_point(position = position_jitterdodge(), aes(color = get(input$color_var))) +
        #geom_line(aes(group = MouseID,color=Genotype),size=1)+
        scale_fill_viridis_d()+
        theme_cowplot(16) +
        theme(legend.position = "top")+
        facet_wrap(as.formula(paste("~", input$facet_var)))
    }
  })
}

shinyApp(ui, server)


