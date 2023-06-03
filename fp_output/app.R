library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
# Define the UI
ui <- fluidPage(
  titlePanel("Longitudinal Time Data"),
  sidebarLayout(
    sidebarPanel(
      fileInput("data_file", "Upload CSV file with longitudinal data"),
      checkboxGroupInput("group_var", "Select variable for grouping", choices = NULL)
    ),
    mainPanel(
      plotOutput("line_plot")
    )
  )
)

# Define the server
server <- function(input, output) {
  
  # Read in the data from file
  data <- reactive({
    req(input$data_file)
    read.csv(input$data_file$datapath, header = TRUE)
  })
  
  # Update the grouping variable options based on the uploaded data
  observe({
    req(data())
    choices <- names(data())
    updateCheckboxGroupInput(session, "group_var", choices = choices)
  })
  
  # Generate the plot
  plot_data <- reactive({
    req(data())
    
    # Group the data by the selected grouping variable
    group_var <- input$group_var
    if (is.null(group_var)) {
      data_grouped <- data()
    } else {
      data_grouped <- data() %>% 
        group_by_at(group_var) %>% 
        nest()
    }
    
    # Convert the grouped data to a list
    data_list <- list(
      x = data_grouped$time,
      y = data_grouped$value,
      group = data_grouped$group
    )
    
    # Return the list as JSON
    asJSON(list(data = data_list), keep_vec_names = TRUE)
  })
  
  # Output the plot
  output$line_plot <- renderPlotly({
    req(plot_data())
    plot_ly(fromJSON(plot_data()))
  })
}


# Run the app
shinyApp(ui, server)
