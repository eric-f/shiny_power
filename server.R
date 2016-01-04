
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyBS)
source("global.R")

shinyServer(function(input, output, session) {

  ## Solve for power/sample size and make power curve --------------------------
  out <- reactive(power.wrapper(input))
  power.n.curve <- reactive(plot.power.n(input))

  ## update input fields -------------------------------------------------------
  observe({
    if(input$solveFor=="Sample size"){
      updateNumericInput(session, "n", value=ceiling(out()$n))
      updateButton(session, "solveForPower", style = "default", icon="", disabled = FALSE)
      updateButton(session, "solveForSampleSize", style = "success", icon=icon("check"), disabled = TRUE)
    }
    if(input$solveFor=="Power"){
      updateNumericInput(session, "power", value=round(out()$power, 3),
                         min=input$alpha)
      updateButton(session, "solveForPower", style = "success", icon=icon("check"), disabled = TRUE)
      updateButton(session, "solveForSampleSize", style = "default", icon="", disabled = FALSE)
    }
  })
  observeEvent(input$solveForPower,{
      updateSelectInput(session, "solveFor", selected="Power")
      updateNumericInput(session, "n", value=ceiling(out()$n))
      updateButton(session, "solveForPower", style = "success", icon=icon("check"), disabled = TRUE)
      updateButton(session, "solveForSampleSize", style = "default", icon="", disabled = FALSE)
  })
  observeEvent(input$solveForSampleSize,{
    updateSelectInput(session, "solveFor", selected="Sample size")
    updateNumericInput(session, "power", value=round(out()$power, 3),
                       min=input$alpha)
    updateButton(session, "solveForPower", style = "default", icon="", disabled = FALSE)
    updateButton(session, "solveForSampleSize", style = "success", icon=icon("check"), disabled = TRUE)
  })

  ## output --------------------------------------------------------------------
  output$power.curve <- renderPlot({
    power.n.curve()
    })
  output$print.solveFor <- renderText({
      print(input$solveFor)
    })

})
