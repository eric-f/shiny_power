
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("global.R")

shinyServer(function(input, output, session) {

  ## Solve for power/sample size and make power curve --------------------------
  out <- reactive(power.wrapper(input))
  power.n.curve <- reactive(plot.power.n(input))

  ## uis for action buttons
  output$buttonPower <- renderUI({
      actionButton("solveForPower", "Power",
                   class=ifelse(input$solveFor=="Power", "btn-danger", "btn-default"))
  })
  output$buttonSampleSize <- renderUI({
    actionButton("solveForSampleSize", "Sample Size",
                 class=ifelse(input$solveFor=="Sample size", "btn-danger", "btn-default"))
  })
  output$buttonNull <- renderUI({
    actionButton("solveForNull", "Null",
                 class=ifelse(input$solveFor=="NULL", "btn-danger", "btn-default"))
  })

  ## update input fields -------------------------------------------------------
  observe({
    if(input$solveFor=="Sample size"){
      updateNumericInput(session, "n", value=ceiling(out()$n))
    }
    if(input$solveFor=="Power"){
      updateNumericInput(session, "power", value=round(out()$power, 3),
                         min=input$alpha)
    }
  })
  observeEvent(input$solveForPower,{
      updateSelectInput(session, "solveFor", selected="Power")
      updateNumericInput(session, "n", value=ceiling(out()$n))
  })
  observeEvent(input$solveForSampleSize,{
    updateSelectInput(session, "solveFor", selected="Sample size")
    updateNumericInput(session, "power", value=round(out()$power, 3),
                       min=input$alpha)
  })

  ## output --------------------------------------------------------------------
  output$power.curve <- renderPlot({
    power.n.curve()
    })
  output$print.solveFor <- renderText({
      print(input$solveFor)
    })

})
